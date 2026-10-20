///===
/// extcore/physics_mechanics_kinematic

pub(all) struct PhysicsmechanicskinematicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_kinematic_make_point(x : Double, y : Double) -> PhysicsmechanicskinematicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_kinematic_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicskinematicPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicskinematicPoint::x(self : PhysicsmechanicskinematicPoint) -> Double { self.x }

pub fn PhysicsmechanicskinematicPoint::y(self : PhysicsmechanicskinematicPoint) -> Double { self.y }

pub fn PhysicsmechanicskinematicPoint::z(self : PhysicsmechanicskinematicPoint) -> Double { self.z }

pub fn PhysicsmechanicskinematicPoint::label(self : PhysicsmechanicskinematicPoint) -> Int { self.label }

pub fn PhysicsmechanicskinematicPoint::dist(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicskinematicPoint::add(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::sub(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::scale(self : PhysicsmechanicskinematicPoint, s : Double) -> PhysicsmechanicskinematicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::dot(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicskinematicPoint::cross(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicskinematicPoint::norm(self : PhysicsmechanicskinematicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicskinematicPoint::normalize(self : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicskinematicPoint::negate(self : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::mid(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint) -> PhysicsmechanicskinematicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::lerp(self : PhysicsmechanicskinematicPoint, other : PhysicsmechanicskinematicPoint, t : Double) -> PhysicsmechanicskinematicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicskinematicPoint::to_string(self : PhysicsmechanicskinematicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_kinematic_make_series(vals : Array[Double], name : String) -> PhysicsmechanicskinematicSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicskinematicSeries::len(self : PhysicsmechanicskinematicSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicskinematicSeries::sum(self : PhysicsmechanicskinematicSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicskinematicSeries::mean(self : PhysicsmechanicskinematicSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicskinematicSeries::min(self : PhysicsmechanicskinematicSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicskinematicSeries::max(self : PhysicsmechanicskinematicSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicskinematicSeries::range(self : PhysicsmechanicskinematicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicskinematicSeries::variance(self : PhysicsmechanicskinematicSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicskinematicSeries::std(self : PhysicsmechanicskinematicSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicskinematicSeries::median(self : PhysicsmechanicskinematicSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicskinematicSeries::scale(self : PhysicsmechanicskinematicSeries, f : Double) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::add(self : PhysicsmechanicskinematicSeries, other : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::sub(self : PhysicsmechanicskinematicSeries, other : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::normalize(self : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicskinematicSeries::cumsum(self : PhysicsmechanicskinematicSeries) -> PhysicsmechanicskinematicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicskinematicSeries::to_string(self : PhysicsmechanicskinematicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicskinematicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_kinematic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicskinematicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_kinematic_matrix_identity(n : Int) -> PhysicsmechanicskinematicMatrix {
  let m = physics_mechanics_kinematic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicskinematicMatrix::get(self : PhysicsmechanicskinematicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicskinematicMatrix::transpose(self : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  let result = physics_mechanics_kinematic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicskinematicMatrix::add(self : PhysicsmechanicskinematicMatrix, other : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_kinematic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicskinematicMatrix::scale(self : PhysicsmechanicskinematicMatrix, s : Double) -> PhysicsmechanicskinematicMatrix {
  let result = physics_mechanics_kinematic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicskinematicMatrix::multiply(self : PhysicsmechanicskinematicMatrix, other : PhysicsmechanicskinematicMatrix) -> PhysicsmechanicskinematicMatrix {
  if self.cols != other.rows { return physics_mechanics_kinematic_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_kinematic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicskinematicMatrix::trace(self : PhysicsmechanicskinematicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicskinematicMatrix::det(self : PhysicsmechanicskinematicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicskinematicMatrix::norm(self : PhysicsmechanicskinematicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicskinematicMatrix::to_string(self : PhysicsmechanicskinematicMatrix) -> String {
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

pub(all) struct PhysicsmechanicskinematicVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_kinematic_make_vector(comps : Array[Double]) -> PhysicsmechanicskinematicVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_kinematic_vector_zero(dim : Int) -> PhysicsmechanicskinematicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicskinematicVector::add(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicskinematicVector::sub(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicskinematicVector::scale(self : PhysicsmechanicskinematicVector, s : Double) -> PhysicsmechanicskinematicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicskinematicVector::dot(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicskinematicVector::norm(self : PhysicsmechanicskinematicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicskinematicVector::normalize(self : PhysicsmechanicskinematicVector) -> PhysicsmechanicskinematicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicskinematicVector::dist(self : PhysicsmechanicskinematicVector, other : PhysicsmechanicskinematicVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicskinematicVector::to_string(self : PhysicsmechanicskinematicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_kinematic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_kinematic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_kinematic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_kinematic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_kinematic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_kinematic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_kinematic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_kinematic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_kinematic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_kinematic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_kinematic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_kinematic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_kinematic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_kinematic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_kinematic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_kinematic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_kinematic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_kinematic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_kinematic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_kinematic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_kinematic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_kinematic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_kinematic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_kinematic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_kinematic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_kinematic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_kinematic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_kinematic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_kinematic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicskinematicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_frame_make(size : Int) -> PhysicsmechanicskinematicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_frame_len(s : PhysicsmechanicskinematicFrame) -> Int { s.size }

pub fn physics_mechanics_kinematic_frame_get(s : PhysicsmechanicskinematicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_frame_set(s : PhysicsmechanicskinematicFrame, i : Int, v : Double) -> PhysicsmechanicskinematicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_frame_sum(s : PhysicsmechanicskinematicFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_frame_mean(s : PhysicsmechanicskinematicFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_frame_scale(s : PhysicsmechanicskinematicFrame, f : Double) -> PhysicsmechanicskinematicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_frame_add(a : PhysicsmechanicskinematicFrame, b : PhysicsmechanicskinematicFrame) -> PhysicsmechanicskinematicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_frame_copy(s : PhysicsmechanicskinematicFrame) -> PhysicsmechanicskinematicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_frame_fill(s : PhysicsmechanicskinematicFrame, v : Double) -> PhysicsmechanicskinematicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_frame_min(s : PhysicsmechanicskinematicFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_frame_max(s : PhysicsmechanicskinematicFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_frame_to_string(s : PhysicsmechanicskinematicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_table_make(size : Int) -> PhysicsmechanicskinematicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_table_len(s : PhysicsmechanicskinematicTable) -> Int { s.size }

pub fn physics_mechanics_kinematic_table_get(s : PhysicsmechanicskinematicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_table_set(s : PhysicsmechanicskinematicTable, i : Int, v : Double) -> PhysicsmechanicskinematicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_table_sum(s : PhysicsmechanicskinematicTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_table_mean(s : PhysicsmechanicskinematicTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_table_scale(s : PhysicsmechanicskinematicTable, f : Double) -> PhysicsmechanicskinematicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_table_add(a : PhysicsmechanicskinematicTable, b : PhysicsmechanicskinematicTable) -> PhysicsmechanicskinematicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_table_copy(s : PhysicsmechanicskinematicTable) -> PhysicsmechanicskinematicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_table_fill(s : PhysicsmechanicskinematicTable, v : Double) -> PhysicsmechanicskinematicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_table_min(s : PhysicsmechanicskinematicTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_table_max(s : PhysicsmechanicskinematicTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_table_to_string(s : PhysicsmechanicskinematicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_graphn_make(size : Int) -> PhysicsmechanicskinematicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_graphn_len(s : PhysicsmechanicskinematicGraphN) -> Int { s.size }

pub fn physics_mechanics_kinematic_graphn_get(s : PhysicsmechanicskinematicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_graphn_set(s : PhysicsmechanicskinematicGraphN, i : Int, v : Double) -> PhysicsmechanicskinematicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_graphn_sum(s : PhysicsmechanicskinematicGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_graphn_mean(s : PhysicsmechanicskinematicGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_graphn_scale(s : PhysicsmechanicskinematicGraphN, f : Double) -> PhysicsmechanicskinematicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_graphn_add(a : PhysicsmechanicskinematicGraphN, b : PhysicsmechanicskinematicGraphN) -> PhysicsmechanicskinematicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_graphn_copy(s : PhysicsmechanicskinematicGraphN) -> PhysicsmechanicskinematicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_graphn_fill(s : PhysicsmechanicskinematicGraphN, v : Double) -> PhysicsmechanicskinematicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_graphn_min(s : PhysicsmechanicskinematicGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_graphn_max(s : PhysicsmechanicskinematicGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_graphn_to_string(s : PhysicsmechanicskinematicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_node_make(size : Int) -> PhysicsmechanicskinematicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_node_len(s : PhysicsmechanicskinematicNode) -> Int { s.size }

pub fn physics_mechanics_kinematic_node_get(s : PhysicsmechanicskinematicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_node_set(s : PhysicsmechanicskinematicNode, i : Int, v : Double) -> PhysicsmechanicskinematicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_node_sum(s : PhysicsmechanicskinematicNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_node_mean(s : PhysicsmechanicskinematicNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_node_scale(s : PhysicsmechanicskinematicNode, f : Double) -> PhysicsmechanicskinematicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_node_add(a : PhysicsmechanicskinematicNode, b : PhysicsmechanicskinematicNode) -> PhysicsmechanicskinematicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_node_copy(s : PhysicsmechanicskinematicNode) -> PhysicsmechanicskinematicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_node_fill(s : PhysicsmechanicskinematicNode, v : Double) -> PhysicsmechanicskinematicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_node_min(s : PhysicsmechanicskinematicNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_node_max(s : PhysicsmechanicskinematicNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_node_to_string(s : PhysicsmechanicskinematicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_edge_make(size : Int) -> PhysicsmechanicskinematicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_edge_len(s : PhysicsmechanicskinematicEdge) -> Int { s.size }

pub fn physics_mechanics_kinematic_edge_get(s : PhysicsmechanicskinematicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_edge_set(s : PhysicsmechanicskinematicEdge, i : Int, v : Double) -> PhysicsmechanicskinematicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_edge_sum(s : PhysicsmechanicskinematicEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_edge_mean(s : PhysicsmechanicskinematicEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_edge_scale(s : PhysicsmechanicskinematicEdge, f : Double) -> PhysicsmechanicskinematicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_edge_add(a : PhysicsmechanicskinematicEdge, b : PhysicsmechanicskinematicEdge) -> PhysicsmechanicskinematicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_edge_copy(s : PhysicsmechanicskinematicEdge) -> PhysicsmechanicskinematicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_edge_fill(s : PhysicsmechanicskinematicEdge, v : Double) -> PhysicsmechanicskinematicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_edge_min(s : PhysicsmechanicskinematicEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_edge_max(s : PhysicsmechanicskinematicEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_edge_to_string(s : PhysicsmechanicskinematicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_path_make(size : Int) -> PhysicsmechanicskinematicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_path_len(s : PhysicsmechanicskinematicPath) -> Int { s.size }

pub fn physics_mechanics_kinematic_path_get(s : PhysicsmechanicskinematicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_path_set(s : PhysicsmechanicskinematicPath, i : Int, v : Double) -> PhysicsmechanicskinematicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_path_sum(s : PhysicsmechanicskinematicPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_path_mean(s : PhysicsmechanicskinematicPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_path_scale(s : PhysicsmechanicskinematicPath, f : Double) -> PhysicsmechanicskinematicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_path_add(a : PhysicsmechanicskinematicPath, b : PhysicsmechanicskinematicPath) -> PhysicsmechanicskinematicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_path_copy(s : PhysicsmechanicskinematicPath) -> PhysicsmechanicskinematicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_path_fill(s : PhysicsmechanicskinematicPath, v : Double) -> PhysicsmechanicskinematicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_path_min(s : PhysicsmechanicskinematicPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_path_max(s : PhysicsmechanicskinematicPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_path_to_string(s : PhysicsmechanicskinematicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_cluster_make(size : Int) -> PhysicsmechanicskinematicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_cluster_len(s : PhysicsmechanicskinematicCluster) -> Int { s.size }

pub fn physics_mechanics_kinematic_cluster_get(s : PhysicsmechanicskinematicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_cluster_set(s : PhysicsmechanicskinematicCluster, i : Int, v : Double) -> PhysicsmechanicskinematicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cluster_sum(s : PhysicsmechanicskinematicCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_cluster_mean(s : PhysicsmechanicskinematicCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_cluster_scale(s : PhysicsmechanicskinematicCluster, f : Double) -> PhysicsmechanicskinematicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cluster_add(a : PhysicsmechanicskinematicCluster, b : PhysicsmechanicskinematicCluster) -> PhysicsmechanicskinematicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_cluster_copy(s : PhysicsmechanicskinematicCluster) -> PhysicsmechanicskinematicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cluster_fill(s : PhysicsmechanicskinematicCluster, v : Double) -> PhysicsmechanicskinematicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cluster_min(s : PhysicsmechanicskinematicCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_cluster_max(s : PhysicsmechanicskinematicCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_cluster_to_string(s : PhysicsmechanicskinematicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_model_make(size : Int) -> PhysicsmechanicskinematicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_model_len(s : PhysicsmechanicskinematicModel) -> Int { s.size }

pub fn physics_mechanics_kinematic_model_get(s : PhysicsmechanicskinematicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_model_set(s : PhysicsmechanicskinematicModel, i : Int, v : Double) -> PhysicsmechanicskinematicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_model_sum(s : PhysicsmechanicskinematicModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_model_mean(s : PhysicsmechanicskinematicModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_model_scale(s : PhysicsmechanicskinematicModel, f : Double) -> PhysicsmechanicskinematicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_model_add(a : PhysicsmechanicskinematicModel, b : PhysicsmechanicskinematicModel) -> PhysicsmechanicskinematicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_model_copy(s : PhysicsmechanicskinematicModel) -> PhysicsmechanicskinematicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_model_fill(s : PhysicsmechanicskinematicModel, v : Double) -> PhysicsmechanicskinematicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_model_min(s : PhysicsmechanicskinematicModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_model_max(s : PhysicsmechanicskinematicModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_model_to_string(s : PhysicsmechanicskinematicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_layer_make(size : Int) -> PhysicsmechanicskinematicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_layer_len(s : PhysicsmechanicskinematicLayer) -> Int { s.size }

pub fn physics_mechanics_kinematic_layer_get(s : PhysicsmechanicskinematicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_layer_set(s : PhysicsmechanicskinematicLayer, i : Int, v : Double) -> PhysicsmechanicskinematicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_layer_sum(s : PhysicsmechanicskinematicLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_layer_mean(s : PhysicsmechanicskinematicLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_layer_scale(s : PhysicsmechanicskinematicLayer, f : Double) -> PhysicsmechanicskinematicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_layer_add(a : PhysicsmechanicskinematicLayer, b : PhysicsmechanicskinematicLayer) -> PhysicsmechanicskinematicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_layer_copy(s : PhysicsmechanicskinematicLayer) -> PhysicsmechanicskinematicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_layer_fill(s : PhysicsmechanicskinematicLayer, v : Double) -> PhysicsmechanicskinematicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_layer_min(s : PhysicsmechanicskinematicLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_layer_max(s : PhysicsmechanicskinematicLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_layer_to_string(s : PhysicsmechanicskinematicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_buffer_make(size : Int) -> PhysicsmechanicskinematicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_buffer_len(s : PhysicsmechanicskinematicBuffer) -> Int { s.size }

pub fn physics_mechanics_kinematic_buffer_get(s : PhysicsmechanicskinematicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_buffer_set(s : PhysicsmechanicskinematicBuffer, i : Int, v : Double) -> PhysicsmechanicskinematicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_buffer_sum(s : PhysicsmechanicskinematicBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_buffer_mean(s : PhysicsmechanicskinematicBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_buffer_scale(s : PhysicsmechanicskinematicBuffer, f : Double) -> PhysicsmechanicskinematicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_buffer_add(a : PhysicsmechanicskinematicBuffer, b : PhysicsmechanicskinematicBuffer) -> PhysicsmechanicskinematicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_buffer_copy(s : PhysicsmechanicskinematicBuffer) -> PhysicsmechanicskinematicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_buffer_fill(s : PhysicsmechanicskinematicBuffer, v : Double) -> PhysicsmechanicskinematicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_buffer_min(s : PhysicsmechanicskinematicBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_buffer_max(s : PhysicsmechanicskinematicBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_buffer_to_string(s : PhysicsmechanicskinematicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_cursor_make(size : Int) -> PhysicsmechanicskinematicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_cursor_len(s : PhysicsmechanicskinematicCursor) -> Int { s.size }

pub fn physics_mechanics_kinematic_cursor_get(s : PhysicsmechanicskinematicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_cursor_set(s : PhysicsmechanicskinematicCursor, i : Int, v : Double) -> PhysicsmechanicskinematicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cursor_sum(s : PhysicsmechanicskinematicCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_cursor_mean(s : PhysicsmechanicskinematicCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_cursor_scale(s : PhysicsmechanicskinematicCursor, f : Double) -> PhysicsmechanicskinematicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cursor_add(a : PhysicsmechanicskinematicCursor, b : PhysicsmechanicskinematicCursor) -> PhysicsmechanicskinematicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_cursor_copy(s : PhysicsmechanicskinematicCursor) -> PhysicsmechanicskinematicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cursor_fill(s : PhysicsmechanicskinematicCursor, v : Double) -> PhysicsmechanicskinematicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_cursor_min(s : PhysicsmechanicskinematicCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_cursor_max(s : PhysicsmechanicskinematicCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_cursor_to_string(s : PhysicsmechanicskinematicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_view_make(size : Int) -> PhysicsmechanicskinematicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_view_len(s : PhysicsmechanicskinematicView) -> Int { s.size }

pub fn physics_mechanics_kinematic_view_get(s : PhysicsmechanicskinematicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_view_set(s : PhysicsmechanicskinematicView, i : Int, v : Double) -> PhysicsmechanicskinematicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_view_sum(s : PhysicsmechanicskinematicView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_view_mean(s : PhysicsmechanicskinematicView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_view_scale(s : PhysicsmechanicskinematicView, f : Double) -> PhysicsmechanicskinematicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_view_add(a : PhysicsmechanicskinematicView, b : PhysicsmechanicskinematicView) -> PhysicsmechanicskinematicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_view_copy(s : PhysicsmechanicskinematicView) -> PhysicsmechanicskinematicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_view_fill(s : PhysicsmechanicskinematicView, v : Double) -> PhysicsmechanicskinematicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_view_min(s : PhysicsmechanicskinematicView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_view_max(s : PhysicsmechanicskinematicView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_view_to_string(s : PhysicsmechanicskinematicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_range_make(size : Int) -> PhysicsmechanicskinematicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_range_len(s : PhysicsmechanicskinematicRange) -> Int { s.size }

pub fn physics_mechanics_kinematic_range_get(s : PhysicsmechanicskinematicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_range_set(s : PhysicsmechanicskinematicRange, i : Int, v : Double) -> PhysicsmechanicskinematicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_range_sum(s : PhysicsmechanicskinematicRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_range_mean(s : PhysicsmechanicskinematicRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_range_scale(s : PhysicsmechanicskinematicRange, f : Double) -> PhysicsmechanicskinematicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_range_add(a : PhysicsmechanicskinematicRange, b : PhysicsmechanicskinematicRange) -> PhysicsmechanicskinematicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_range_copy(s : PhysicsmechanicskinematicRange) -> PhysicsmechanicskinematicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_range_fill(s : PhysicsmechanicskinematicRange, v : Double) -> PhysicsmechanicskinematicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_range_min(s : PhysicsmechanicskinematicRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_range_max(s : PhysicsmechanicskinematicRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_range_to_string(s : PhysicsmechanicskinematicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicskinematicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_kinematic_slice_make(size : Int) -> PhysicsmechanicskinematicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_kinematic_slice_len(s : PhysicsmechanicskinematicSlice) -> Int { s.size }

pub fn physics_mechanics_kinematic_slice_get(s : PhysicsmechanicskinematicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_kinematic_slice_set(s : PhysicsmechanicskinematicSlice, i : Int, v : Double) -> PhysicsmechanicskinematicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_slice_sum(s : PhysicsmechanicskinematicSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_kinematic_slice_mean(s : PhysicsmechanicskinematicSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_kinematic_slice_scale(s : PhysicsmechanicskinematicSlice, f : Double) -> PhysicsmechanicskinematicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_slice_add(a : PhysicsmechanicskinematicSlice, b : PhysicsmechanicskinematicSlice) -> PhysicsmechanicskinematicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_kinematic_slice_copy(s : PhysicsmechanicskinematicSlice) -> PhysicsmechanicskinematicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_slice_fill(s : PhysicsmechanicskinematicSlice, v : Double) -> PhysicsmechanicskinematicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_kinematic_slice_min(s : PhysicsmechanicskinematicSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_kinematic_slice_max(s : PhysicsmechanicskinematicSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_kinematic_slice_to_string(s : PhysicsmechanicskinematicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

