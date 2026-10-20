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

pub fn PhysicsfluidcompressibleFrame::len(self : PhysicsfluidcompressibleFrame) -> Int { self.size }

pub fn PhysicsfluidcompressibleFrame::get(self : PhysicsfluidcompressibleFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleFrame::set(self : PhysicsfluidcompressibleFrame, i : Int, v : Double) -> PhysicsfluidcompressibleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleFrame::sum(self : PhysicsfluidcompressibleFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleFrame::mean(self : PhysicsfluidcompressibleFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleFrame::scale(self : PhysicsfluidcompressibleFrame, f : Double) -> PhysicsfluidcompressibleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleFrame::add(self : PhysicsfluidcompressibleFrame, other : PhysicsfluidcompressibleFrame) -> PhysicsfluidcompressibleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleFrame::copy(self : PhysicsfluidcompressibleFrame) -> PhysicsfluidcompressibleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleFrame::fill(self : PhysicsfluidcompressibleFrame, v : Double) -> PhysicsfluidcompressibleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleFrame::min(self : PhysicsfluidcompressibleFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleFrame::max(self : PhysicsfluidcompressibleFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleFrame::to_string(self : PhysicsfluidcompressibleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_table_make(size : Int) -> PhysicsfluidcompressibleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleTable::len(self : PhysicsfluidcompressibleTable) -> Int { self.size }

pub fn PhysicsfluidcompressibleTable::get(self : PhysicsfluidcompressibleTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleTable::set(self : PhysicsfluidcompressibleTable, i : Int, v : Double) -> PhysicsfluidcompressibleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleTable::sum(self : PhysicsfluidcompressibleTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleTable::mean(self : PhysicsfluidcompressibleTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleTable::scale(self : PhysicsfluidcompressibleTable, f : Double) -> PhysicsfluidcompressibleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleTable::add(self : PhysicsfluidcompressibleTable, other : PhysicsfluidcompressibleTable) -> PhysicsfluidcompressibleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleTable::copy(self : PhysicsfluidcompressibleTable) -> PhysicsfluidcompressibleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleTable::fill(self : PhysicsfluidcompressibleTable, v : Double) -> PhysicsfluidcompressibleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleTable::min(self : PhysicsfluidcompressibleTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleTable::max(self : PhysicsfluidcompressibleTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleTable::to_string(self : PhysicsfluidcompressibleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_graphn_make(size : Int) -> PhysicsfluidcompressibleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleGraphN::len(self : PhysicsfluidcompressibleGraphN) -> Int { self.size }

pub fn PhysicsfluidcompressibleGraphN::get(self : PhysicsfluidcompressibleGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleGraphN::set(self : PhysicsfluidcompressibleGraphN, i : Int, v : Double) -> PhysicsfluidcompressibleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleGraphN::sum(self : PhysicsfluidcompressibleGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleGraphN::mean(self : PhysicsfluidcompressibleGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleGraphN::scale(self : PhysicsfluidcompressibleGraphN, f : Double) -> PhysicsfluidcompressibleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleGraphN::add(self : PhysicsfluidcompressibleGraphN, other : PhysicsfluidcompressibleGraphN) -> PhysicsfluidcompressibleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleGraphN::copy(self : PhysicsfluidcompressibleGraphN) -> PhysicsfluidcompressibleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleGraphN::fill(self : PhysicsfluidcompressibleGraphN, v : Double) -> PhysicsfluidcompressibleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleGraphN::min(self : PhysicsfluidcompressibleGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleGraphN::max(self : PhysicsfluidcompressibleGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleGraphN::to_string(self : PhysicsfluidcompressibleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_node_make(size : Int) -> PhysicsfluidcompressibleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleNode::len(self : PhysicsfluidcompressibleNode) -> Int { self.size }

pub fn PhysicsfluidcompressibleNode::get(self : PhysicsfluidcompressibleNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleNode::set(self : PhysicsfluidcompressibleNode, i : Int, v : Double) -> PhysicsfluidcompressibleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleNode::sum(self : PhysicsfluidcompressibleNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleNode::mean(self : PhysicsfluidcompressibleNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleNode::scale(self : PhysicsfluidcompressibleNode, f : Double) -> PhysicsfluidcompressibleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleNode::add(self : PhysicsfluidcompressibleNode, other : PhysicsfluidcompressibleNode) -> PhysicsfluidcompressibleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleNode::copy(self : PhysicsfluidcompressibleNode) -> PhysicsfluidcompressibleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleNode::fill(self : PhysicsfluidcompressibleNode, v : Double) -> PhysicsfluidcompressibleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleNode::min(self : PhysicsfluidcompressibleNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleNode::max(self : PhysicsfluidcompressibleNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleNode::to_string(self : PhysicsfluidcompressibleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_edge_make(size : Int) -> PhysicsfluidcompressibleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleEdge::len(self : PhysicsfluidcompressibleEdge) -> Int { self.size }

pub fn PhysicsfluidcompressibleEdge::get(self : PhysicsfluidcompressibleEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleEdge::set(self : PhysicsfluidcompressibleEdge, i : Int, v : Double) -> PhysicsfluidcompressibleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleEdge::sum(self : PhysicsfluidcompressibleEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleEdge::mean(self : PhysicsfluidcompressibleEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleEdge::scale(self : PhysicsfluidcompressibleEdge, f : Double) -> PhysicsfluidcompressibleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleEdge::add(self : PhysicsfluidcompressibleEdge, other : PhysicsfluidcompressibleEdge) -> PhysicsfluidcompressibleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleEdge::copy(self : PhysicsfluidcompressibleEdge) -> PhysicsfluidcompressibleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleEdge::fill(self : PhysicsfluidcompressibleEdge, v : Double) -> PhysicsfluidcompressibleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleEdge::min(self : PhysicsfluidcompressibleEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleEdge::max(self : PhysicsfluidcompressibleEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleEdge::to_string(self : PhysicsfluidcompressibleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressiblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_path_make(size : Int) -> PhysicsfluidcompressiblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressiblePath::len(self : PhysicsfluidcompressiblePath) -> Int { self.size }

pub fn PhysicsfluidcompressiblePath::get(self : PhysicsfluidcompressiblePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressiblePath::set(self : PhysicsfluidcompressiblePath, i : Int, v : Double) -> PhysicsfluidcompressiblePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressiblePath::sum(self : PhysicsfluidcompressiblePath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressiblePath::mean(self : PhysicsfluidcompressiblePath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressiblePath::scale(self : PhysicsfluidcompressiblePath, f : Double) -> PhysicsfluidcompressiblePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressiblePath::add(self : PhysicsfluidcompressiblePath, other : PhysicsfluidcompressiblePath) -> PhysicsfluidcompressiblePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressiblePath::copy(self : PhysicsfluidcompressiblePath) -> PhysicsfluidcompressiblePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressiblePath::fill(self : PhysicsfluidcompressiblePath, v : Double) -> PhysicsfluidcompressiblePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressiblePath::min(self : PhysicsfluidcompressiblePath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressiblePath::max(self : PhysicsfluidcompressiblePath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressiblePath::to_string(self : PhysicsfluidcompressiblePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_cluster_make(size : Int) -> PhysicsfluidcompressibleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleCluster::len(self : PhysicsfluidcompressibleCluster) -> Int { self.size }

pub fn PhysicsfluidcompressibleCluster::get(self : PhysicsfluidcompressibleCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleCluster::set(self : PhysicsfluidcompressibleCluster, i : Int, v : Double) -> PhysicsfluidcompressibleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCluster::sum(self : PhysicsfluidcompressibleCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleCluster::mean(self : PhysicsfluidcompressibleCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleCluster::scale(self : PhysicsfluidcompressibleCluster, f : Double) -> PhysicsfluidcompressibleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCluster::add(self : PhysicsfluidcompressibleCluster, other : PhysicsfluidcompressibleCluster) -> PhysicsfluidcompressibleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCluster::copy(self : PhysicsfluidcompressibleCluster) -> PhysicsfluidcompressibleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCluster::fill(self : PhysicsfluidcompressibleCluster, v : Double) -> PhysicsfluidcompressibleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCluster::min(self : PhysicsfluidcompressibleCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleCluster::max(self : PhysicsfluidcompressibleCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleCluster::to_string(self : PhysicsfluidcompressibleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_model_make(size : Int) -> PhysicsfluidcompressibleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleModel::len(self : PhysicsfluidcompressibleModel) -> Int { self.size }

pub fn PhysicsfluidcompressibleModel::get(self : PhysicsfluidcompressibleModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleModel::set(self : PhysicsfluidcompressibleModel, i : Int, v : Double) -> PhysicsfluidcompressibleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleModel::sum(self : PhysicsfluidcompressibleModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleModel::mean(self : PhysicsfluidcompressibleModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleModel::scale(self : PhysicsfluidcompressibleModel, f : Double) -> PhysicsfluidcompressibleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleModel::add(self : PhysicsfluidcompressibleModel, other : PhysicsfluidcompressibleModel) -> PhysicsfluidcompressibleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleModel::copy(self : PhysicsfluidcompressibleModel) -> PhysicsfluidcompressibleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleModel::fill(self : PhysicsfluidcompressibleModel, v : Double) -> PhysicsfluidcompressibleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleModel::min(self : PhysicsfluidcompressibleModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleModel::max(self : PhysicsfluidcompressibleModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleModel::to_string(self : PhysicsfluidcompressibleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_layer_make(size : Int) -> PhysicsfluidcompressibleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleLayer::len(self : PhysicsfluidcompressibleLayer) -> Int { self.size }

pub fn PhysicsfluidcompressibleLayer::get(self : PhysicsfluidcompressibleLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleLayer::set(self : PhysicsfluidcompressibleLayer, i : Int, v : Double) -> PhysicsfluidcompressibleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleLayer::sum(self : PhysicsfluidcompressibleLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleLayer::mean(self : PhysicsfluidcompressibleLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleLayer::scale(self : PhysicsfluidcompressibleLayer, f : Double) -> PhysicsfluidcompressibleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleLayer::add(self : PhysicsfluidcompressibleLayer, other : PhysicsfluidcompressibleLayer) -> PhysicsfluidcompressibleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleLayer::copy(self : PhysicsfluidcompressibleLayer) -> PhysicsfluidcompressibleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleLayer::fill(self : PhysicsfluidcompressibleLayer, v : Double) -> PhysicsfluidcompressibleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleLayer::min(self : PhysicsfluidcompressibleLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleLayer::max(self : PhysicsfluidcompressibleLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleLayer::to_string(self : PhysicsfluidcompressibleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_buffer_make(size : Int) -> PhysicsfluidcompressibleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleBuffer::len(self : PhysicsfluidcompressibleBuffer) -> Int { self.size }

pub fn PhysicsfluidcompressibleBuffer::get(self : PhysicsfluidcompressibleBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleBuffer::set(self : PhysicsfluidcompressibleBuffer, i : Int, v : Double) -> PhysicsfluidcompressibleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleBuffer::sum(self : PhysicsfluidcompressibleBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleBuffer::mean(self : PhysicsfluidcompressibleBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleBuffer::scale(self : PhysicsfluidcompressibleBuffer, f : Double) -> PhysicsfluidcompressibleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleBuffer::add(self : PhysicsfluidcompressibleBuffer, other : PhysicsfluidcompressibleBuffer) -> PhysicsfluidcompressibleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleBuffer::copy(self : PhysicsfluidcompressibleBuffer) -> PhysicsfluidcompressibleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleBuffer::fill(self : PhysicsfluidcompressibleBuffer, v : Double) -> PhysicsfluidcompressibleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleBuffer::min(self : PhysicsfluidcompressibleBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleBuffer::max(self : PhysicsfluidcompressibleBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleBuffer::to_string(self : PhysicsfluidcompressibleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_cursor_make(size : Int) -> PhysicsfluidcompressibleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleCursor::len(self : PhysicsfluidcompressibleCursor) -> Int { self.size }

pub fn PhysicsfluidcompressibleCursor::get(self : PhysicsfluidcompressibleCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleCursor::set(self : PhysicsfluidcompressibleCursor, i : Int, v : Double) -> PhysicsfluidcompressibleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCursor::sum(self : PhysicsfluidcompressibleCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleCursor::mean(self : PhysicsfluidcompressibleCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleCursor::scale(self : PhysicsfluidcompressibleCursor, f : Double) -> PhysicsfluidcompressibleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCursor::add(self : PhysicsfluidcompressibleCursor, other : PhysicsfluidcompressibleCursor) -> PhysicsfluidcompressibleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCursor::copy(self : PhysicsfluidcompressibleCursor) -> PhysicsfluidcompressibleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCursor::fill(self : PhysicsfluidcompressibleCursor, v : Double) -> PhysicsfluidcompressibleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleCursor::min(self : PhysicsfluidcompressibleCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleCursor::max(self : PhysicsfluidcompressibleCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleCursor::to_string(self : PhysicsfluidcompressibleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_view_make(size : Int) -> PhysicsfluidcompressibleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleView::len(self : PhysicsfluidcompressibleView) -> Int { self.size }

pub fn PhysicsfluidcompressibleView::get(self : PhysicsfluidcompressibleView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleView::set(self : PhysicsfluidcompressibleView, i : Int, v : Double) -> PhysicsfluidcompressibleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleView::sum(self : PhysicsfluidcompressibleView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleView::mean(self : PhysicsfluidcompressibleView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleView::scale(self : PhysicsfluidcompressibleView, f : Double) -> PhysicsfluidcompressibleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleView::add(self : PhysicsfluidcompressibleView, other : PhysicsfluidcompressibleView) -> PhysicsfluidcompressibleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleView::copy(self : PhysicsfluidcompressibleView) -> PhysicsfluidcompressibleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleView::fill(self : PhysicsfluidcompressibleView, v : Double) -> PhysicsfluidcompressibleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleView::min(self : PhysicsfluidcompressibleView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleView::max(self : PhysicsfluidcompressibleView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleView::to_string(self : PhysicsfluidcompressibleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_range_make(size : Int) -> PhysicsfluidcompressibleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleRange::len(self : PhysicsfluidcompressibleRange) -> Int { self.size }

pub fn PhysicsfluidcompressibleRange::get(self : PhysicsfluidcompressibleRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleRange::set(self : PhysicsfluidcompressibleRange, i : Int, v : Double) -> PhysicsfluidcompressibleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleRange::sum(self : PhysicsfluidcompressibleRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleRange::mean(self : PhysicsfluidcompressibleRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleRange::scale(self : PhysicsfluidcompressibleRange, f : Double) -> PhysicsfluidcompressibleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleRange::add(self : PhysicsfluidcompressibleRange, other : PhysicsfluidcompressibleRange) -> PhysicsfluidcompressibleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleRange::copy(self : PhysicsfluidcompressibleRange) -> PhysicsfluidcompressibleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleRange::fill(self : PhysicsfluidcompressibleRange, v : Double) -> PhysicsfluidcompressibleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleRange::min(self : PhysicsfluidcompressibleRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleRange::max(self : PhysicsfluidcompressibleRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleRange::to_string(self : PhysicsfluidcompressibleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_slice_make(size : Int) -> PhysicsfluidcompressibleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidcompressibleSlice::len(self : PhysicsfluidcompressibleSlice) -> Int { self.size }

pub fn PhysicsfluidcompressibleSlice::get(self : PhysicsfluidcompressibleSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidcompressibleSlice::set(self : PhysicsfluidcompressibleSlice, i : Int, v : Double) -> PhysicsfluidcompressibleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleSlice::sum(self : PhysicsfluidcompressibleSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidcompressibleSlice::mean(self : PhysicsfluidcompressibleSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidcompressibleSlice::scale(self : PhysicsfluidcompressibleSlice, f : Double) -> PhysicsfluidcompressibleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleSlice::add(self : PhysicsfluidcompressibleSlice, other : PhysicsfluidcompressibleSlice) -> PhysicsfluidcompressibleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidcompressibleSlice::copy(self : PhysicsfluidcompressibleSlice) -> PhysicsfluidcompressibleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleSlice::fill(self : PhysicsfluidcompressibleSlice, v : Double) -> PhysicsfluidcompressibleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidcompressibleSlice::min(self : PhysicsfluidcompressibleSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidcompressibleSlice::max(self : PhysicsfluidcompressibleSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidcompressibleSlice::to_string(self : PhysicsfluidcompressibleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

