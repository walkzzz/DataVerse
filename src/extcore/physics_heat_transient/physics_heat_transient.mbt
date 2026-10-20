///===
/// extcore/physics_heat_transient

pub(all) struct PhysicsheattransientPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_transient_make_point(x : Double, y : Double) -> PhysicsheattransientPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_transient_make_point3(x : Double, y : Double, z : Double) -> PhysicsheattransientPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheattransientPoint::x(self : PhysicsheattransientPoint) -> Double { self.x }

pub fn PhysicsheattransientPoint::y(self : PhysicsheattransientPoint) -> Double { self.y }

pub fn PhysicsheattransientPoint::z(self : PhysicsheattransientPoint) -> Double { self.z }

pub fn PhysicsheattransientPoint::label(self : PhysicsheattransientPoint) -> Int { self.label }

pub fn PhysicsheattransientPoint::dist(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheattransientPoint::add(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheattransientPoint::sub(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheattransientPoint::scale(self : PhysicsheattransientPoint, s : Double) -> PhysicsheattransientPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheattransientPoint::dot(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheattransientPoint::cross(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheattransientPoint::norm(self : PhysicsheattransientPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheattransientPoint::normalize(self : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheattransientPoint::negate(self : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheattransientPoint::mid(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheattransientPoint::lerp(self : PhysicsheattransientPoint, other : PhysicsheattransientPoint, t : Double) -> PhysicsheattransientPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheattransientPoint::to_string(self : PhysicsheattransientPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheattransientSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_transient_make_series(vals : Array[Double], name : String) -> PhysicsheattransientSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheattransientSeries::len(self : PhysicsheattransientSeries) -> Int { self.vals.length() }

pub fn PhysicsheattransientSeries::sum(self : PhysicsheattransientSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheattransientSeries::mean(self : PhysicsheattransientSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheattransientSeries::min(self : PhysicsheattransientSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheattransientSeries::max(self : PhysicsheattransientSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheattransientSeries::range(self : PhysicsheattransientSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheattransientSeries::variance(self : PhysicsheattransientSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheattransientSeries::std(self : PhysicsheattransientSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheattransientSeries::median(self : PhysicsheattransientSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheattransientSeries::scale(self : PhysicsheattransientSeries, f : Double) -> PhysicsheattransientSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheattransientSeries::add(self : PhysicsheattransientSeries, other : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheattransientSeries::sub(self : PhysicsheattransientSeries, other : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheattransientSeries::normalize(self : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheattransientSeries::cumsum(self : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheattransientSeries::to_string(self : PhysicsheattransientSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheattransientMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_transient_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheattransientMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_transient_matrix_identity(n : Int) -> PhysicsheattransientMatrix {
  let m = physics_heat_transient_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheattransientMatrix::get(self : PhysicsheattransientMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheattransientMatrix::transpose(self : PhysicsheattransientMatrix) -> PhysicsheattransientMatrix {
  let result = physics_heat_transient_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheattransientMatrix::add(self : PhysicsheattransientMatrix, other : PhysicsheattransientMatrix) -> PhysicsheattransientMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_transient_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheattransientMatrix::scale(self : PhysicsheattransientMatrix, s : Double) -> PhysicsheattransientMatrix {
  let result = physics_heat_transient_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheattransientMatrix::multiply(self : PhysicsheattransientMatrix, other : PhysicsheattransientMatrix) -> PhysicsheattransientMatrix {
  if self.cols != other.rows { return physics_heat_transient_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_transient_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheattransientMatrix::trace(self : PhysicsheattransientMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheattransientMatrix::det(self : PhysicsheattransientMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheattransientMatrix::norm(self : PhysicsheattransientMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheattransientMatrix::to_string(self : PhysicsheattransientMatrix) -> String {
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

pub(all) struct PhysicsheattransientVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_transient_make_vector(comps : Array[Double]) -> PhysicsheattransientVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_transient_vector_zero(dim : Int) -> PhysicsheattransientVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheattransientVector::add(self : PhysicsheattransientVector, other : PhysicsheattransientVector) -> PhysicsheattransientVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheattransientVector::sub(self : PhysicsheattransientVector, other : PhysicsheattransientVector) -> PhysicsheattransientVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheattransientVector::scale(self : PhysicsheattransientVector, s : Double) -> PhysicsheattransientVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheattransientVector::dot(self : PhysicsheattransientVector, other : PhysicsheattransientVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheattransientVector::norm(self : PhysicsheattransientVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheattransientVector::normalize(self : PhysicsheattransientVector) -> PhysicsheattransientVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheattransientVector::dist(self : PhysicsheattransientVector, other : PhysicsheattransientVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheattransientVector::to_string(self : PhysicsheattransientVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_transient_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_transient_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_transient_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_transient_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_transient_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_transient_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_transient_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_transient_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_transient_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_transient_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_transient_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_transient_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_transient_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_transient_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_transient_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_transient_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_transient_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_transient_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_transient_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_transient_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_transient_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_transient_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_transient_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_transient_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_transient_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_transient_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_transient_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_transient_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_transient_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheattransientFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_frame_make(size : Int) -> PhysicsheattransientFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_frame_len(s : PhysicsheattransientFrame) -> Int { s.size }

pub fn physics_heat_transient_frame_get(s : PhysicsheattransientFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_frame_set(s : PhysicsheattransientFrame, i : Int, v : Double) -> PhysicsheattransientFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_sum(s : PhysicsheattransientFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_frame_mean(s : PhysicsheattransientFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_frame_scale(s : PhysicsheattransientFrame, f : Double) -> PhysicsheattransientFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_add(a : PhysicsheattransientFrame, b : PhysicsheattransientFrame) -> PhysicsheattransientFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_frame_copy(s : PhysicsheattransientFrame) -> PhysicsheattransientFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_fill(s : PhysicsheattransientFrame, v : Double) -> PhysicsheattransientFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_min(s : PhysicsheattransientFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_frame_max(s : PhysicsheattransientFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_frame_to_string(s : PhysicsheattransientFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_table_make(size : Int) -> PhysicsheattransientTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_table_len(s : PhysicsheattransientTable) -> Int { s.size }

pub fn physics_heat_transient_table_get(s : PhysicsheattransientTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_table_set(s : PhysicsheattransientTable, i : Int, v : Double) -> PhysicsheattransientTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_sum(s : PhysicsheattransientTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_table_mean(s : PhysicsheattransientTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_table_scale(s : PhysicsheattransientTable, f : Double) -> PhysicsheattransientTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_add(a : PhysicsheattransientTable, b : PhysicsheattransientTable) -> PhysicsheattransientTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_table_copy(s : PhysicsheattransientTable) -> PhysicsheattransientTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_fill(s : PhysicsheattransientTable, v : Double) -> PhysicsheattransientTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_min(s : PhysicsheattransientTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_table_max(s : PhysicsheattransientTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_table_to_string(s : PhysicsheattransientTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_graphn_make(size : Int) -> PhysicsheattransientGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_graphn_len(s : PhysicsheattransientGraphN) -> Int { s.size }

pub fn physics_heat_transient_graphn_get(s : PhysicsheattransientGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_graphn_set(s : PhysicsheattransientGraphN, i : Int, v : Double) -> PhysicsheattransientGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_sum(s : PhysicsheattransientGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_graphn_mean(s : PhysicsheattransientGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_graphn_scale(s : PhysicsheattransientGraphN, f : Double) -> PhysicsheattransientGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_add(a : PhysicsheattransientGraphN, b : PhysicsheattransientGraphN) -> PhysicsheattransientGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_graphn_copy(s : PhysicsheattransientGraphN) -> PhysicsheattransientGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_fill(s : PhysicsheattransientGraphN, v : Double) -> PhysicsheattransientGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_min(s : PhysicsheattransientGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_graphn_max(s : PhysicsheattransientGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_graphn_to_string(s : PhysicsheattransientGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_node_make(size : Int) -> PhysicsheattransientNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_node_len(s : PhysicsheattransientNode) -> Int { s.size }

pub fn physics_heat_transient_node_get(s : PhysicsheattransientNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_node_set(s : PhysicsheattransientNode, i : Int, v : Double) -> PhysicsheattransientNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_sum(s : PhysicsheattransientNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_node_mean(s : PhysicsheattransientNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_node_scale(s : PhysicsheattransientNode, f : Double) -> PhysicsheattransientNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_add(a : PhysicsheattransientNode, b : PhysicsheattransientNode) -> PhysicsheattransientNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_node_copy(s : PhysicsheattransientNode) -> PhysicsheattransientNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_fill(s : PhysicsheattransientNode, v : Double) -> PhysicsheattransientNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_min(s : PhysicsheattransientNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_node_max(s : PhysicsheattransientNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_node_to_string(s : PhysicsheattransientNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_edge_make(size : Int) -> PhysicsheattransientEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_edge_len(s : PhysicsheattransientEdge) -> Int { s.size }

pub fn physics_heat_transient_edge_get(s : PhysicsheattransientEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_edge_set(s : PhysicsheattransientEdge, i : Int, v : Double) -> PhysicsheattransientEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_sum(s : PhysicsheattransientEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_edge_mean(s : PhysicsheattransientEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_edge_scale(s : PhysicsheattransientEdge, f : Double) -> PhysicsheattransientEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_add(a : PhysicsheattransientEdge, b : PhysicsheattransientEdge) -> PhysicsheattransientEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_edge_copy(s : PhysicsheattransientEdge) -> PhysicsheattransientEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_fill(s : PhysicsheattransientEdge, v : Double) -> PhysicsheattransientEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_min(s : PhysicsheattransientEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_edge_max(s : PhysicsheattransientEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_edge_to_string(s : PhysicsheattransientEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_path_make(size : Int) -> PhysicsheattransientPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_path_len(s : PhysicsheattransientPath) -> Int { s.size }

pub fn physics_heat_transient_path_get(s : PhysicsheattransientPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_path_set(s : PhysicsheattransientPath, i : Int, v : Double) -> PhysicsheattransientPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_sum(s : PhysicsheattransientPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_path_mean(s : PhysicsheattransientPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_path_scale(s : PhysicsheattransientPath, f : Double) -> PhysicsheattransientPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_add(a : PhysicsheattransientPath, b : PhysicsheattransientPath) -> PhysicsheattransientPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_path_copy(s : PhysicsheattransientPath) -> PhysicsheattransientPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_fill(s : PhysicsheattransientPath, v : Double) -> PhysicsheattransientPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_min(s : PhysicsheattransientPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_path_max(s : PhysicsheattransientPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_path_to_string(s : PhysicsheattransientPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_cluster_make(size : Int) -> PhysicsheattransientCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_cluster_len(s : PhysicsheattransientCluster) -> Int { s.size }

pub fn physics_heat_transient_cluster_get(s : PhysicsheattransientCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_cluster_set(s : PhysicsheattransientCluster, i : Int, v : Double) -> PhysicsheattransientCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_sum(s : PhysicsheattransientCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_cluster_mean(s : PhysicsheattransientCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_cluster_scale(s : PhysicsheattransientCluster, f : Double) -> PhysicsheattransientCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_add(a : PhysicsheattransientCluster, b : PhysicsheattransientCluster) -> PhysicsheattransientCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_cluster_copy(s : PhysicsheattransientCluster) -> PhysicsheattransientCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_fill(s : PhysicsheattransientCluster, v : Double) -> PhysicsheattransientCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_min(s : PhysicsheattransientCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_cluster_max(s : PhysicsheattransientCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_cluster_to_string(s : PhysicsheattransientCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_model_make(size : Int) -> PhysicsheattransientModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_model_len(s : PhysicsheattransientModel) -> Int { s.size }

pub fn physics_heat_transient_model_get(s : PhysicsheattransientModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_model_set(s : PhysicsheattransientModel, i : Int, v : Double) -> PhysicsheattransientModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_sum(s : PhysicsheattransientModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_model_mean(s : PhysicsheattransientModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_model_scale(s : PhysicsheattransientModel, f : Double) -> PhysicsheattransientModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_add(a : PhysicsheattransientModel, b : PhysicsheattransientModel) -> PhysicsheattransientModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_model_copy(s : PhysicsheattransientModel) -> PhysicsheattransientModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_fill(s : PhysicsheattransientModel, v : Double) -> PhysicsheattransientModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_min(s : PhysicsheattransientModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_model_max(s : PhysicsheattransientModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_model_to_string(s : PhysicsheattransientModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_layer_make(size : Int) -> PhysicsheattransientLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_layer_len(s : PhysicsheattransientLayer) -> Int { s.size }

pub fn physics_heat_transient_layer_get(s : PhysicsheattransientLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_layer_set(s : PhysicsheattransientLayer, i : Int, v : Double) -> PhysicsheattransientLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_sum(s : PhysicsheattransientLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_layer_mean(s : PhysicsheattransientLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_layer_scale(s : PhysicsheattransientLayer, f : Double) -> PhysicsheattransientLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_add(a : PhysicsheattransientLayer, b : PhysicsheattransientLayer) -> PhysicsheattransientLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_layer_copy(s : PhysicsheattransientLayer) -> PhysicsheattransientLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_fill(s : PhysicsheattransientLayer, v : Double) -> PhysicsheattransientLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_min(s : PhysicsheattransientLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_layer_max(s : PhysicsheattransientLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_layer_to_string(s : PhysicsheattransientLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_buffer_make(size : Int) -> PhysicsheattransientBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_buffer_len(s : PhysicsheattransientBuffer) -> Int { s.size }

pub fn physics_heat_transient_buffer_get(s : PhysicsheattransientBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_buffer_set(s : PhysicsheattransientBuffer, i : Int, v : Double) -> PhysicsheattransientBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_sum(s : PhysicsheattransientBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_buffer_mean(s : PhysicsheattransientBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_buffer_scale(s : PhysicsheattransientBuffer, f : Double) -> PhysicsheattransientBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_add(a : PhysicsheattransientBuffer, b : PhysicsheattransientBuffer) -> PhysicsheattransientBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_buffer_copy(s : PhysicsheattransientBuffer) -> PhysicsheattransientBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_fill(s : PhysicsheattransientBuffer, v : Double) -> PhysicsheattransientBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_min(s : PhysicsheattransientBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_buffer_max(s : PhysicsheattransientBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_buffer_to_string(s : PhysicsheattransientBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_cursor_make(size : Int) -> PhysicsheattransientCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_cursor_len(s : PhysicsheattransientCursor) -> Int { s.size }

pub fn physics_heat_transient_cursor_get(s : PhysicsheattransientCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_cursor_set(s : PhysicsheattransientCursor, i : Int, v : Double) -> PhysicsheattransientCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_sum(s : PhysicsheattransientCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_cursor_mean(s : PhysicsheattransientCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_cursor_scale(s : PhysicsheattransientCursor, f : Double) -> PhysicsheattransientCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_add(a : PhysicsheattransientCursor, b : PhysicsheattransientCursor) -> PhysicsheattransientCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_cursor_copy(s : PhysicsheattransientCursor) -> PhysicsheattransientCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_fill(s : PhysicsheattransientCursor, v : Double) -> PhysicsheattransientCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_min(s : PhysicsheattransientCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_cursor_max(s : PhysicsheattransientCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_cursor_to_string(s : PhysicsheattransientCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_view_make(size : Int) -> PhysicsheattransientView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_view_len(s : PhysicsheattransientView) -> Int { s.size }

pub fn physics_heat_transient_view_get(s : PhysicsheattransientView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_view_set(s : PhysicsheattransientView, i : Int, v : Double) -> PhysicsheattransientView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_sum(s : PhysicsheattransientView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_view_mean(s : PhysicsheattransientView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_view_scale(s : PhysicsheattransientView, f : Double) -> PhysicsheattransientView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_add(a : PhysicsheattransientView, b : PhysicsheattransientView) -> PhysicsheattransientView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_view_copy(s : PhysicsheattransientView) -> PhysicsheattransientView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_fill(s : PhysicsheattransientView, v : Double) -> PhysicsheattransientView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_min(s : PhysicsheattransientView) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_view_max(s : PhysicsheattransientView) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_view_to_string(s : PhysicsheattransientView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_range_make(size : Int) -> PhysicsheattransientRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_range_len(s : PhysicsheattransientRange) -> Int { s.size }

pub fn physics_heat_transient_range_get(s : PhysicsheattransientRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_range_set(s : PhysicsheattransientRange, i : Int, v : Double) -> PhysicsheattransientRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_sum(s : PhysicsheattransientRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_range_mean(s : PhysicsheattransientRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_range_scale(s : PhysicsheattransientRange, f : Double) -> PhysicsheattransientRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_add(a : PhysicsheattransientRange, b : PhysicsheattransientRange) -> PhysicsheattransientRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_range_copy(s : PhysicsheattransientRange) -> PhysicsheattransientRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_fill(s : PhysicsheattransientRange, v : Double) -> PhysicsheattransientRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_min(s : PhysicsheattransientRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_range_max(s : PhysicsheattransientRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_range_to_string(s : PhysicsheattransientRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_slice_make(size : Int) -> PhysicsheattransientSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_slice_len(s : PhysicsheattransientSlice) -> Int { s.size }

pub fn physics_heat_transient_slice_get(s : PhysicsheattransientSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_slice_set(s : PhysicsheattransientSlice, i : Int, v : Double) -> PhysicsheattransientSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_sum(s : PhysicsheattransientSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_slice_mean(s : PhysicsheattransientSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_slice_scale(s : PhysicsheattransientSlice, f : Double) -> PhysicsheattransientSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_add(a : PhysicsheattransientSlice, b : PhysicsheattransientSlice) -> PhysicsheattransientSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_slice_copy(s : PhysicsheattransientSlice) -> PhysicsheattransientSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_fill(s : PhysicsheattransientSlice, v : Double) -> PhysicsheattransientSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_min(s : PhysicsheattransientSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_slice_max(s : PhysicsheattransientSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_slice_to_string(s : PhysicsheattransientSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

