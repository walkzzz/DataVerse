///===
/// extcore/physics_fluid_compressible

pub(all) struct PhysicsfluidcompressiblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_compressible_make_point(x : Double, y : Double) -> PhysicsfluidcompressiblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_compressible_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidcompressiblePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidcompressiblePoint::x(self : PhysicsfluidcompressiblePoint) -> Double { self.x }

pub fn PhysicsfluidcompressiblePoint::y(self : PhysicsfluidcompressiblePoint) -> Double { self.y }

pub fn PhysicsfluidcompressiblePoint::z(self : PhysicsfluidcompressiblePoint) -> Double { self.z }

pub fn PhysicsfluidcompressiblePoint::label(self : PhysicsfluidcompressiblePoint) -> Int { self.label }

pub fn PhysicsfluidcompressiblePoint::dist(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidcompressiblePoint::add(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidcompressiblePoint::sub(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidcompressiblePoint::scale(self : PhysicsfluidcompressiblePoint, s : Double) -> PhysicsfluidcompressiblePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidcompressiblePoint::dot(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidcompressiblePoint::cross(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidcompressiblePoint::norm(self : PhysicsfluidcompressiblePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidcompressiblePoint::normalize(self : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidcompressiblePoint::negate(self : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidcompressiblePoint::mid(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidcompressiblePoint::lerp(self : PhysicsfluidcompressiblePoint, other : PhysicsfluidcompressiblePoint, t : Double) -> PhysicsfluidcompressiblePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidcompressiblePoint::to_string(self : PhysicsfluidcompressiblePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_compressible_make_series(vals : Array[Double], name : String) -> PhysicsfluidcompressibleSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidcompressibleSeries::len(self : PhysicsfluidcompressibleSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidcompressibleSeries::sum(self : PhysicsfluidcompressibleSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidcompressibleSeries::mean(self : PhysicsfluidcompressibleSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidcompressibleSeries::min(self : PhysicsfluidcompressibleSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidcompressibleSeries::max(self : PhysicsfluidcompressibleSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidcompressibleSeries::range(self : PhysicsfluidcompressibleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidcompressibleSeries::variance(self : PhysicsfluidcompressibleSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidcompressibleSeries::std(self : PhysicsfluidcompressibleSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidcompressibleSeries::median(self : PhysicsfluidcompressibleSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidcompressibleSeries::scale(self : PhysicsfluidcompressibleSeries, f : Double) -> PhysicsfluidcompressibleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidcompressibleSeries::add(self : PhysicsfluidcompressibleSeries, other : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidcompressibleSeries::sub(self : PhysicsfluidcompressibleSeries, other : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidcompressibleSeries::normalize(self : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidcompressibleSeries::cumsum(self : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidcompressibleSeries::to_string(self : PhysicsfluidcompressibleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidcompressibleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_compressible_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidcompressibleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_compressible_matrix_identity(n : Int) -> PhysicsfluidcompressibleMatrix {
  let m = physics_fluid_compressible_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidcompressibleMatrix::get(self : PhysicsfluidcompressibleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidcompressibleMatrix::transpose(self : PhysicsfluidcompressibleMatrix) -> PhysicsfluidcompressibleMatrix {
  let result = physics_fluid_compressible_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidcompressibleMatrix::add(self : PhysicsfluidcompressibleMatrix, other : PhysicsfluidcompressibleMatrix) -> PhysicsfluidcompressibleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_compressible_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidcompressibleMatrix::scale(self : PhysicsfluidcompressibleMatrix, s : Double) -> PhysicsfluidcompressibleMatrix {
  let result = physics_fluid_compressible_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidcompressibleMatrix::multiply(self : PhysicsfluidcompressibleMatrix, other : PhysicsfluidcompressibleMatrix) -> PhysicsfluidcompressibleMatrix {
  if self.cols != other.rows { return physics_fluid_compressible_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_compressible_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidcompressibleMatrix::trace(self : PhysicsfluidcompressibleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidcompressibleMatrix::det(self : PhysicsfluidcompressibleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidcompressibleMatrix::norm(self : PhysicsfluidcompressibleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidcompressibleMatrix::to_string(self : PhysicsfluidcompressibleMatrix) -> String {
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

pub(all) struct PhysicsfluidcompressibleVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_compressible_make_vector(comps : Array[Double]) -> PhysicsfluidcompressibleVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_compressible_vector_zero(dim : Int) -> PhysicsfluidcompressibleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidcompressibleVector::add(self : PhysicsfluidcompressibleVector, other : PhysicsfluidcompressibleVector) -> PhysicsfluidcompressibleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidcompressibleVector::sub(self : PhysicsfluidcompressibleVector, other : PhysicsfluidcompressibleVector) -> PhysicsfluidcompressibleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidcompressibleVector::scale(self : PhysicsfluidcompressibleVector, s : Double) -> PhysicsfluidcompressibleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidcompressibleVector::dot(self : PhysicsfluidcompressibleVector, other : PhysicsfluidcompressibleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidcompressibleVector::norm(self : PhysicsfluidcompressibleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidcompressibleVector::normalize(self : PhysicsfluidcompressibleVector) -> PhysicsfluidcompressibleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidcompressibleVector::dist(self : PhysicsfluidcompressibleVector, other : PhysicsfluidcompressibleVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidcompressibleVector::to_string(self : PhysicsfluidcompressibleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_compressible_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_compressible_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_compressible_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_compressible_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_compressible_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_compressible_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_compressible_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_compressible_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_compressible_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_compressible_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_compressible_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_compressible_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_compressible_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_compressible_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_compressible_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_compressible_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_compressible_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_compressible_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_compressible_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_compressible_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_compressible_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_compressible_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_compressible_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_compressible_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_compressible_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_compressible_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_compressible_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_compressible_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_compressible_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidcompressibleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_frame_make(size : Int) -> PhysicsfluidcompressibleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_frame_len(s : PhysicsfluidcompressibleFrame) -> Int { s.size }

pub fn physics_fluid_compressible_frame_get(s : PhysicsfluidcompressibleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_frame_set(s : PhysicsfluidcompressibleFrame, i : Int, v : Double) -> PhysicsfluidcompressibleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_frame_sum(s : PhysicsfluidcompressibleFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_frame_mean(s : PhysicsfluidcompressibleFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_frame_scale(s : PhysicsfluidcompressibleFrame, f : Double) -> PhysicsfluidcompressibleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_frame_add(a : PhysicsfluidcompressibleFrame, b : PhysicsfluidcompressibleFrame) -> PhysicsfluidcompressibleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_frame_copy(s : PhysicsfluidcompressibleFrame) -> PhysicsfluidcompressibleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_frame_fill(s : PhysicsfluidcompressibleFrame, v : Double) -> PhysicsfluidcompressibleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_frame_min(s : PhysicsfluidcompressibleFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_frame_max(s : PhysicsfluidcompressibleFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_frame_to_string(s : PhysicsfluidcompressibleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_table_make(size : Int) -> PhysicsfluidcompressibleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_table_len(s : PhysicsfluidcompressibleTable) -> Int { s.size }

pub fn physics_fluid_compressible_table_get(s : PhysicsfluidcompressibleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_table_set(s : PhysicsfluidcompressibleTable, i : Int, v : Double) -> PhysicsfluidcompressibleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_table_sum(s : PhysicsfluidcompressibleTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_table_mean(s : PhysicsfluidcompressibleTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_table_scale(s : PhysicsfluidcompressibleTable, f : Double) -> PhysicsfluidcompressibleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_table_add(a : PhysicsfluidcompressibleTable, b : PhysicsfluidcompressibleTable) -> PhysicsfluidcompressibleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_table_copy(s : PhysicsfluidcompressibleTable) -> PhysicsfluidcompressibleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_table_fill(s : PhysicsfluidcompressibleTable, v : Double) -> PhysicsfluidcompressibleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_table_min(s : PhysicsfluidcompressibleTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_table_max(s : PhysicsfluidcompressibleTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_table_to_string(s : PhysicsfluidcompressibleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_graphn_make(size : Int) -> PhysicsfluidcompressibleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_graphn_len(s : PhysicsfluidcompressibleGraphN) -> Int { s.size }

pub fn physics_fluid_compressible_graphn_get(s : PhysicsfluidcompressibleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_graphn_set(s : PhysicsfluidcompressibleGraphN, i : Int, v : Double) -> PhysicsfluidcompressibleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_graphn_sum(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_graphn_mean(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_graphn_scale(s : PhysicsfluidcompressibleGraphN, f : Double) -> PhysicsfluidcompressibleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_graphn_add(a : PhysicsfluidcompressibleGraphN, b : PhysicsfluidcompressibleGraphN) -> PhysicsfluidcompressibleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_graphn_copy(s : PhysicsfluidcompressibleGraphN) -> PhysicsfluidcompressibleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_graphn_fill(s : PhysicsfluidcompressibleGraphN, v : Double) -> PhysicsfluidcompressibleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_graphn_min(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_graphn_max(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_graphn_to_string(s : PhysicsfluidcompressibleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_node_make(size : Int) -> PhysicsfluidcompressibleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_node_len(s : PhysicsfluidcompressibleNode) -> Int { s.size }

pub fn physics_fluid_compressible_node_get(s : PhysicsfluidcompressibleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_node_set(s : PhysicsfluidcompressibleNode, i : Int, v : Double) -> PhysicsfluidcompressibleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_node_sum(s : PhysicsfluidcompressibleNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_node_mean(s : PhysicsfluidcompressibleNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_node_scale(s : PhysicsfluidcompressibleNode, f : Double) -> PhysicsfluidcompressibleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_node_add(a : PhysicsfluidcompressibleNode, b : PhysicsfluidcompressibleNode) -> PhysicsfluidcompressibleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_node_copy(s : PhysicsfluidcompressibleNode) -> PhysicsfluidcompressibleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_node_fill(s : PhysicsfluidcompressibleNode, v : Double) -> PhysicsfluidcompressibleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_node_min(s : PhysicsfluidcompressibleNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_node_max(s : PhysicsfluidcompressibleNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_node_to_string(s : PhysicsfluidcompressibleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_edge_make(size : Int) -> PhysicsfluidcompressibleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_edge_len(s : PhysicsfluidcompressibleEdge) -> Int { s.size }

pub fn physics_fluid_compressible_edge_get(s : PhysicsfluidcompressibleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_edge_set(s : PhysicsfluidcompressibleEdge, i : Int, v : Double) -> PhysicsfluidcompressibleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_edge_sum(s : PhysicsfluidcompressibleEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_edge_mean(s : PhysicsfluidcompressibleEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_edge_scale(s : PhysicsfluidcompressibleEdge, f : Double) -> PhysicsfluidcompressibleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_edge_add(a : PhysicsfluidcompressibleEdge, b : PhysicsfluidcompressibleEdge) -> PhysicsfluidcompressibleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_edge_copy(s : PhysicsfluidcompressibleEdge) -> PhysicsfluidcompressibleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_edge_fill(s : PhysicsfluidcompressibleEdge, v : Double) -> PhysicsfluidcompressibleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_edge_min(s : PhysicsfluidcompressibleEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_edge_max(s : PhysicsfluidcompressibleEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_edge_to_string(s : PhysicsfluidcompressibleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressiblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_path_make(size : Int) -> PhysicsfluidcompressiblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_path_len(s : PhysicsfluidcompressiblePath) -> Int { s.size }

pub fn physics_fluid_compressible_path_get(s : PhysicsfluidcompressiblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_path_set(s : PhysicsfluidcompressiblePath, i : Int, v : Double) -> PhysicsfluidcompressiblePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_path_sum(s : PhysicsfluidcompressiblePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_path_mean(s : PhysicsfluidcompressiblePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_path_scale(s : PhysicsfluidcompressiblePath, f : Double) -> PhysicsfluidcompressiblePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_path_add(a : PhysicsfluidcompressiblePath, b : PhysicsfluidcompressiblePath) -> PhysicsfluidcompressiblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_path_copy(s : PhysicsfluidcompressiblePath) -> PhysicsfluidcompressiblePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_path_fill(s : PhysicsfluidcompressiblePath, v : Double) -> PhysicsfluidcompressiblePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_path_min(s : PhysicsfluidcompressiblePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_path_max(s : PhysicsfluidcompressiblePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_path_to_string(s : PhysicsfluidcompressiblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_cluster_make(size : Int) -> PhysicsfluidcompressibleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_cluster_len(s : PhysicsfluidcompressibleCluster) -> Int { s.size }

pub fn physics_fluid_compressible_cluster_get(s : PhysicsfluidcompressibleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_cluster_set(s : PhysicsfluidcompressibleCluster, i : Int, v : Double) -> PhysicsfluidcompressibleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cluster_sum(s : PhysicsfluidcompressibleCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_cluster_mean(s : PhysicsfluidcompressibleCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_cluster_scale(s : PhysicsfluidcompressibleCluster, f : Double) -> PhysicsfluidcompressibleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cluster_add(a : PhysicsfluidcompressibleCluster, b : PhysicsfluidcompressibleCluster) -> PhysicsfluidcompressibleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_cluster_copy(s : PhysicsfluidcompressibleCluster) -> PhysicsfluidcompressibleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cluster_fill(s : PhysicsfluidcompressibleCluster, v : Double) -> PhysicsfluidcompressibleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cluster_min(s : PhysicsfluidcompressibleCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_cluster_max(s : PhysicsfluidcompressibleCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_cluster_to_string(s : PhysicsfluidcompressibleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_model_make(size : Int) -> PhysicsfluidcompressibleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_model_len(s : PhysicsfluidcompressibleModel) -> Int { s.size }

pub fn physics_fluid_compressible_model_get(s : PhysicsfluidcompressibleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_model_set(s : PhysicsfluidcompressibleModel, i : Int, v : Double) -> PhysicsfluidcompressibleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_model_sum(s : PhysicsfluidcompressibleModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_model_mean(s : PhysicsfluidcompressibleModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_model_scale(s : PhysicsfluidcompressibleModel, f : Double) -> PhysicsfluidcompressibleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_model_add(a : PhysicsfluidcompressibleModel, b : PhysicsfluidcompressibleModel) -> PhysicsfluidcompressibleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_model_copy(s : PhysicsfluidcompressibleModel) -> PhysicsfluidcompressibleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_model_fill(s : PhysicsfluidcompressibleModel, v : Double) -> PhysicsfluidcompressibleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_model_min(s : PhysicsfluidcompressibleModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_model_max(s : PhysicsfluidcompressibleModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_model_to_string(s : PhysicsfluidcompressibleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_layer_make(size : Int) -> PhysicsfluidcompressibleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_layer_len(s : PhysicsfluidcompressibleLayer) -> Int { s.size }

pub fn physics_fluid_compressible_layer_get(s : PhysicsfluidcompressibleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_layer_set(s : PhysicsfluidcompressibleLayer, i : Int, v : Double) -> PhysicsfluidcompressibleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_layer_sum(s : PhysicsfluidcompressibleLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_layer_mean(s : PhysicsfluidcompressibleLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_layer_scale(s : PhysicsfluidcompressibleLayer, f : Double) -> PhysicsfluidcompressibleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_layer_add(a : PhysicsfluidcompressibleLayer, b : PhysicsfluidcompressibleLayer) -> PhysicsfluidcompressibleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_layer_copy(s : PhysicsfluidcompressibleLayer) -> PhysicsfluidcompressibleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_layer_fill(s : PhysicsfluidcompressibleLayer, v : Double) -> PhysicsfluidcompressibleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_layer_min(s : PhysicsfluidcompressibleLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_layer_max(s : PhysicsfluidcompressibleLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_layer_to_string(s : PhysicsfluidcompressibleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_buffer_make(size : Int) -> PhysicsfluidcompressibleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_buffer_len(s : PhysicsfluidcompressibleBuffer) -> Int { s.size }

pub fn physics_fluid_compressible_buffer_get(s : PhysicsfluidcompressibleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_buffer_set(s : PhysicsfluidcompressibleBuffer, i : Int, v : Double) -> PhysicsfluidcompressibleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_buffer_sum(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_buffer_mean(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_buffer_scale(s : PhysicsfluidcompressibleBuffer, f : Double) -> PhysicsfluidcompressibleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_buffer_add(a : PhysicsfluidcompressibleBuffer, b : PhysicsfluidcompressibleBuffer) -> PhysicsfluidcompressibleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_buffer_copy(s : PhysicsfluidcompressibleBuffer) -> PhysicsfluidcompressibleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_buffer_fill(s : PhysicsfluidcompressibleBuffer, v : Double) -> PhysicsfluidcompressibleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_buffer_min(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_buffer_max(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_buffer_to_string(s : PhysicsfluidcompressibleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_cursor_make(size : Int) -> PhysicsfluidcompressibleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_cursor_len(s : PhysicsfluidcompressibleCursor) -> Int { s.size }

pub fn physics_fluid_compressible_cursor_get(s : PhysicsfluidcompressibleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_cursor_set(s : PhysicsfluidcompressibleCursor, i : Int, v : Double) -> PhysicsfluidcompressibleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cursor_sum(s : PhysicsfluidcompressibleCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_cursor_mean(s : PhysicsfluidcompressibleCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_cursor_scale(s : PhysicsfluidcompressibleCursor, f : Double) -> PhysicsfluidcompressibleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cursor_add(a : PhysicsfluidcompressibleCursor, b : PhysicsfluidcompressibleCursor) -> PhysicsfluidcompressibleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_cursor_copy(s : PhysicsfluidcompressibleCursor) -> PhysicsfluidcompressibleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cursor_fill(s : PhysicsfluidcompressibleCursor, v : Double) -> PhysicsfluidcompressibleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_cursor_min(s : PhysicsfluidcompressibleCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_cursor_max(s : PhysicsfluidcompressibleCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_cursor_to_string(s : PhysicsfluidcompressibleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_view_make(size : Int) -> PhysicsfluidcompressibleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_view_len(s : PhysicsfluidcompressibleView) -> Int { s.size }

pub fn physics_fluid_compressible_view_get(s : PhysicsfluidcompressibleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_view_set(s : PhysicsfluidcompressibleView, i : Int, v : Double) -> PhysicsfluidcompressibleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_view_sum(s : PhysicsfluidcompressibleView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_view_mean(s : PhysicsfluidcompressibleView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_view_scale(s : PhysicsfluidcompressibleView, f : Double) -> PhysicsfluidcompressibleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_view_add(a : PhysicsfluidcompressibleView, b : PhysicsfluidcompressibleView) -> PhysicsfluidcompressibleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_view_copy(s : PhysicsfluidcompressibleView) -> PhysicsfluidcompressibleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_view_fill(s : PhysicsfluidcompressibleView, v : Double) -> PhysicsfluidcompressibleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_view_min(s : PhysicsfluidcompressibleView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_view_max(s : PhysicsfluidcompressibleView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_view_to_string(s : PhysicsfluidcompressibleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_range_make(size : Int) -> PhysicsfluidcompressibleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_range_len(s : PhysicsfluidcompressibleRange) -> Int { s.size }

pub fn physics_fluid_compressible_range_get(s : PhysicsfluidcompressibleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_range_set(s : PhysicsfluidcompressibleRange, i : Int, v : Double) -> PhysicsfluidcompressibleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_range_sum(s : PhysicsfluidcompressibleRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_range_mean(s : PhysicsfluidcompressibleRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_range_scale(s : PhysicsfluidcompressibleRange, f : Double) -> PhysicsfluidcompressibleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_range_add(a : PhysicsfluidcompressibleRange, b : PhysicsfluidcompressibleRange) -> PhysicsfluidcompressibleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_range_copy(s : PhysicsfluidcompressibleRange) -> PhysicsfluidcompressibleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_range_fill(s : PhysicsfluidcompressibleRange, v : Double) -> PhysicsfluidcompressibleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_range_min(s : PhysicsfluidcompressibleRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_range_max(s : PhysicsfluidcompressibleRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_range_to_string(s : PhysicsfluidcompressibleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_slice_make(size : Int) -> PhysicsfluidcompressibleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_slice_len(s : PhysicsfluidcompressibleSlice) -> Int { s.size }

pub fn physics_fluid_compressible_slice_get(s : PhysicsfluidcompressibleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_slice_set(s : PhysicsfluidcompressibleSlice, i : Int, v : Double) -> PhysicsfluidcompressibleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_slice_sum(s : PhysicsfluidcompressibleSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_slice_mean(s : PhysicsfluidcompressibleSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_slice_scale(s : PhysicsfluidcompressibleSlice, f : Double) -> PhysicsfluidcompressibleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_slice_add(a : PhysicsfluidcompressibleSlice, b : PhysicsfluidcompressibleSlice) -> PhysicsfluidcompressibleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_compressible_slice_copy(s : PhysicsfluidcompressibleSlice) -> PhysicsfluidcompressibleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_slice_fill(s : PhysicsfluidcompressibleSlice, v : Double) -> PhysicsfluidcompressibleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_compressible_slice_min(s : PhysicsfluidcompressibleSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_slice_max(s : PhysicsfluidcompressibleSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_slice_to_string(s : PhysicsfluidcompressibleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

