///===
/// extcore/physics_heat_boundary

pub(all) struct PhysicsheatboundaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_boundary_make_point(x : Double, y : Double) -> PhysicsheatboundaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_boundary_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatboundaryPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatboundaryPoint::x(self : PhysicsheatboundaryPoint) -> Double { self.x }

pub fn PhysicsheatboundaryPoint::y(self : PhysicsheatboundaryPoint) -> Double { self.y }

pub fn PhysicsheatboundaryPoint::z(self : PhysicsheatboundaryPoint) -> Double { self.z }

pub fn PhysicsheatboundaryPoint::label(self : PhysicsheatboundaryPoint) -> Int { self.label }

pub fn PhysicsheatboundaryPoint::dist(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatboundaryPoint::add(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatboundaryPoint::sub(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatboundaryPoint::scale(self : PhysicsheatboundaryPoint, s : Double) -> PhysicsheatboundaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatboundaryPoint::dot(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatboundaryPoint::cross(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatboundaryPoint::norm(self : PhysicsheatboundaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatboundaryPoint::normalize(self : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatboundaryPoint::negate(self : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatboundaryPoint::mid(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint) -> PhysicsheatboundaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatboundaryPoint::lerp(self : PhysicsheatboundaryPoint, other : PhysicsheatboundaryPoint, t : Double) -> PhysicsheatboundaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatboundaryPoint::to_string(self : PhysicsheatboundaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatboundarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_boundary_make_series(vals : Array[Double], name : String) -> PhysicsheatboundarySeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatboundarySeries::len(self : PhysicsheatboundarySeries) -> Int { self.vals.length() }

pub fn PhysicsheatboundarySeries::sum(self : PhysicsheatboundarySeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatboundarySeries::mean(self : PhysicsheatboundarySeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatboundarySeries::min(self : PhysicsheatboundarySeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatboundarySeries::max(self : PhysicsheatboundarySeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatboundarySeries::range(self : PhysicsheatboundarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatboundarySeries::variance(self : PhysicsheatboundarySeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatboundarySeries::std(self : PhysicsheatboundarySeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatboundarySeries::median(self : PhysicsheatboundarySeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatboundarySeries::scale(self : PhysicsheatboundarySeries, f : Double) -> PhysicsheatboundarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatboundarySeries::add(self : PhysicsheatboundarySeries, other : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatboundarySeries::sub(self : PhysicsheatboundarySeries, other : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatboundarySeries::normalize(self : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatboundarySeries::cumsum(self : PhysicsheatboundarySeries) -> PhysicsheatboundarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatboundarySeries::to_string(self : PhysicsheatboundarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatboundaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_boundary_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatboundaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_boundary_matrix_identity(n : Int) -> PhysicsheatboundaryMatrix {
  let m = physics_heat_boundary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatboundaryMatrix::get(self : PhysicsheatboundaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatboundaryMatrix::transpose(self : PhysicsheatboundaryMatrix) -> PhysicsheatboundaryMatrix {
  let result = physics_heat_boundary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatboundaryMatrix::add(self : PhysicsheatboundaryMatrix, other : PhysicsheatboundaryMatrix) -> PhysicsheatboundaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_boundary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatboundaryMatrix::scale(self : PhysicsheatboundaryMatrix, s : Double) -> PhysicsheatboundaryMatrix {
  let result = physics_heat_boundary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatboundaryMatrix::multiply(self : PhysicsheatboundaryMatrix, other : PhysicsheatboundaryMatrix) -> PhysicsheatboundaryMatrix {
  if self.cols != other.rows { return physics_heat_boundary_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_boundary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatboundaryMatrix::trace(self : PhysicsheatboundaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatboundaryMatrix::det(self : PhysicsheatboundaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatboundaryMatrix::norm(self : PhysicsheatboundaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatboundaryMatrix::to_string(self : PhysicsheatboundaryMatrix) -> String {
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

pub(all) struct PhysicsheatboundaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_boundary_make_vector(comps : Array[Double]) -> PhysicsheatboundaryVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_boundary_vector_zero(dim : Int) -> PhysicsheatboundaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatboundaryVector::add(self : PhysicsheatboundaryVector, other : PhysicsheatboundaryVector) -> PhysicsheatboundaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatboundaryVector::sub(self : PhysicsheatboundaryVector, other : PhysicsheatboundaryVector) -> PhysicsheatboundaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatboundaryVector::scale(self : PhysicsheatboundaryVector, s : Double) -> PhysicsheatboundaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatboundaryVector::dot(self : PhysicsheatboundaryVector, other : PhysicsheatboundaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatboundaryVector::norm(self : PhysicsheatboundaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatboundaryVector::normalize(self : PhysicsheatboundaryVector) -> PhysicsheatboundaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatboundaryVector::dist(self : PhysicsheatboundaryVector, other : PhysicsheatboundaryVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatboundaryVector::to_string(self : PhysicsheatboundaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_boundary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_boundary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_boundary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_boundary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_boundary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_boundary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_boundary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_boundary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_boundary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_boundary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_boundary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_boundary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_boundary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_boundary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_boundary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_boundary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_boundary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_boundary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_boundary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_boundary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_boundary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_boundary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_boundary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_boundary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_boundary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_boundary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_boundary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_boundary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_boundary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatboundaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_frame_make(size : Int) -> PhysicsheatboundaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryFrame::len(self : PhysicsheatboundaryFrame) -> Int { self.size }

pub fn PhysicsheatboundaryFrame::get(self : PhysicsheatboundaryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryFrame::set(self : PhysicsheatboundaryFrame, i : Int, v : Double) -> PhysicsheatboundaryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryFrame::sum(self : PhysicsheatboundaryFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryFrame::mean(self : PhysicsheatboundaryFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryFrame::scale(self : PhysicsheatboundaryFrame, f : Double) -> PhysicsheatboundaryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryFrame::add(self : PhysicsheatboundaryFrame, other : PhysicsheatboundaryFrame) -> PhysicsheatboundaryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryFrame::copy(self : PhysicsheatboundaryFrame) -> PhysicsheatboundaryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryFrame::fill(self : PhysicsheatboundaryFrame, v : Double) -> PhysicsheatboundaryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryFrame::min(self : PhysicsheatboundaryFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryFrame::max(self : PhysicsheatboundaryFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryFrame::to_string(self : PhysicsheatboundaryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_table_make(size : Int) -> PhysicsheatboundaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryTable::len(self : PhysicsheatboundaryTable) -> Int { self.size }

pub fn PhysicsheatboundaryTable::get(self : PhysicsheatboundaryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryTable::set(self : PhysicsheatboundaryTable, i : Int, v : Double) -> PhysicsheatboundaryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryTable::sum(self : PhysicsheatboundaryTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryTable::mean(self : PhysicsheatboundaryTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryTable::scale(self : PhysicsheatboundaryTable, f : Double) -> PhysicsheatboundaryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryTable::add(self : PhysicsheatboundaryTable, other : PhysicsheatboundaryTable) -> PhysicsheatboundaryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryTable::copy(self : PhysicsheatboundaryTable) -> PhysicsheatboundaryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryTable::fill(self : PhysicsheatboundaryTable, v : Double) -> PhysicsheatboundaryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryTable::min(self : PhysicsheatboundaryTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryTable::max(self : PhysicsheatboundaryTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryTable::to_string(self : PhysicsheatboundaryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_graphn_make(size : Int) -> PhysicsheatboundaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryGraphN::len(self : PhysicsheatboundaryGraphN) -> Int { self.size }

pub fn PhysicsheatboundaryGraphN::get(self : PhysicsheatboundaryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryGraphN::set(self : PhysicsheatboundaryGraphN, i : Int, v : Double) -> PhysicsheatboundaryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryGraphN::sum(self : PhysicsheatboundaryGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryGraphN::mean(self : PhysicsheatboundaryGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryGraphN::scale(self : PhysicsheatboundaryGraphN, f : Double) -> PhysicsheatboundaryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryGraphN::add(self : PhysicsheatboundaryGraphN, other : PhysicsheatboundaryGraphN) -> PhysicsheatboundaryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryGraphN::copy(self : PhysicsheatboundaryGraphN) -> PhysicsheatboundaryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryGraphN::fill(self : PhysicsheatboundaryGraphN, v : Double) -> PhysicsheatboundaryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryGraphN::min(self : PhysicsheatboundaryGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryGraphN::max(self : PhysicsheatboundaryGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryGraphN::to_string(self : PhysicsheatboundaryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_node_make(size : Int) -> PhysicsheatboundaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryNode::len(self : PhysicsheatboundaryNode) -> Int { self.size }

pub fn PhysicsheatboundaryNode::get(self : PhysicsheatboundaryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryNode::set(self : PhysicsheatboundaryNode, i : Int, v : Double) -> PhysicsheatboundaryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryNode::sum(self : PhysicsheatboundaryNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryNode::mean(self : PhysicsheatboundaryNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryNode::scale(self : PhysicsheatboundaryNode, f : Double) -> PhysicsheatboundaryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryNode::add(self : PhysicsheatboundaryNode, other : PhysicsheatboundaryNode) -> PhysicsheatboundaryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryNode::copy(self : PhysicsheatboundaryNode) -> PhysicsheatboundaryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryNode::fill(self : PhysicsheatboundaryNode, v : Double) -> PhysicsheatboundaryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryNode::min(self : PhysicsheatboundaryNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryNode::max(self : PhysicsheatboundaryNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryNode::to_string(self : PhysicsheatboundaryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_edge_make(size : Int) -> PhysicsheatboundaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryEdge::len(self : PhysicsheatboundaryEdge) -> Int { self.size }

pub fn PhysicsheatboundaryEdge::get(self : PhysicsheatboundaryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryEdge::set(self : PhysicsheatboundaryEdge, i : Int, v : Double) -> PhysicsheatboundaryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryEdge::sum(self : PhysicsheatboundaryEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryEdge::mean(self : PhysicsheatboundaryEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryEdge::scale(self : PhysicsheatboundaryEdge, f : Double) -> PhysicsheatboundaryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryEdge::add(self : PhysicsheatboundaryEdge, other : PhysicsheatboundaryEdge) -> PhysicsheatboundaryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryEdge::copy(self : PhysicsheatboundaryEdge) -> PhysicsheatboundaryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryEdge::fill(self : PhysicsheatboundaryEdge, v : Double) -> PhysicsheatboundaryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryEdge::min(self : PhysicsheatboundaryEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryEdge::max(self : PhysicsheatboundaryEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryEdge::to_string(self : PhysicsheatboundaryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_path_make(size : Int) -> PhysicsheatboundaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryPath::len(self : PhysicsheatboundaryPath) -> Int { self.size }

pub fn PhysicsheatboundaryPath::get(self : PhysicsheatboundaryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryPath::set(self : PhysicsheatboundaryPath, i : Int, v : Double) -> PhysicsheatboundaryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryPath::sum(self : PhysicsheatboundaryPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryPath::mean(self : PhysicsheatboundaryPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryPath::scale(self : PhysicsheatboundaryPath, f : Double) -> PhysicsheatboundaryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryPath::add(self : PhysicsheatboundaryPath, other : PhysicsheatboundaryPath) -> PhysicsheatboundaryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryPath::copy(self : PhysicsheatboundaryPath) -> PhysicsheatboundaryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryPath::fill(self : PhysicsheatboundaryPath, v : Double) -> PhysicsheatboundaryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryPath::min(self : PhysicsheatboundaryPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryPath::max(self : PhysicsheatboundaryPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryPath::to_string(self : PhysicsheatboundaryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_cluster_make(size : Int) -> PhysicsheatboundaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryCluster::len(self : PhysicsheatboundaryCluster) -> Int { self.size }

pub fn PhysicsheatboundaryCluster::get(self : PhysicsheatboundaryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryCluster::set(self : PhysicsheatboundaryCluster, i : Int, v : Double) -> PhysicsheatboundaryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCluster::sum(self : PhysicsheatboundaryCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryCluster::mean(self : PhysicsheatboundaryCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryCluster::scale(self : PhysicsheatboundaryCluster, f : Double) -> PhysicsheatboundaryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCluster::add(self : PhysicsheatboundaryCluster, other : PhysicsheatboundaryCluster) -> PhysicsheatboundaryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryCluster::copy(self : PhysicsheatboundaryCluster) -> PhysicsheatboundaryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCluster::fill(self : PhysicsheatboundaryCluster, v : Double) -> PhysicsheatboundaryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCluster::min(self : PhysicsheatboundaryCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryCluster::max(self : PhysicsheatboundaryCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryCluster::to_string(self : PhysicsheatboundaryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_model_make(size : Int) -> PhysicsheatboundaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryModel::len(self : PhysicsheatboundaryModel) -> Int { self.size }

pub fn PhysicsheatboundaryModel::get(self : PhysicsheatboundaryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryModel::set(self : PhysicsheatboundaryModel, i : Int, v : Double) -> PhysicsheatboundaryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryModel::sum(self : PhysicsheatboundaryModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryModel::mean(self : PhysicsheatboundaryModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryModel::scale(self : PhysicsheatboundaryModel, f : Double) -> PhysicsheatboundaryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryModel::add(self : PhysicsheatboundaryModel, other : PhysicsheatboundaryModel) -> PhysicsheatboundaryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryModel::copy(self : PhysicsheatboundaryModel) -> PhysicsheatboundaryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryModel::fill(self : PhysicsheatboundaryModel, v : Double) -> PhysicsheatboundaryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryModel::min(self : PhysicsheatboundaryModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryModel::max(self : PhysicsheatboundaryModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryModel::to_string(self : PhysicsheatboundaryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_layer_make(size : Int) -> PhysicsheatboundaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryLayer::len(self : PhysicsheatboundaryLayer) -> Int { self.size }

pub fn PhysicsheatboundaryLayer::get(self : PhysicsheatboundaryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryLayer::set(self : PhysicsheatboundaryLayer, i : Int, v : Double) -> PhysicsheatboundaryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryLayer::sum(self : PhysicsheatboundaryLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryLayer::mean(self : PhysicsheatboundaryLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryLayer::scale(self : PhysicsheatboundaryLayer, f : Double) -> PhysicsheatboundaryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryLayer::add(self : PhysicsheatboundaryLayer, other : PhysicsheatboundaryLayer) -> PhysicsheatboundaryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryLayer::copy(self : PhysicsheatboundaryLayer) -> PhysicsheatboundaryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryLayer::fill(self : PhysicsheatboundaryLayer, v : Double) -> PhysicsheatboundaryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryLayer::min(self : PhysicsheatboundaryLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryLayer::max(self : PhysicsheatboundaryLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryLayer::to_string(self : PhysicsheatboundaryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_buffer_make(size : Int) -> PhysicsheatboundaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryBuffer::len(self : PhysicsheatboundaryBuffer) -> Int { self.size }

pub fn PhysicsheatboundaryBuffer::get(self : PhysicsheatboundaryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryBuffer::set(self : PhysicsheatboundaryBuffer, i : Int, v : Double) -> PhysicsheatboundaryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryBuffer::sum(self : PhysicsheatboundaryBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryBuffer::mean(self : PhysicsheatboundaryBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryBuffer::scale(self : PhysicsheatboundaryBuffer, f : Double) -> PhysicsheatboundaryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryBuffer::add(self : PhysicsheatboundaryBuffer, other : PhysicsheatboundaryBuffer) -> PhysicsheatboundaryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryBuffer::copy(self : PhysicsheatboundaryBuffer) -> PhysicsheatboundaryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryBuffer::fill(self : PhysicsheatboundaryBuffer, v : Double) -> PhysicsheatboundaryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryBuffer::min(self : PhysicsheatboundaryBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryBuffer::max(self : PhysicsheatboundaryBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryBuffer::to_string(self : PhysicsheatboundaryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_cursor_make(size : Int) -> PhysicsheatboundaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryCursor::len(self : PhysicsheatboundaryCursor) -> Int { self.size }

pub fn PhysicsheatboundaryCursor::get(self : PhysicsheatboundaryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryCursor::set(self : PhysicsheatboundaryCursor, i : Int, v : Double) -> PhysicsheatboundaryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCursor::sum(self : PhysicsheatboundaryCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryCursor::mean(self : PhysicsheatboundaryCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryCursor::scale(self : PhysicsheatboundaryCursor, f : Double) -> PhysicsheatboundaryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCursor::add(self : PhysicsheatboundaryCursor, other : PhysicsheatboundaryCursor) -> PhysicsheatboundaryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryCursor::copy(self : PhysicsheatboundaryCursor) -> PhysicsheatboundaryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCursor::fill(self : PhysicsheatboundaryCursor, v : Double) -> PhysicsheatboundaryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryCursor::min(self : PhysicsheatboundaryCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryCursor::max(self : PhysicsheatboundaryCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryCursor::to_string(self : PhysicsheatboundaryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_view_make(size : Int) -> PhysicsheatboundaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryView::len(self : PhysicsheatboundaryView) -> Int { self.size }

pub fn PhysicsheatboundaryView::get(self : PhysicsheatboundaryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryView::set(self : PhysicsheatboundaryView, i : Int, v : Double) -> PhysicsheatboundaryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryView::sum(self : PhysicsheatboundaryView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryView::mean(self : PhysicsheatboundaryView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryView::scale(self : PhysicsheatboundaryView, f : Double) -> PhysicsheatboundaryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryView::add(self : PhysicsheatboundaryView, other : PhysicsheatboundaryView) -> PhysicsheatboundaryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryView::copy(self : PhysicsheatboundaryView) -> PhysicsheatboundaryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryView::fill(self : PhysicsheatboundaryView, v : Double) -> PhysicsheatboundaryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryView::min(self : PhysicsheatboundaryView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryView::max(self : PhysicsheatboundaryView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryView::to_string(self : PhysicsheatboundaryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_range_make(size : Int) -> PhysicsheatboundaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundaryRange::len(self : PhysicsheatboundaryRange) -> Int { self.size }

pub fn PhysicsheatboundaryRange::get(self : PhysicsheatboundaryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundaryRange::set(self : PhysicsheatboundaryRange, i : Int, v : Double) -> PhysicsheatboundaryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryRange::sum(self : PhysicsheatboundaryRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundaryRange::mean(self : PhysicsheatboundaryRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundaryRange::scale(self : PhysicsheatboundaryRange, f : Double) -> PhysicsheatboundaryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryRange::add(self : PhysicsheatboundaryRange, other : PhysicsheatboundaryRange) -> PhysicsheatboundaryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundaryRange::copy(self : PhysicsheatboundaryRange) -> PhysicsheatboundaryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryRange::fill(self : PhysicsheatboundaryRange, v : Double) -> PhysicsheatboundaryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundaryRange::min(self : PhysicsheatboundaryRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundaryRange::max(self : PhysicsheatboundaryRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundaryRange::to_string(self : PhysicsheatboundaryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_slice_make(size : Int) -> PhysicsheatboundarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatboundarySlice::len(self : PhysicsheatboundarySlice) -> Int { self.size }

pub fn PhysicsheatboundarySlice::get(self : PhysicsheatboundarySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatboundarySlice::set(self : PhysicsheatboundarySlice, i : Int, v : Double) -> PhysicsheatboundarySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundarySlice::sum(self : PhysicsheatboundarySlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatboundarySlice::mean(self : PhysicsheatboundarySlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatboundarySlice::scale(self : PhysicsheatboundarySlice, f : Double) -> PhysicsheatboundarySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundarySlice::add(self : PhysicsheatboundarySlice, other : PhysicsheatboundarySlice) -> PhysicsheatboundarySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatboundarySlice::copy(self : PhysicsheatboundarySlice) -> PhysicsheatboundarySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundarySlice::fill(self : PhysicsheatboundarySlice, v : Double) -> PhysicsheatboundarySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatboundarySlice::min(self : PhysicsheatboundarySlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatboundarySlice::max(self : PhysicsheatboundarySlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatboundarySlice::to_string(self : PhysicsheatboundarySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

