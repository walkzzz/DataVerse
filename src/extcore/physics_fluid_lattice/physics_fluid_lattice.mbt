///===
/// extcore/physics_fluid_lattice

pub(all) struct PhysicsfluidlatticePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_lattice_make_point(x : Double, y : Double) -> PhysicsfluidlatticePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_lattice_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidlatticePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidlatticePoint::x(self : PhysicsfluidlatticePoint) -> Double { self.x }

pub fn PhysicsfluidlatticePoint::y(self : PhysicsfluidlatticePoint) -> Double { self.y }

pub fn PhysicsfluidlatticePoint::z(self : PhysicsfluidlatticePoint) -> Double { self.z }

pub fn PhysicsfluidlatticePoint::label(self : PhysicsfluidlatticePoint) -> Int { self.label }

pub fn PhysicsfluidlatticePoint::dist(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidlatticePoint::add(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidlatticePoint::sub(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidlatticePoint::scale(self : PhysicsfluidlatticePoint, s : Double) -> PhysicsfluidlatticePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidlatticePoint::dot(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidlatticePoint::cross(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidlatticePoint::norm(self : PhysicsfluidlatticePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidlatticePoint::normalize(self : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidlatticePoint::negate(self : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidlatticePoint::mid(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidlatticePoint::lerp(self : PhysicsfluidlatticePoint, other : PhysicsfluidlatticePoint, t : Double) -> PhysicsfluidlatticePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidlatticePoint::to_string(self : PhysicsfluidlatticePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_lattice_make_series(vals : Array[Double], name : String) -> PhysicsfluidlatticeSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidlatticeSeries::len(self : PhysicsfluidlatticeSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidlatticeSeries::sum(self : PhysicsfluidlatticeSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidlatticeSeries::mean(self : PhysicsfluidlatticeSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidlatticeSeries::min(self : PhysicsfluidlatticeSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidlatticeSeries::max(self : PhysicsfluidlatticeSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidlatticeSeries::range(self : PhysicsfluidlatticeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidlatticeSeries::variance(self : PhysicsfluidlatticeSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidlatticeSeries::std(self : PhysicsfluidlatticeSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidlatticeSeries::median(self : PhysicsfluidlatticeSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidlatticeSeries::scale(self : PhysicsfluidlatticeSeries, f : Double) -> PhysicsfluidlatticeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::add(self : PhysicsfluidlatticeSeries, other : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::sub(self : PhysicsfluidlatticeSeries, other : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::normalize(self : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidlatticeSeries::cumsum(self : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidlatticeSeries::to_string(self : PhysicsfluidlatticeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlatticeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_lattice_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidlatticeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_lattice_matrix_identity(n : Int) -> PhysicsfluidlatticeMatrix {
  let m = physics_fluid_lattice_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidlatticeMatrix::get(self : PhysicsfluidlatticeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidlatticeMatrix::transpose(self : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  let result = physics_fluid_lattice_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidlatticeMatrix::add(self : PhysicsfluidlatticeMatrix, other : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_lattice_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidlatticeMatrix::scale(self : PhysicsfluidlatticeMatrix, s : Double) -> PhysicsfluidlatticeMatrix {
  let result = physics_fluid_lattice_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidlatticeMatrix::multiply(self : PhysicsfluidlatticeMatrix, other : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  if self.cols != other.rows { return physics_fluid_lattice_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_lattice_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidlatticeMatrix::trace(self : PhysicsfluidlatticeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidlatticeMatrix::det(self : PhysicsfluidlatticeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidlatticeMatrix::norm(self : PhysicsfluidlatticeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidlatticeMatrix::to_string(self : PhysicsfluidlatticeMatrix) -> String {
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

pub(all) struct PhysicsfluidlatticeVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_lattice_make_vector(comps : Array[Double]) -> PhysicsfluidlatticeVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_lattice_vector_zero(dim : Int) -> PhysicsfluidlatticeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidlatticeVector::add(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidlatticeVector::sub(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidlatticeVector::scale(self : PhysicsfluidlatticeVector, s : Double) -> PhysicsfluidlatticeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidlatticeVector::dot(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidlatticeVector::norm(self : PhysicsfluidlatticeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidlatticeVector::normalize(self : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidlatticeVector::dist(self : PhysicsfluidlatticeVector, other : PhysicsfluidlatticeVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidlatticeVector::to_string(self : PhysicsfluidlatticeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_lattice_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_lattice_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_lattice_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_lattice_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_lattice_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_lattice_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_lattice_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_lattice_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_lattice_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_lattice_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_lattice_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_lattice_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_lattice_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_lattice_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_lattice_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_lattice_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_lattice_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_lattice_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_lattice_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_lattice_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_lattice_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_lattice_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_lattice_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_lattice_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_lattice_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_lattice_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_lattice_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_lattice_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_lattice_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidlatticeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_frame_make(size : Int) -> PhysicsfluidlatticeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_frame_len(s : PhysicsfluidlatticeFrame) -> Int { s.size }

pub fn physics_fluid_lattice_frame_get(s : PhysicsfluidlatticeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_frame_set(s : PhysicsfluidlatticeFrame, i : Int, v : Double) -> PhysicsfluidlatticeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_sum(s : PhysicsfluidlatticeFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_frame_mean(s : PhysicsfluidlatticeFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_frame_scale(s : PhysicsfluidlatticeFrame, f : Double) -> PhysicsfluidlatticeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_add(a : PhysicsfluidlatticeFrame, b : PhysicsfluidlatticeFrame) -> PhysicsfluidlatticeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_frame_copy(s : PhysicsfluidlatticeFrame) -> PhysicsfluidlatticeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_fill(s : PhysicsfluidlatticeFrame, v : Double) -> PhysicsfluidlatticeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_min(s : PhysicsfluidlatticeFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_frame_max(s : PhysicsfluidlatticeFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_frame_to_string(s : PhysicsfluidlatticeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_table_make(size : Int) -> PhysicsfluidlatticeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_table_len(s : PhysicsfluidlatticeTable) -> Int { s.size }

pub fn physics_fluid_lattice_table_get(s : PhysicsfluidlatticeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_table_set(s : PhysicsfluidlatticeTable, i : Int, v : Double) -> PhysicsfluidlatticeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_sum(s : PhysicsfluidlatticeTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_table_mean(s : PhysicsfluidlatticeTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_table_scale(s : PhysicsfluidlatticeTable, f : Double) -> PhysicsfluidlatticeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_add(a : PhysicsfluidlatticeTable, b : PhysicsfluidlatticeTable) -> PhysicsfluidlatticeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_table_copy(s : PhysicsfluidlatticeTable) -> PhysicsfluidlatticeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_fill(s : PhysicsfluidlatticeTable, v : Double) -> PhysicsfluidlatticeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_min(s : PhysicsfluidlatticeTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_table_max(s : PhysicsfluidlatticeTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_table_to_string(s : PhysicsfluidlatticeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_graphn_make(size : Int) -> PhysicsfluidlatticeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_graphn_len(s : PhysicsfluidlatticeGraphN) -> Int { s.size }

pub fn physics_fluid_lattice_graphn_get(s : PhysicsfluidlatticeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_graphn_set(s : PhysicsfluidlatticeGraphN, i : Int, v : Double) -> PhysicsfluidlatticeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_sum(s : PhysicsfluidlatticeGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_graphn_mean(s : PhysicsfluidlatticeGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_graphn_scale(s : PhysicsfluidlatticeGraphN, f : Double) -> PhysicsfluidlatticeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_add(a : PhysicsfluidlatticeGraphN, b : PhysicsfluidlatticeGraphN) -> PhysicsfluidlatticeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_graphn_copy(s : PhysicsfluidlatticeGraphN) -> PhysicsfluidlatticeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_fill(s : PhysicsfluidlatticeGraphN, v : Double) -> PhysicsfluidlatticeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_min(s : PhysicsfluidlatticeGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_graphn_max(s : PhysicsfluidlatticeGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_graphn_to_string(s : PhysicsfluidlatticeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_node_make(size : Int) -> PhysicsfluidlatticeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_node_len(s : PhysicsfluidlatticeNode) -> Int { s.size }

pub fn physics_fluid_lattice_node_get(s : PhysicsfluidlatticeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_node_set(s : PhysicsfluidlatticeNode, i : Int, v : Double) -> PhysicsfluidlatticeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_sum(s : PhysicsfluidlatticeNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_node_mean(s : PhysicsfluidlatticeNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_node_scale(s : PhysicsfluidlatticeNode, f : Double) -> PhysicsfluidlatticeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_add(a : PhysicsfluidlatticeNode, b : PhysicsfluidlatticeNode) -> PhysicsfluidlatticeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_node_copy(s : PhysicsfluidlatticeNode) -> PhysicsfluidlatticeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_fill(s : PhysicsfluidlatticeNode, v : Double) -> PhysicsfluidlatticeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_min(s : PhysicsfluidlatticeNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_node_max(s : PhysicsfluidlatticeNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_node_to_string(s : PhysicsfluidlatticeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_edge_make(size : Int) -> PhysicsfluidlatticeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_edge_len(s : PhysicsfluidlatticeEdge) -> Int { s.size }

pub fn physics_fluid_lattice_edge_get(s : PhysicsfluidlatticeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_edge_set(s : PhysicsfluidlatticeEdge, i : Int, v : Double) -> PhysicsfluidlatticeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_sum(s : PhysicsfluidlatticeEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_edge_mean(s : PhysicsfluidlatticeEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_edge_scale(s : PhysicsfluidlatticeEdge, f : Double) -> PhysicsfluidlatticeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_add(a : PhysicsfluidlatticeEdge, b : PhysicsfluidlatticeEdge) -> PhysicsfluidlatticeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_edge_copy(s : PhysicsfluidlatticeEdge) -> PhysicsfluidlatticeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_fill(s : PhysicsfluidlatticeEdge, v : Double) -> PhysicsfluidlatticeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_min(s : PhysicsfluidlatticeEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_edge_max(s : PhysicsfluidlatticeEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_edge_to_string(s : PhysicsfluidlatticeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_path_make(size : Int) -> PhysicsfluidlatticePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_path_len(s : PhysicsfluidlatticePath) -> Int { s.size }

pub fn physics_fluid_lattice_path_get(s : PhysicsfluidlatticePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_path_set(s : PhysicsfluidlatticePath, i : Int, v : Double) -> PhysicsfluidlatticePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_sum(s : PhysicsfluidlatticePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_path_mean(s : PhysicsfluidlatticePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_path_scale(s : PhysicsfluidlatticePath, f : Double) -> PhysicsfluidlatticePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_add(a : PhysicsfluidlatticePath, b : PhysicsfluidlatticePath) -> PhysicsfluidlatticePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_path_copy(s : PhysicsfluidlatticePath) -> PhysicsfluidlatticePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_fill(s : PhysicsfluidlatticePath, v : Double) -> PhysicsfluidlatticePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_min(s : PhysicsfluidlatticePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_path_max(s : PhysicsfluidlatticePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_path_to_string(s : PhysicsfluidlatticePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_cluster_make(size : Int) -> PhysicsfluidlatticeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_cluster_len(s : PhysicsfluidlatticeCluster) -> Int { s.size }

pub fn physics_fluid_lattice_cluster_get(s : PhysicsfluidlatticeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_cluster_set(s : PhysicsfluidlatticeCluster, i : Int, v : Double) -> PhysicsfluidlatticeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_sum(s : PhysicsfluidlatticeCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_cluster_mean(s : PhysicsfluidlatticeCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_cluster_scale(s : PhysicsfluidlatticeCluster, f : Double) -> PhysicsfluidlatticeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_add(a : PhysicsfluidlatticeCluster, b : PhysicsfluidlatticeCluster) -> PhysicsfluidlatticeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_cluster_copy(s : PhysicsfluidlatticeCluster) -> PhysicsfluidlatticeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_fill(s : PhysicsfluidlatticeCluster, v : Double) -> PhysicsfluidlatticeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_min(s : PhysicsfluidlatticeCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_cluster_max(s : PhysicsfluidlatticeCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_cluster_to_string(s : PhysicsfluidlatticeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_model_make(size : Int) -> PhysicsfluidlatticeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_model_len(s : PhysicsfluidlatticeModel) -> Int { s.size }

pub fn physics_fluid_lattice_model_get(s : PhysicsfluidlatticeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_model_set(s : PhysicsfluidlatticeModel, i : Int, v : Double) -> PhysicsfluidlatticeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_sum(s : PhysicsfluidlatticeModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_model_mean(s : PhysicsfluidlatticeModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_model_scale(s : PhysicsfluidlatticeModel, f : Double) -> PhysicsfluidlatticeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_add(a : PhysicsfluidlatticeModel, b : PhysicsfluidlatticeModel) -> PhysicsfluidlatticeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_model_copy(s : PhysicsfluidlatticeModel) -> PhysicsfluidlatticeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_fill(s : PhysicsfluidlatticeModel, v : Double) -> PhysicsfluidlatticeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_min(s : PhysicsfluidlatticeModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_model_max(s : PhysicsfluidlatticeModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_model_to_string(s : PhysicsfluidlatticeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_layer_make(size : Int) -> PhysicsfluidlatticeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_layer_len(s : PhysicsfluidlatticeLayer) -> Int { s.size }

pub fn physics_fluid_lattice_layer_get(s : PhysicsfluidlatticeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_layer_set(s : PhysicsfluidlatticeLayer, i : Int, v : Double) -> PhysicsfluidlatticeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_sum(s : PhysicsfluidlatticeLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_layer_mean(s : PhysicsfluidlatticeLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_layer_scale(s : PhysicsfluidlatticeLayer, f : Double) -> PhysicsfluidlatticeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_add(a : PhysicsfluidlatticeLayer, b : PhysicsfluidlatticeLayer) -> PhysicsfluidlatticeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_layer_copy(s : PhysicsfluidlatticeLayer) -> PhysicsfluidlatticeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_fill(s : PhysicsfluidlatticeLayer, v : Double) -> PhysicsfluidlatticeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_min(s : PhysicsfluidlatticeLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_layer_max(s : PhysicsfluidlatticeLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_layer_to_string(s : PhysicsfluidlatticeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_buffer_make(size : Int) -> PhysicsfluidlatticeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_buffer_len(s : PhysicsfluidlatticeBuffer) -> Int { s.size }

pub fn physics_fluid_lattice_buffer_get(s : PhysicsfluidlatticeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_buffer_set(s : PhysicsfluidlatticeBuffer, i : Int, v : Double) -> PhysicsfluidlatticeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_sum(s : PhysicsfluidlatticeBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_buffer_mean(s : PhysicsfluidlatticeBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_buffer_scale(s : PhysicsfluidlatticeBuffer, f : Double) -> PhysicsfluidlatticeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_add(a : PhysicsfluidlatticeBuffer, b : PhysicsfluidlatticeBuffer) -> PhysicsfluidlatticeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_buffer_copy(s : PhysicsfluidlatticeBuffer) -> PhysicsfluidlatticeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_fill(s : PhysicsfluidlatticeBuffer, v : Double) -> PhysicsfluidlatticeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_min(s : PhysicsfluidlatticeBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_buffer_max(s : PhysicsfluidlatticeBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_buffer_to_string(s : PhysicsfluidlatticeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_cursor_make(size : Int) -> PhysicsfluidlatticeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_cursor_len(s : PhysicsfluidlatticeCursor) -> Int { s.size }

pub fn physics_fluid_lattice_cursor_get(s : PhysicsfluidlatticeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_cursor_set(s : PhysicsfluidlatticeCursor, i : Int, v : Double) -> PhysicsfluidlatticeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_sum(s : PhysicsfluidlatticeCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_cursor_mean(s : PhysicsfluidlatticeCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_cursor_scale(s : PhysicsfluidlatticeCursor, f : Double) -> PhysicsfluidlatticeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_add(a : PhysicsfluidlatticeCursor, b : PhysicsfluidlatticeCursor) -> PhysicsfluidlatticeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_cursor_copy(s : PhysicsfluidlatticeCursor) -> PhysicsfluidlatticeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_fill(s : PhysicsfluidlatticeCursor, v : Double) -> PhysicsfluidlatticeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_min(s : PhysicsfluidlatticeCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_cursor_max(s : PhysicsfluidlatticeCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_cursor_to_string(s : PhysicsfluidlatticeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_view_make(size : Int) -> PhysicsfluidlatticeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_view_len(s : PhysicsfluidlatticeView) -> Int { s.size }

pub fn physics_fluid_lattice_view_get(s : PhysicsfluidlatticeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_view_set(s : PhysicsfluidlatticeView, i : Int, v : Double) -> PhysicsfluidlatticeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_sum(s : PhysicsfluidlatticeView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_view_mean(s : PhysicsfluidlatticeView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_view_scale(s : PhysicsfluidlatticeView, f : Double) -> PhysicsfluidlatticeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_add(a : PhysicsfluidlatticeView, b : PhysicsfluidlatticeView) -> PhysicsfluidlatticeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_view_copy(s : PhysicsfluidlatticeView) -> PhysicsfluidlatticeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_fill(s : PhysicsfluidlatticeView, v : Double) -> PhysicsfluidlatticeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_min(s : PhysicsfluidlatticeView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_view_max(s : PhysicsfluidlatticeView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_view_to_string(s : PhysicsfluidlatticeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_range_make(size : Int) -> PhysicsfluidlatticeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_range_len(s : PhysicsfluidlatticeRange) -> Int { s.size }

pub fn physics_fluid_lattice_range_get(s : PhysicsfluidlatticeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_range_set(s : PhysicsfluidlatticeRange, i : Int, v : Double) -> PhysicsfluidlatticeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_sum(s : PhysicsfluidlatticeRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_range_mean(s : PhysicsfluidlatticeRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_range_scale(s : PhysicsfluidlatticeRange, f : Double) -> PhysicsfluidlatticeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_add(a : PhysicsfluidlatticeRange, b : PhysicsfluidlatticeRange) -> PhysicsfluidlatticeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_range_copy(s : PhysicsfluidlatticeRange) -> PhysicsfluidlatticeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_fill(s : PhysicsfluidlatticeRange, v : Double) -> PhysicsfluidlatticeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_min(s : PhysicsfluidlatticeRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_range_max(s : PhysicsfluidlatticeRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_range_to_string(s : PhysicsfluidlatticeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_slice_make(size : Int) -> PhysicsfluidlatticeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_slice_len(s : PhysicsfluidlatticeSlice) -> Int { s.size }

pub fn physics_fluid_lattice_slice_get(s : PhysicsfluidlatticeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_slice_set(s : PhysicsfluidlatticeSlice, i : Int, v : Double) -> PhysicsfluidlatticeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_sum(s : PhysicsfluidlatticeSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_slice_mean(s : PhysicsfluidlatticeSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_slice_scale(s : PhysicsfluidlatticeSlice, f : Double) -> PhysicsfluidlatticeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_add(a : PhysicsfluidlatticeSlice, b : PhysicsfluidlatticeSlice) -> PhysicsfluidlatticeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_slice_copy(s : PhysicsfluidlatticeSlice) -> PhysicsfluidlatticeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_fill(s : PhysicsfluidlatticeSlice, v : Double) -> PhysicsfluidlatticeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_min(s : PhysicsfluidlatticeSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_slice_max(s : PhysicsfluidlatticeSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_slice_to_string(s : PhysicsfluidlatticeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

