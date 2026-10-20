///===
/// extcore/physics_fluid_turbulence

pub(all) struct PhysicsfluidturbulencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_turbulence_make_point(x : Double, y : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_turbulence_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidturbulencePoint::x(self : PhysicsfluidturbulencePoint) -> Double { self.x }

pub fn PhysicsfluidturbulencePoint::y(self : PhysicsfluidturbulencePoint) -> Double { self.y }

pub fn PhysicsfluidturbulencePoint::z(self : PhysicsfluidturbulencePoint) -> Double { self.z }

pub fn PhysicsfluidturbulencePoint::label(self : PhysicsfluidturbulencePoint) -> Int { self.label }

pub fn PhysicsfluidturbulencePoint::dist(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidturbulencePoint::add(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::sub(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::scale(self : PhysicsfluidturbulencePoint, s : Double) -> PhysicsfluidturbulencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::dot(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidturbulencePoint::cross(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidturbulencePoint::norm(self : PhysicsfluidturbulencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidturbulencePoint::normalize(self : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidturbulencePoint::negate(self : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::mid(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::lerp(self : PhysicsfluidturbulencePoint, other : PhysicsfluidturbulencePoint, t : Double) -> PhysicsfluidturbulencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidturbulencePoint::to_string(self : PhysicsfluidturbulencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_turbulence_make_series(vals : Array[Double], name : String) -> PhysicsfluidturbulenceSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidturbulenceSeries::len(self : PhysicsfluidturbulenceSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidturbulenceSeries::sum(self : PhysicsfluidturbulenceSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidturbulenceSeries::mean(self : PhysicsfluidturbulenceSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidturbulenceSeries::min(self : PhysicsfluidturbulenceSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidturbulenceSeries::max(self : PhysicsfluidturbulenceSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidturbulenceSeries::range(self : PhysicsfluidturbulenceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidturbulenceSeries::variance(self : PhysicsfluidturbulenceSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidturbulenceSeries::std(self : PhysicsfluidturbulenceSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidturbulenceSeries::median(self : PhysicsfluidturbulenceSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidturbulenceSeries::scale(self : PhysicsfluidturbulenceSeries, f : Double) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::add(self : PhysicsfluidturbulenceSeries, other : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::sub(self : PhysicsfluidturbulenceSeries, other : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::normalize(self : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidturbulenceSeries::cumsum(self : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidturbulenceSeries::to_string(self : PhysicsfluidturbulenceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidturbulenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_turbulence_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidturbulenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_turbulence_matrix_identity(n : Int) -> PhysicsfluidturbulenceMatrix {
  let m = physics_fluid_turbulence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidturbulenceMatrix::get(self : PhysicsfluidturbulenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidturbulenceMatrix::transpose(self : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidturbulenceMatrix::add(self : PhysicsfluidturbulenceMatrix, other : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_turbulence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidturbulenceMatrix::scale(self : PhysicsfluidturbulenceMatrix, s : Double) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidturbulenceMatrix::multiply(self : PhysicsfluidturbulenceMatrix, other : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if self.cols != other.rows { return physics_fluid_turbulence_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_turbulence_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidturbulenceMatrix::trace(self : PhysicsfluidturbulenceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidturbulenceMatrix::det(self : PhysicsfluidturbulenceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidturbulenceMatrix::norm(self : PhysicsfluidturbulenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidturbulenceMatrix::to_string(self : PhysicsfluidturbulenceMatrix) -> String {
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

pub(all) struct PhysicsfluidturbulenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_turbulence_make_vector(comps : Array[Double]) -> PhysicsfluidturbulenceVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_turbulence_vector_zero(dim : Int) -> PhysicsfluidturbulenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidturbulenceVector::add(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidturbulenceVector::sub(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidturbulenceVector::scale(self : PhysicsfluidturbulenceVector, s : Double) -> PhysicsfluidturbulenceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidturbulenceVector::dot(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidturbulenceVector::norm(self : PhysicsfluidturbulenceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidturbulenceVector::normalize(self : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidturbulenceVector::dist(self : PhysicsfluidturbulenceVector, other : PhysicsfluidturbulenceVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidturbulenceVector::to_string(self : PhysicsfluidturbulenceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_turbulence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_turbulence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_turbulence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_turbulence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_turbulence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_turbulence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_turbulence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_turbulence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_turbulence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_turbulence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_turbulence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_turbulence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_turbulence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_turbulence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_turbulence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_turbulence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_turbulence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_turbulence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_turbulence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_turbulence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_turbulence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_turbulence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_turbulence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_turbulence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_turbulence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_turbulence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_turbulence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_turbulence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_turbulence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidturbulenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_frame_make(size : Int) -> PhysicsfluidturbulenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_frame_len(s : PhysicsfluidturbulenceFrame) -> Int { s.size }

pub fn physics_fluid_turbulence_frame_get(s : PhysicsfluidturbulenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_frame_set(s : PhysicsfluidturbulenceFrame, i : Int, v : Double) -> PhysicsfluidturbulenceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_sum(s : PhysicsfluidturbulenceFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_frame_mean(s : PhysicsfluidturbulenceFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_frame_scale(s : PhysicsfluidturbulenceFrame, f : Double) -> PhysicsfluidturbulenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_add(a : PhysicsfluidturbulenceFrame, b : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_frame_copy(s : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_fill(s : PhysicsfluidturbulenceFrame, v : Double) -> PhysicsfluidturbulenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_min(s : PhysicsfluidturbulenceFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_frame_max(s : PhysicsfluidturbulenceFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_frame_to_string(s : PhysicsfluidturbulenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_table_make(size : Int) -> PhysicsfluidturbulenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_table_len(s : PhysicsfluidturbulenceTable) -> Int { s.size }

pub fn physics_fluid_turbulence_table_get(s : PhysicsfluidturbulenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_table_set(s : PhysicsfluidturbulenceTable, i : Int, v : Double) -> PhysicsfluidturbulenceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_sum(s : PhysicsfluidturbulenceTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_table_mean(s : PhysicsfluidturbulenceTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_table_scale(s : PhysicsfluidturbulenceTable, f : Double) -> PhysicsfluidturbulenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_add(a : PhysicsfluidturbulenceTable, b : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_table_copy(s : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_fill(s : PhysicsfluidturbulenceTable, v : Double) -> PhysicsfluidturbulenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_min(s : PhysicsfluidturbulenceTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_table_max(s : PhysicsfluidturbulenceTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_table_to_string(s : PhysicsfluidturbulenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_graphn_make(size : Int) -> PhysicsfluidturbulenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_graphn_len(s : PhysicsfluidturbulenceGraphN) -> Int { s.size }

pub fn physics_fluid_turbulence_graphn_get(s : PhysicsfluidturbulenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_graphn_set(s : PhysicsfluidturbulenceGraphN, i : Int, v : Double) -> PhysicsfluidturbulenceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_sum(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_graphn_mean(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_graphn_scale(s : PhysicsfluidturbulenceGraphN, f : Double) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_add(a : PhysicsfluidturbulenceGraphN, b : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_graphn_copy(s : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_fill(s : PhysicsfluidturbulenceGraphN, v : Double) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_min(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_graphn_max(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_graphn_to_string(s : PhysicsfluidturbulenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_node_make(size : Int) -> PhysicsfluidturbulenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_node_len(s : PhysicsfluidturbulenceNode) -> Int { s.size }

pub fn physics_fluid_turbulence_node_get(s : PhysicsfluidturbulenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_node_set(s : PhysicsfluidturbulenceNode, i : Int, v : Double) -> PhysicsfluidturbulenceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_sum(s : PhysicsfluidturbulenceNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_node_mean(s : PhysicsfluidturbulenceNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_node_scale(s : PhysicsfluidturbulenceNode, f : Double) -> PhysicsfluidturbulenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_add(a : PhysicsfluidturbulenceNode, b : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_node_copy(s : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_fill(s : PhysicsfluidturbulenceNode, v : Double) -> PhysicsfluidturbulenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_min(s : PhysicsfluidturbulenceNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_node_max(s : PhysicsfluidturbulenceNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_node_to_string(s : PhysicsfluidturbulenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_edge_make(size : Int) -> PhysicsfluidturbulenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_edge_len(s : PhysicsfluidturbulenceEdge) -> Int { s.size }

pub fn physics_fluid_turbulence_edge_get(s : PhysicsfluidturbulenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_edge_set(s : PhysicsfluidturbulenceEdge, i : Int, v : Double) -> PhysicsfluidturbulenceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_sum(s : PhysicsfluidturbulenceEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_edge_mean(s : PhysicsfluidturbulenceEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_edge_scale(s : PhysicsfluidturbulenceEdge, f : Double) -> PhysicsfluidturbulenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_add(a : PhysicsfluidturbulenceEdge, b : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_edge_copy(s : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_fill(s : PhysicsfluidturbulenceEdge, v : Double) -> PhysicsfluidturbulenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_min(s : PhysicsfluidturbulenceEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_edge_max(s : PhysicsfluidturbulenceEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_edge_to_string(s : PhysicsfluidturbulenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_path_make(size : Int) -> PhysicsfluidturbulencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_path_len(s : PhysicsfluidturbulencePath) -> Int { s.size }

pub fn physics_fluid_turbulence_path_get(s : PhysicsfluidturbulencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_path_set(s : PhysicsfluidturbulencePath, i : Int, v : Double) -> PhysicsfluidturbulencePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_sum(s : PhysicsfluidturbulencePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_path_mean(s : PhysicsfluidturbulencePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_path_scale(s : PhysicsfluidturbulencePath, f : Double) -> PhysicsfluidturbulencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_add(a : PhysicsfluidturbulencePath, b : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_path_copy(s : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_fill(s : PhysicsfluidturbulencePath, v : Double) -> PhysicsfluidturbulencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_min(s : PhysicsfluidturbulencePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_path_max(s : PhysicsfluidturbulencePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_path_to_string(s : PhysicsfluidturbulencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cluster_make(size : Int) -> PhysicsfluidturbulenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_cluster_len(s : PhysicsfluidturbulenceCluster) -> Int { s.size }

pub fn physics_fluid_turbulence_cluster_get(s : PhysicsfluidturbulenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_cluster_set(s : PhysicsfluidturbulenceCluster, i : Int, v : Double) -> PhysicsfluidturbulenceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_sum(s : PhysicsfluidturbulenceCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_cluster_mean(s : PhysicsfluidturbulenceCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_cluster_scale(s : PhysicsfluidturbulenceCluster, f : Double) -> PhysicsfluidturbulenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_add(a : PhysicsfluidturbulenceCluster, b : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_cluster_copy(s : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_fill(s : PhysicsfluidturbulenceCluster, v : Double) -> PhysicsfluidturbulenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_min(s : PhysicsfluidturbulenceCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_cluster_max(s : PhysicsfluidturbulenceCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_cluster_to_string(s : PhysicsfluidturbulenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_model_make(size : Int) -> PhysicsfluidturbulenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_model_len(s : PhysicsfluidturbulenceModel) -> Int { s.size }

pub fn physics_fluid_turbulence_model_get(s : PhysicsfluidturbulenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_model_set(s : PhysicsfluidturbulenceModel, i : Int, v : Double) -> PhysicsfluidturbulenceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_sum(s : PhysicsfluidturbulenceModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_model_mean(s : PhysicsfluidturbulenceModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_model_scale(s : PhysicsfluidturbulenceModel, f : Double) -> PhysicsfluidturbulenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_add(a : PhysicsfluidturbulenceModel, b : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_model_copy(s : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_fill(s : PhysicsfluidturbulenceModel, v : Double) -> PhysicsfluidturbulenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_min(s : PhysicsfluidturbulenceModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_model_max(s : PhysicsfluidturbulenceModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_model_to_string(s : PhysicsfluidturbulenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_layer_make(size : Int) -> PhysicsfluidturbulenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_layer_len(s : PhysicsfluidturbulenceLayer) -> Int { s.size }

pub fn physics_fluid_turbulence_layer_get(s : PhysicsfluidturbulenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_layer_set(s : PhysicsfluidturbulenceLayer, i : Int, v : Double) -> PhysicsfluidturbulenceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_sum(s : PhysicsfluidturbulenceLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_layer_mean(s : PhysicsfluidturbulenceLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_layer_scale(s : PhysicsfluidturbulenceLayer, f : Double) -> PhysicsfluidturbulenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_add(a : PhysicsfluidturbulenceLayer, b : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_layer_copy(s : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_fill(s : PhysicsfluidturbulenceLayer, v : Double) -> PhysicsfluidturbulenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_min(s : PhysicsfluidturbulenceLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_layer_max(s : PhysicsfluidturbulenceLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_layer_to_string(s : PhysicsfluidturbulenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_buffer_make(size : Int) -> PhysicsfluidturbulenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_buffer_len(s : PhysicsfluidturbulenceBuffer) -> Int { s.size }

pub fn physics_fluid_turbulence_buffer_get(s : PhysicsfluidturbulenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_buffer_set(s : PhysicsfluidturbulenceBuffer, i : Int, v : Double) -> PhysicsfluidturbulenceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_sum(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_buffer_mean(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_buffer_scale(s : PhysicsfluidturbulenceBuffer, f : Double) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_add(a : PhysicsfluidturbulenceBuffer, b : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_buffer_copy(s : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_fill(s : PhysicsfluidturbulenceBuffer, v : Double) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_min(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_buffer_max(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_buffer_to_string(s : PhysicsfluidturbulenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cursor_make(size : Int) -> PhysicsfluidturbulenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_cursor_len(s : PhysicsfluidturbulenceCursor) -> Int { s.size }

pub fn physics_fluid_turbulence_cursor_get(s : PhysicsfluidturbulenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_cursor_set(s : PhysicsfluidturbulenceCursor, i : Int, v : Double) -> PhysicsfluidturbulenceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_sum(s : PhysicsfluidturbulenceCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_cursor_mean(s : PhysicsfluidturbulenceCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_cursor_scale(s : PhysicsfluidturbulenceCursor, f : Double) -> PhysicsfluidturbulenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_add(a : PhysicsfluidturbulenceCursor, b : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_cursor_copy(s : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_fill(s : PhysicsfluidturbulenceCursor, v : Double) -> PhysicsfluidturbulenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_min(s : PhysicsfluidturbulenceCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_cursor_max(s : PhysicsfluidturbulenceCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_cursor_to_string(s : PhysicsfluidturbulenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_view_make(size : Int) -> PhysicsfluidturbulenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_view_len(s : PhysicsfluidturbulenceView) -> Int { s.size }

pub fn physics_fluid_turbulence_view_get(s : PhysicsfluidturbulenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_view_set(s : PhysicsfluidturbulenceView, i : Int, v : Double) -> PhysicsfluidturbulenceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_sum(s : PhysicsfluidturbulenceView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_view_mean(s : PhysicsfluidturbulenceView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_view_scale(s : PhysicsfluidturbulenceView, f : Double) -> PhysicsfluidturbulenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_add(a : PhysicsfluidturbulenceView, b : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_view_copy(s : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_fill(s : PhysicsfluidturbulenceView, v : Double) -> PhysicsfluidturbulenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_min(s : PhysicsfluidturbulenceView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_view_max(s : PhysicsfluidturbulenceView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_view_to_string(s : PhysicsfluidturbulenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_range_make(size : Int) -> PhysicsfluidturbulenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_range_len(s : PhysicsfluidturbulenceRange) -> Int { s.size }

pub fn physics_fluid_turbulence_range_get(s : PhysicsfluidturbulenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_range_set(s : PhysicsfluidturbulenceRange, i : Int, v : Double) -> PhysicsfluidturbulenceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_sum(s : PhysicsfluidturbulenceRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_range_mean(s : PhysicsfluidturbulenceRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_range_scale(s : PhysicsfluidturbulenceRange, f : Double) -> PhysicsfluidturbulenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_add(a : PhysicsfluidturbulenceRange, b : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_range_copy(s : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_fill(s : PhysicsfluidturbulenceRange, v : Double) -> PhysicsfluidturbulenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_min(s : PhysicsfluidturbulenceRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_range_max(s : PhysicsfluidturbulenceRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_range_to_string(s : PhysicsfluidturbulenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_slice_make(size : Int) -> PhysicsfluidturbulenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_slice_len(s : PhysicsfluidturbulenceSlice) -> Int { s.size }

pub fn physics_fluid_turbulence_slice_get(s : PhysicsfluidturbulenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_slice_set(s : PhysicsfluidturbulenceSlice, i : Int, v : Double) -> PhysicsfluidturbulenceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_sum(s : PhysicsfluidturbulenceSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_slice_mean(s : PhysicsfluidturbulenceSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_slice_scale(s : PhysicsfluidturbulenceSlice, f : Double) -> PhysicsfluidturbulenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_add(a : PhysicsfluidturbulenceSlice, b : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_slice_copy(s : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_fill(s : PhysicsfluidturbulenceSlice, v : Double) -> PhysicsfluidturbulenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_min(s : PhysicsfluidturbulenceSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_slice_max(s : PhysicsfluidturbulenceSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_slice_to_string(s : PhysicsfluidturbulenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

