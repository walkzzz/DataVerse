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

pub fn physics_heat_boundary_frame_len(s : PhysicsheatboundaryFrame) -> Int { s.size }

pub fn physics_heat_boundary_frame_get(s : PhysicsheatboundaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_frame_set(s : PhysicsheatboundaryFrame, i : Int, v : Double) -> PhysicsheatboundaryFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_frame_sum(s : PhysicsheatboundaryFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_frame_mean(s : PhysicsheatboundaryFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_frame_scale(s : PhysicsheatboundaryFrame, f : Double) -> PhysicsheatboundaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_frame_add(a : PhysicsheatboundaryFrame, b : PhysicsheatboundaryFrame) -> PhysicsheatboundaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_frame_copy(s : PhysicsheatboundaryFrame) -> PhysicsheatboundaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_frame_fill(s : PhysicsheatboundaryFrame, v : Double) -> PhysicsheatboundaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_frame_min(s : PhysicsheatboundaryFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_frame_max(s : PhysicsheatboundaryFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_frame_to_string(s : PhysicsheatboundaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_table_make(size : Int) -> PhysicsheatboundaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_table_len(s : PhysicsheatboundaryTable) -> Int { s.size }

pub fn physics_heat_boundary_table_get(s : PhysicsheatboundaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_table_set(s : PhysicsheatboundaryTable, i : Int, v : Double) -> PhysicsheatboundaryTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_table_sum(s : PhysicsheatboundaryTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_table_mean(s : PhysicsheatboundaryTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_table_scale(s : PhysicsheatboundaryTable, f : Double) -> PhysicsheatboundaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_table_add(a : PhysicsheatboundaryTable, b : PhysicsheatboundaryTable) -> PhysicsheatboundaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_table_copy(s : PhysicsheatboundaryTable) -> PhysicsheatboundaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_table_fill(s : PhysicsheatboundaryTable, v : Double) -> PhysicsheatboundaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_table_min(s : PhysicsheatboundaryTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_table_max(s : PhysicsheatboundaryTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_table_to_string(s : PhysicsheatboundaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_graphn_make(size : Int) -> PhysicsheatboundaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_graphn_len(s : PhysicsheatboundaryGraphN) -> Int { s.size }

pub fn physics_heat_boundary_graphn_get(s : PhysicsheatboundaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_graphn_set(s : PhysicsheatboundaryGraphN, i : Int, v : Double) -> PhysicsheatboundaryGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_graphn_sum(s : PhysicsheatboundaryGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_graphn_mean(s : PhysicsheatboundaryGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_graphn_scale(s : PhysicsheatboundaryGraphN, f : Double) -> PhysicsheatboundaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_graphn_add(a : PhysicsheatboundaryGraphN, b : PhysicsheatboundaryGraphN) -> PhysicsheatboundaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_graphn_copy(s : PhysicsheatboundaryGraphN) -> PhysicsheatboundaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_graphn_fill(s : PhysicsheatboundaryGraphN, v : Double) -> PhysicsheatboundaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_graphn_min(s : PhysicsheatboundaryGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_graphn_max(s : PhysicsheatboundaryGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_graphn_to_string(s : PhysicsheatboundaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_node_make(size : Int) -> PhysicsheatboundaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_node_len(s : PhysicsheatboundaryNode) -> Int { s.size }

pub fn physics_heat_boundary_node_get(s : PhysicsheatboundaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_node_set(s : PhysicsheatboundaryNode, i : Int, v : Double) -> PhysicsheatboundaryNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_node_sum(s : PhysicsheatboundaryNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_node_mean(s : PhysicsheatboundaryNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_node_scale(s : PhysicsheatboundaryNode, f : Double) -> PhysicsheatboundaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_node_add(a : PhysicsheatboundaryNode, b : PhysicsheatboundaryNode) -> PhysicsheatboundaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_node_copy(s : PhysicsheatboundaryNode) -> PhysicsheatboundaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_node_fill(s : PhysicsheatboundaryNode, v : Double) -> PhysicsheatboundaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_node_min(s : PhysicsheatboundaryNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_node_max(s : PhysicsheatboundaryNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_node_to_string(s : PhysicsheatboundaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_edge_make(size : Int) -> PhysicsheatboundaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_edge_len(s : PhysicsheatboundaryEdge) -> Int { s.size }

pub fn physics_heat_boundary_edge_get(s : PhysicsheatboundaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_edge_set(s : PhysicsheatboundaryEdge, i : Int, v : Double) -> PhysicsheatboundaryEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_edge_sum(s : PhysicsheatboundaryEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_edge_mean(s : PhysicsheatboundaryEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_edge_scale(s : PhysicsheatboundaryEdge, f : Double) -> PhysicsheatboundaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_edge_add(a : PhysicsheatboundaryEdge, b : PhysicsheatboundaryEdge) -> PhysicsheatboundaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_edge_copy(s : PhysicsheatboundaryEdge) -> PhysicsheatboundaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_edge_fill(s : PhysicsheatboundaryEdge, v : Double) -> PhysicsheatboundaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_edge_min(s : PhysicsheatboundaryEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_edge_max(s : PhysicsheatboundaryEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_edge_to_string(s : PhysicsheatboundaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_path_make(size : Int) -> PhysicsheatboundaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_path_len(s : PhysicsheatboundaryPath) -> Int { s.size }

pub fn physics_heat_boundary_path_get(s : PhysicsheatboundaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_path_set(s : PhysicsheatboundaryPath, i : Int, v : Double) -> PhysicsheatboundaryPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_path_sum(s : PhysicsheatboundaryPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_path_mean(s : PhysicsheatboundaryPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_path_scale(s : PhysicsheatboundaryPath, f : Double) -> PhysicsheatboundaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_path_add(a : PhysicsheatboundaryPath, b : PhysicsheatboundaryPath) -> PhysicsheatboundaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_path_copy(s : PhysicsheatboundaryPath) -> PhysicsheatboundaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_path_fill(s : PhysicsheatboundaryPath, v : Double) -> PhysicsheatboundaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_path_min(s : PhysicsheatboundaryPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_path_max(s : PhysicsheatboundaryPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_path_to_string(s : PhysicsheatboundaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_cluster_make(size : Int) -> PhysicsheatboundaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_cluster_len(s : PhysicsheatboundaryCluster) -> Int { s.size }

pub fn physics_heat_boundary_cluster_get(s : PhysicsheatboundaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_cluster_set(s : PhysicsheatboundaryCluster, i : Int, v : Double) -> PhysicsheatboundaryCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cluster_sum(s : PhysicsheatboundaryCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_cluster_mean(s : PhysicsheatboundaryCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_cluster_scale(s : PhysicsheatboundaryCluster, f : Double) -> PhysicsheatboundaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cluster_add(a : PhysicsheatboundaryCluster, b : PhysicsheatboundaryCluster) -> PhysicsheatboundaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_cluster_copy(s : PhysicsheatboundaryCluster) -> PhysicsheatboundaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cluster_fill(s : PhysicsheatboundaryCluster, v : Double) -> PhysicsheatboundaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cluster_min(s : PhysicsheatboundaryCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_cluster_max(s : PhysicsheatboundaryCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_cluster_to_string(s : PhysicsheatboundaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_model_make(size : Int) -> PhysicsheatboundaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_model_len(s : PhysicsheatboundaryModel) -> Int { s.size }

pub fn physics_heat_boundary_model_get(s : PhysicsheatboundaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_model_set(s : PhysicsheatboundaryModel, i : Int, v : Double) -> PhysicsheatboundaryModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_model_sum(s : PhysicsheatboundaryModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_model_mean(s : PhysicsheatboundaryModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_model_scale(s : PhysicsheatboundaryModel, f : Double) -> PhysicsheatboundaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_model_add(a : PhysicsheatboundaryModel, b : PhysicsheatboundaryModel) -> PhysicsheatboundaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_model_copy(s : PhysicsheatboundaryModel) -> PhysicsheatboundaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_model_fill(s : PhysicsheatboundaryModel, v : Double) -> PhysicsheatboundaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_model_min(s : PhysicsheatboundaryModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_model_max(s : PhysicsheatboundaryModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_model_to_string(s : PhysicsheatboundaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_layer_make(size : Int) -> PhysicsheatboundaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_layer_len(s : PhysicsheatboundaryLayer) -> Int { s.size }

pub fn physics_heat_boundary_layer_get(s : PhysicsheatboundaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_layer_set(s : PhysicsheatboundaryLayer, i : Int, v : Double) -> PhysicsheatboundaryLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_layer_sum(s : PhysicsheatboundaryLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_layer_mean(s : PhysicsheatboundaryLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_layer_scale(s : PhysicsheatboundaryLayer, f : Double) -> PhysicsheatboundaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_layer_add(a : PhysicsheatboundaryLayer, b : PhysicsheatboundaryLayer) -> PhysicsheatboundaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_layer_copy(s : PhysicsheatboundaryLayer) -> PhysicsheatboundaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_layer_fill(s : PhysicsheatboundaryLayer, v : Double) -> PhysicsheatboundaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_layer_min(s : PhysicsheatboundaryLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_layer_max(s : PhysicsheatboundaryLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_layer_to_string(s : PhysicsheatboundaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_buffer_make(size : Int) -> PhysicsheatboundaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_buffer_len(s : PhysicsheatboundaryBuffer) -> Int { s.size }

pub fn physics_heat_boundary_buffer_get(s : PhysicsheatboundaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_buffer_set(s : PhysicsheatboundaryBuffer, i : Int, v : Double) -> PhysicsheatboundaryBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_buffer_sum(s : PhysicsheatboundaryBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_buffer_mean(s : PhysicsheatboundaryBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_buffer_scale(s : PhysicsheatboundaryBuffer, f : Double) -> PhysicsheatboundaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_buffer_add(a : PhysicsheatboundaryBuffer, b : PhysicsheatboundaryBuffer) -> PhysicsheatboundaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_buffer_copy(s : PhysicsheatboundaryBuffer) -> PhysicsheatboundaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_buffer_fill(s : PhysicsheatboundaryBuffer, v : Double) -> PhysicsheatboundaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_buffer_min(s : PhysicsheatboundaryBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_buffer_max(s : PhysicsheatboundaryBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_buffer_to_string(s : PhysicsheatboundaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_cursor_make(size : Int) -> PhysicsheatboundaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_cursor_len(s : PhysicsheatboundaryCursor) -> Int { s.size }

pub fn physics_heat_boundary_cursor_get(s : PhysicsheatboundaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_cursor_set(s : PhysicsheatboundaryCursor, i : Int, v : Double) -> PhysicsheatboundaryCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cursor_sum(s : PhysicsheatboundaryCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_cursor_mean(s : PhysicsheatboundaryCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_cursor_scale(s : PhysicsheatboundaryCursor, f : Double) -> PhysicsheatboundaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cursor_add(a : PhysicsheatboundaryCursor, b : PhysicsheatboundaryCursor) -> PhysicsheatboundaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_cursor_copy(s : PhysicsheatboundaryCursor) -> PhysicsheatboundaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cursor_fill(s : PhysicsheatboundaryCursor, v : Double) -> PhysicsheatboundaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_cursor_min(s : PhysicsheatboundaryCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_cursor_max(s : PhysicsheatboundaryCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_cursor_to_string(s : PhysicsheatboundaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_view_make(size : Int) -> PhysicsheatboundaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_view_len(s : PhysicsheatboundaryView) -> Int { s.size }

pub fn physics_heat_boundary_view_get(s : PhysicsheatboundaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_view_set(s : PhysicsheatboundaryView, i : Int, v : Double) -> PhysicsheatboundaryView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_view_sum(s : PhysicsheatboundaryView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_view_mean(s : PhysicsheatboundaryView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_view_scale(s : PhysicsheatboundaryView, f : Double) -> PhysicsheatboundaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_view_add(a : PhysicsheatboundaryView, b : PhysicsheatboundaryView) -> PhysicsheatboundaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_view_copy(s : PhysicsheatboundaryView) -> PhysicsheatboundaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_view_fill(s : PhysicsheatboundaryView, v : Double) -> PhysicsheatboundaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_view_min(s : PhysicsheatboundaryView) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_view_max(s : PhysicsheatboundaryView) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_view_to_string(s : PhysicsheatboundaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_range_make(size : Int) -> PhysicsheatboundaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_range_len(s : PhysicsheatboundaryRange) -> Int { s.size }

pub fn physics_heat_boundary_range_get(s : PhysicsheatboundaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_range_set(s : PhysicsheatboundaryRange, i : Int, v : Double) -> PhysicsheatboundaryRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_range_sum(s : PhysicsheatboundaryRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_range_mean(s : PhysicsheatboundaryRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_range_scale(s : PhysicsheatboundaryRange, f : Double) -> PhysicsheatboundaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_range_add(a : PhysicsheatboundaryRange, b : PhysicsheatboundaryRange) -> PhysicsheatboundaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_range_copy(s : PhysicsheatboundaryRange) -> PhysicsheatboundaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_range_fill(s : PhysicsheatboundaryRange, v : Double) -> PhysicsheatboundaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_range_min(s : PhysicsheatboundaryRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_range_max(s : PhysicsheatboundaryRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_range_to_string(s : PhysicsheatboundaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatboundarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_boundary_slice_make(size : Int) -> PhysicsheatboundarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_boundary_slice_len(s : PhysicsheatboundarySlice) -> Int { s.size }

pub fn physics_heat_boundary_slice_get(s : PhysicsheatboundarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_boundary_slice_set(s : PhysicsheatboundarySlice, i : Int, v : Double) -> PhysicsheatboundarySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_slice_sum(s : PhysicsheatboundarySlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_boundary_slice_mean(s : PhysicsheatboundarySlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_boundary_slice_scale(s : PhysicsheatboundarySlice, f : Double) -> PhysicsheatboundarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_slice_add(a : PhysicsheatboundarySlice, b : PhysicsheatboundarySlice) -> PhysicsheatboundarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_boundary_slice_copy(s : PhysicsheatboundarySlice) -> PhysicsheatboundarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_slice_fill(s : PhysicsheatboundarySlice, v : Double) -> PhysicsheatboundarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_boundary_slice_min(s : PhysicsheatboundarySlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_boundary_slice_max(s : PhysicsheatboundarySlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_boundary_slice_to_string(s : PhysicsheatboundarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

