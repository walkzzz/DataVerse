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

pub fn PhysicsheattransientFrame::len(self : PhysicsheattransientFrame) -> Int { self.size }

pub fn PhysicsheattransientFrame::get(self : PhysicsheattransientFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientFrame::set(self : PhysicsheattransientFrame, i : Int, v : Double) -> PhysicsheattransientFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientFrame::sum(self : PhysicsheattransientFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientFrame::mean(self : PhysicsheattransientFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientFrame::scale(self : PhysicsheattransientFrame, f : Double) -> PhysicsheattransientFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientFrame::add(self : PhysicsheattransientFrame, other : PhysicsheattransientFrame) -> PhysicsheattransientFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientFrame::copy(self : PhysicsheattransientFrame) -> PhysicsheattransientFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientFrame::fill(self : PhysicsheattransientFrame, v : Double) -> PhysicsheattransientFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientFrame::min(self : PhysicsheattransientFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientFrame::max(self : PhysicsheattransientFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientFrame::to_string(self : PhysicsheattransientFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_table_make(size : Int) -> PhysicsheattransientTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientTable::len(self : PhysicsheattransientTable) -> Int { self.size }

pub fn PhysicsheattransientTable::get(self : PhysicsheattransientTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientTable::set(self : PhysicsheattransientTable, i : Int, v : Double) -> PhysicsheattransientTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientTable::sum(self : PhysicsheattransientTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientTable::mean(self : PhysicsheattransientTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientTable::scale(self : PhysicsheattransientTable, f : Double) -> PhysicsheattransientTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientTable::add(self : PhysicsheattransientTable, other : PhysicsheattransientTable) -> PhysicsheattransientTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientTable::copy(self : PhysicsheattransientTable) -> PhysicsheattransientTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientTable::fill(self : PhysicsheattransientTable, v : Double) -> PhysicsheattransientTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientTable::min(self : PhysicsheattransientTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientTable::max(self : PhysicsheattransientTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientTable::to_string(self : PhysicsheattransientTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_graphn_make(size : Int) -> PhysicsheattransientGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientGraphN::len(self : PhysicsheattransientGraphN) -> Int { self.size }

pub fn PhysicsheattransientGraphN::get(self : PhysicsheattransientGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientGraphN::set(self : PhysicsheattransientGraphN, i : Int, v : Double) -> PhysicsheattransientGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientGraphN::sum(self : PhysicsheattransientGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientGraphN::mean(self : PhysicsheattransientGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientGraphN::scale(self : PhysicsheattransientGraphN, f : Double) -> PhysicsheattransientGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientGraphN::add(self : PhysicsheattransientGraphN, other : PhysicsheattransientGraphN) -> PhysicsheattransientGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientGraphN::copy(self : PhysicsheattransientGraphN) -> PhysicsheattransientGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientGraphN::fill(self : PhysicsheattransientGraphN, v : Double) -> PhysicsheattransientGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientGraphN::min(self : PhysicsheattransientGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientGraphN::max(self : PhysicsheattransientGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientGraphN::to_string(self : PhysicsheattransientGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_node_make(size : Int) -> PhysicsheattransientNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientNode::len(self : PhysicsheattransientNode) -> Int { self.size }

pub fn PhysicsheattransientNode::get(self : PhysicsheattransientNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientNode::set(self : PhysicsheattransientNode, i : Int, v : Double) -> PhysicsheattransientNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientNode::sum(self : PhysicsheattransientNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientNode::mean(self : PhysicsheattransientNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientNode::scale(self : PhysicsheattransientNode, f : Double) -> PhysicsheattransientNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientNode::add(self : PhysicsheattransientNode, other : PhysicsheattransientNode) -> PhysicsheattransientNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientNode::copy(self : PhysicsheattransientNode) -> PhysicsheattransientNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientNode::fill(self : PhysicsheattransientNode, v : Double) -> PhysicsheattransientNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientNode::min(self : PhysicsheattransientNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientNode::max(self : PhysicsheattransientNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientNode::to_string(self : PhysicsheattransientNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_edge_make(size : Int) -> PhysicsheattransientEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientEdge::len(self : PhysicsheattransientEdge) -> Int { self.size }

pub fn PhysicsheattransientEdge::get(self : PhysicsheattransientEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientEdge::set(self : PhysicsheattransientEdge, i : Int, v : Double) -> PhysicsheattransientEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientEdge::sum(self : PhysicsheattransientEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientEdge::mean(self : PhysicsheattransientEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientEdge::scale(self : PhysicsheattransientEdge, f : Double) -> PhysicsheattransientEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientEdge::add(self : PhysicsheattransientEdge, other : PhysicsheattransientEdge) -> PhysicsheattransientEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientEdge::copy(self : PhysicsheattransientEdge) -> PhysicsheattransientEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientEdge::fill(self : PhysicsheattransientEdge, v : Double) -> PhysicsheattransientEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientEdge::min(self : PhysicsheattransientEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientEdge::max(self : PhysicsheattransientEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientEdge::to_string(self : PhysicsheattransientEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_path_make(size : Int) -> PhysicsheattransientPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientPath::len(self : PhysicsheattransientPath) -> Int { self.size }

pub fn PhysicsheattransientPath::get(self : PhysicsheattransientPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientPath::set(self : PhysicsheattransientPath, i : Int, v : Double) -> PhysicsheattransientPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientPath::sum(self : PhysicsheattransientPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientPath::mean(self : PhysicsheattransientPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientPath::scale(self : PhysicsheattransientPath, f : Double) -> PhysicsheattransientPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientPath::add(self : PhysicsheattransientPath, other : PhysicsheattransientPath) -> PhysicsheattransientPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientPath::copy(self : PhysicsheattransientPath) -> PhysicsheattransientPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientPath::fill(self : PhysicsheattransientPath, v : Double) -> PhysicsheattransientPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientPath::min(self : PhysicsheattransientPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientPath::max(self : PhysicsheattransientPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientPath::to_string(self : PhysicsheattransientPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_cluster_make(size : Int) -> PhysicsheattransientCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientCluster::len(self : PhysicsheattransientCluster) -> Int { self.size }

pub fn PhysicsheattransientCluster::get(self : PhysicsheattransientCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientCluster::set(self : PhysicsheattransientCluster, i : Int, v : Double) -> PhysicsheattransientCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCluster::sum(self : PhysicsheattransientCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientCluster::mean(self : PhysicsheattransientCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientCluster::scale(self : PhysicsheattransientCluster, f : Double) -> PhysicsheattransientCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCluster::add(self : PhysicsheattransientCluster, other : PhysicsheattransientCluster) -> PhysicsheattransientCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientCluster::copy(self : PhysicsheattransientCluster) -> PhysicsheattransientCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCluster::fill(self : PhysicsheattransientCluster, v : Double) -> PhysicsheattransientCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCluster::min(self : PhysicsheattransientCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientCluster::max(self : PhysicsheattransientCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientCluster::to_string(self : PhysicsheattransientCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_model_make(size : Int) -> PhysicsheattransientModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientModel::len(self : PhysicsheattransientModel) -> Int { self.size }

pub fn PhysicsheattransientModel::get(self : PhysicsheattransientModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientModel::set(self : PhysicsheattransientModel, i : Int, v : Double) -> PhysicsheattransientModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientModel::sum(self : PhysicsheattransientModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientModel::mean(self : PhysicsheattransientModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientModel::scale(self : PhysicsheattransientModel, f : Double) -> PhysicsheattransientModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientModel::add(self : PhysicsheattransientModel, other : PhysicsheattransientModel) -> PhysicsheattransientModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientModel::copy(self : PhysicsheattransientModel) -> PhysicsheattransientModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientModel::fill(self : PhysicsheattransientModel, v : Double) -> PhysicsheattransientModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientModel::min(self : PhysicsheattransientModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientModel::max(self : PhysicsheattransientModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientModel::to_string(self : PhysicsheattransientModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_layer_make(size : Int) -> PhysicsheattransientLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientLayer::len(self : PhysicsheattransientLayer) -> Int { self.size }

pub fn PhysicsheattransientLayer::get(self : PhysicsheattransientLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientLayer::set(self : PhysicsheattransientLayer, i : Int, v : Double) -> PhysicsheattransientLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientLayer::sum(self : PhysicsheattransientLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientLayer::mean(self : PhysicsheattransientLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientLayer::scale(self : PhysicsheattransientLayer, f : Double) -> PhysicsheattransientLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientLayer::add(self : PhysicsheattransientLayer, other : PhysicsheattransientLayer) -> PhysicsheattransientLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientLayer::copy(self : PhysicsheattransientLayer) -> PhysicsheattransientLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientLayer::fill(self : PhysicsheattransientLayer, v : Double) -> PhysicsheattransientLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientLayer::min(self : PhysicsheattransientLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientLayer::max(self : PhysicsheattransientLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientLayer::to_string(self : PhysicsheattransientLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_buffer_make(size : Int) -> PhysicsheattransientBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientBuffer::len(self : PhysicsheattransientBuffer) -> Int { self.size }

pub fn PhysicsheattransientBuffer::get(self : PhysicsheattransientBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientBuffer::set(self : PhysicsheattransientBuffer, i : Int, v : Double) -> PhysicsheattransientBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientBuffer::sum(self : PhysicsheattransientBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientBuffer::mean(self : PhysicsheattransientBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientBuffer::scale(self : PhysicsheattransientBuffer, f : Double) -> PhysicsheattransientBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientBuffer::add(self : PhysicsheattransientBuffer, other : PhysicsheattransientBuffer) -> PhysicsheattransientBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientBuffer::copy(self : PhysicsheattransientBuffer) -> PhysicsheattransientBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientBuffer::fill(self : PhysicsheattransientBuffer, v : Double) -> PhysicsheattransientBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientBuffer::min(self : PhysicsheattransientBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientBuffer::max(self : PhysicsheattransientBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientBuffer::to_string(self : PhysicsheattransientBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_cursor_make(size : Int) -> PhysicsheattransientCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientCursor::len(self : PhysicsheattransientCursor) -> Int { self.size }

pub fn PhysicsheattransientCursor::get(self : PhysicsheattransientCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientCursor::set(self : PhysicsheattransientCursor, i : Int, v : Double) -> PhysicsheattransientCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCursor::sum(self : PhysicsheattransientCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientCursor::mean(self : PhysicsheattransientCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientCursor::scale(self : PhysicsheattransientCursor, f : Double) -> PhysicsheattransientCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCursor::add(self : PhysicsheattransientCursor, other : PhysicsheattransientCursor) -> PhysicsheattransientCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientCursor::copy(self : PhysicsheattransientCursor) -> PhysicsheattransientCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCursor::fill(self : PhysicsheattransientCursor, v : Double) -> PhysicsheattransientCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientCursor::min(self : PhysicsheattransientCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientCursor::max(self : PhysicsheattransientCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientCursor::to_string(self : PhysicsheattransientCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_view_make(size : Int) -> PhysicsheattransientView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientView::len(self : PhysicsheattransientView) -> Int { self.size }

pub fn PhysicsheattransientView::get(self : PhysicsheattransientView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientView::set(self : PhysicsheattransientView, i : Int, v : Double) -> PhysicsheattransientView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientView::sum(self : PhysicsheattransientView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientView::mean(self : PhysicsheattransientView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientView::scale(self : PhysicsheattransientView, f : Double) -> PhysicsheattransientView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientView::add(self : PhysicsheattransientView, other : PhysicsheattransientView) -> PhysicsheattransientView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientView::copy(self : PhysicsheattransientView) -> PhysicsheattransientView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientView::fill(self : PhysicsheattransientView, v : Double) -> PhysicsheattransientView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientView::min(self : PhysicsheattransientView) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientView::max(self : PhysicsheattransientView) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientView::to_string(self : PhysicsheattransientView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_range_make(size : Int) -> PhysicsheattransientRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientRange::len(self : PhysicsheattransientRange) -> Int { self.size }

pub fn PhysicsheattransientRange::get(self : PhysicsheattransientRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientRange::set(self : PhysicsheattransientRange, i : Int, v : Double) -> PhysicsheattransientRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientRange::sum(self : PhysicsheattransientRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientRange::mean(self : PhysicsheattransientRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientRange::scale(self : PhysicsheattransientRange, f : Double) -> PhysicsheattransientRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientRange::add(self : PhysicsheattransientRange, other : PhysicsheattransientRange) -> PhysicsheattransientRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientRange::copy(self : PhysicsheattransientRange) -> PhysicsheattransientRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientRange::fill(self : PhysicsheattransientRange, v : Double) -> PhysicsheattransientRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientRange::min(self : PhysicsheattransientRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientRange::max(self : PhysicsheattransientRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientRange::to_string(self : PhysicsheattransientRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_slice_make(size : Int) -> PhysicsheattransientSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheattransientSlice::len(self : PhysicsheattransientSlice) -> Int { self.size }

pub fn PhysicsheattransientSlice::get(self : PhysicsheattransientSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheattransientSlice::set(self : PhysicsheattransientSlice, i : Int, v : Double) -> PhysicsheattransientSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientSlice::sum(self : PhysicsheattransientSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheattransientSlice::mean(self : PhysicsheattransientSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheattransientSlice::scale(self : PhysicsheattransientSlice, f : Double) -> PhysicsheattransientSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientSlice::add(self : PhysicsheattransientSlice, other : PhysicsheattransientSlice) -> PhysicsheattransientSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheattransientSlice::copy(self : PhysicsheattransientSlice) -> PhysicsheattransientSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientSlice::fill(self : PhysicsheattransientSlice, v : Double) -> PhysicsheattransientSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheattransientSlice::min(self : PhysicsheattransientSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheattransientSlice::max(self : PhysicsheattransientSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheattransientSlice::to_string(self : PhysicsheattransientSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

