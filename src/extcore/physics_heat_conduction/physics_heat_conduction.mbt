///===
/// extcore/physics_heat_conduction

pub(all) struct PhysicsheatconductionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_conduction_make_point(x : Double, y : Double) -> PhysicsheatconductionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_conduction_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatconductionPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatconductionPoint::x(self : PhysicsheatconductionPoint) -> Double { self.x }

pub fn PhysicsheatconductionPoint::y(self : PhysicsheatconductionPoint) -> Double { self.y }

pub fn PhysicsheatconductionPoint::z(self : PhysicsheatconductionPoint) -> Double { self.z }

pub fn PhysicsheatconductionPoint::label(self : PhysicsheatconductionPoint) -> Int { self.label }

pub fn PhysicsheatconductionPoint::dist(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatconductionPoint::add(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatconductionPoint::sub(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatconductionPoint::scale(self : PhysicsheatconductionPoint, s : Double) -> PhysicsheatconductionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatconductionPoint::dot(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatconductionPoint::cross(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatconductionPoint::norm(self : PhysicsheatconductionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatconductionPoint::normalize(self : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatconductionPoint::negate(self : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatconductionPoint::mid(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatconductionPoint::lerp(self : PhysicsheatconductionPoint, other : PhysicsheatconductionPoint, t : Double) -> PhysicsheatconductionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatconductionPoint::to_string(self : PhysicsheatconductionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_conduction_make_series(vals : Array[Double], name : String) -> PhysicsheatconductionSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatconductionSeries::len(self : PhysicsheatconductionSeries) -> Int { self.vals.length() }

pub fn PhysicsheatconductionSeries::sum(self : PhysicsheatconductionSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatconductionSeries::mean(self : PhysicsheatconductionSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatconductionSeries::min(self : PhysicsheatconductionSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatconductionSeries::max(self : PhysicsheatconductionSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatconductionSeries::range(self : PhysicsheatconductionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatconductionSeries::variance(self : PhysicsheatconductionSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatconductionSeries::std(self : PhysicsheatconductionSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatconductionSeries::median(self : PhysicsheatconductionSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatconductionSeries::scale(self : PhysicsheatconductionSeries, f : Double) -> PhysicsheatconductionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatconductionSeries::add(self : PhysicsheatconductionSeries, other : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatconductionSeries::sub(self : PhysicsheatconductionSeries, other : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatconductionSeries::normalize(self : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatconductionSeries::cumsum(self : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatconductionSeries::to_string(self : PhysicsheatconductionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconductionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_conduction_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatconductionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_conduction_matrix_identity(n : Int) -> PhysicsheatconductionMatrix {
  let m = physics_heat_conduction_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatconductionMatrix::get(self : PhysicsheatconductionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatconductionMatrix::transpose(self : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatconductionMatrix::add(self : PhysicsheatconductionMatrix, other : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_conduction_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatconductionMatrix::scale(self : PhysicsheatconductionMatrix, s : Double) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatconductionMatrix::multiply(self : PhysicsheatconductionMatrix, other : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if self.cols != other.rows { return physics_heat_conduction_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_conduction_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatconductionMatrix::trace(self : PhysicsheatconductionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatconductionMatrix::det(self : PhysicsheatconductionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatconductionMatrix::norm(self : PhysicsheatconductionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatconductionMatrix::to_string(self : PhysicsheatconductionMatrix) -> String {
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

pub(all) struct PhysicsheatconductionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_conduction_make_vector(comps : Array[Double]) -> PhysicsheatconductionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_conduction_vector_zero(dim : Int) -> PhysicsheatconductionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatconductionVector::add(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatconductionVector::sub(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatconductionVector::scale(self : PhysicsheatconductionVector, s : Double) -> PhysicsheatconductionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatconductionVector::dot(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatconductionVector::norm(self : PhysicsheatconductionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatconductionVector::normalize(self : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatconductionVector::dist(self : PhysicsheatconductionVector, other : PhysicsheatconductionVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatconductionVector::to_string(self : PhysicsheatconductionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_conduction_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_conduction_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_conduction_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_conduction_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_conduction_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_conduction_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_conduction_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_conduction_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_conduction_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_conduction_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_conduction_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_conduction_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_conduction_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_conduction_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_conduction_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_conduction_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_conduction_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_conduction_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_conduction_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_conduction_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_conduction_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_conduction_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_conduction_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_conduction_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_conduction_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_conduction_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_conduction_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_conduction_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_conduction_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatconductionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_frame_make(size : Int) -> PhysicsheatconductionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_frame_len(s : PhysicsheatconductionFrame) -> Int { s.size }

pub fn physics_heat_conduction_frame_get(s : PhysicsheatconductionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_frame_set(s : PhysicsheatconductionFrame, i : Int, v : Double) -> PhysicsheatconductionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_sum(s : PhysicsheatconductionFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_frame_mean(s : PhysicsheatconductionFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_frame_scale(s : PhysicsheatconductionFrame, f : Double) -> PhysicsheatconductionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_add(a : PhysicsheatconductionFrame, b : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_frame_copy(s : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_fill(s : PhysicsheatconductionFrame, v : Double) -> PhysicsheatconductionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_min(s : PhysicsheatconductionFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_frame_max(s : PhysicsheatconductionFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_frame_to_string(s : PhysicsheatconductionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_table_make(size : Int) -> PhysicsheatconductionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_table_len(s : PhysicsheatconductionTable) -> Int { s.size }

pub fn physics_heat_conduction_table_get(s : PhysicsheatconductionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_table_set(s : PhysicsheatconductionTable, i : Int, v : Double) -> PhysicsheatconductionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_sum(s : PhysicsheatconductionTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_table_mean(s : PhysicsheatconductionTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_table_scale(s : PhysicsheatconductionTable, f : Double) -> PhysicsheatconductionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_add(a : PhysicsheatconductionTable, b : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_table_copy(s : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_fill(s : PhysicsheatconductionTable, v : Double) -> PhysicsheatconductionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_min(s : PhysicsheatconductionTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_table_max(s : PhysicsheatconductionTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_table_to_string(s : PhysicsheatconductionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_graphn_make(size : Int) -> PhysicsheatconductionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_graphn_len(s : PhysicsheatconductionGraphN) -> Int { s.size }

pub fn physics_heat_conduction_graphn_get(s : PhysicsheatconductionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_graphn_set(s : PhysicsheatconductionGraphN, i : Int, v : Double) -> PhysicsheatconductionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_sum(s : PhysicsheatconductionGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_graphn_mean(s : PhysicsheatconductionGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_graphn_scale(s : PhysicsheatconductionGraphN, f : Double) -> PhysicsheatconductionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_add(a : PhysicsheatconductionGraphN, b : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_graphn_copy(s : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_fill(s : PhysicsheatconductionGraphN, v : Double) -> PhysicsheatconductionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_min(s : PhysicsheatconductionGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_graphn_max(s : PhysicsheatconductionGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_graphn_to_string(s : PhysicsheatconductionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_node_make(size : Int) -> PhysicsheatconductionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_node_len(s : PhysicsheatconductionNode) -> Int { s.size }

pub fn physics_heat_conduction_node_get(s : PhysicsheatconductionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_node_set(s : PhysicsheatconductionNode, i : Int, v : Double) -> PhysicsheatconductionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_sum(s : PhysicsheatconductionNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_node_mean(s : PhysicsheatconductionNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_node_scale(s : PhysicsheatconductionNode, f : Double) -> PhysicsheatconductionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_add(a : PhysicsheatconductionNode, b : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_node_copy(s : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_fill(s : PhysicsheatconductionNode, v : Double) -> PhysicsheatconductionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_min(s : PhysicsheatconductionNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_node_max(s : PhysicsheatconductionNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_node_to_string(s : PhysicsheatconductionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_edge_make(size : Int) -> PhysicsheatconductionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_edge_len(s : PhysicsheatconductionEdge) -> Int { s.size }

pub fn physics_heat_conduction_edge_get(s : PhysicsheatconductionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_edge_set(s : PhysicsheatconductionEdge, i : Int, v : Double) -> PhysicsheatconductionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_sum(s : PhysicsheatconductionEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_edge_mean(s : PhysicsheatconductionEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_edge_scale(s : PhysicsheatconductionEdge, f : Double) -> PhysicsheatconductionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_add(a : PhysicsheatconductionEdge, b : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_edge_copy(s : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_fill(s : PhysicsheatconductionEdge, v : Double) -> PhysicsheatconductionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_min(s : PhysicsheatconductionEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_edge_max(s : PhysicsheatconductionEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_edge_to_string(s : PhysicsheatconductionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_path_make(size : Int) -> PhysicsheatconductionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_path_len(s : PhysicsheatconductionPath) -> Int { s.size }

pub fn physics_heat_conduction_path_get(s : PhysicsheatconductionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_path_set(s : PhysicsheatconductionPath, i : Int, v : Double) -> PhysicsheatconductionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_sum(s : PhysicsheatconductionPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_path_mean(s : PhysicsheatconductionPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_path_scale(s : PhysicsheatconductionPath, f : Double) -> PhysicsheatconductionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_add(a : PhysicsheatconductionPath, b : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_path_copy(s : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_fill(s : PhysicsheatconductionPath, v : Double) -> PhysicsheatconductionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_min(s : PhysicsheatconductionPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_path_max(s : PhysicsheatconductionPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_path_to_string(s : PhysicsheatconductionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cluster_make(size : Int) -> PhysicsheatconductionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_cluster_len(s : PhysicsheatconductionCluster) -> Int { s.size }

pub fn physics_heat_conduction_cluster_get(s : PhysicsheatconductionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_cluster_set(s : PhysicsheatconductionCluster, i : Int, v : Double) -> PhysicsheatconductionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_sum(s : PhysicsheatconductionCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_cluster_mean(s : PhysicsheatconductionCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_cluster_scale(s : PhysicsheatconductionCluster, f : Double) -> PhysicsheatconductionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_add(a : PhysicsheatconductionCluster, b : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_cluster_copy(s : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_fill(s : PhysicsheatconductionCluster, v : Double) -> PhysicsheatconductionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_min(s : PhysicsheatconductionCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_cluster_max(s : PhysicsheatconductionCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_cluster_to_string(s : PhysicsheatconductionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_model_make(size : Int) -> PhysicsheatconductionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_model_len(s : PhysicsheatconductionModel) -> Int { s.size }

pub fn physics_heat_conduction_model_get(s : PhysicsheatconductionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_model_set(s : PhysicsheatconductionModel, i : Int, v : Double) -> PhysicsheatconductionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_sum(s : PhysicsheatconductionModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_model_mean(s : PhysicsheatconductionModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_model_scale(s : PhysicsheatconductionModel, f : Double) -> PhysicsheatconductionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_add(a : PhysicsheatconductionModel, b : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_model_copy(s : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_fill(s : PhysicsheatconductionModel, v : Double) -> PhysicsheatconductionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_min(s : PhysicsheatconductionModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_model_max(s : PhysicsheatconductionModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_model_to_string(s : PhysicsheatconductionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_layer_make(size : Int) -> PhysicsheatconductionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_layer_len(s : PhysicsheatconductionLayer) -> Int { s.size }

pub fn physics_heat_conduction_layer_get(s : PhysicsheatconductionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_layer_set(s : PhysicsheatconductionLayer, i : Int, v : Double) -> PhysicsheatconductionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_sum(s : PhysicsheatconductionLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_layer_mean(s : PhysicsheatconductionLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_layer_scale(s : PhysicsheatconductionLayer, f : Double) -> PhysicsheatconductionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_add(a : PhysicsheatconductionLayer, b : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_layer_copy(s : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_fill(s : PhysicsheatconductionLayer, v : Double) -> PhysicsheatconductionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_min(s : PhysicsheatconductionLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_layer_max(s : PhysicsheatconductionLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_layer_to_string(s : PhysicsheatconductionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_buffer_make(size : Int) -> PhysicsheatconductionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_buffer_len(s : PhysicsheatconductionBuffer) -> Int { s.size }

pub fn physics_heat_conduction_buffer_get(s : PhysicsheatconductionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_buffer_set(s : PhysicsheatconductionBuffer, i : Int, v : Double) -> PhysicsheatconductionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_sum(s : PhysicsheatconductionBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_buffer_mean(s : PhysicsheatconductionBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_buffer_scale(s : PhysicsheatconductionBuffer, f : Double) -> PhysicsheatconductionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_add(a : PhysicsheatconductionBuffer, b : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_buffer_copy(s : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_fill(s : PhysicsheatconductionBuffer, v : Double) -> PhysicsheatconductionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_min(s : PhysicsheatconductionBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_buffer_max(s : PhysicsheatconductionBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_buffer_to_string(s : PhysicsheatconductionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cursor_make(size : Int) -> PhysicsheatconductionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_cursor_len(s : PhysicsheatconductionCursor) -> Int { s.size }

pub fn physics_heat_conduction_cursor_get(s : PhysicsheatconductionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_cursor_set(s : PhysicsheatconductionCursor, i : Int, v : Double) -> PhysicsheatconductionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_sum(s : PhysicsheatconductionCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_cursor_mean(s : PhysicsheatconductionCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_cursor_scale(s : PhysicsheatconductionCursor, f : Double) -> PhysicsheatconductionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_add(a : PhysicsheatconductionCursor, b : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_cursor_copy(s : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_fill(s : PhysicsheatconductionCursor, v : Double) -> PhysicsheatconductionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_min(s : PhysicsheatconductionCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_cursor_max(s : PhysicsheatconductionCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_cursor_to_string(s : PhysicsheatconductionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_view_make(size : Int) -> PhysicsheatconductionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_view_len(s : PhysicsheatconductionView) -> Int { s.size }

pub fn physics_heat_conduction_view_get(s : PhysicsheatconductionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_view_set(s : PhysicsheatconductionView, i : Int, v : Double) -> PhysicsheatconductionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_sum(s : PhysicsheatconductionView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_view_mean(s : PhysicsheatconductionView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_view_scale(s : PhysicsheatconductionView, f : Double) -> PhysicsheatconductionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_add(a : PhysicsheatconductionView, b : PhysicsheatconductionView) -> PhysicsheatconductionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_view_copy(s : PhysicsheatconductionView) -> PhysicsheatconductionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_fill(s : PhysicsheatconductionView, v : Double) -> PhysicsheatconductionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_min(s : PhysicsheatconductionView) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_view_max(s : PhysicsheatconductionView) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_view_to_string(s : PhysicsheatconductionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_range_make(size : Int) -> PhysicsheatconductionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_range_len(s : PhysicsheatconductionRange) -> Int { s.size }

pub fn physics_heat_conduction_range_get(s : PhysicsheatconductionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_range_set(s : PhysicsheatconductionRange, i : Int, v : Double) -> PhysicsheatconductionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_sum(s : PhysicsheatconductionRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_range_mean(s : PhysicsheatconductionRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_range_scale(s : PhysicsheatconductionRange, f : Double) -> PhysicsheatconductionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_add(a : PhysicsheatconductionRange, b : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_range_copy(s : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_fill(s : PhysicsheatconductionRange, v : Double) -> PhysicsheatconductionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_min(s : PhysicsheatconductionRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_range_max(s : PhysicsheatconductionRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_range_to_string(s : PhysicsheatconductionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_slice_make(size : Int) -> PhysicsheatconductionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_slice_len(s : PhysicsheatconductionSlice) -> Int { s.size }

pub fn physics_heat_conduction_slice_get(s : PhysicsheatconductionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_slice_set(s : PhysicsheatconductionSlice, i : Int, v : Double) -> PhysicsheatconductionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_sum(s : PhysicsheatconductionSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_slice_mean(s : PhysicsheatconductionSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_slice_scale(s : PhysicsheatconductionSlice, f : Double) -> PhysicsheatconductionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_add(a : PhysicsheatconductionSlice, b : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_slice_copy(s : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_fill(s : PhysicsheatconductionSlice, v : Double) -> PhysicsheatconductionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_min(s : PhysicsheatconductionSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_slice_max(s : PhysicsheatconductionSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_slice_to_string(s : PhysicsheatconductionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

