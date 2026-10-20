///===
/// extcore/physics_mechanics_dynamic

pub(all) struct PhysicsmechanicsdynamicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_dynamic_make_point(x : Double, y : Double) -> PhysicsmechanicsdynamicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_dynamic_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsdynamicPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsdynamicPoint::x(self : PhysicsmechanicsdynamicPoint) -> Double { self.x }

pub fn PhysicsmechanicsdynamicPoint::y(self : PhysicsmechanicsdynamicPoint) -> Double { self.y }

pub fn PhysicsmechanicsdynamicPoint::z(self : PhysicsmechanicsdynamicPoint) -> Double { self.z }

pub fn PhysicsmechanicsdynamicPoint::label(self : PhysicsmechanicsdynamicPoint) -> Int { self.label }

pub fn PhysicsmechanicsdynamicPoint::dist(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsdynamicPoint::add(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::sub(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::scale(self : PhysicsmechanicsdynamicPoint, s : Double) -> PhysicsmechanicsdynamicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::dot(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsdynamicPoint::cross(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsdynamicPoint::norm(self : PhysicsmechanicsdynamicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsdynamicPoint::normalize(self : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsdynamicPoint::negate(self : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::mid(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint) -> PhysicsmechanicsdynamicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::lerp(self : PhysicsmechanicsdynamicPoint, other : PhysicsmechanicsdynamicPoint, t : Double) -> PhysicsmechanicsdynamicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsdynamicPoint::to_string(self : PhysicsmechanicsdynamicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_dynamic_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsdynamicSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsdynamicSeries::len(self : PhysicsmechanicsdynamicSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsdynamicSeries::sum(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::mean(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::min(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::max(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::range(self : PhysicsmechanicsdynamicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsdynamicSeries::variance(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::std(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::median(self : PhysicsmechanicsdynamicSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsdynamicSeries::scale(self : PhysicsmechanicsdynamicSeries, f : Double) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::add(self : PhysicsmechanicsdynamicSeries, other : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::sub(self : PhysicsmechanicsdynamicSeries, other : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::normalize(self : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsdynamicSeries::cumsum(self : PhysicsmechanicsdynamicSeries) -> PhysicsmechanicsdynamicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsdynamicSeries::to_string(self : PhysicsmechanicsdynamicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsdynamicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_dynamic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsdynamicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_dynamic_matrix_identity(n : Int) -> PhysicsmechanicsdynamicMatrix {
  let m = physics_mechanics_dynamic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsdynamicMatrix::get(self : PhysicsmechanicsdynamicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsdynamicMatrix::transpose(self : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  let result = physics_mechanics_dynamic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::add(self : PhysicsmechanicsdynamicMatrix, other : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::scale(self : PhysicsmechanicsdynamicMatrix, s : Double) -> PhysicsmechanicsdynamicMatrix {
  let result = physics_mechanics_dynamic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::multiply(self : PhysicsmechanicsdynamicMatrix, other : PhysicsmechanicsdynamicMatrix) -> PhysicsmechanicsdynamicMatrix {
  if self.cols != other.rows { return physics_mechanics_dynamic_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_dynamic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsdynamicMatrix::trace(self : PhysicsmechanicsdynamicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsdynamicMatrix::det(self : PhysicsmechanicsdynamicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsdynamicMatrix::norm(self : PhysicsmechanicsdynamicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsdynamicMatrix::to_string(self : PhysicsmechanicsdynamicMatrix) -> String {
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

pub(all) struct PhysicsmechanicsdynamicVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_dynamic_make_vector(comps : Array[Double]) -> PhysicsmechanicsdynamicVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_dynamic_vector_zero(dim : Int) -> PhysicsmechanicsdynamicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsdynamicVector::add(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsdynamicVector::sub(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsdynamicVector::scale(self : PhysicsmechanicsdynamicVector, s : Double) -> PhysicsmechanicsdynamicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsdynamicVector::dot(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsdynamicVector::norm(self : PhysicsmechanicsdynamicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsdynamicVector::normalize(self : PhysicsmechanicsdynamicVector) -> PhysicsmechanicsdynamicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsdynamicVector::dist(self : PhysicsmechanicsdynamicVector, other : PhysicsmechanicsdynamicVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsdynamicVector::to_string(self : PhysicsmechanicsdynamicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_dynamic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_dynamic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_dynamic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_dynamic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_dynamic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_dynamic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_dynamic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_dynamic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_dynamic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_dynamic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_dynamic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_dynamic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_dynamic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_dynamic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_dynamic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_dynamic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_dynamic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_dynamic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_dynamic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_dynamic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_dynamic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_dynamic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_dynamic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_dynamic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_dynamic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_dynamic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_dynamic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_dynamic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_dynamic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsdynamicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_frame_make(size : Int) -> PhysicsmechanicsdynamicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_frame_len(s : PhysicsmechanicsdynamicFrame) -> Int { s.size }

pub fn physics_mechanics_dynamic_frame_get(s : PhysicsmechanicsdynamicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_frame_set(s : PhysicsmechanicsdynamicFrame, i : Int, v : Double) -> PhysicsmechanicsdynamicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_frame_sum(s : PhysicsmechanicsdynamicFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_frame_mean(s : PhysicsmechanicsdynamicFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_frame_scale(s : PhysicsmechanicsdynamicFrame, f : Double) -> PhysicsmechanicsdynamicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_frame_add(a : PhysicsmechanicsdynamicFrame, b : PhysicsmechanicsdynamicFrame) -> PhysicsmechanicsdynamicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_frame_copy(s : PhysicsmechanicsdynamicFrame) -> PhysicsmechanicsdynamicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_frame_fill(s : PhysicsmechanicsdynamicFrame, v : Double) -> PhysicsmechanicsdynamicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_frame_min(s : PhysicsmechanicsdynamicFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_frame_max(s : PhysicsmechanicsdynamicFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_frame_to_string(s : PhysicsmechanicsdynamicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_table_make(size : Int) -> PhysicsmechanicsdynamicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_table_len(s : PhysicsmechanicsdynamicTable) -> Int { s.size }

pub fn physics_mechanics_dynamic_table_get(s : PhysicsmechanicsdynamicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_table_set(s : PhysicsmechanicsdynamicTable, i : Int, v : Double) -> PhysicsmechanicsdynamicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_table_sum(s : PhysicsmechanicsdynamicTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_table_mean(s : PhysicsmechanicsdynamicTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_table_scale(s : PhysicsmechanicsdynamicTable, f : Double) -> PhysicsmechanicsdynamicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_table_add(a : PhysicsmechanicsdynamicTable, b : PhysicsmechanicsdynamicTable) -> PhysicsmechanicsdynamicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_table_copy(s : PhysicsmechanicsdynamicTable) -> PhysicsmechanicsdynamicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_table_fill(s : PhysicsmechanicsdynamicTable, v : Double) -> PhysicsmechanicsdynamicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_table_min(s : PhysicsmechanicsdynamicTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_table_max(s : PhysicsmechanicsdynamicTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_table_to_string(s : PhysicsmechanicsdynamicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_graphn_make(size : Int) -> PhysicsmechanicsdynamicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_graphn_len(s : PhysicsmechanicsdynamicGraphN) -> Int { s.size }

pub fn physics_mechanics_dynamic_graphn_get(s : PhysicsmechanicsdynamicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_graphn_set(s : PhysicsmechanicsdynamicGraphN, i : Int, v : Double) -> PhysicsmechanicsdynamicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_graphn_sum(s : PhysicsmechanicsdynamicGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_graphn_mean(s : PhysicsmechanicsdynamicGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_graphn_scale(s : PhysicsmechanicsdynamicGraphN, f : Double) -> PhysicsmechanicsdynamicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_graphn_add(a : PhysicsmechanicsdynamicGraphN, b : PhysicsmechanicsdynamicGraphN) -> PhysicsmechanicsdynamicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_graphn_copy(s : PhysicsmechanicsdynamicGraphN) -> PhysicsmechanicsdynamicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_graphn_fill(s : PhysicsmechanicsdynamicGraphN, v : Double) -> PhysicsmechanicsdynamicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_graphn_min(s : PhysicsmechanicsdynamicGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_graphn_max(s : PhysicsmechanicsdynamicGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_graphn_to_string(s : PhysicsmechanicsdynamicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_node_make(size : Int) -> PhysicsmechanicsdynamicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_node_len(s : PhysicsmechanicsdynamicNode) -> Int { s.size }

pub fn physics_mechanics_dynamic_node_get(s : PhysicsmechanicsdynamicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_node_set(s : PhysicsmechanicsdynamicNode, i : Int, v : Double) -> PhysicsmechanicsdynamicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_node_sum(s : PhysicsmechanicsdynamicNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_node_mean(s : PhysicsmechanicsdynamicNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_node_scale(s : PhysicsmechanicsdynamicNode, f : Double) -> PhysicsmechanicsdynamicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_node_add(a : PhysicsmechanicsdynamicNode, b : PhysicsmechanicsdynamicNode) -> PhysicsmechanicsdynamicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_node_copy(s : PhysicsmechanicsdynamicNode) -> PhysicsmechanicsdynamicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_node_fill(s : PhysicsmechanicsdynamicNode, v : Double) -> PhysicsmechanicsdynamicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_node_min(s : PhysicsmechanicsdynamicNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_node_max(s : PhysicsmechanicsdynamicNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_node_to_string(s : PhysicsmechanicsdynamicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_edge_make(size : Int) -> PhysicsmechanicsdynamicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_edge_len(s : PhysicsmechanicsdynamicEdge) -> Int { s.size }

pub fn physics_mechanics_dynamic_edge_get(s : PhysicsmechanicsdynamicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_edge_set(s : PhysicsmechanicsdynamicEdge, i : Int, v : Double) -> PhysicsmechanicsdynamicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_edge_sum(s : PhysicsmechanicsdynamicEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_edge_mean(s : PhysicsmechanicsdynamicEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_edge_scale(s : PhysicsmechanicsdynamicEdge, f : Double) -> PhysicsmechanicsdynamicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_edge_add(a : PhysicsmechanicsdynamicEdge, b : PhysicsmechanicsdynamicEdge) -> PhysicsmechanicsdynamicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_edge_copy(s : PhysicsmechanicsdynamicEdge) -> PhysicsmechanicsdynamicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_edge_fill(s : PhysicsmechanicsdynamicEdge, v : Double) -> PhysicsmechanicsdynamicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_edge_min(s : PhysicsmechanicsdynamicEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_edge_max(s : PhysicsmechanicsdynamicEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_edge_to_string(s : PhysicsmechanicsdynamicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_path_make(size : Int) -> PhysicsmechanicsdynamicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_path_len(s : PhysicsmechanicsdynamicPath) -> Int { s.size }

pub fn physics_mechanics_dynamic_path_get(s : PhysicsmechanicsdynamicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_path_set(s : PhysicsmechanicsdynamicPath, i : Int, v : Double) -> PhysicsmechanicsdynamicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_path_sum(s : PhysicsmechanicsdynamicPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_path_mean(s : PhysicsmechanicsdynamicPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_path_scale(s : PhysicsmechanicsdynamicPath, f : Double) -> PhysicsmechanicsdynamicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_path_add(a : PhysicsmechanicsdynamicPath, b : PhysicsmechanicsdynamicPath) -> PhysicsmechanicsdynamicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_path_copy(s : PhysicsmechanicsdynamicPath) -> PhysicsmechanicsdynamicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_path_fill(s : PhysicsmechanicsdynamicPath, v : Double) -> PhysicsmechanicsdynamicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_path_min(s : PhysicsmechanicsdynamicPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_path_max(s : PhysicsmechanicsdynamicPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_path_to_string(s : PhysicsmechanicsdynamicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_cluster_make(size : Int) -> PhysicsmechanicsdynamicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_cluster_len(s : PhysicsmechanicsdynamicCluster) -> Int { s.size }

pub fn physics_mechanics_dynamic_cluster_get(s : PhysicsmechanicsdynamicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_cluster_set(s : PhysicsmechanicsdynamicCluster, i : Int, v : Double) -> PhysicsmechanicsdynamicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cluster_sum(s : PhysicsmechanicsdynamicCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_cluster_mean(s : PhysicsmechanicsdynamicCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_cluster_scale(s : PhysicsmechanicsdynamicCluster, f : Double) -> PhysicsmechanicsdynamicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cluster_add(a : PhysicsmechanicsdynamicCluster, b : PhysicsmechanicsdynamicCluster) -> PhysicsmechanicsdynamicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_cluster_copy(s : PhysicsmechanicsdynamicCluster) -> PhysicsmechanicsdynamicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cluster_fill(s : PhysicsmechanicsdynamicCluster, v : Double) -> PhysicsmechanicsdynamicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cluster_min(s : PhysicsmechanicsdynamicCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_cluster_max(s : PhysicsmechanicsdynamicCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_cluster_to_string(s : PhysicsmechanicsdynamicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_model_make(size : Int) -> PhysicsmechanicsdynamicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_model_len(s : PhysicsmechanicsdynamicModel) -> Int { s.size }

pub fn physics_mechanics_dynamic_model_get(s : PhysicsmechanicsdynamicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_model_set(s : PhysicsmechanicsdynamicModel, i : Int, v : Double) -> PhysicsmechanicsdynamicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_model_sum(s : PhysicsmechanicsdynamicModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_model_mean(s : PhysicsmechanicsdynamicModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_model_scale(s : PhysicsmechanicsdynamicModel, f : Double) -> PhysicsmechanicsdynamicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_model_add(a : PhysicsmechanicsdynamicModel, b : PhysicsmechanicsdynamicModel) -> PhysicsmechanicsdynamicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_model_copy(s : PhysicsmechanicsdynamicModel) -> PhysicsmechanicsdynamicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_model_fill(s : PhysicsmechanicsdynamicModel, v : Double) -> PhysicsmechanicsdynamicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_model_min(s : PhysicsmechanicsdynamicModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_model_max(s : PhysicsmechanicsdynamicModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_model_to_string(s : PhysicsmechanicsdynamicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_layer_make(size : Int) -> PhysicsmechanicsdynamicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_layer_len(s : PhysicsmechanicsdynamicLayer) -> Int { s.size }

pub fn physics_mechanics_dynamic_layer_get(s : PhysicsmechanicsdynamicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_layer_set(s : PhysicsmechanicsdynamicLayer, i : Int, v : Double) -> PhysicsmechanicsdynamicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_layer_sum(s : PhysicsmechanicsdynamicLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_layer_mean(s : PhysicsmechanicsdynamicLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_layer_scale(s : PhysicsmechanicsdynamicLayer, f : Double) -> PhysicsmechanicsdynamicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_layer_add(a : PhysicsmechanicsdynamicLayer, b : PhysicsmechanicsdynamicLayer) -> PhysicsmechanicsdynamicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_layer_copy(s : PhysicsmechanicsdynamicLayer) -> PhysicsmechanicsdynamicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_layer_fill(s : PhysicsmechanicsdynamicLayer, v : Double) -> PhysicsmechanicsdynamicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_layer_min(s : PhysicsmechanicsdynamicLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_layer_max(s : PhysicsmechanicsdynamicLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_layer_to_string(s : PhysicsmechanicsdynamicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_buffer_make(size : Int) -> PhysicsmechanicsdynamicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_buffer_len(s : PhysicsmechanicsdynamicBuffer) -> Int { s.size }

pub fn physics_mechanics_dynamic_buffer_get(s : PhysicsmechanicsdynamicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_buffer_set(s : PhysicsmechanicsdynamicBuffer, i : Int, v : Double) -> PhysicsmechanicsdynamicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_buffer_sum(s : PhysicsmechanicsdynamicBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_buffer_mean(s : PhysicsmechanicsdynamicBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_buffer_scale(s : PhysicsmechanicsdynamicBuffer, f : Double) -> PhysicsmechanicsdynamicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_buffer_add(a : PhysicsmechanicsdynamicBuffer, b : PhysicsmechanicsdynamicBuffer) -> PhysicsmechanicsdynamicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_buffer_copy(s : PhysicsmechanicsdynamicBuffer) -> PhysicsmechanicsdynamicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_buffer_fill(s : PhysicsmechanicsdynamicBuffer, v : Double) -> PhysicsmechanicsdynamicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_buffer_min(s : PhysicsmechanicsdynamicBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_buffer_max(s : PhysicsmechanicsdynamicBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_buffer_to_string(s : PhysicsmechanicsdynamicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_cursor_make(size : Int) -> PhysicsmechanicsdynamicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_cursor_len(s : PhysicsmechanicsdynamicCursor) -> Int { s.size }

pub fn physics_mechanics_dynamic_cursor_get(s : PhysicsmechanicsdynamicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_cursor_set(s : PhysicsmechanicsdynamicCursor, i : Int, v : Double) -> PhysicsmechanicsdynamicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cursor_sum(s : PhysicsmechanicsdynamicCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_cursor_mean(s : PhysicsmechanicsdynamicCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_cursor_scale(s : PhysicsmechanicsdynamicCursor, f : Double) -> PhysicsmechanicsdynamicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cursor_add(a : PhysicsmechanicsdynamicCursor, b : PhysicsmechanicsdynamicCursor) -> PhysicsmechanicsdynamicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_cursor_copy(s : PhysicsmechanicsdynamicCursor) -> PhysicsmechanicsdynamicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cursor_fill(s : PhysicsmechanicsdynamicCursor, v : Double) -> PhysicsmechanicsdynamicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_cursor_min(s : PhysicsmechanicsdynamicCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_cursor_max(s : PhysicsmechanicsdynamicCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_cursor_to_string(s : PhysicsmechanicsdynamicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_view_make(size : Int) -> PhysicsmechanicsdynamicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_view_len(s : PhysicsmechanicsdynamicView) -> Int { s.size }

pub fn physics_mechanics_dynamic_view_get(s : PhysicsmechanicsdynamicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_view_set(s : PhysicsmechanicsdynamicView, i : Int, v : Double) -> PhysicsmechanicsdynamicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_view_sum(s : PhysicsmechanicsdynamicView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_view_mean(s : PhysicsmechanicsdynamicView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_view_scale(s : PhysicsmechanicsdynamicView, f : Double) -> PhysicsmechanicsdynamicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_view_add(a : PhysicsmechanicsdynamicView, b : PhysicsmechanicsdynamicView) -> PhysicsmechanicsdynamicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_view_copy(s : PhysicsmechanicsdynamicView) -> PhysicsmechanicsdynamicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_view_fill(s : PhysicsmechanicsdynamicView, v : Double) -> PhysicsmechanicsdynamicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_view_min(s : PhysicsmechanicsdynamicView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_view_max(s : PhysicsmechanicsdynamicView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_view_to_string(s : PhysicsmechanicsdynamicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_range_make(size : Int) -> PhysicsmechanicsdynamicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_range_len(s : PhysicsmechanicsdynamicRange) -> Int { s.size }

pub fn physics_mechanics_dynamic_range_get(s : PhysicsmechanicsdynamicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_range_set(s : PhysicsmechanicsdynamicRange, i : Int, v : Double) -> PhysicsmechanicsdynamicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_range_sum(s : PhysicsmechanicsdynamicRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_range_mean(s : PhysicsmechanicsdynamicRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_range_scale(s : PhysicsmechanicsdynamicRange, f : Double) -> PhysicsmechanicsdynamicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_range_add(a : PhysicsmechanicsdynamicRange, b : PhysicsmechanicsdynamicRange) -> PhysicsmechanicsdynamicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_range_copy(s : PhysicsmechanicsdynamicRange) -> PhysicsmechanicsdynamicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_range_fill(s : PhysicsmechanicsdynamicRange, v : Double) -> PhysicsmechanicsdynamicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_range_min(s : PhysicsmechanicsdynamicRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_range_max(s : PhysicsmechanicsdynamicRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_range_to_string(s : PhysicsmechanicsdynamicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsdynamicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_dynamic_slice_make(size : Int) -> PhysicsmechanicsdynamicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_dynamic_slice_len(s : PhysicsmechanicsdynamicSlice) -> Int { s.size }

pub fn physics_mechanics_dynamic_slice_get(s : PhysicsmechanicsdynamicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_dynamic_slice_set(s : PhysicsmechanicsdynamicSlice, i : Int, v : Double) -> PhysicsmechanicsdynamicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_slice_sum(s : PhysicsmechanicsdynamicSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_dynamic_slice_mean(s : PhysicsmechanicsdynamicSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_dynamic_slice_scale(s : PhysicsmechanicsdynamicSlice, f : Double) -> PhysicsmechanicsdynamicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_slice_add(a : PhysicsmechanicsdynamicSlice, b : PhysicsmechanicsdynamicSlice) -> PhysicsmechanicsdynamicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_dynamic_slice_copy(s : PhysicsmechanicsdynamicSlice) -> PhysicsmechanicsdynamicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_slice_fill(s : PhysicsmechanicsdynamicSlice, v : Double) -> PhysicsmechanicsdynamicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_dynamic_slice_min(s : PhysicsmechanicsdynamicSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_dynamic_slice_max(s : PhysicsmechanicsdynamicSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_dynamic_slice_to_string(s : PhysicsmechanicsdynamicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

