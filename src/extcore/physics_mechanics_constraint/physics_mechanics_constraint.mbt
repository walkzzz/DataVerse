///===
/// extcore/physics_mechanics_constraint

pub(all) struct PhysicsmechanicsconstraintPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_constraint_make_point(x : Double, y : Double) -> PhysicsmechanicsconstraintPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_constraint_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsconstraintPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsconstraintPoint::x(self : PhysicsmechanicsconstraintPoint) -> Double { self.x }

pub fn PhysicsmechanicsconstraintPoint::y(self : PhysicsmechanicsconstraintPoint) -> Double { self.y }

pub fn PhysicsmechanicsconstraintPoint::z(self : PhysicsmechanicsconstraintPoint) -> Double { self.z }

pub fn PhysicsmechanicsconstraintPoint::label(self : PhysicsmechanicsconstraintPoint) -> Int { self.label }

pub fn PhysicsmechanicsconstraintPoint::dist(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsconstraintPoint::add(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsconstraintPoint::sub(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsconstraintPoint::scale(self : PhysicsmechanicsconstraintPoint, s : Double) -> PhysicsmechanicsconstraintPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsconstraintPoint::dot(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsconstraintPoint::cross(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsconstraintPoint::norm(self : PhysicsmechanicsconstraintPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsconstraintPoint::normalize(self : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsconstraintPoint::negate(self : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsconstraintPoint::mid(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsconstraintPoint::lerp(self : PhysicsmechanicsconstraintPoint, other : PhysicsmechanicsconstraintPoint, t : Double) -> PhysicsmechanicsconstraintPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsconstraintPoint::to_string(self : PhysicsmechanicsconstraintPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_constraint_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsconstraintSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsconstraintSeries::len(self : PhysicsmechanicsconstraintSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsconstraintSeries::sum(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::mean(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::min(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::max(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::range(self : PhysicsmechanicsconstraintSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsconstraintSeries::variance(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::std(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::median(self : PhysicsmechanicsconstraintSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsconstraintSeries::scale(self : PhysicsmechanicsconstraintSeries, f : Double) -> PhysicsmechanicsconstraintSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsconstraintSeries::add(self : PhysicsmechanicsconstraintSeries, other : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsconstraintSeries::sub(self : PhysicsmechanicsconstraintSeries, other : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsconstraintSeries::normalize(self : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsconstraintSeries::cumsum(self : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsconstraintSeries::to_string(self : PhysicsmechanicsconstraintSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsconstraintMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_constraint_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsconstraintMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_constraint_matrix_identity(n : Int) -> PhysicsmechanicsconstraintMatrix {
  let m = physics_mechanics_constraint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsconstraintMatrix::get(self : PhysicsmechanicsconstraintMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsconstraintMatrix::transpose(self : PhysicsmechanicsconstraintMatrix) -> PhysicsmechanicsconstraintMatrix {
  let result = physics_mechanics_constraint_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsconstraintMatrix::add(self : PhysicsmechanicsconstraintMatrix, other : PhysicsmechanicsconstraintMatrix) -> PhysicsmechanicsconstraintMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_constraint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsconstraintMatrix::scale(self : PhysicsmechanicsconstraintMatrix, s : Double) -> PhysicsmechanicsconstraintMatrix {
  let result = physics_mechanics_constraint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsconstraintMatrix::multiply(self : PhysicsmechanicsconstraintMatrix, other : PhysicsmechanicsconstraintMatrix) -> PhysicsmechanicsconstraintMatrix {
  if self.cols != other.rows { return physics_mechanics_constraint_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_constraint_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsconstraintMatrix::trace(self : PhysicsmechanicsconstraintMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsconstraintMatrix::det(self : PhysicsmechanicsconstraintMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsconstraintMatrix::norm(self : PhysicsmechanicsconstraintMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsconstraintMatrix::to_string(self : PhysicsmechanicsconstraintMatrix) -> String {
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

pub(all) struct PhysicsmechanicsconstraintVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_constraint_make_vector(comps : Array[Double]) -> PhysicsmechanicsconstraintVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_constraint_vector_zero(dim : Int) -> PhysicsmechanicsconstraintVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsconstraintVector::add(self : PhysicsmechanicsconstraintVector, other : PhysicsmechanicsconstraintVector) -> PhysicsmechanicsconstraintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsconstraintVector::sub(self : PhysicsmechanicsconstraintVector, other : PhysicsmechanicsconstraintVector) -> PhysicsmechanicsconstraintVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsconstraintVector::scale(self : PhysicsmechanicsconstraintVector, s : Double) -> PhysicsmechanicsconstraintVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsconstraintVector::dot(self : PhysicsmechanicsconstraintVector, other : PhysicsmechanicsconstraintVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsconstraintVector::norm(self : PhysicsmechanicsconstraintVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsconstraintVector::normalize(self : PhysicsmechanicsconstraintVector) -> PhysicsmechanicsconstraintVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsconstraintVector::dist(self : PhysicsmechanicsconstraintVector, other : PhysicsmechanicsconstraintVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsconstraintVector::to_string(self : PhysicsmechanicsconstraintVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_constraint_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_constraint_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_constraint_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_constraint_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_constraint_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_constraint_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_constraint_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_constraint_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_constraint_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_constraint_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_constraint_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_constraint_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_constraint_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_constraint_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_constraint_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_constraint_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_constraint_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_constraint_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_constraint_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_constraint_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_constraint_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_constraint_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_constraint_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_constraint_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_constraint_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_constraint_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_constraint_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_constraint_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_constraint_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsconstraintFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_frame_make(size : Int) -> PhysicsmechanicsconstraintFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_frame_len(s : PhysicsmechanicsconstraintFrame) -> Int { s.size }

pub fn physics_mechanics_constraint_frame_get(s : PhysicsmechanicsconstraintFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_frame_set(s : PhysicsmechanicsconstraintFrame, i : Int, v : Double) -> PhysicsmechanicsconstraintFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_sum(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_frame_mean(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_frame_scale(s : PhysicsmechanicsconstraintFrame, f : Double) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_add(a : PhysicsmechanicsconstraintFrame, b : PhysicsmechanicsconstraintFrame) -> PhysicsmechanicsconstraintFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_frame_copy(s : PhysicsmechanicsconstraintFrame) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_fill(s : PhysicsmechanicsconstraintFrame, v : Double) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_min(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_frame_max(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_frame_to_string(s : PhysicsmechanicsconstraintFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_table_make(size : Int) -> PhysicsmechanicsconstraintTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_table_len(s : PhysicsmechanicsconstraintTable) -> Int { s.size }

pub fn physics_mechanics_constraint_table_get(s : PhysicsmechanicsconstraintTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_table_set(s : PhysicsmechanicsconstraintTable, i : Int, v : Double) -> PhysicsmechanicsconstraintTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_sum(s : PhysicsmechanicsconstraintTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_table_mean(s : PhysicsmechanicsconstraintTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_table_scale(s : PhysicsmechanicsconstraintTable, f : Double) -> PhysicsmechanicsconstraintTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_add(a : PhysicsmechanicsconstraintTable, b : PhysicsmechanicsconstraintTable) -> PhysicsmechanicsconstraintTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_table_copy(s : PhysicsmechanicsconstraintTable) -> PhysicsmechanicsconstraintTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_fill(s : PhysicsmechanicsconstraintTable, v : Double) -> PhysicsmechanicsconstraintTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_min(s : PhysicsmechanicsconstraintTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_table_max(s : PhysicsmechanicsconstraintTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_table_to_string(s : PhysicsmechanicsconstraintTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_graphn_make(size : Int) -> PhysicsmechanicsconstraintGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_graphn_len(s : PhysicsmechanicsconstraintGraphN) -> Int { s.size }

pub fn physics_mechanics_constraint_graphn_get(s : PhysicsmechanicsconstraintGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_graphn_set(s : PhysicsmechanicsconstraintGraphN, i : Int, v : Double) -> PhysicsmechanicsconstraintGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_sum(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_graphn_mean(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_graphn_scale(s : PhysicsmechanicsconstraintGraphN, f : Double) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_add(a : PhysicsmechanicsconstraintGraphN, b : PhysicsmechanicsconstraintGraphN) -> PhysicsmechanicsconstraintGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_graphn_copy(s : PhysicsmechanicsconstraintGraphN) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_fill(s : PhysicsmechanicsconstraintGraphN, v : Double) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_min(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_graphn_max(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_graphn_to_string(s : PhysicsmechanicsconstraintGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_node_make(size : Int) -> PhysicsmechanicsconstraintNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_node_len(s : PhysicsmechanicsconstraintNode) -> Int { s.size }

pub fn physics_mechanics_constraint_node_get(s : PhysicsmechanicsconstraintNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_node_set(s : PhysicsmechanicsconstraintNode, i : Int, v : Double) -> PhysicsmechanicsconstraintNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_sum(s : PhysicsmechanicsconstraintNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_node_mean(s : PhysicsmechanicsconstraintNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_node_scale(s : PhysicsmechanicsconstraintNode, f : Double) -> PhysicsmechanicsconstraintNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_add(a : PhysicsmechanicsconstraintNode, b : PhysicsmechanicsconstraintNode) -> PhysicsmechanicsconstraintNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_node_copy(s : PhysicsmechanicsconstraintNode) -> PhysicsmechanicsconstraintNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_fill(s : PhysicsmechanicsconstraintNode, v : Double) -> PhysicsmechanicsconstraintNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_min(s : PhysicsmechanicsconstraintNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_node_max(s : PhysicsmechanicsconstraintNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_node_to_string(s : PhysicsmechanicsconstraintNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_edge_make(size : Int) -> PhysicsmechanicsconstraintEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_edge_len(s : PhysicsmechanicsconstraintEdge) -> Int { s.size }

pub fn physics_mechanics_constraint_edge_get(s : PhysicsmechanicsconstraintEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_edge_set(s : PhysicsmechanicsconstraintEdge, i : Int, v : Double) -> PhysicsmechanicsconstraintEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_sum(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_edge_mean(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_edge_scale(s : PhysicsmechanicsconstraintEdge, f : Double) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_add(a : PhysicsmechanicsconstraintEdge, b : PhysicsmechanicsconstraintEdge) -> PhysicsmechanicsconstraintEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_edge_copy(s : PhysicsmechanicsconstraintEdge) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_fill(s : PhysicsmechanicsconstraintEdge, v : Double) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_min(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_edge_max(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_edge_to_string(s : PhysicsmechanicsconstraintEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_path_make(size : Int) -> PhysicsmechanicsconstraintPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_path_len(s : PhysicsmechanicsconstraintPath) -> Int { s.size }

pub fn physics_mechanics_constraint_path_get(s : PhysicsmechanicsconstraintPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_path_set(s : PhysicsmechanicsconstraintPath, i : Int, v : Double) -> PhysicsmechanicsconstraintPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_sum(s : PhysicsmechanicsconstraintPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_path_mean(s : PhysicsmechanicsconstraintPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_path_scale(s : PhysicsmechanicsconstraintPath, f : Double) -> PhysicsmechanicsconstraintPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_add(a : PhysicsmechanicsconstraintPath, b : PhysicsmechanicsconstraintPath) -> PhysicsmechanicsconstraintPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_path_copy(s : PhysicsmechanicsconstraintPath) -> PhysicsmechanicsconstraintPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_fill(s : PhysicsmechanicsconstraintPath, v : Double) -> PhysicsmechanicsconstraintPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_min(s : PhysicsmechanicsconstraintPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_path_max(s : PhysicsmechanicsconstraintPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_path_to_string(s : PhysicsmechanicsconstraintPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_cluster_make(size : Int) -> PhysicsmechanicsconstraintCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_cluster_len(s : PhysicsmechanicsconstraintCluster) -> Int { s.size }

pub fn physics_mechanics_constraint_cluster_get(s : PhysicsmechanicsconstraintCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_cluster_set(s : PhysicsmechanicsconstraintCluster, i : Int, v : Double) -> PhysicsmechanicsconstraintCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_sum(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_cluster_mean(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_cluster_scale(s : PhysicsmechanicsconstraintCluster, f : Double) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_add(a : PhysicsmechanicsconstraintCluster, b : PhysicsmechanicsconstraintCluster) -> PhysicsmechanicsconstraintCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_cluster_copy(s : PhysicsmechanicsconstraintCluster) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_fill(s : PhysicsmechanicsconstraintCluster, v : Double) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_min(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_cluster_max(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_cluster_to_string(s : PhysicsmechanicsconstraintCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_model_make(size : Int) -> PhysicsmechanicsconstraintModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_model_len(s : PhysicsmechanicsconstraintModel) -> Int { s.size }

pub fn physics_mechanics_constraint_model_get(s : PhysicsmechanicsconstraintModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_model_set(s : PhysicsmechanicsconstraintModel, i : Int, v : Double) -> PhysicsmechanicsconstraintModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_sum(s : PhysicsmechanicsconstraintModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_model_mean(s : PhysicsmechanicsconstraintModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_model_scale(s : PhysicsmechanicsconstraintModel, f : Double) -> PhysicsmechanicsconstraintModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_add(a : PhysicsmechanicsconstraintModel, b : PhysicsmechanicsconstraintModel) -> PhysicsmechanicsconstraintModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_model_copy(s : PhysicsmechanicsconstraintModel) -> PhysicsmechanicsconstraintModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_fill(s : PhysicsmechanicsconstraintModel, v : Double) -> PhysicsmechanicsconstraintModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_min(s : PhysicsmechanicsconstraintModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_model_max(s : PhysicsmechanicsconstraintModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_model_to_string(s : PhysicsmechanicsconstraintModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_layer_make(size : Int) -> PhysicsmechanicsconstraintLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_layer_len(s : PhysicsmechanicsconstraintLayer) -> Int { s.size }

pub fn physics_mechanics_constraint_layer_get(s : PhysicsmechanicsconstraintLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_layer_set(s : PhysicsmechanicsconstraintLayer, i : Int, v : Double) -> PhysicsmechanicsconstraintLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_sum(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_layer_mean(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_layer_scale(s : PhysicsmechanicsconstraintLayer, f : Double) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_add(a : PhysicsmechanicsconstraintLayer, b : PhysicsmechanicsconstraintLayer) -> PhysicsmechanicsconstraintLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_layer_copy(s : PhysicsmechanicsconstraintLayer) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_fill(s : PhysicsmechanicsconstraintLayer, v : Double) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_min(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_layer_max(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_layer_to_string(s : PhysicsmechanicsconstraintLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_buffer_make(size : Int) -> PhysicsmechanicsconstraintBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_buffer_len(s : PhysicsmechanicsconstraintBuffer) -> Int { s.size }

pub fn physics_mechanics_constraint_buffer_get(s : PhysicsmechanicsconstraintBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_buffer_set(s : PhysicsmechanicsconstraintBuffer, i : Int, v : Double) -> PhysicsmechanicsconstraintBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_sum(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_buffer_mean(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_buffer_scale(s : PhysicsmechanicsconstraintBuffer, f : Double) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_add(a : PhysicsmechanicsconstraintBuffer, b : PhysicsmechanicsconstraintBuffer) -> PhysicsmechanicsconstraintBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_buffer_copy(s : PhysicsmechanicsconstraintBuffer) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_fill(s : PhysicsmechanicsconstraintBuffer, v : Double) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_min(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_buffer_max(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_buffer_to_string(s : PhysicsmechanicsconstraintBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_cursor_make(size : Int) -> PhysicsmechanicsconstraintCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_cursor_len(s : PhysicsmechanicsconstraintCursor) -> Int { s.size }

pub fn physics_mechanics_constraint_cursor_get(s : PhysicsmechanicsconstraintCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_cursor_set(s : PhysicsmechanicsconstraintCursor, i : Int, v : Double) -> PhysicsmechanicsconstraintCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_sum(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_cursor_mean(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_cursor_scale(s : PhysicsmechanicsconstraintCursor, f : Double) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_add(a : PhysicsmechanicsconstraintCursor, b : PhysicsmechanicsconstraintCursor) -> PhysicsmechanicsconstraintCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_cursor_copy(s : PhysicsmechanicsconstraintCursor) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_fill(s : PhysicsmechanicsconstraintCursor, v : Double) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_min(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_cursor_max(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_cursor_to_string(s : PhysicsmechanicsconstraintCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_view_make(size : Int) -> PhysicsmechanicsconstraintView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_view_len(s : PhysicsmechanicsconstraintView) -> Int { s.size }

pub fn physics_mechanics_constraint_view_get(s : PhysicsmechanicsconstraintView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_view_set(s : PhysicsmechanicsconstraintView, i : Int, v : Double) -> PhysicsmechanicsconstraintView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_sum(s : PhysicsmechanicsconstraintView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_view_mean(s : PhysicsmechanicsconstraintView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_view_scale(s : PhysicsmechanicsconstraintView, f : Double) -> PhysicsmechanicsconstraintView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_add(a : PhysicsmechanicsconstraintView, b : PhysicsmechanicsconstraintView) -> PhysicsmechanicsconstraintView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_view_copy(s : PhysicsmechanicsconstraintView) -> PhysicsmechanicsconstraintView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_fill(s : PhysicsmechanicsconstraintView, v : Double) -> PhysicsmechanicsconstraintView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_min(s : PhysicsmechanicsconstraintView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_view_max(s : PhysicsmechanicsconstraintView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_view_to_string(s : PhysicsmechanicsconstraintView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_range_make(size : Int) -> PhysicsmechanicsconstraintRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_range_len(s : PhysicsmechanicsconstraintRange) -> Int { s.size }

pub fn physics_mechanics_constraint_range_get(s : PhysicsmechanicsconstraintRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_range_set(s : PhysicsmechanicsconstraintRange, i : Int, v : Double) -> PhysicsmechanicsconstraintRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_sum(s : PhysicsmechanicsconstraintRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_range_mean(s : PhysicsmechanicsconstraintRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_range_scale(s : PhysicsmechanicsconstraintRange, f : Double) -> PhysicsmechanicsconstraintRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_add(a : PhysicsmechanicsconstraintRange, b : PhysicsmechanicsconstraintRange) -> PhysicsmechanicsconstraintRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_range_copy(s : PhysicsmechanicsconstraintRange) -> PhysicsmechanicsconstraintRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_fill(s : PhysicsmechanicsconstraintRange, v : Double) -> PhysicsmechanicsconstraintRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_min(s : PhysicsmechanicsconstraintRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_range_max(s : PhysicsmechanicsconstraintRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_range_to_string(s : PhysicsmechanicsconstraintRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_slice_make(size : Int) -> PhysicsmechanicsconstraintSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_slice_len(s : PhysicsmechanicsconstraintSlice) -> Int { s.size }

pub fn physics_mechanics_constraint_slice_get(s : PhysicsmechanicsconstraintSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_slice_set(s : PhysicsmechanicsconstraintSlice, i : Int, v : Double) -> PhysicsmechanicsconstraintSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_sum(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_slice_mean(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_slice_scale(s : PhysicsmechanicsconstraintSlice, f : Double) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_add(a : PhysicsmechanicsconstraintSlice, b : PhysicsmechanicsconstraintSlice) -> PhysicsmechanicsconstraintSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_slice_copy(s : PhysicsmechanicsconstraintSlice) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_fill(s : PhysicsmechanicsconstraintSlice, v : Double) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_min(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_slice_max(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_slice_to_string(s : PhysicsmechanicsconstraintSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

