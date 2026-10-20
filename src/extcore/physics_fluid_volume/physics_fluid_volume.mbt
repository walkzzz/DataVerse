///===
/// extcore/physics_fluid_volume

pub(all) struct PhysicsfluidvolumePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_volume_make_point(x : Double, y : Double) -> PhysicsfluidvolumePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_volume_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidvolumePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidvolumePoint::x(self : PhysicsfluidvolumePoint) -> Double { self.x }

pub fn PhysicsfluidvolumePoint::y(self : PhysicsfluidvolumePoint) -> Double { self.y }

pub fn PhysicsfluidvolumePoint::z(self : PhysicsfluidvolumePoint) -> Double { self.z }

pub fn PhysicsfluidvolumePoint::label(self : PhysicsfluidvolumePoint) -> Int { self.label }

pub fn PhysicsfluidvolumePoint::dist(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidvolumePoint::add(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidvolumePoint::sub(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidvolumePoint::scale(self : PhysicsfluidvolumePoint, s : Double) -> PhysicsfluidvolumePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidvolumePoint::dot(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidvolumePoint::cross(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidvolumePoint::norm(self : PhysicsfluidvolumePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidvolumePoint::normalize(self : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidvolumePoint::negate(self : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidvolumePoint::mid(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidvolumePoint::lerp(self : PhysicsfluidvolumePoint, other : PhysicsfluidvolumePoint, t : Double) -> PhysicsfluidvolumePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidvolumePoint::to_string(self : PhysicsfluidvolumePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_volume_make_series(vals : Array[Double], name : String) -> PhysicsfluidvolumeSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidvolumeSeries::len(self : PhysicsfluidvolumeSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidvolumeSeries::sum(self : PhysicsfluidvolumeSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidvolumeSeries::mean(self : PhysicsfluidvolumeSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidvolumeSeries::min(self : PhysicsfluidvolumeSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidvolumeSeries::max(self : PhysicsfluidvolumeSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidvolumeSeries::range(self : PhysicsfluidvolumeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidvolumeSeries::variance(self : PhysicsfluidvolumeSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidvolumeSeries::std(self : PhysicsfluidvolumeSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidvolumeSeries::median(self : PhysicsfluidvolumeSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidvolumeSeries::scale(self : PhysicsfluidvolumeSeries, f : Double) -> PhysicsfluidvolumeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::add(self : PhysicsfluidvolumeSeries, other : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::sub(self : PhysicsfluidvolumeSeries, other : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::normalize(self : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidvolumeSeries::cumsum(self : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidvolumeSeries::to_string(self : PhysicsfluidvolumeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvolumeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_volume_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidvolumeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_volume_matrix_identity(n : Int) -> PhysicsfluidvolumeMatrix {
  let m = physics_fluid_volume_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidvolumeMatrix::get(self : PhysicsfluidvolumeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidvolumeMatrix::transpose(self : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  let result = physics_fluid_volume_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidvolumeMatrix::add(self : PhysicsfluidvolumeMatrix, other : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidvolumeMatrix::scale(self : PhysicsfluidvolumeMatrix, s : Double) -> PhysicsfluidvolumeMatrix {
  let result = physics_fluid_volume_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidvolumeMatrix::multiply(self : PhysicsfluidvolumeMatrix, other : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  if self.cols != other.rows { return physics_fluid_volume_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_volume_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidvolumeMatrix::trace(self : PhysicsfluidvolumeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidvolumeMatrix::det(self : PhysicsfluidvolumeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidvolumeMatrix::norm(self : PhysicsfluidvolumeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidvolumeMatrix::to_string(self : PhysicsfluidvolumeMatrix) -> String {
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

pub(all) struct PhysicsfluidvolumeVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_volume_make_vector(comps : Array[Double]) -> PhysicsfluidvolumeVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_volume_vector_zero(dim : Int) -> PhysicsfluidvolumeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidvolumeVector::add(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidvolumeVector::sub(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidvolumeVector::scale(self : PhysicsfluidvolumeVector, s : Double) -> PhysicsfluidvolumeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidvolumeVector::dot(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidvolumeVector::norm(self : PhysicsfluidvolumeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidvolumeVector::normalize(self : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidvolumeVector::dist(self : PhysicsfluidvolumeVector, other : PhysicsfluidvolumeVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidvolumeVector::to_string(self : PhysicsfluidvolumeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_volume_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_volume_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_volume_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_volume_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_volume_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_volume_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_volume_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_volume_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_volume_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_volume_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_volume_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_volume_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_volume_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_volume_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_volume_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_volume_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_volume_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_volume_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_volume_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_volume_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_volume_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_volume_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_volume_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_volume_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_volume_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_volume_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_volume_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_volume_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_volume_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidvolumeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_frame_make(size : Int) -> PhysicsfluidvolumeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_frame_len(s : PhysicsfluidvolumeFrame) -> Int { s.size }

pub fn physics_fluid_volume_frame_get(s : PhysicsfluidvolumeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_frame_set(s : PhysicsfluidvolumeFrame, i : Int, v : Double) -> PhysicsfluidvolumeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_sum(s : PhysicsfluidvolumeFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_frame_mean(s : PhysicsfluidvolumeFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_frame_scale(s : PhysicsfluidvolumeFrame, f : Double) -> PhysicsfluidvolumeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_add(a : PhysicsfluidvolumeFrame, b : PhysicsfluidvolumeFrame) -> PhysicsfluidvolumeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_frame_copy(s : PhysicsfluidvolumeFrame) -> PhysicsfluidvolumeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_fill(s : PhysicsfluidvolumeFrame, v : Double) -> PhysicsfluidvolumeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_min(s : PhysicsfluidvolumeFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_frame_max(s : PhysicsfluidvolumeFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_frame_to_string(s : PhysicsfluidvolumeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_table_make(size : Int) -> PhysicsfluidvolumeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_table_len(s : PhysicsfluidvolumeTable) -> Int { s.size }

pub fn physics_fluid_volume_table_get(s : PhysicsfluidvolumeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_table_set(s : PhysicsfluidvolumeTable, i : Int, v : Double) -> PhysicsfluidvolumeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_sum(s : PhysicsfluidvolumeTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_table_mean(s : PhysicsfluidvolumeTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_table_scale(s : PhysicsfluidvolumeTable, f : Double) -> PhysicsfluidvolumeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_add(a : PhysicsfluidvolumeTable, b : PhysicsfluidvolumeTable) -> PhysicsfluidvolumeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_table_copy(s : PhysicsfluidvolumeTable) -> PhysicsfluidvolumeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_fill(s : PhysicsfluidvolumeTable, v : Double) -> PhysicsfluidvolumeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_min(s : PhysicsfluidvolumeTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_table_max(s : PhysicsfluidvolumeTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_table_to_string(s : PhysicsfluidvolumeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_graphn_make(size : Int) -> PhysicsfluidvolumeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_graphn_len(s : PhysicsfluidvolumeGraphN) -> Int { s.size }

pub fn physics_fluid_volume_graphn_get(s : PhysicsfluidvolumeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_graphn_set(s : PhysicsfluidvolumeGraphN, i : Int, v : Double) -> PhysicsfluidvolumeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_sum(s : PhysicsfluidvolumeGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_graphn_mean(s : PhysicsfluidvolumeGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_graphn_scale(s : PhysicsfluidvolumeGraphN, f : Double) -> PhysicsfluidvolumeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_add(a : PhysicsfluidvolumeGraphN, b : PhysicsfluidvolumeGraphN) -> PhysicsfluidvolumeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_graphn_copy(s : PhysicsfluidvolumeGraphN) -> PhysicsfluidvolumeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_fill(s : PhysicsfluidvolumeGraphN, v : Double) -> PhysicsfluidvolumeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_min(s : PhysicsfluidvolumeGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_graphn_max(s : PhysicsfluidvolumeGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_graphn_to_string(s : PhysicsfluidvolumeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_node_make(size : Int) -> PhysicsfluidvolumeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_node_len(s : PhysicsfluidvolumeNode) -> Int { s.size }

pub fn physics_fluid_volume_node_get(s : PhysicsfluidvolumeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_node_set(s : PhysicsfluidvolumeNode, i : Int, v : Double) -> PhysicsfluidvolumeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_sum(s : PhysicsfluidvolumeNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_node_mean(s : PhysicsfluidvolumeNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_node_scale(s : PhysicsfluidvolumeNode, f : Double) -> PhysicsfluidvolumeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_add(a : PhysicsfluidvolumeNode, b : PhysicsfluidvolumeNode) -> PhysicsfluidvolumeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_node_copy(s : PhysicsfluidvolumeNode) -> PhysicsfluidvolumeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_fill(s : PhysicsfluidvolumeNode, v : Double) -> PhysicsfluidvolumeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_min(s : PhysicsfluidvolumeNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_node_max(s : PhysicsfluidvolumeNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_node_to_string(s : PhysicsfluidvolumeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_edge_make(size : Int) -> PhysicsfluidvolumeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_edge_len(s : PhysicsfluidvolumeEdge) -> Int { s.size }

pub fn physics_fluid_volume_edge_get(s : PhysicsfluidvolumeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_edge_set(s : PhysicsfluidvolumeEdge, i : Int, v : Double) -> PhysicsfluidvolumeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_sum(s : PhysicsfluidvolumeEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_edge_mean(s : PhysicsfluidvolumeEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_edge_scale(s : PhysicsfluidvolumeEdge, f : Double) -> PhysicsfluidvolumeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_add(a : PhysicsfluidvolumeEdge, b : PhysicsfluidvolumeEdge) -> PhysicsfluidvolumeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_edge_copy(s : PhysicsfluidvolumeEdge) -> PhysicsfluidvolumeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_fill(s : PhysicsfluidvolumeEdge, v : Double) -> PhysicsfluidvolumeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_min(s : PhysicsfluidvolumeEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_edge_max(s : PhysicsfluidvolumeEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_edge_to_string(s : PhysicsfluidvolumeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_path_make(size : Int) -> PhysicsfluidvolumePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_path_len(s : PhysicsfluidvolumePath) -> Int { s.size }

pub fn physics_fluid_volume_path_get(s : PhysicsfluidvolumePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_path_set(s : PhysicsfluidvolumePath, i : Int, v : Double) -> PhysicsfluidvolumePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_sum(s : PhysicsfluidvolumePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_path_mean(s : PhysicsfluidvolumePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_path_scale(s : PhysicsfluidvolumePath, f : Double) -> PhysicsfluidvolumePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_add(a : PhysicsfluidvolumePath, b : PhysicsfluidvolumePath) -> PhysicsfluidvolumePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_path_copy(s : PhysicsfluidvolumePath) -> PhysicsfluidvolumePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_fill(s : PhysicsfluidvolumePath, v : Double) -> PhysicsfluidvolumePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_min(s : PhysicsfluidvolumePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_path_max(s : PhysicsfluidvolumePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_path_to_string(s : PhysicsfluidvolumePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_cluster_make(size : Int) -> PhysicsfluidvolumeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_cluster_len(s : PhysicsfluidvolumeCluster) -> Int { s.size }

pub fn physics_fluid_volume_cluster_get(s : PhysicsfluidvolumeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_cluster_set(s : PhysicsfluidvolumeCluster, i : Int, v : Double) -> PhysicsfluidvolumeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_sum(s : PhysicsfluidvolumeCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_cluster_mean(s : PhysicsfluidvolumeCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_cluster_scale(s : PhysicsfluidvolumeCluster, f : Double) -> PhysicsfluidvolumeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_add(a : PhysicsfluidvolumeCluster, b : PhysicsfluidvolumeCluster) -> PhysicsfluidvolumeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_cluster_copy(s : PhysicsfluidvolumeCluster) -> PhysicsfluidvolumeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_fill(s : PhysicsfluidvolumeCluster, v : Double) -> PhysicsfluidvolumeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_min(s : PhysicsfluidvolumeCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_cluster_max(s : PhysicsfluidvolumeCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_cluster_to_string(s : PhysicsfluidvolumeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_model_make(size : Int) -> PhysicsfluidvolumeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_model_len(s : PhysicsfluidvolumeModel) -> Int { s.size }

pub fn physics_fluid_volume_model_get(s : PhysicsfluidvolumeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_model_set(s : PhysicsfluidvolumeModel, i : Int, v : Double) -> PhysicsfluidvolumeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_sum(s : PhysicsfluidvolumeModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_model_mean(s : PhysicsfluidvolumeModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_model_scale(s : PhysicsfluidvolumeModel, f : Double) -> PhysicsfluidvolumeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_add(a : PhysicsfluidvolumeModel, b : PhysicsfluidvolumeModel) -> PhysicsfluidvolumeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_model_copy(s : PhysicsfluidvolumeModel) -> PhysicsfluidvolumeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_fill(s : PhysicsfluidvolumeModel, v : Double) -> PhysicsfluidvolumeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_min(s : PhysicsfluidvolumeModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_model_max(s : PhysicsfluidvolumeModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_model_to_string(s : PhysicsfluidvolumeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_layer_make(size : Int) -> PhysicsfluidvolumeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_layer_len(s : PhysicsfluidvolumeLayer) -> Int { s.size }

pub fn physics_fluid_volume_layer_get(s : PhysicsfluidvolumeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_layer_set(s : PhysicsfluidvolumeLayer, i : Int, v : Double) -> PhysicsfluidvolumeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_sum(s : PhysicsfluidvolumeLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_layer_mean(s : PhysicsfluidvolumeLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_layer_scale(s : PhysicsfluidvolumeLayer, f : Double) -> PhysicsfluidvolumeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_add(a : PhysicsfluidvolumeLayer, b : PhysicsfluidvolumeLayer) -> PhysicsfluidvolumeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_layer_copy(s : PhysicsfluidvolumeLayer) -> PhysicsfluidvolumeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_fill(s : PhysicsfluidvolumeLayer, v : Double) -> PhysicsfluidvolumeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_min(s : PhysicsfluidvolumeLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_layer_max(s : PhysicsfluidvolumeLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_layer_to_string(s : PhysicsfluidvolumeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_buffer_make(size : Int) -> PhysicsfluidvolumeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_buffer_len(s : PhysicsfluidvolumeBuffer) -> Int { s.size }

pub fn physics_fluid_volume_buffer_get(s : PhysicsfluidvolumeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_buffer_set(s : PhysicsfluidvolumeBuffer, i : Int, v : Double) -> PhysicsfluidvolumeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_sum(s : PhysicsfluidvolumeBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_buffer_mean(s : PhysicsfluidvolumeBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_buffer_scale(s : PhysicsfluidvolumeBuffer, f : Double) -> PhysicsfluidvolumeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_add(a : PhysicsfluidvolumeBuffer, b : PhysicsfluidvolumeBuffer) -> PhysicsfluidvolumeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_buffer_copy(s : PhysicsfluidvolumeBuffer) -> PhysicsfluidvolumeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_fill(s : PhysicsfluidvolumeBuffer, v : Double) -> PhysicsfluidvolumeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_min(s : PhysicsfluidvolumeBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_buffer_max(s : PhysicsfluidvolumeBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_buffer_to_string(s : PhysicsfluidvolumeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_cursor_make(size : Int) -> PhysicsfluidvolumeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_cursor_len(s : PhysicsfluidvolumeCursor) -> Int { s.size }

pub fn physics_fluid_volume_cursor_get(s : PhysicsfluidvolumeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_cursor_set(s : PhysicsfluidvolumeCursor, i : Int, v : Double) -> PhysicsfluidvolumeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_sum(s : PhysicsfluidvolumeCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_cursor_mean(s : PhysicsfluidvolumeCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_cursor_scale(s : PhysicsfluidvolumeCursor, f : Double) -> PhysicsfluidvolumeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_add(a : PhysicsfluidvolumeCursor, b : PhysicsfluidvolumeCursor) -> PhysicsfluidvolumeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_cursor_copy(s : PhysicsfluidvolumeCursor) -> PhysicsfluidvolumeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_fill(s : PhysicsfluidvolumeCursor, v : Double) -> PhysicsfluidvolumeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_min(s : PhysicsfluidvolumeCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_cursor_max(s : PhysicsfluidvolumeCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_cursor_to_string(s : PhysicsfluidvolumeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_view_make(size : Int) -> PhysicsfluidvolumeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_view_len(s : PhysicsfluidvolumeView) -> Int { s.size }

pub fn physics_fluid_volume_view_get(s : PhysicsfluidvolumeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_view_set(s : PhysicsfluidvolumeView, i : Int, v : Double) -> PhysicsfluidvolumeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_sum(s : PhysicsfluidvolumeView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_view_mean(s : PhysicsfluidvolumeView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_view_scale(s : PhysicsfluidvolumeView, f : Double) -> PhysicsfluidvolumeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_add(a : PhysicsfluidvolumeView, b : PhysicsfluidvolumeView) -> PhysicsfluidvolumeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_view_copy(s : PhysicsfluidvolumeView) -> PhysicsfluidvolumeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_fill(s : PhysicsfluidvolumeView, v : Double) -> PhysicsfluidvolumeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_min(s : PhysicsfluidvolumeView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_view_max(s : PhysicsfluidvolumeView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_view_to_string(s : PhysicsfluidvolumeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_range_make(size : Int) -> PhysicsfluidvolumeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_range_len(s : PhysicsfluidvolumeRange) -> Int { s.size }

pub fn physics_fluid_volume_range_get(s : PhysicsfluidvolumeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_range_set(s : PhysicsfluidvolumeRange, i : Int, v : Double) -> PhysicsfluidvolumeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_sum(s : PhysicsfluidvolumeRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_range_mean(s : PhysicsfluidvolumeRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_range_scale(s : PhysicsfluidvolumeRange, f : Double) -> PhysicsfluidvolumeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_add(a : PhysicsfluidvolumeRange, b : PhysicsfluidvolumeRange) -> PhysicsfluidvolumeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_range_copy(s : PhysicsfluidvolumeRange) -> PhysicsfluidvolumeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_fill(s : PhysicsfluidvolumeRange, v : Double) -> PhysicsfluidvolumeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_min(s : PhysicsfluidvolumeRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_range_max(s : PhysicsfluidvolumeRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_range_to_string(s : PhysicsfluidvolumeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_slice_make(size : Int) -> PhysicsfluidvolumeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_slice_len(s : PhysicsfluidvolumeSlice) -> Int { s.size }

pub fn physics_fluid_volume_slice_get(s : PhysicsfluidvolumeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_slice_set(s : PhysicsfluidvolumeSlice, i : Int, v : Double) -> PhysicsfluidvolumeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_sum(s : PhysicsfluidvolumeSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_slice_mean(s : PhysicsfluidvolumeSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_slice_scale(s : PhysicsfluidvolumeSlice, f : Double) -> PhysicsfluidvolumeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_add(a : PhysicsfluidvolumeSlice, b : PhysicsfluidvolumeSlice) -> PhysicsfluidvolumeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_slice_copy(s : PhysicsfluidvolumeSlice) -> PhysicsfluidvolumeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_fill(s : PhysicsfluidvolumeSlice, v : Double) -> PhysicsfluidvolumeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_min(s : PhysicsfluidvolumeSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_slice_max(s : PhysicsfluidvolumeSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_slice_to_string(s : PhysicsfluidvolumeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

