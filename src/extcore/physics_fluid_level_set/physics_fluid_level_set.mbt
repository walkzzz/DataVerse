///===
/// extcore/physics_fluid_level_set

pub(all) struct PhysicsfluidlevelsetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_level_set_make_point(x : Double, y : Double) -> PhysicsfluidlevelsetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_level_set_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidlevelsetPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidlevelsetPoint::x(self : PhysicsfluidlevelsetPoint) -> Double { self.x }

pub fn PhysicsfluidlevelsetPoint::y(self : PhysicsfluidlevelsetPoint) -> Double { self.y }

pub fn PhysicsfluidlevelsetPoint::z(self : PhysicsfluidlevelsetPoint) -> Double { self.z }

pub fn PhysicsfluidlevelsetPoint::label(self : PhysicsfluidlevelsetPoint) -> Int { self.label }

pub fn PhysicsfluidlevelsetPoint::dist(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidlevelsetPoint::add(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidlevelsetPoint::sub(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidlevelsetPoint::scale(self : PhysicsfluidlevelsetPoint, s : Double) -> PhysicsfluidlevelsetPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidlevelsetPoint::dot(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidlevelsetPoint::cross(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidlevelsetPoint::norm(self : PhysicsfluidlevelsetPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidlevelsetPoint::normalize(self : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidlevelsetPoint::negate(self : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidlevelsetPoint::mid(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidlevelsetPoint::lerp(self : PhysicsfluidlevelsetPoint, other : PhysicsfluidlevelsetPoint, t : Double) -> PhysicsfluidlevelsetPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidlevelsetPoint::to_string(self : PhysicsfluidlevelsetPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_level_set_make_series(vals : Array[Double], name : String) -> PhysicsfluidlevelsetSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidlevelsetSeries::len(self : PhysicsfluidlevelsetSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidlevelsetSeries::sum(self : PhysicsfluidlevelsetSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidlevelsetSeries::mean(self : PhysicsfluidlevelsetSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidlevelsetSeries::min(self : PhysicsfluidlevelsetSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidlevelsetSeries::max(self : PhysicsfluidlevelsetSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidlevelsetSeries::range(self : PhysicsfluidlevelsetSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidlevelsetSeries::variance(self : PhysicsfluidlevelsetSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidlevelsetSeries::std(self : PhysicsfluidlevelsetSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidlevelsetSeries::median(self : PhysicsfluidlevelsetSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidlevelsetSeries::scale(self : PhysicsfluidlevelsetSeries, f : Double) -> PhysicsfluidlevelsetSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidlevelsetSeries::add(self : PhysicsfluidlevelsetSeries, other : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidlevelsetSeries::sub(self : PhysicsfluidlevelsetSeries, other : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidlevelsetSeries::normalize(self : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidlevelsetSeries::cumsum(self : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidlevelsetSeries::to_string(self : PhysicsfluidlevelsetSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlevelsetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_level_set_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidlevelsetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_level_set_matrix_identity(n : Int) -> PhysicsfluidlevelsetMatrix {
  let m = physics_fluid_level_set_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidlevelsetMatrix::get(self : PhysicsfluidlevelsetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidlevelsetMatrix::transpose(self : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidlevelsetMatrix::add(self : PhysicsfluidlevelsetMatrix, other : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_level_set_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidlevelsetMatrix::scale(self : PhysicsfluidlevelsetMatrix, s : Double) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidlevelsetMatrix::multiply(self : PhysicsfluidlevelsetMatrix, other : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  if self.cols != other.rows { return physics_fluid_level_set_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_level_set_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidlevelsetMatrix::trace(self : PhysicsfluidlevelsetMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidlevelsetMatrix::det(self : PhysicsfluidlevelsetMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidlevelsetMatrix::norm(self : PhysicsfluidlevelsetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidlevelsetMatrix::to_string(self : PhysicsfluidlevelsetMatrix) -> String {
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

pub(all) struct PhysicsfluidlevelsetVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_level_set_make_vector(comps : Array[Double]) -> PhysicsfluidlevelsetVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_level_set_vector_zero(dim : Int) -> PhysicsfluidlevelsetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidlevelsetVector::add(self : PhysicsfluidlevelsetVector, other : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidlevelsetVector::sub(self : PhysicsfluidlevelsetVector, other : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidlevelsetVector::scale(self : PhysicsfluidlevelsetVector, s : Double) -> PhysicsfluidlevelsetVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidlevelsetVector::dot(self : PhysicsfluidlevelsetVector, other : PhysicsfluidlevelsetVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidlevelsetVector::norm(self : PhysicsfluidlevelsetVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidlevelsetVector::normalize(self : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidlevelsetVector::dist(self : PhysicsfluidlevelsetVector, other : PhysicsfluidlevelsetVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidlevelsetVector::to_string(self : PhysicsfluidlevelsetVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_level_set_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_level_set_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_level_set_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_level_set_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_level_set_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_level_set_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_level_set_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_level_set_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_level_set_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_level_set_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_level_set_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_level_set_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_level_set_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_level_set_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_level_set_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_level_set_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_level_set_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_level_set_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_level_set_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_level_set_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_level_set_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_level_set_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_level_set_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_level_set_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_level_set_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_level_set_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_level_set_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_level_set_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_level_set_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidlevelsetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_frame_make(size : Int) -> PhysicsfluidlevelsetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_frame_len(s : PhysicsfluidlevelsetFrame) -> Int { s.size }

pub fn physics_fluid_level_set_frame_get(s : PhysicsfluidlevelsetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_frame_set(s : PhysicsfluidlevelsetFrame, i : Int, v : Double) -> PhysicsfluidlevelsetFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_sum(s : PhysicsfluidlevelsetFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_frame_mean(s : PhysicsfluidlevelsetFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_frame_scale(s : PhysicsfluidlevelsetFrame, f : Double) -> PhysicsfluidlevelsetFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_add(a : PhysicsfluidlevelsetFrame, b : PhysicsfluidlevelsetFrame) -> PhysicsfluidlevelsetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_frame_copy(s : PhysicsfluidlevelsetFrame) -> PhysicsfluidlevelsetFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_fill(s : PhysicsfluidlevelsetFrame, v : Double) -> PhysicsfluidlevelsetFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_min(s : PhysicsfluidlevelsetFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_frame_max(s : PhysicsfluidlevelsetFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_frame_to_string(s : PhysicsfluidlevelsetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_table_make(size : Int) -> PhysicsfluidlevelsetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_table_len(s : PhysicsfluidlevelsetTable) -> Int { s.size }

pub fn physics_fluid_level_set_table_get(s : PhysicsfluidlevelsetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_table_set(s : PhysicsfluidlevelsetTable, i : Int, v : Double) -> PhysicsfluidlevelsetTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_sum(s : PhysicsfluidlevelsetTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_table_mean(s : PhysicsfluidlevelsetTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_table_scale(s : PhysicsfluidlevelsetTable, f : Double) -> PhysicsfluidlevelsetTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_add(a : PhysicsfluidlevelsetTable, b : PhysicsfluidlevelsetTable) -> PhysicsfluidlevelsetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_table_copy(s : PhysicsfluidlevelsetTable) -> PhysicsfluidlevelsetTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_fill(s : PhysicsfluidlevelsetTable, v : Double) -> PhysicsfluidlevelsetTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_min(s : PhysicsfluidlevelsetTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_table_max(s : PhysicsfluidlevelsetTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_table_to_string(s : PhysicsfluidlevelsetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_graphn_make(size : Int) -> PhysicsfluidlevelsetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_graphn_len(s : PhysicsfluidlevelsetGraphN) -> Int { s.size }

pub fn physics_fluid_level_set_graphn_get(s : PhysicsfluidlevelsetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_graphn_set(s : PhysicsfluidlevelsetGraphN, i : Int, v : Double) -> PhysicsfluidlevelsetGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_sum(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_graphn_mean(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_graphn_scale(s : PhysicsfluidlevelsetGraphN, f : Double) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_add(a : PhysicsfluidlevelsetGraphN, b : PhysicsfluidlevelsetGraphN) -> PhysicsfluidlevelsetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_graphn_copy(s : PhysicsfluidlevelsetGraphN) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_fill(s : PhysicsfluidlevelsetGraphN, v : Double) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_min(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_graphn_max(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_graphn_to_string(s : PhysicsfluidlevelsetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_node_make(size : Int) -> PhysicsfluidlevelsetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_node_len(s : PhysicsfluidlevelsetNode) -> Int { s.size }

pub fn physics_fluid_level_set_node_get(s : PhysicsfluidlevelsetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_node_set(s : PhysicsfluidlevelsetNode, i : Int, v : Double) -> PhysicsfluidlevelsetNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_sum(s : PhysicsfluidlevelsetNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_node_mean(s : PhysicsfluidlevelsetNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_node_scale(s : PhysicsfluidlevelsetNode, f : Double) -> PhysicsfluidlevelsetNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_add(a : PhysicsfluidlevelsetNode, b : PhysicsfluidlevelsetNode) -> PhysicsfluidlevelsetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_node_copy(s : PhysicsfluidlevelsetNode) -> PhysicsfluidlevelsetNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_fill(s : PhysicsfluidlevelsetNode, v : Double) -> PhysicsfluidlevelsetNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_min(s : PhysicsfluidlevelsetNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_node_max(s : PhysicsfluidlevelsetNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_node_to_string(s : PhysicsfluidlevelsetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_edge_make(size : Int) -> PhysicsfluidlevelsetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_edge_len(s : PhysicsfluidlevelsetEdge) -> Int { s.size }

pub fn physics_fluid_level_set_edge_get(s : PhysicsfluidlevelsetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_edge_set(s : PhysicsfluidlevelsetEdge, i : Int, v : Double) -> PhysicsfluidlevelsetEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_sum(s : PhysicsfluidlevelsetEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_edge_mean(s : PhysicsfluidlevelsetEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_edge_scale(s : PhysicsfluidlevelsetEdge, f : Double) -> PhysicsfluidlevelsetEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_add(a : PhysicsfluidlevelsetEdge, b : PhysicsfluidlevelsetEdge) -> PhysicsfluidlevelsetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_edge_copy(s : PhysicsfluidlevelsetEdge) -> PhysicsfluidlevelsetEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_fill(s : PhysicsfluidlevelsetEdge, v : Double) -> PhysicsfluidlevelsetEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_min(s : PhysicsfluidlevelsetEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_edge_max(s : PhysicsfluidlevelsetEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_edge_to_string(s : PhysicsfluidlevelsetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_path_make(size : Int) -> PhysicsfluidlevelsetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_path_len(s : PhysicsfluidlevelsetPath) -> Int { s.size }

pub fn physics_fluid_level_set_path_get(s : PhysicsfluidlevelsetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_path_set(s : PhysicsfluidlevelsetPath, i : Int, v : Double) -> PhysicsfluidlevelsetPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_sum(s : PhysicsfluidlevelsetPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_path_mean(s : PhysicsfluidlevelsetPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_path_scale(s : PhysicsfluidlevelsetPath, f : Double) -> PhysicsfluidlevelsetPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_add(a : PhysicsfluidlevelsetPath, b : PhysicsfluidlevelsetPath) -> PhysicsfluidlevelsetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_path_copy(s : PhysicsfluidlevelsetPath) -> PhysicsfluidlevelsetPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_fill(s : PhysicsfluidlevelsetPath, v : Double) -> PhysicsfluidlevelsetPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_min(s : PhysicsfluidlevelsetPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_path_max(s : PhysicsfluidlevelsetPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_path_to_string(s : PhysicsfluidlevelsetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_cluster_make(size : Int) -> PhysicsfluidlevelsetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_cluster_len(s : PhysicsfluidlevelsetCluster) -> Int { s.size }

pub fn physics_fluid_level_set_cluster_get(s : PhysicsfluidlevelsetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_cluster_set(s : PhysicsfluidlevelsetCluster, i : Int, v : Double) -> PhysicsfluidlevelsetCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_sum(s : PhysicsfluidlevelsetCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_cluster_mean(s : PhysicsfluidlevelsetCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_cluster_scale(s : PhysicsfluidlevelsetCluster, f : Double) -> PhysicsfluidlevelsetCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_add(a : PhysicsfluidlevelsetCluster, b : PhysicsfluidlevelsetCluster) -> PhysicsfluidlevelsetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_cluster_copy(s : PhysicsfluidlevelsetCluster) -> PhysicsfluidlevelsetCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_fill(s : PhysicsfluidlevelsetCluster, v : Double) -> PhysicsfluidlevelsetCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_min(s : PhysicsfluidlevelsetCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_cluster_max(s : PhysicsfluidlevelsetCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_cluster_to_string(s : PhysicsfluidlevelsetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_model_make(size : Int) -> PhysicsfluidlevelsetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_model_len(s : PhysicsfluidlevelsetModel) -> Int { s.size }

pub fn physics_fluid_level_set_model_get(s : PhysicsfluidlevelsetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_model_set(s : PhysicsfluidlevelsetModel, i : Int, v : Double) -> PhysicsfluidlevelsetModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_sum(s : PhysicsfluidlevelsetModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_model_mean(s : PhysicsfluidlevelsetModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_model_scale(s : PhysicsfluidlevelsetModel, f : Double) -> PhysicsfluidlevelsetModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_add(a : PhysicsfluidlevelsetModel, b : PhysicsfluidlevelsetModel) -> PhysicsfluidlevelsetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_model_copy(s : PhysicsfluidlevelsetModel) -> PhysicsfluidlevelsetModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_fill(s : PhysicsfluidlevelsetModel, v : Double) -> PhysicsfluidlevelsetModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_min(s : PhysicsfluidlevelsetModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_model_max(s : PhysicsfluidlevelsetModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_model_to_string(s : PhysicsfluidlevelsetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_layer_make(size : Int) -> PhysicsfluidlevelsetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_layer_len(s : PhysicsfluidlevelsetLayer) -> Int { s.size }

pub fn physics_fluid_level_set_layer_get(s : PhysicsfluidlevelsetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_layer_set(s : PhysicsfluidlevelsetLayer, i : Int, v : Double) -> PhysicsfluidlevelsetLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_sum(s : PhysicsfluidlevelsetLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_layer_mean(s : PhysicsfluidlevelsetLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_layer_scale(s : PhysicsfluidlevelsetLayer, f : Double) -> PhysicsfluidlevelsetLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_add(a : PhysicsfluidlevelsetLayer, b : PhysicsfluidlevelsetLayer) -> PhysicsfluidlevelsetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_layer_copy(s : PhysicsfluidlevelsetLayer) -> PhysicsfluidlevelsetLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_fill(s : PhysicsfluidlevelsetLayer, v : Double) -> PhysicsfluidlevelsetLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_min(s : PhysicsfluidlevelsetLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_layer_max(s : PhysicsfluidlevelsetLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_layer_to_string(s : PhysicsfluidlevelsetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_buffer_make(size : Int) -> PhysicsfluidlevelsetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_buffer_len(s : PhysicsfluidlevelsetBuffer) -> Int { s.size }

pub fn physics_fluid_level_set_buffer_get(s : PhysicsfluidlevelsetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_buffer_set(s : PhysicsfluidlevelsetBuffer, i : Int, v : Double) -> PhysicsfluidlevelsetBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_sum(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_buffer_mean(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_buffer_scale(s : PhysicsfluidlevelsetBuffer, f : Double) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_add(a : PhysicsfluidlevelsetBuffer, b : PhysicsfluidlevelsetBuffer) -> PhysicsfluidlevelsetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_buffer_copy(s : PhysicsfluidlevelsetBuffer) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_fill(s : PhysicsfluidlevelsetBuffer, v : Double) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_min(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_buffer_max(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_buffer_to_string(s : PhysicsfluidlevelsetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_cursor_make(size : Int) -> PhysicsfluidlevelsetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_cursor_len(s : PhysicsfluidlevelsetCursor) -> Int { s.size }

pub fn physics_fluid_level_set_cursor_get(s : PhysicsfluidlevelsetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_cursor_set(s : PhysicsfluidlevelsetCursor, i : Int, v : Double) -> PhysicsfluidlevelsetCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_sum(s : PhysicsfluidlevelsetCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_cursor_mean(s : PhysicsfluidlevelsetCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_cursor_scale(s : PhysicsfluidlevelsetCursor, f : Double) -> PhysicsfluidlevelsetCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_add(a : PhysicsfluidlevelsetCursor, b : PhysicsfluidlevelsetCursor) -> PhysicsfluidlevelsetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_cursor_copy(s : PhysicsfluidlevelsetCursor) -> PhysicsfluidlevelsetCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_fill(s : PhysicsfluidlevelsetCursor, v : Double) -> PhysicsfluidlevelsetCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_min(s : PhysicsfluidlevelsetCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_cursor_max(s : PhysicsfluidlevelsetCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_cursor_to_string(s : PhysicsfluidlevelsetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_view_make(size : Int) -> PhysicsfluidlevelsetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_view_len(s : PhysicsfluidlevelsetView) -> Int { s.size }

pub fn physics_fluid_level_set_view_get(s : PhysicsfluidlevelsetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_view_set(s : PhysicsfluidlevelsetView, i : Int, v : Double) -> PhysicsfluidlevelsetView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_sum(s : PhysicsfluidlevelsetView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_view_mean(s : PhysicsfluidlevelsetView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_view_scale(s : PhysicsfluidlevelsetView, f : Double) -> PhysicsfluidlevelsetView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_add(a : PhysicsfluidlevelsetView, b : PhysicsfluidlevelsetView) -> PhysicsfluidlevelsetView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_view_copy(s : PhysicsfluidlevelsetView) -> PhysicsfluidlevelsetView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_fill(s : PhysicsfluidlevelsetView, v : Double) -> PhysicsfluidlevelsetView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_min(s : PhysicsfluidlevelsetView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_view_max(s : PhysicsfluidlevelsetView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_view_to_string(s : PhysicsfluidlevelsetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_range_make(size : Int) -> PhysicsfluidlevelsetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_range_len(s : PhysicsfluidlevelsetRange) -> Int { s.size }

pub fn physics_fluid_level_set_range_get(s : PhysicsfluidlevelsetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_range_set(s : PhysicsfluidlevelsetRange, i : Int, v : Double) -> PhysicsfluidlevelsetRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_sum(s : PhysicsfluidlevelsetRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_range_mean(s : PhysicsfluidlevelsetRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_range_scale(s : PhysicsfluidlevelsetRange, f : Double) -> PhysicsfluidlevelsetRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_add(a : PhysicsfluidlevelsetRange, b : PhysicsfluidlevelsetRange) -> PhysicsfluidlevelsetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_range_copy(s : PhysicsfluidlevelsetRange) -> PhysicsfluidlevelsetRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_fill(s : PhysicsfluidlevelsetRange, v : Double) -> PhysicsfluidlevelsetRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_min(s : PhysicsfluidlevelsetRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_range_max(s : PhysicsfluidlevelsetRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_range_to_string(s : PhysicsfluidlevelsetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_slice_make(size : Int) -> PhysicsfluidlevelsetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_slice_len(s : PhysicsfluidlevelsetSlice) -> Int { s.size }

pub fn physics_fluid_level_set_slice_get(s : PhysicsfluidlevelsetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_slice_set(s : PhysicsfluidlevelsetSlice, i : Int, v : Double) -> PhysicsfluidlevelsetSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_sum(s : PhysicsfluidlevelsetSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_slice_mean(s : PhysicsfluidlevelsetSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_slice_scale(s : PhysicsfluidlevelsetSlice, f : Double) -> PhysicsfluidlevelsetSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_add(a : PhysicsfluidlevelsetSlice, b : PhysicsfluidlevelsetSlice) -> PhysicsfluidlevelsetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_slice_copy(s : PhysicsfluidlevelsetSlice) -> PhysicsfluidlevelsetSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_fill(s : PhysicsfluidlevelsetSlice, v : Double) -> PhysicsfluidlevelsetSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_min(s : PhysicsfluidlevelsetSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_slice_max(s : PhysicsfluidlevelsetSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_slice_to_string(s : PhysicsfluidlevelsetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

