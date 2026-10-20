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

pub fn PhysicsfluidvortexFrame::len(self : PhysicsfluidvortexFrame) -> Int { self.size }

pub fn PhysicsfluidvortexFrame::get(self : PhysicsfluidvortexFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexFrame::set(self : PhysicsfluidvortexFrame, i : Int, v : Double) -> PhysicsfluidvortexFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexFrame::sum(self : PhysicsfluidvortexFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexFrame::mean(self : PhysicsfluidvortexFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexFrame::scale(self : PhysicsfluidvortexFrame, f : Double) -> PhysicsfluidvortexFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexFrame::add(self : PhysicsfluidvortexFrame, other : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexFrame::copy(self : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexFrame::fill(self : PhysicsfluidvortexFrame, v : Double) -> PhysicsfluidvortexFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexFrame::min(self : PhysicsfluidvortexFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexFrame::max(self : PhysicsfluidvortexFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexFrame::to_string(self : PhysicsfluidvortexFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_table_make(size : Int) -> PhysicsfluidvortexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexTable::len(self : PhysicsfluidvortexTable) -> Int { self.size }

pub fn PhysicsfluidvortexTable::get(self : PhysicsfluidvortexTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexTable::set(self : PhysicsfluidvortexTable, i : Int, v : Double) -> PhysicsfluidvortexTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexTable::sum(self : PhysicsfluidvortexTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexTable::mean(self : PhysicsfluidvortexTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexTable::scale(self : PhysicsfluidvortexTable, f : Double) -> PhysicsfluidvortexTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexTable::add(self : PhysicsfluidvortexTable, other : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexTable::copy(self : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexTable::fill(self : PhysicsfluidvortexTable, v : Double) -> PhysicsfluidvortexTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexTable::min(self : PhysicsfluidvortexTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexTable::max(self : PhysicsfluidvortexTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexTable::to_string(self : PhysicsfluidvortexTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_graphn_make(size : Int) -> PhysicsfluidvortexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexGraphN::len(self : PhysicsfluidvortexGraphN) -> Int { self.size }

pub fn PhysicsfluidvortexGraphN::get(self : PhysicsfluidvortexGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexGraphN::set(self : PhysicsfluidvortexGraphN, i : Int, v : Double) -> PhysicsfluidvortexGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexGraphN::sum(self : PhysicsfluidvortexGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexGraphN::mean(self : PhysicsfluidvortexGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexGraphN::scale(self : PhysicsfluidvortexGraphN, f : Double) -> PhysicsfluidvortexGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexGraphN::add(self : PhysicsfluidvortexGraphN, other : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexGraphN::copy(self : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexGraphN::fill(self : PhysicsfluidvortexGraphN, v : Double) -> PhysicsfluidvortexGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexGraphN::min(self : PhysicsfluidvortexGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexGraphN::max(self : PhysicsfluidvortexGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexGraphN::to_string(self : PhysicsfluidvortexGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_node_make(size : Int) -> PhysicsfluidvortexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexNode::len(self : PhysicsfluidvortexNode) -> Int { self.size }

pub fn PhysicsfluidvortexNode::get(self : PhysicsfluidvortexNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexNode::set(self : PhysicsfluidvortexNode, i : Int, v : Double) -> PhysicsfluidvortexNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexNode::sum(self : PhysicsfluidvortexNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexNode::mean(self : PhysicsfluidvortexNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexNode::scale(self : PhysicsfluidvortexNode, f : Double) -> PhysicsfluidvortexNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexNode::add(self : PhysicsfluidvortexNode, other : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexNode::copy(self : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexNode::fill(self : PhysicsfluidvortexNode, v : Double) -> PhysicsfluidvortexNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexNode::min(self : PhysicsfluidvortexNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexNode::max(self : PhysicsfluidvortexNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexNode::to_string(self : PhysicsfluidvortexNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_edge_make(size : Int) -> PhysicsfluidvortexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexEdge::len(self : PhysicsfluidvortexEdge) -> Int { self.size }

pub fn PhysicsfluidvortexEdge::get(self : PhysicsfluidvortexEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexEdge::set(self : PhysicsfluidvortexEdge, i : Int, v : Double) -> PhysicsfluidvortexEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexEdge::sum(self : PhysicsfluidvortexEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexEdge::mean(self : PhysicsfluidvortexEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexEdge::scale(self : PhysicsfluidvortexEdge, f : Double) -> PhysicsfluidvortexEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexEdge::add(self : PhysicsfluidvortexEdge, other : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexEdge::copy(self : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexEdge::fill(self : PhysicsfluidvortexEdge, v : Double) -> PhysicsfluidvortexEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexEdge::min(self : PhysicsfluidvortexEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexEdge::max(self : PhysicsfluidvortexEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexEdge::to_string(self : PhysicsfluidvortexEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_path_make(size : Int) -> PhysicsfluidvortexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexPath::len(self : PhysicsfluidvortexPath) -> Int { self.size }

pub fn PhysicsfluidvortexPath::get(self : PhysicsfluidvortexPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexPath::set(self : PhysicsfluidvortexPath, i : Int, v : Double) -> PhysicsfluidvortexPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexPath::sum(self : PhysicsfluidvortexPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexPath::mean(self : PhysicsfluidvortexPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexPath::scale(self : PhysicsfluidvortexPath, f : Double) -> PhysicsfluidvortexPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexPath::add(self : PhysicsfluidvortexPath, other : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexPath::copy(self : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexPath::fill(self : PhysicsfluidvortexPath, v : Double) -> PhysicsfluidvortexPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexPath::min(self : PhysicsfluidvortexPath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexPath::max(self : PhysicsfluidvortexPath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexPath::to_string(self : PhysicsfluidvortexPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cluster_make(size : Int) -> PhysicsfluidvortexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexCluster::len(self : PhysicsfluidvortexCluster) -> Int { self.size }

pub fn PhysicsfluidvortexCluster::get(self : PhysicsfluidvortexCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexCluster::set(self : PhysicsfluidvortexCluster, i : Int, v : Double) -> PhysicsfluidvortexCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCluster::sum(self : PhysicsfluidvortexCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexCluster::mean(self : PhysicsfluidvortexCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexCluster::scale(self : PhysicsfluidvortexCluster, f : Double) -> PhysicsfluidvortexCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCluster::add(self : PhysicsfluidvortexCluster, other : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexCluster::copy(self : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCluster::fill(self : PhysicsfluidvortexCluster, v : Double) -> PhysicsfluidvortexCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCluster::min(self : PhysicsfluidvortexCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexCluster::max(self : PhysicsfluidvortexCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexCluster::to_string(self : PhysicsfluidvortexCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_model_make(size : Int) -> PhysicsfluidvortexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexModel::len(self : PhysicsfluidvortexModel) -> Int { self.size }

pub fn PhysicsfluidvortexModel::get(self : PhysicsfluidvortexModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexModel::set(self : PhysicsfluidvortexModel, i : Int, v : Double) -> PhysicsfluidvortexModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexModel::sum(self : PhysicsfluidvortexModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexModel::mean(self : PhysicsfluidvortexModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexModel::scale(self : PhysicsfluidvortexModel, f : Double) -> PhysicsfluidvortexModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexModel::add(self : PhysicsfluidvortexModel, other : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexModel::copy(self : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexModel::fill(self : PhysicsfluidvortexModel, v : Double) -> PhysicsfluidvortexModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexModel::min(self : PhysicsfluidvortexModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexModel::max(self : PhysicsfluidvortexModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexModel::to_string(self : PhysicsfluidvortexModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_layer_make(size : Int) -> PhysicsfluidvortexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexLayer::len(self : PhysicsfluidvortexLayer) -> Int { self.size }

pub fn PhysicsfluidvortexLayer::get(self : PhysicsfluidvortexLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexLayer::set(self : PhysicsfluidvortexLayer, i : Int, v : Double) -> PhysicsfluidvortexLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexLayer::sum(self : PhysicsfluidvortexLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexLayer::mean(self : PhysicsfluidvortexLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexLayer::scale(self : PhysicsfluidvortexLayer, f : Double) -> PhysicsfluidvortexLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexLayer::add(self : PhysicsfluidvortexLayer, other : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexLayer::copy(self : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexLayer::fill(self : PhysicsfluidvortexLayer, v : Double) -> PhysicsfluidvortexLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexLayer::min(self : PhysicsfluidvortexLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexLayer::max(self : PhysicsfluidvortexLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexLayer::to_string(self : PhysicsfluidvortexLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_buffer_make(size : Int) -> PhysicsfluidvortexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexBuffer::len(self : PhysicsfluidvortexBuffer) -> Int { self.size }

pub fn PhysicsfluidvortexBuffer::get(self : PhysicsfluidvortexBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexBuffer::set(self : PhysicsfluidvortexBuffer, i : Int, v : Double) -> PhysicsfluidvortexBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexBuffer::sum(self : PhysicsfluidvortexBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexBuffer::mean(self : PhysicsfluidvortexBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexBuffer::scale(self : PhysicsfluidvortexBuffer, f : Double) -> PhysicsfluidvortexBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexBuffer::add(self : PhysicsfluidvortexBuffer, other : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexBuffer::copy(self : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexBuffer::fill(self : PhysicsfluidvortexBuffer, v : Double) -> PhysicsfluidvortexBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexBuffer::min(self : PhysicsfluidvortexBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexBuffer::max(self : PhysicsfluidvortexBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexBuffer::to_string(self : PhysicsfluidvortexBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cursor_make(size : Int) -> PhysicsfluidvortexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexCursor::len(self : PhysicsfluidvortexCursor) -> Int { self.size }

pub fn PhysicsfluidvortexCursor::get(self : PhysicsfluidvortexCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexCursor::set(self : PhysicsfluidvortexCursor, i : Int, v : Double) -> PhysicsfluidvortexCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCursor::sum(self : PhysicsfluidvortexCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexCursor::mean(self : PhysicsfluidvortexCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexCursor::scale(self : PhysicsfluidvortexCursor, f : Double) -> PhysicsfluidvortexCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCursor::add(self : PhysicsfluidvortexCursor, other : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexCursor::copy(self : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCursor::fill(self : PhysicsfluidvortexCursor, v : Double) -> PhysicsfluidvortexCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexCursor::min(self : PhysicsfluidvortexCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexCursor::max(self : PhysicsfluidvortexCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexCursor::to_string(self : PhysicsfluidvortexCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_view_make(size : Int) -> PhysicsfluidvortexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexView::len(self : PhysicsfluidvortexView) -> Int { self.size }

pub fn PhysicsfluidvortexView::get(self : PhysicsfluidvortexView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexView::set(self : PhysicsfluidvortexView, i : Int, v : Double) -> PhysicsfluidvortexView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexView::sum(self : PhysicsfluidvortexView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexView::mean(self : PhysicsfluidvortexView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexView::scale(self : PhysicsfluidvortexView, f : Double) -> PhysicsfluidvortexView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexView::add(self : PhysicsfluidvortexView, other : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexView::copy(self : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexView::fill(self : PhysicsfluidvortexView, v : Double) -> PhysicsfluidvortexView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexView::min(self : PhysicsfluidvortexView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexView::max(self : PhysicsfluidvortexView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexView::to_string(self : PhysicsfluidvortexView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_range_make(size : Int) -> PhysicsfluidvortexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexRange::len(self : PhysicsfluidvortexRange) -> Int { self.size }

pub fn PhysicsfluidvortexRange::get(self : PhysicsfluidvortexRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexRange::set(self : PhysicsfluidvortexRange, i : Int, v : Double) -> PhysicsfluidvortexRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexRange::sum(self : PhysicsfluidvortexRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexRange::mean(self : PhysicsfluidvortexRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexRange::scale(self : PhysicsfluidvortexRange, f : Double) -> PhysicsfluidvortexRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexRange::add(self : PhysicsfluidvortexRange, other : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexRange::copy(self : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexRange::fill(self : PhysicsfluidvortexRange, v : Double) -> PhysicsfluidvortexRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexRange::min(self : PhysicsfluidvortexRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexRange::max(self : PhysicsfluidvortexRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexRange::to_string(self : PhysicsfluidvortexRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_slice_make(size : Int) -> PhysicsfluidvortexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidvortexSlice::len(self : PhysicsfluidvortexSlice) -> Int { self.size }

pub fn PhysicsfluidvortexSlice::get(self : PhysicsfluidvortexSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidvortexSlice::set(self : PhysicsfluidvortexSlice, i : Int, v : Double) -> PhysicsfluidvortexSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexSlice::sum(self : PhysicsfluidvortexSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidvortexSlice::mean(self : PhysicsfluidvortexSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidvortexSlice::scale(self : PhysicsfluidvortexSlice, f : Double) -> PhysicsfluidvortexSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexSlice::add(self : PhysicsfluidvortexSlice, other : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidvortexSlice::copy(self : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexSlice::fill(self : PhysicsfluidvortexSlice, v : Double) -> PhysicsfluidvortexSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidvortexSlice::min(self : PhysicsfluidvortexSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidvortexSlice::max(self : PhysicsfluidvortexSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidvortexSlice::to_string(self : PhysicsfluidvortexSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

