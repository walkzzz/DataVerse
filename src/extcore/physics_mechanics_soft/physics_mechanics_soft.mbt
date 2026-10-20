///===
/// extcore/physics_mechanics_soft

pub(all) struct PhysicsmechanicssoftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_soft_make_point(x : Double, y : Double) -> PhysicsmechanicssoftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_soft_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicssoftPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicssoftPoint::x(self : PhysicsmechanicssoftPoint) -> Double { self.x }

pub fn PhysicsmechanicssoftPoint::y(self : PhysicsmechanicssoftPoint) -> Double { self.y }

pub fn PhysicsmechanicssoftPoint::z(self : PhysicsmechanicssoftPoint) -> Double { self.z }

pub fn PhysicsmechanicssoftPoint::label(self : PhysicsmechanicssoftPoint) -> Int { self.label }

pub fn PhysicsmechanicssoftPoint::dist(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicssoftPoint::add(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::sub(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::scale(self : PhysicsmechanicssoftPoint, s : Double) -> PhysicsmechanicssoftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::dot(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicssoftPoint::cross(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicssoftPoint::norm(self : PhysicsmechanicssoftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicssoftPoint::normalize(self : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicssoftPoint::negate(self : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::mid(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint) -> PhysicsmechanicssoftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::lerp(self : PhysicsmechanicssoftPoint, other : PhysicsmechanicssoftPoint, t : Double) -> PhysicsmechanicssoftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicssoftPoint::to_string(self : PhysicsmechanicssoftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_soft_make_series(vals : Array[Double], name : String) -> PhysicsmechanicssoftSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicssoftSeries::len(self : PhysicsmechanicssoftSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicssoftSeries::sum(self : PhysicsmechanicssoftSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicssoftSeries::mean(self : PhysicsmechanicssoftSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicssoftSeries::min(self : PhysicsmechanicssoftSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicssoftSeries::max(self : PhysicsmechanicssoftSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicssoftSeries::range(self : PhysicsmechanicssoftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicssoftSeries::variance(self : PhysicsmechanicssoftSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicssoftSeries::std(self : PhysicsmechanicssoftSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicssoftSeries::median(self : PhysicsmechanicssoftSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicssoftSeries::scale(self : PhysicsmechanicssoftSeries, f : Double) -> PhysicsmechanicssoftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::add(self : PhysicsmechanicssoftSeries, other : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::sub(self : PhysicsmechanicssoftSeries, other : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::normalize(self : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicssoftSeries::cumsum(self : PhysicsmechanicssoftSeries) -> PhysicsmechanicssoftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicssoftSeries::to_string(self : PhysicsmechanicssoftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicssoftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_soft_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicssoftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_soft_matrix_identity(n : Int) -> PhysicsmechanicssoftMatrix {
  let m = physics_mechanics_soft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicssoftMatrix::get(self : PhysicsmechanicssoftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicssoftMatrix::transpose(self : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  let result = physics_mechanics_soft_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicssoftMatrix::add(self : PhysicsmechanicssoftMatrix, other : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_soft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicssoftMatrix::scale(self : PhysicsmechanicssoftMatrix, s : Double) -> PhysicsmechanicssoftMatrix {
  let result = physics_mechanics_soft_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicssoftMatrix::multiply(self : PhysicsmechanicssoftMatrix, other : PhysicsmechanicssoftMatrix) -> PhysicsmechanicssoftMatrix {
  if self.cols != other.rows { return physics_mechanics_soft_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_soft_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicssoftMatrix::trace(self : PhysicsmechanicssoftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicssoftMatrix::det(self : PhysicsmechanicssoftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicssoftMatrix::norm(self : PhysicsmechanicssoftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicssoftMatrix::to_string(self : PhysicsmechanicssoftMatrix) -> String {
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

pub(all) struct PhysicsmechanicssoftVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_soft_make_vector(comps : Array[Double]) -> PhysicsmechanicssoftVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_soft_vector_zero(dim : Int) -> PhysicsmechanicssoftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicssoftVector::add(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicssoftVector::sub(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicssoftVector::scale(self : PhysicsmechanicssoftVector, s : Double) -> PhysicsmechanicssoftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicssoftVector::dot(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicssoftVector::norm(self : PhysicsmechanicssoftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicssoftVector::normalize(self : PhysicsmechanicssoftVector) -> PhysicsmechanicssoftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicssoftVector::dist(self : PhysicsmechanicssoftVector, other : PhysicsmechanicssoftVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicssoftVector::to_string(self : PhysicsmechanicssoftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_soft_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_soft_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_soft_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_soft_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_soft_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_soft_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_soft_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_soft_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_soft_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_soft_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_soft_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_soft_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_soft_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_soft_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_soft_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_soft_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_soft_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_soft_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_soft_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_soft_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_soft_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_soft_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_soft_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_soft_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_soft_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_soft_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_soft_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_soft_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_soft_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicssoftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_frame_make(size : Int) -> PhysicsmechanicssoftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_frame_len(s : PhysicsmechanicssoftFrame) -> Int { s.size }

pub fn physics_mechanics_soft_frame_get(s : PhysicsmechanicssoftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_frame_set(s : PhysicsmechanicssoftFrame, i : Int, v : Double) -> PhysicsmechanicssoftFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_frame_sum(s : PhysicsmechanicssoftFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_frame_mean(s : PhysicsmechanicssoftFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_frame_scale(s : PhysicsmechanicssoftFrame, f : Double) -> PhysicsmechanicssoftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_frame_add(a : PhysicsmechanicssoftFrame, b : PhysicsmechanicssoftFrame) -> PhysicsmechanicssoftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_frame_copy(s : PhysicsmechanicssoftFrame) -> PhysicsmechanicssoftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_frame_fill(s : PhysicsmechanicssoftFrame, v : Double) -> PhysicsmechanicssoftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_frame_min(s : PhysicsmechanicssoftFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_frame_max(s : PhysicsmechanicssoftFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_frame_to_string(s : PhysicsmechanicssoftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_table_make(size : Int) -> PhysicsmechanicssoftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_table_len(s : PhysicsmechanicssoftTable) -> Int { s.size }

pub fn physics_mechanics_soft_table_get(s : PhysicsmechanicssoftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_table_set(s : PhysicsmechanicssoftTable, i : Int, v : Double) -> PhysicsmechanicssoftTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_table_sum(s : PhysicsmechanicssoftTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_table_mean(s : PhysicsmechanicssoftTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_table_scale(s : PhysicsmechanicssoftTable, f : Double) -> PhysicsmechanicssoftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_table_add(a : PhysicsmechanicssoftTable, b : PhysicsmechanicssoftTable) -> PhysicsmechanicssoftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_table_copy(s : PhysicsmechanicssoftTable) -> PhysicsmechanicssoftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_table_fill(s : PhysicsmechanicssoftTable, v : Double) -> PhysicsmechanicssoftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_table_min(s : PhysicsmechanicssoftTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_table_max(s : PhysicsmechanicssoftTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_table_to_string(s : PhysicsmechanicssoftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_graphn_make(size : Int) -> PhysicsmechanicssoftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_graphn_len(s : PhysicsmechanicssoftGraphN) -> Int { s.size }

pub fn physics_mechanics_soft_graphn_get(s : PhysicsmechanicssoftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_graphn_set(s : PhysicsmechanicssoftGraphN, i : Int, v : Double) -> PhysicsmechanicssoftGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_graphn_sum(s : PhysicsmechanicssoftGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_graphn_mean(s : PhysicsmechanicssoftGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_graphn_scale(s : PhysicsmechanicssoftGraphN, f : Double) -> PhysicsmechanicssoftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_graphn_add(a : PhysicsmechanicssoftGraphN, b : PhysicsmechanicssoftGraphN) -> PhysicsmechanicssoftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_graphn_copy(s : PhysicsmechanicssoftGraphN) -> PhysicsmechanicssoftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_graphn_fill(s : PhysicsmechanicssoftGraphN, v : Double) -> PhysicsmechanicssoftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_graphn_min(s : PhysicsmechanicssoftGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_graphn_max(s : PhysicsmechanicssoftGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_graphn_to_string(s : PhysicsmechanicssoftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_node_make(size : Int) -> PhysicsmechanicssoftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_node_len(s : PhysicsmechanicssoftNode) -> Int { s.size }

pub fn physics_mechanics_soft_node_get(s : PhysicsmechanicssoftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_node_set(s : PhysicsmechanicssoftNode, i : Int, v : Double) -> PhysicsmechanicssoftNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_node_sum(s : PhysicsmechanicssoftNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_node_mean(s : PhysicsmechanicssoftNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_node_scale(s : PhysicsmechanicssoftNode, f : Double) -> PhysicsmechanicssoftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_node_add(a : PhysicsmechanicssoftNode, b : PhysicsmechanicssoftNode) -> PhysicsmechanicssoftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_node_copy(s : PhysicsmechanicssoftNode) -> PhysicsmechanicssoftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_node_fill(s : PhysicsmechanicssoftNode, v : Double) -> PhysicsmechanicssoftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_node_min(s : PhysicsmechanicssoftNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_node_max(s : PhysicsmechanicssoftNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_node_to_string(s : PhysicsmechanicssoftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_edge_make(size : Int) -> PhysicsmechanicssoftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_edge_len(s : PhysicsmechanicssoftEdge) -> Int { s.size }

pub fn physics_mechanics_soft_edge_get(s : PhysicsmechanicssoftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_edge_set(s : PhysicsmechanicssoftEdge, i : Int, v : Double) -> PhysicsmechanicssoftEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_edge_sum(s : PhysicsmechanicssoftEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_edge_mean(s : PhysicsmechanicssoftEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_edge_scale(s : PhysicsmechanicssoftEdge, f : Double) -> PhysicsmechanicssoftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_edge_add(a : PhysicsmechanicssoftEdge, b : PhysicsmechanicssoftEdge) -> PhysicsmechanicssoftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_edge_copy(s : PhysicsmechanicssoftEdge) -> PhysicsmechanicssoftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_edge_fill(s : PhysicsmechanicssoftEdge, v : Double) -> PhysicsmechanicssoftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_edge_min(s : PhysicsmechanicssoftEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_edge_max(s : PhysicsmechanicssoftEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_edge_to_string(s : PhysicsmechanicssoftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_path_make(size : Int) -> PhysicsmechanicssoftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_path_len(s : PhysicsmechanicssoftPath) -> Int { s.size }

pub fn physics_mechanics_soft_path_get(s : PhysicsmechanicssoftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_path_set(s : PhysicsmechanicssoftPath, i : Int, v : Double) -> PhysicsmechanicssoftPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_path_sum(s : PhysicsmechanicssoftPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_path_mean(s : PhysicsmechanicssoftPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_path_scale(s : PhysicsmechanicssoftPath, f : Double) -> PhysicsmechanicssoftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_path_add(a : PhysicsmechanicssoftPath, b : PhysicsmechanicssoftPath) -> PhysicsmechanicssoftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_path_copy(s : PhysicsmechanicssoftPath) -> PhysicsmechanicssoftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_path_fill(s : PhysicsmechanicssoftPath, v : Double) -> PhysicsmechanicssoftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_path_min(s : PhysicsmechanicssoftPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_path_max(s : PhysicsmechanicssoftPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_path_to_string(s : PhysicsmechanicssoftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_cluster_make(size : Int) -> PhysicsmechanicssoftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_cluster_len(s : PhysicsmechanicssoftCluster) -> Int { s.size }

pub fn physics_mechanics_soft_cluster_get(s : PhysicsmechanicssoftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_cluster_set(s : PhysicsmechanicssoftCluster, i : Int, v : Double) -> PhysicsmechanicssoftCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cluster_sum(s : PhysicsmechanicssoftCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_cluster_mean(s : PhysicsmechanicssoftCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_cluster_scale(s : PhysicsmechanicssoftCluster, f : Double) -> PhysicsmechanicssoftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cluster_add(a : PhysicsmechanicssoftCluster, b : PhysicsmechanicssoftCluster) -> PhysicsmechanicssoftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_cluster_copy(s : PhysicsmechanicssoftCluster) -> PhysicsmechanicssoftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cluster_fill(s : PhysicsmechanicssoftCluster, v : Double) -> PhysicsmechanicssoftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cluster_min(s : PhysicsmechanicssoftCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_cluster_max(s : PhysicsmechanicssoftCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_cluster_to_string(s : PhysicsmechanicssoftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_model_make(size : Int) -> PhysicsmechanicssoftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_model_len(s : PhysicsmechanicssoftModel) -> Int { s.size }

pub fn physics_mechanics_soft_model_get(s : PhysicsmechanicssoftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_model_set(s : PhysicsmechanicssoftModel, i : Int, v : Double) -> PhysicsmechanicssoftModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_model_sum(s : PhysicsmechanicssoftModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_model_mean(s : PhysicsmechanicssoftModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_model_scale(s : PhysicsmechanicssoftModel, f : Double) -> PhysicsmechanicssoftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_model_add(a : PhysicsmechanicssoftModel, b : PhysicsmechanicssoftModel) -> PhysicsmechanicssoftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_model_copy(s : PhysicsmechanicssoftModel) -> PhysicsmechanicssoftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_model_fill(s : PhysicsmechanicssoftModel, v : Double) -> PhysicsmechanicssoftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_model_min(s : PhysicsmechanicssoftModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_model_max(s : PhysicsmechanicssoftModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_model_to_string(s : PhysicsmechanicssoftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_layer_make(size : Int) -> PhysicsmechanicssoftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_layer_len(s : PhysicsmechanicssoftLayer) -> Int { s.size }

pub fn physics_mechanics_soft_layer_get(s : PhysicsmechanicssoftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_layer_set(s : PhysicsmechanicssoftLayer, i : Int, v : Double) -> PhysicsmechanicssoftLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_layer_sum(s : PhysicsmechanicssoftLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_layer_mean(s : PhysicsmechanicssoftLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_layer_scale(s : PhysicsmechanicssoftLayer, f : Double) -> PhysicsmechanicssoftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_layer_add(a : PhysicsmechanicssoftLayer, b : PhysicsmechanicssoftLayer) -> PhysicsmechanicssoftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_layer_copy(s : PhysicsmechanicssoftLayer) -> PhysicsmechanicssoftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_layer_fill(s : PhysicsmechanicssoftLayer, v : Double) -> PhysicsmechanicssoftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_layer_min(s : PhysicsmechanicssoftLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_layer_max(s : PhysicsmechanicssoftLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_layer_to_string(s : PhysicsmechanicssoftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_buffer_make(size : Int) -> PhysicsmechanicssoftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_buffer_len(s : PhysicsmechanicssoftBuffer) -> Int { s.size }

pub fn physics_mechanics_soft_buffer_get(s : PhysicsmechanicssoftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_buffer_set(s : PhysicsmechanicssoftBuffer, i : Int, v : Double) -> PhysicsmechanicssoftBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_buffer_sum(s : PhysicsmechanicssoftBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_buffer_mean(s : PhysicsmechanicssoftBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_buffer_scale(s : PhysicsmechanicssoftBuffer, f : Double) -> PhysicsmechanicssoftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_buffer_add(a : PhysicsmechanicssoftBuffer, b : PhysicsmechanicssoftBuffer) -> PhysicsmechanicssoftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_buffer_copy(s : PhysicsmechanicssoftBuffer) -> PhysicsmechanicssoftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_buffer_fill(s : PhysicsmechanicssoftBuffer, v : Double) -> PhysicsmechanicssoftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_buffer_min(s : PhysicsmechanicssoftBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_buffer_max(s : PhysicsmechanicssoftBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_buffer_to_string(s : PhysicsmechanicssoftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_cursor_make(size : Int) -> PhysicsmechanicssoftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_cursor_len(s : PhysicsmechanicssoftCursor) -> Int { s.size }

pub fn physics_mechanics_soft_cursor_get(s : PhysicsmechanicssoftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_cursor_set(s : PhysicsmechanicssoftCursor, i : Int, v : Double) -> PhysicsmechanicssoftCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cursor_sum(s : PhysicsmechanicssoftCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_cursor_mean(s : PhysicsmechanicssoftCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_cursor_scale(s : PhysicsmechanicssoftCursor, f : Double) -> PhysicsmechanicssoftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cursor_add(a : PhysicsmechanicssoftCursor, b : PhysicsmechanicssoftCursor) -> PhysicsmechanicssoftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_cursor_copy(s : PhysicsmechanicssoftCursor) -> PhysicsmechanicssoftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cursor_fill(s : PhysicsmechanicssoftCursor, v : Double) -> PhysicsmechanicssoftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_cursor_min(s : PhysicsmechanicssoftCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_cursor_max(s : PhysicsmechanicssoftCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_cursor_to_string(s : PhysicsmechanicssoftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_view_make(size : Int) -> PhysicsmechanicssoftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_view_len(s : PhysicsmechanicssoftView) -> Int { s.size }

pub fn physics_mechanics_soft_view_get(s : PhysicsmechanicssoftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_view_set(s : PhysicsmechanicssoftView, i : Int, v : Double) -> PhysicsmechanicssoftView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_view_sum(s : PhysicsmechanicssoftView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_view_mean(s : PhysicsmechanicssoftView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_view_scale(s : PhysicsmechanicssoftView, f : Double) -> PhysicsmechanicssoftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_view_add(a : PhysicsmechanicssoftView, b : PhysicsmechanicssoftView) -> PhysicsmechanicssoftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_view_copy(s : PhysicsmechanicssoftView) -> PhysicsmechanicssoftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_view_fill(s : PhysicsmechanicssoftView, v : Double) -> PhysicsmechanicssoftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_view_min(s : PhysicsmechanicssoftView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_view_max(s : PhysicsmechanicssoftView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_view_to_string(s : PhysicsmechanicssoftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_range_make(size : Int) -> PhysicsmechanicssoftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_range_len(s : PhysicsmechanicssoftRange) -> Int { s.size }

pub fn physics_mechanics_soft_range_get(s : PhysicsmechanicssoftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_range_set(s : PhysicsmechanicssoftRange, i : Int, v : Double) -> PhysicsmechanicssoftRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_range_sum(s : PhysicsmechanicssoftRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_range_mean(s : PhysicsmechanicssoftRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_range_scale(s : PhysicsmechanicssoftRange, f : Double) -> PhysicsmechanicssoftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_range_add(a : PhysicsmechanicssoftRange, b : PhysicsmechanicssoftRange) -> PhysicsmechanicssoftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_range_copy(s : PhysicsmechanicssoftRange) -> PhysicsmechanicssoftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_range_fill(s : PhysicsmechanicssoftRange, v : Double) -> PhysicsmechanicssoftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_range_min(s : PhysicsmechanicssoftRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_range_max(s : PhysicsmechanicssoftRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_range_to_string(s : PhysicsmechanicssoftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicssoftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_soft_slice_make(size : Int) -> PhysicsmechanicssoftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_soft_slice_len(s : PhysicsmechanicssoftSlice) -> Int { s.size }

pub fn physics_mechanics_soft_slice_get(s : PhysicsmechanicssoftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_soft_slice_set(s : PhysicsmechanicssoftSlice, i : Int, v : Double) -> PhysicsmechanicssoftSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_slice_sum(s : PhysicsmechanicssoftSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_soft_slice_mean(s : PhysicsmechanicssoftSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_soft_slice_scale(s : PhysicsmechanicssoftSlice, f : Double) -> PhysicsmechanicssoftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_slice_add(a : PhysicsmechanicssoftSlice, b : PhysicsmechanicssoftSlice) -> PhysicsmechanicssoftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_soft_slice_copy(s : PhysicsmechanicssoftSlice) -> PhysicsmechanicssoftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_slice_fill(s : PhysicsmechanicssoftSlice, v : Double) -> PhysicsmechanicssoftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_soft_slice_min(s : PhysicsmechanicssoftSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_soft_slice_max(s : PhysicsmechanicssoftSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_soft_slice_to_string(s : PhysicsmechanicssoftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

