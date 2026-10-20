///===
/// extcore/physics_fluid_vortex

pub(all) struct PhysicsfluidvortexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_vortex_make_point(x : Double, y : Double) -> PhysicsfluidvortexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_vortex_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidvortexPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidvortexPoint::x(self : PhysicsfluidvortexPoint) -> Double { self.x }

pub fn PhysicsfluidvortexPoint::y(self : PhysicsfluidvortexPoint) -> Double { self.y }

pub fn PhysicsfluidvortexPoint::z(self : PhysicsfluidvortexPoint) -> Double { self.z }

pub fn PhysicsfluidvortexPoint::label(self : PhysicsfluidvortexPoint) -> Int { self.label }

pub fn PhysicsfluidvortexPoint::dist(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidvortexPoint::add(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidvortexPoint::sub(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidvortexPoint::scale(self : PhysicsfluidvortexPoint, s : Double) -> PhysicsfluidvortexPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidvortexPoint::dot(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidvortexPoint::cross(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidvortexPoint::norm(self : PhysicsfluidvortexPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidvortexPoint::normalize(self : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidvortexPoint::negate(self : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidvortexPoint::mid(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidvortexPoint::lerp(self : PhysicsfluidvortexPoint, other : PhysicsfluidvortexPoint, t : Double) -> PhysicsfluidvortexPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidvortexPoint::to_string(self : PhysicsfluidvortexPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_vortex_make_series(vals : Array[Double], name : String) -> PhysicsfluidvortexSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidvortexSeries::len(self : PhysicsfluidvortexSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidvortexSeries::sum(self : PhysicsfluidvortexSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidvortexSeries::mean(self : PhysicsfluidvortexSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidvortexSeries::min(self : PhysicsfluidvortexSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidvortexSeries::max(self : PhysicsfluidvortexSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidvortexSeries::range(self : PhysicsfluidvortexSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidvortexSeries::variance(self : PhysicsfluidvortexSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidvortexSeries::std(self : PhysicsfluidvortexSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidvortexSeries::median(self : PhysicsfluidvortexSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidvortexSeries::scale(self : PhysicsfluidvortexSeries, f : Double) -> PhysicsfluidvortexSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidvortexSeries::add(self : PhysicsfluidvortexSeries, other : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidvortexSeries::sub(self : PhysicsfluidvortexSeries, other : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidvortexSeries::normalize(self : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidvortexSeries::cumsum(self : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidvortexSeries::to_string(self : PhysicsfluidvortexSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvortexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_vortex_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidvortexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_vortex_matrix_identity(n : Int) -> PhysicsfluidvortexMatrix {
  let m = physics_fluid_vortex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidvortexMatrix::get(self : PhysicsfluidvortexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidvortexMatrix::transpose(self : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  let result = physics_fluid_vortex_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidvortexMatrix::add(self : PhysicsfluidvortexMatrix, other : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_vortex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidvortexMatrix::scale(self : PhysicsfluidvortexMatrix, s : Double) -> PhysicsfluidvortexMatrix {
  let result = physics_fluid_vortex_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidvortexMatrix::multiply(self : PhysicsfluidvortexMatrix, other : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  if self.cols != other.rows { return physics_fluid_vortex_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_vortex_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidvortexMatrix::trace(self : PhysicsfluidvortexMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidvortexMatrix::det(self : PhysicsfluidvortexMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidvortexMatrix::norm(self : PhysicsfluidvortexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidvortexMatrix::to_string(self : PhysicsfluidvortexMatrix) -> String {
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

pub(all) struct PhysicsfluidvortexVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_vortex_make_vector(comps : Array[Double]) -> PhysicsfluidvortexVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_vortex_vector_zero(dim : Int) -> PhysicsfluidvortexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidvortexVector::add(self : PhysicsfluidvortexVector, other : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidvortexVector::sub(self : PhysicsfluidvortexVector, other : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidvortexVector::scale(self : PhysicsfluidvortexVector, s : Double) -> PhysicsfluidvortexVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidvortexVector::dot(self : PhysicsfluidvortexVector, other : PhysicsfluidvortexVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidvortexVector::norm(self : PhysicsfluidvortexVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidvortexVector::normalize(self : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidvortexVector::dist(self : PhysicsfluidvortexVector, other : PhysicsfluidvortexVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidvortexVector::to_string(self : PhysicsfluidvortexVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_vortex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_vortex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_vortex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_vortex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_vortex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_vortex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_vortex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_vortex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_vortex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_vortex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_vortex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_vortex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_vortex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_vortex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_vortex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_vortex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_vortex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_vortex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_vortex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_vortex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_vortex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_vortex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_vortex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_vortex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_vortex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_vortex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_vortex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_vortex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_vortex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidvortexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_frame_make(size : Int) -> PhysicsfluidvortexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_frame_len(s : PhysicsfluidvortexFrame) -> Int { s.size }

pub fn physics_fluid_vortex_frame_get(s : PhysicsfluidvortexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_frame_set(s : PhysicsfluidvortexFrame, i : Int, v : Double) -> PhysicsfluidvortexFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_sum(s : PhysicsfluidvortexFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_frame_mean(s : PhysicsfluidvortexFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_frame_scale(s : PhysicsfluidvortexFrame, f : Double) -> PhysicsfluidvortexFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_add(a : PhysicsfluidvortexFrame, b : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_frame_copy(s : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_fill(s : PhysicsfluidvortexFrame, v : Double) -> PhysicsfluidvortexFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_min(s : PhysicsfluidvortexFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_frame_max(s : PhysicsfluidvortexFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_frame_to_string(s : PhysicsfluidvortexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_table_make(size : Int) -> PhysicsfluidvortexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_table_len(s : PhysicsfluidvortexTable) -> Int { s.size }

pub fn physics_fluid_vortex_table_get(s : PhysicsfluidvortexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_table_set(s : PhysicsfluidvortexTable, i : Int, v : Double) -> PhysicsfluidvortexTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_sum(s : PhysicsfluidvortexTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_table_mean(s : PhysicsfluidvortexTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_table_scale(s : PhysicsfluidvortexTable, f : Double) -> PhysicsfluidvortexTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_add(a : PhysicsfluidvortexTable, b : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_table_copy(s : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_fill(s : PhysicsfluidvortexTable, v : Double) -> PhysicsfluidvortexTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_min(s : PhysicsfluidvortexTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_table_max(s : PhysicsfluidvortexTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_table_to_string(s : PhysicsfluidvortexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_graphn_make(size : Int) -> PhysicsfluidvortexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_graphn_len(s : PhysicsfluidvortexGraphN) -> Int { s.size }

pub fn physics_fluid_vortex_graphn_get(s : PhysicsfluidvortexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_graphn_set(s : PhysicsfluidvortexGraphN, i : Int, v : Double) -> PhysicsfluidvortexGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_sum(s : PhysicsfluidvortexGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_graphn_mean(s : PhysicsfluidvortexGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_graphn_scale(s : PhysicsfluidvortexGraphN, f : Double) -> PhysicsfluidvortexGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_add(a : PhysicsfluidvortexGraphN, b : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_graphn_copy(s : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_fill(s : PhysicsfluidvortexGraphN, v : Double) -> PhysicsfluidvortexGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_min(s : PhysicsfluidvortexGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_graphn_max(s : PhysicsfluidvortexGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_graphn_to_string(s : PhysicsfluidvortexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_node_make(size : Int) -> PhysicsfluidvortexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_node_len(s : PhysicsfluidvortexNode) -> Int { s.size }

pub fn physics_fluid_vortex_node_get(s : PhysicsfluidvortexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_node_set(s : PhysicsfluidvortexNode, i : Int, v : Double) -> PhysicsfluidvortexNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_sum(s : PhysicsfluidvortexNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_node_mean(s : PhysicsfluidvortexNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_node_scale(s : PhysicsfluidvortexNode, f : Double) -> PhysicsfluidvortexNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_add(a : PhysicsfluidvortexNode, b : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_node_copy(s : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_fill(s : PhysicsfluidvortexNode, v : Double) -> PhysicsfluidvortexNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_min(s : PhysicsfluidvortexNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_node_max(s : PhysicsfluidvortexNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_node_to_string(s : PhysicsfluidvortexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_edge_make(size : Int) -> PhysicsfluidvortexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_edge_len(s : PhysicsfluidvortexEdge) -> Int { s.size }

pub fn physics_fluid_vortex_edge_get(s : PhysicsfluidvortexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_edge_set(s : PhysicsfluidvortexEdge, i : Int, v : Double) -> PhysicsfluidvortexEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_sum(s : PhysicsfluidvortexEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_edge_mean(s : PhysicsfluidvortexEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_edge_scale(s : PhysicsfluidvortexEdge, f : Double) -> PhysicsfluidvortexEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_add(a : PhysicsfluidvortexEdge, b : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_edge_copy(s : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_fill(s : PhysicsfluidvortexEdge, v : Double) -> PhysicsfluidvortexEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_min(s : PhysicsfluidvortexEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_edge_max(s : PhysicsfluidvortexEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_edge_to_string(s : PhysicsfluidvortexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_path_make(size : Int) -> PhysicsfluidvortexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_path_len(s : PhysicsfluidvortexPath) -> Int { s.size }

pub fn physics_fluid_vortex_path_get(s : PhysicsfluidvortexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_path_set(s : PhysicsfluidvortexPath, i : Int, v : Double) -> PhysicsfluidvortexPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_sum(s : PhysicsfluidvortexPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_path_mean(s : PhysicsfluidvortexPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_path_scale(s : PhysicsfluidvortexPath, f : Double) -> PhysicsfluidvortexPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_add(a : PhysicsfluidvortexPath, b : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_path_copy(s : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_fill(s : PhysicsfluidvortexPath, v : Double) -> PhysicsfluidvortexPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_min(s : PhysicsfluidvortexPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_path_max(s : PhysicsfluidvortexPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_path_to_string(s : PhysicsfluidvortexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cluster_make(size : Int) -> PhysicsfluidvortexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_cluster_len(s : PhysicsfluidvortexCluster) -> Int { s.size }

pub fn physics_fluid_vortex_cluster_get(s : PhysicsfluidvortexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_cluster_set(s : PhysicsfluidvortexCluster, i : Int, v : Double) -> PhysicsfluidvortexCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_sum(s : PhysicsfluidvortexCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_cluster_mean(s : PhysicsfluidvortexCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_cluster_scale(s : PhysicsfluidvortexCluster, f : Double) -> PhysicsfluidvortexCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_add(a : PhysicsfluidvortexCluster, b : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_cluster_copy(s : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_fill(s : PhysicsfluidvortexCluster, v : Double) -> PhysicsfluidvortexCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_min(s : PhysicsfluidvortexCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_cluster_max(s : PhysicsfluidvortexCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_cluster_to_string(s : PhysicsfluidvortexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_model_make(size : Int) -> PhysicsfluidvortexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_model_len(s : PhysicsfluidvortexModel) -> Int { s.size }

pub fn physics_fluid_vortex_model_get(s : PhysicsfluidvortexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_model_set(s : PhysicsfluidvortexModel, i : Int, v : Double) -> PhysicsfluidvortexModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_sum(s : PhysicsfluidvortexModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_model_mean(s : PhysicsfluidvortexModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_model_scale(s : PhysicsfluidvortexModel, f : Double) -> PhysicsfluidvortexModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_add(a : PhysicsfluidvortexModel, b : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_model_copy(s : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_fill(s : PhysicsfluidvortexModel, v : Double) -> PhysicsfluidvortexModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_min(s : PhysicsfluidvortexModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_model_max(s : PhysicsfluidvortexModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_model_to_string(s : PhysicsfluidvortexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_layer_make(size : Int) -> PhysicsfluidvortexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_layer_len(s : PhysicsfluidvortexLayer) -> Int { s.size }

pub fn physics_fluid_vortex_layer_get(s : PhysicsfluidvortexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_layer_set(s : PhysicsfluidvortexLayer, i : Int, v : Double) -> PhysicsfluidvortexLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_sum(s : PhysicsfluidvortexLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_layer_mean(s : PhysicsfluidvortexLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_layer_scale(s : PhysicsfluidvortexLayer, f : Double) -> PhysicsfluidvortexLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_add(a : PhysicsfluidvortexLayer, b : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_layer_copy(s : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_fill(s : PhysicsfluidvortexLayer, v : Double) -> PhysicsfluidvortexLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_min(s : PhysicsfluidvortexLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_layer_max(s : PhysicsfluidvortexLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_layer_to_string(s : PhysicsfluidvortexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_buffer_make(size : Int) -> PhysicsfluidvortexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_buffer_len(s : PhysicsfluidvortexBuffer) -> Int { s.size }

pub fn physics_fluid_vortex_buffer_get(s : PhysicsfluidvortexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_buffer_set(s : PhysicsfluidvortexBuffer, i : Int, v : Double) -> PhysicsfluidvortexBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_sum(s : PhysicsfluidvortexBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_buffer_mean(s : PhysicsfluidvortexBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_buffer_scale(s : PhysicsfluidvortexBuffer, f : Double) -> PhysicsfluidvortexBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_add(a : PhysicsfluidvortexBuffer, b : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_buffer_copy(s : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_fill(s : PhysicsfluidvortexBuffer, v : Double) -> PhysicsfluidvortexBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_min(s : PhysicsfluidvortexBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_buffer_max(s : PhysicsfluidvortexBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_buffer_to_string(s : PhysicsfluidvortexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cursor_make(size : Int) -> PhysicsfluidvortexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_cursor_len(s : PhysicsfluidvortexCursor) -> Int { s.size }

pub fn physics_fluid_vortex_cursor_get(s : PhysicsfluidvortexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_cursor_set(s : PhysicsfluidvortexCursor, i : Int, v : Double) -> PhysicsfluidvortexCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_sum(s : PhysicsfluidvortexCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_cursor_mean(s : PhysicsfluidvortexCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_cursor_scale(s : PhysicsfluidvortexCursor, f : Double) -> PhysicsfluidvortexCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_add(a : PhysicsfluidvortexCursor, b : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_cursor_copy(s : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_fill(s : PhysicsfluidvortexCursor, v : Double) -> PhysicsfluidvortexCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_min(s : PhysicsfluidvortexCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_cursor_max(s : PhysicsfluidvortexCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_cursor_to_string(s : PhysicsfluidvortexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_view_make(size : Int) -> PhysicsfluidvortexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_view_len(s : PhysicsfluidvortexView) -> Int { s.size }

pub fn physics_fluid_vortex_view_get(s : PhysicsfluidvortexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_view_set(s : PhysicsfluidvortexView, i : Int, v : Double) -> PhysicsfluidvortexView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_sum(s : PhysicsfluidvortexView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_view_mean(s : PhysicsfluidvortexView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_view_scale(s : PhysicsfluidvortexView, f : Double) -> PhysicsfluidvortexView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_add(a : PhysicsfluidvortexView, b : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_view_copy(s : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_fill(s : PhysicsfluidvortexView, v : Double) -> PhysicsfluidvortexView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_min(s : PhysicsfluidvortexView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_view_max(s : PhysicsfluidvortexView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_view_to_string(s : PhysicsfluidvortexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_range_make(size : Int) -> PhysicsfluidvortexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_range_len(s : PhysicsfluidvortexRange) -> Int { s.size }

pub fn physics_fluid_vortex_range_get(s : PhysicsfluidvortexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_range_set(s : PhysicsfluidvortexRange, i : Int, v : Double) -> PhysicsfluidvortexRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_sum(s : PhysicsfluidvortexRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_range_mean(s : PhysicsfluidvortexRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_range_scale(s : PhysicsfluidvortexRange, f : Double) -> PhysicsfluidvortexRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_add(a : PhysicsfluidvortexRange, b : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_range_copy(s : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_fill(s : PhysicsfluidvortexRange, v : Double) -> PhysicsfluidvortexRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_min(s : PhysicsfluidvortexRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_range_max(s : PhysicsfluidvortexRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_range_to_string(s : PhysicsfluidvortexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_slice_make(size : Int) -> PhysicsfluidvortexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_slice_len(s : PhysicsfluidvortexSlice) -> Int { s.size }

pub fn physics_fluid_vortex_slice_get(s : PhysicsfluidvortexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_slice_set(s : PhysicsfluidvortexSlice, i : Int, v : Double) -> PhysicsfluidvortexSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_sum(s : PhysicsfluidvortexSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_slice_mean(s : PhysicsfluidvortexSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_slice_scale(s : PhysicsfluidvortexSlice, f : Double) -> PhysicsfluidvortexSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_add(a : PhysicsfluidvortexSlice, b : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_slice_copy(s : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_fill(s : PhysicsfluidvortexSlice, v : Double) -> PhysicsfluidvortexSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_min(s : PhysicsfluidvortexSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_slice_max(s : PhysicsfluidvortexSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_slice_to_string(s : PhysicsfluidvortexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

