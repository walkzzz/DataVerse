///===
/// extcore/physics_mechanics_energy

pub(all) struct PhysicsmechanicsenergyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_energy_make_point(x : Double, y : Double) -> PhysicsmechanicsenergyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_energy_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsenergyPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsenergyPoint::x(self : PhysicsmechanicsenergyPoint) -> Double { self.x }

pub fn PhysicsmechanicsenergyPoint::y(self : PhysicsmechanicsenergyPoint) -> Double { self.y }

pub fn PhysicsmechanicsenergyPoint::z(self : PhysicsmechanicsenergyPoint) -> Double { self.z }

pub fn PhysicsmechanicsenergyPoint::label(self : PhysicsmechanicsenergyPoint) -> Int { self.label }

pub fn PhysicsmechanicsenergyPoint::dist(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsenergyPoint::add(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsenergyPoint::sub(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsenergyPoint::scale(self : PhysicsmechanicsenergyPoint, s : Double) -> PhysicsmechanicsenergyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsenergyPoint::dot(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsenergyPoint::cross(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsenergyPoint::norm(self : PhysicsmechanicsenergyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsenergyPoint::normalize(self : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsenergyPoint::negate(self : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsenergyPoint::mid(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsenergyPoint::lerp(self : PhysicsmechanicsenergyPoint, other : PhysicsmechanicsenergyPoint, t : Double) -> PhysicsmechanicsenergyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsenergyPoint::to_string(self : PhysicsmechanicsenergyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_energy_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsenergySeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsenergySeries::len(self : PhysicsmechanicsenergySeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsenergySeries::sum(self : PhysicsmechanicsenergySeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsenergySeries::mean(self : PhysicsmechanicsenergySeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsenergySeries::min(self : PhysicsmechanicsenergySeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsenergySeries::max(self : PhysicsmechanicsenergySeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsenergySeries::range(self : PhysicsmechanicsenergySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsenergySeries::variance(self : PhysicsmechanicsenergySeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsenergySeries::std(self : PhysicsmechanicsenergySeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsenergySeries::median(self : PhysicsmechanicsenergySeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsenergySeries::scale(self : PhysicsmechanicsenergySeries, f : Double) -> PhysicsmechanicsenergySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsenergySeries::add(self : PhysicsmechanicsenergySeries, other : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsenergySeries::sub(self : PhysicsmechanicsenergySeries, other : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsenergySeries::normalize(self : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsenergySeries::cumsum(self : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsenergySeries::to_string(self : PhysicsmechanicsenergySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsenergyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_energy_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsenergyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_energy_matrix_identity(n : Int) -> PhysicsmechanicsenergyMatrix {
  let m = physics_mechanics_energy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsenergyMatrix::get(self : PhysicsmechanicsenergyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsenergyMatrix::transpose(self : PhysicsmechanicsenergyMatrix) -> PhysicsmechanicsenergyMatrix {
  let result = physics_mechanics_energy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsenergyMatrix::add(self : PhysicsmechanicsenergyMatrix, other : PhysicsmechanicsenergyMatrix) -> PhysicsmechanicsenergyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_energy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsenergyMatrix::scale(self : PhysicsmechanicsenergyMatrix, s : Double) -> PhysicsmechanicsenergyMatrix {
  let result = physics_mechanics_energy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsenergyMatrix::multiply(self : PhysicsmechanicsenergyMatrix, other : PhysicsmechanicsenergyMatrix) -> PhysicsmechanicsenergyMatrix {
  if self.cols != other.rows { return physics_mechanics_energy_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_energy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsenergyMatrix::trace(self : PhysicsmechanicsenergyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsenergyMatrix::det(self : PhysicsmechanicsenergyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsenergyMatrix::norm(self : PhysicsmechanicsenergyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsenergyMatrix::to_string(self : PhysicsmechanicsenergyMatrix) -> String {
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

pub(all) struct PhysicsmechanicsenergyVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_energy_make_vector(comps : Array[Double]) -> PhysicsmechanicsenergyVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_energy_vector_zero(dim : Int) -> PhysicsmechanicsenergyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsenergyVector::add(self : PhysicsmechanicsenergyVector, other : PhysicsmechanicsenergyVector) -> PhysicsmechanicsenergyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsenergyVector::sub(self : PhysicsmechanicsenergyVector, other : PhysicsmechanicsenergyVector) -> PhysicsmechanicsenergyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsenergyVector::scale(self : PhysicsmechanicsenergyVector, s : Double) -> PhysicsmechanicsenergyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsenergyVector::dot(self : PhysicsmechanicsenergyVector, other : PhysicsmechanicsenergyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsenergyVector::norm(self : PhysicsmechanicsenergyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsenergyVector::normalize(self : PhysicsmechanicsenergyVector) -> PhysicsmechanicsenergyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsenergyVector::dist(self : PhysicsmechanicsenergyVector, other : PhysicsmechanicsenergyVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsenergyVector::to_string(self : PhysicsmechanicsenergyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_energy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_energy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_energy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_energy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_energy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_energy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_energy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_energy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_energy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_energy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_energy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_energy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_energy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_energy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_energy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_energy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_energy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_energy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_energy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_energy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_energy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_energy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_energy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_energy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_energy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_energy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_energy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_energy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_energy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsenergyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_frame_make(size : Int) -> PhysicsmechanicsenergyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_frame_len(s : PhysicsmechanicsenergyFrame) -> Int { s.size }

pub fn physics_mechanics_energy_frame_get(s : PhysicsmechanicsenergyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_frame_set(s : PhysicsmechanicsenergyFrame, i : Int, v : Double) -> PhysicsmechanicsenergyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_frame_sum(s : PhysicsmechanicsenergyFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_frame_mean(s : PhysicsmechanicsenergyFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_frame_scale(s : PhysicsmechanicsenergyFrame, f : Double) -> PhysicsmechanicsenergyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_frame_add(a : PhysicsmechanicsenergyFrame, b : PhysicsmechanicsenergyFrame) -> PhysicsmechanicsenergyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_frame_copy(s : PhysicsmechanicsenergyFrame) -> PhysicsmechanicsenergyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_frame_fill(s : PhysicsmechanicsenergyFrame, v : Double) -> PhysicsmechanicsenergyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_frame_min(s : PhysicsmechanicsenergyFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_frame_max(s : PhysicsmechanicsenergyFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_frame_to_string(s : PhysicsmechanicsenergyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_table_make(size : Int) -> PhysicsmechanicsenergyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_table_len(s : PhysicsmechanicsenergyTable) -> Int { s.size }

pub fn physics_mechanics_energy_table_get(s : PhysicsmechanicsenergyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_table_set(s : PhysicsmechanicsenergyTable, i : Int, v : Double) -> PhysicsmechanicsenergyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_table_sum(s : PhysicsmechanicsenergyTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_table_mean(s : PhysicsmechanicsenergyTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_table_scale(s : PhysicsmechanicsenergyTable, f : Double) -> PhysicsmechanicsenergyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_table_add(a : PhysicsmechanicsenergyTable, b : PhysicsmechanicsenergyTable) -> PhysicsmechanicsenergyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_table_copy(s : PhysicsmechanicsenergyTable) -> PhysicsmechanicsenergyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_table_fill(s : PhysicsmechanicsenergyTable, v : Double) -> PhysicsmechanicsenergyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_table_min(s : PhysicsmechanicsenergyTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_table_max(s : PhysicsmechanicsenergyTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_table_to_string(s : PhysicsmechanicsenergyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_graphn_make(size : Int) -> PhysicsmechanicsenergyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_graphn_len(s : PhysicsmechanicsenergyGraphN) -> Int { s.size }

pub fn physics_mechanics_energy_graphn_get(s : PhysicsmechanicsenergyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_graphn_set(s : PhysicsmechanicsenergyGraphN, i : Int, v : Double) -> PhysicsmechanicsenergyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_graphn_sum(s : PhysicsmechanicsenergyGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_graphn_mean(s : PhysicsmechanicsenergyGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_graphn_scale(s : PhysicsmechanicsenergyGraphN, f : Double) -> PhysicsmechanicsenergyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_graphn_add(a : PhysicsmechanicsenergyGraphN, b : PhysicsmechanicsenergyGraphN) -> PhysicsmechanicsenergyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_graphn_copy(s : PhysicsmechanicsenergyGraphN) -> PhysicsmechanicsenergyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_graphn_fill(s : PhysicsmechanicsenergyGraphN, v : Double) -> PhysicsmechanicsenergyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_graphn_min(s : PhysicsmechanicsenergyGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_graphn_max(s : PhysicsmechanicsenergyGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_graphn_to_string(s : PhysicsmechanicsenergyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_node_make(size : Int) -> PhysicsmechanicsenergyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_node_len(s : PhysicsmechanicsenergyNode) -> Int { s.size }

pub fn physics_mechanics_energy_node_get(s : PhysicsmechanicsenergyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_node_set(s : PhysicsmechanicsenergyNode, i : Int, v : Double) -> PhysicsmechanicsenergyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_node_sum(s : PhysicsmechanicsenergyNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_node_mean(s : PhysicsmechanicsenergyNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_node_scale(s : PhysicsmechanicsenergyNode, f : Double) -> PhysicsmechanicsenergyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_node_add(a : PhysicsmechanicsenergyNode, b : PhysicsmechanicsenergyNode) -> PhysicsmechanicsenergyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_node_copy(s : PhysicsmechanicsenergyNode) -> PhysicsmechanicsenergyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_node_fill(s : PhysicsmechanicsenergyNode, v : Double) -> PhysicsmechanicsenergyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_node_min(s : PhysicsmechanicsenergyNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_node_max(s : PhysicsmechanicsenergyNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_node_to_string(s : PhysicsmechanicsenergyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_edge_make(size : Int) -> PhysicsmechanicsenergyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_edge_len(s : PhysicsmechanicsenergyEdge) -> Int { s.size }

pub fn physics_mechanics_energy_edge_get(s : PhysicsmechanicsenergyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_edge_set(s : PhysicsmechanicsenergyEdge, i : Int, v : Double) -> PhysicsmechanicsenergyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_edge_sum(s : PhysicsmechanicsenergyEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_edge_mean(s : PhysicsmechanicsenergyEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_edge_scale(s : PhysicsmechanicsenergyEdge, f : Double) -> PhysicsmechanicsenergyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_edge_add(a : PhysicsmechanicsenergyEdge, b : PhysicsmechanicsenergyEdge) -> PhysicsmechanicsenergyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_edge_copy(s : PhysicsmechanicsenergyEdge) -> PhysicsmechanicsenergyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_edge_fill(s : PhysicsmechanicsenergyEdge, v : Double) -> PhysicsmechanicsenergyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_edge_min(s : PhysicsmechanicsenergyEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_edge_max(s : PhysicsmechanicsenergyEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_edge_to_string(s : PhysicsmechanicsenergyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_path_make(size : Int) -> PhysicsmechanicsenergyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_path_len(s : PhysicsmechanicsenergyPath) -> Int { s.size }

pub fn physics_mechanics_energy_path_get(s : PhysicsmechanicsenergyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_path_set(s : PhysicsmechanicsenergyPath, i : Int, v : Double) -> PhysicsmechanicsenergyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_path_sum(s : PhysicsmechanicsenergyPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_path_mean(s : PhysicsmechanicsenergyPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_path_scale(s : PhysicsmechanicsenergyPath, f : Double) -> PhysicsmechanicsenergyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_path_add(a : PhysicsmechanicsenergyPath, b : PhysicsmechanicsenergyPath) -> PhysicsmechanicsenergyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_path_copy(s : PhysicsmechanicsenergyPath) -> PhysicsmechanicsenergyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_path_fill(s : PhysicsmechanicsenergyPath, v : Double) -> PhysicsmechanicsenergyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_path_min(s : PhysicsmechanicsenergyPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_path_max(s : PhysicsmechanicsenergyPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_path_to_string(s : PhysicsmechanicsenergyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_cluster_make(size : Int) -> PhysicsmechanicsenergyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_cluster_len(s : PhysicsmechanicsenergyCluster) -> Int { s.size }

pub fn physics_mechanics_energy_cluster_get(s : PhysicsmechanicsenergyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_cluster_set(s : PhysicsmechanicsenergyCluster, i : Int, v : Double) -> PhysicsmechanicsenergyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cluster_sum(s : PhysicsmechanicsenergyCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_cluster_mean(s : PhysicsmechanicsenergyCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_cluster_scale(s : PhysicsmechanicsenergyCluster, f : Double) -> PhysicsmechanicsenergyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cluster_add(a : PhysicsmechanicsenergyCluster, b : PhysicsmechanicsenergyCluster) -> PhysicsmechanicsenergyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_cluster_copy(s : PhysicsmechanicsenergyCluster) -> PhysicsmechanicsenergyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cluster_fill(s : PhysicsmechanicsenergyCluster, v : Double) -> PhysicsmechanicsenergyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cluster_min(s : PhysicsmechanicsenergyCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_cluster_max(s : PhysicsmechanicsenergyCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_cluster_to_string(s : PhysicsmechanicsenergyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_model_make(size : Int) -> PhysicsmechanicsenergyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_model_len(s : PhysicsmechanicsenergyModel) -> Int { s.size }

pub fn physics_mechanics_energy_model_get(s : PhysicsmechanicsenergyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_model_set(s : PhysicsmechanicsenergyModel, i : Int, v : Double) -> PhysicsmechanicsenergyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_model_sum(s : PhysicsmechanicsenergyModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_model_mean(s : PhysicsmechanicsenergyModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_model_scale(s : PhysicsmechanicsenergyModel, f : Double) -> PhysicsmechanicsenergyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_model_add(a : PhysicsmechanicsenergyModel, b : PhysicsmechanicsenergyModel) -> PhysicsmechanicsenergyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_model_copy(s : PhysicsmechanicsenergyModel) -> PhysicsmechanicsenergyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_model_fill(s : PhysicsmechanicsenergyModel, v : Double) -> PhysicsmechanicsenergyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_model_min(s : PhysicsmechanicsenergyModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_model_max(s : PhysicsmechanicsenergyModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_model_to_string(s : PhysicsmechanicsenergyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_layer_make(size : Int) -> PhysicsmechanicsenergyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_layer_len(s : PhysicsmechanicsenergyLayer) -> Int { s.size }

pub fn physics_mechanics_energy_layer_get(s : PhysicsmechanicsenergyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_layer_set(s : PhysicsmechanicsenergyLayer, i : Int, v : Double) -> PhysicsmechanicsenergyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_layer_sum(s : PhysicsmechanicsenergyLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_layer_mean(s : PhysicsmechanicsenergyLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_layer_scale(s : PhysicsmechanicsenergyLayer, f : Double) -> PhysicsmechanicsenergyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_layer_add(a : PhysicsmechanicsenergyLayer, b : PhysicsmechanicsenergyLayer) -> PhysicsmechanicsenergyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_layer_copy(s : PhysicsmechanicsenergyLayer) -> PhysicsmechanicsenergyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_layer_fill(s : PhysicsmechanicsenergyLayer, v : Double) -> PhysicsmechanicsenergyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_layer_min(s : PhysicsmechanicsenergyLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_layer_max(s : PhysicsmechanicsenergyLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_layer_to_string(s : PhysicsmechanicsenergyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_buffer_make(size : Int) -> PhysicsmechanicsenergyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_buffer_len(s : PhysicsmechanicsenergyBuffer) -> Int { s.size }

pub fn physics_mechanics_energy_buffer_get(s : PhysicsmechanicsenergyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_buffer_set(s : PhysicsmechanicsenergyBuffer, i : Int, v : Double) -> PhysicsmechanicsenergyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_buffer_sum(s : PhysicsmechanicsenergyBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_buffer_mean(s : PhysicsmechanicsenergyBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_buffer_scale(s : PhysicsmechanicsenergyBuffer, f : Double) -> PhysicsmechanicsenergyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_buffer_add(a : PhysicsmechanicsenergyBuffer, b : PhysicsmechanicsenergyBuffer) -> PhysicsmechanicsenergyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_buffer_copy(s : PhysicsmechanicsenergyBuffer) -> PhysicsmechanicsenergyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_buffer_fill(s : PhysicsmechanicsenergyBuffer, v : Double) -> PhysicsmechanicsenergyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_buffer_min(s : PhysicsmechanicsenergyBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_buffer_max(s : PhysicsmechanicsenergyBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_buffer_to_string(s : PhysicsmechanicsenergyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_cursor_make(size : Int) -> PhysicsmechanicsenergyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_cursor_len(s : PhysicsmechanicsenergyCursor) -> Int { s.size }

pub fn physics_mechanics_energy_cursor_get(s : PhysicsmechanicsenergyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_cursor_set(s : PhysicsmechanicsenergyCursor, i : Int, v : Double) -> PhysicsmechanicsenergyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cursor_sum(s : PhysicsmechanicsenergyCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_cursor_mean(s : PhysicsmechanicsenergyCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_cursor_scale(s : PhysicsmechanicsenergyCursor, f : Double) -> PhysicsmechanicsenergyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cursor_add(a : PhysicsmechanicsenergyCursor, b : PhysicsmechanicsenergyCursor) -> PhysicsmechanicsenergyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_cursor_copy(s : PhysicsmechanicsenergyCursor) -> PhysicsmechanicsenergyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cursor_fill(s : PhysicsmechanicsenergyCursor, v : Double) -> PhysicsmechanicsenergyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_cursor_min(s : PhysicsmechanicsenergyCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_cursor_max(s : PhysicsmechanicsenergyCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_cursor_to_string(s : PhysicsmechanicsenergyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_view_make(size : Int) -> PhysicsmechanicsenergyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_view_len(s : PhysicsmechanicsenergyView) -> Int { s.size }

pub fn physics_mechanics_energy_view_get(s : PhysicsmechanicsenergyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_view_set(s : PhysicsmechanicsenergyView, i : Int, v : Double) -> PhysicsmechanicsenergyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_view_sum(s : PhysicsmechanicsenergyView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_view_mean(s : PhysicsmechanicsenergyView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_view_scale(s : PhysicsmechanicsenergyView, f : Double) -> PhysicsmechanicsenergyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_view_add(a : PhysicsmechanicsenergyView, b : PhysicsmechanicsenergyView) -> PhysicsmechanicsenergyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_view_copy(s : PhysicsmechanicsenergyView) -> PhysicsmechanicsenergyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_view_fill(s : PhysicsmechanicsenergyView, v : Double) -> PhysicsmechanicsenergyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_view_min(s : PhysicsmechanicsenergyView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_view_max(s : PhysicsmechanicsenergyView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_view_to_string(s : PhysicsmechanicsenergyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_range_make(size : Int) -> PhysicsmechanicsenergyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_range_len(s : PhysicsmechanicsenergyRange) -> Int { s.size }

pub fn physics_mechanics_energy_range_get(s : PhysicsmechanicsenergyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_range_set(s : PhysicsmechanicsenergyRange, i : Int, v : Double) -> PhysicsmechanicsenergyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_range_sum(s : PhysicsmechanicsenergyRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_range_mean(s : PhysicsmechanicsenergyRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_range_scale(s : PhysicsmechanicsenergyRange, f : Double) -> PhysicsmechanicsenergyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_range_add(a : PhysicsmechanicsenergyRange, b : PhysicsmechanicsenergyRange) -> PhysicsmechanicsenergyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_range_copy(s : PhysicsmechanicsenergyRange) -> PhysicsmechanicsenergyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_range_fill(s : PhysicsmechanicsenergyRange, v : Double) -> PhysicsmechanicsenergyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_range_min(s : PhysicsmechanicsenergyRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_range_max(s : PhysicsmechanicsenergyRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_range_to_string(s : PhysicsmechanicsenergyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_slice_make(size : Int) -> PhysicsmechanicsenergySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_slice_len(s : PhysicsmechanicsenergySlice) -> Int { s.size }

pub fn physics_mechanics_energy_slice_get(s : PhysicsmechanicsenergySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_slice_set(s : PhysicsmechanicsenergySlice, i : Int, v : Double) -> PhysicsmechanicsenergySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_slice_sum(s : PhysicsmechanicsenergySlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_energy_slice_mean(s : PhysicsmechanicsenergySlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_energy_slice_scale(s : PhysicsmechanicsenergySlice, f : Double) -> PhysicsmechanicsenergySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_slice_add(a : PhysicsmechanicsenergySlice, b : PhysicsmechanicsenergySlice) -> PhysicsmechanicsenergySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_energy_slice_copy(s : PhysicsmechanicsenergySlice) -> PhysicsmechanicsenergySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_slice_fill(s : PhysicsmechanicsenergySlice, v : Double) -> PhysicsmechanicsenergySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_energy_slice_min(s : PhysicsmechanicsenergySlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_energy_slice_max(s : PhysicsmechanicsenergySlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_energy_slice_to_string(s : PhysicsmechanicsenergySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

