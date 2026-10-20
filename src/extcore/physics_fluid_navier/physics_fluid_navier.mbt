///===
/// extcore/physics_fluid_navier

pub(all) struct PhysicsfluidnavierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_navier_make_point(x : Double, y : Double) -> PhysicsfluidnavierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_navier_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidnavierPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidnavierPoint::x(self : PhysicsfluidnavierPoint) -> Double { self.x }

pub fn PhysicsfluidnavierPoint::y(self : PhysicsfluidnavierPoint) -> Double { self.y }

pub fn PhysicsfluidnavierPoint::z(self : PhysicsfluidnavierPoint) -> Double { self.z }

pub fn PhysicsfluidnavierPoint::label(self : PhysicsfluidnavierPoint) -> Int { self.label }

pub fn PhysicsfluidnavierPoint::dist(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidnavierPoint::add(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidnavierPoint::sub(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidnavierPoint::scale(self : PhysicsfluidnavierPoint, s : Double) -> PhysicsfluidnavierPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidnavierPoint::dot(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidnavierPoint::cross(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidnavierPoint::norm(self : PhysicsfluidnavierPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidnavierPoint::normalize(self : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidnavierPoint::negate(self : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidnavierPoint::mid(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidnavierPoint::lerp(self : PhysicsfluidnavierPoint, other : PhysicsfluidnavierPoint, t : Double) -> PhysicsfluidnavierPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidnavierPoint::to_string(self : PhysicsfluidnavierPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_navier_make_series(vals : Array[Double], name : String) -> PhysicsfluidnavierSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidnavierSeries::len(self : PhysicsfluidnavierSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidnavierSeries::sum(self : PhysicsfluidnavierSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidnavierSeries::mean(self : PhysicsfluidnavierSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidnavierSeries::min(self : PhysicsfluidnavierSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidnavierSeries::max(self : PhysicsfluidnavierSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidnavierSeries::range(self : PhysicsfluidnavierSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidnavierSeries::variance(self : PhysicsfluidnavierSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidnavierSeries::std(self : PhysicsfluidnavierSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidnavierSeries::median(self : PhysicsfluidnavierSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidnavierSeries::scale(self : PhysicsfluidnavierSeries, f : Double) -> PhysicsfluidnavierSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidnavierSeries::add(self : PhysicsfluidnavierSeries, other : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidnavierSeries::sub(self : PhysicsfluidnavierSeries, other : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidnavierSeries::normalize(self : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidnavierSeries::cumsum(self : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidnavierSeries::to_string(self : PhysicsfluidnavierSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidnavierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_navier_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidnavierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_navier_matrix_identity(n : Int) -> PhysicsfluidnavierMatrix {
  let m = physics_fluid_navier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidnavierMatrix::get(self : PhysicsfluidnavierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidnavierMatrix::transpose(self : PhysicsfluidnavierMatrix) -> PhysicsfluidnavierMatrix {
  let result = physics_fluid_navier_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidnavierMatrix::add(self : PhysicsfluidnavierMatrix, other : PhysicsfluidnavierMatrix) -> PhysicsfluidnavierMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_navier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidnavierMatrix::scale(self : PhysicsfluidnavierMatrix, s : Double) -> PhysicsfluidnavierMatrix {
  let result = physics_fluid_navier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidnavierMatrix::multiply(self : PhysicsfluidnavierMatrix, other : PhysicsfluidnavierMatrix) -> PhysicsfluidnavierMatrix {
  if self.cols != other.rows { return physics_fluid_navier_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_navier_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidnavierMatrix::trace(self : PhysicsfluidnavierMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidnavierMatrix::det(self : PhysicsfluidnavierMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidnavierMatrix::norm(self : PhysicsfluidnavierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidnavierMatrix::to_string(self : PhysicsfluidnavierMatrix) -> String {
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

pub(all) struct PhysicsfluidnavierVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_navier_make_vector(comps : Array[Double]) -> PhysicsfluidnavierVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_navier_vector_zero(dim : Int) -> PhysicsfluidnavierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidnavierVector::add(self : PhysicsfluidnavierVector, other : PhysicsfluidnavierVector) -> PhysicsfluidnavierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidnavierVector::sub(self : PhysicsfluidnavierVector, other : PhysicsfluidnavierVector) -> PhysicsfluidnavierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidnavierVector::scale(self : PhysicsfluidnavierVector, s : Double) -> PhysicsfluidnavierVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidnavierVector::dot(self : PhysicsfluidnavierVector, other : PhysicsfluidnavierVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidnavierVector::norm(self : PhysicsfluidnavierVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidnavierVector::normalize(self : PhysicsfluidnavierVector) -> PhysicsfluidnavierVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidnavierVector::dist(self : PhysicsfluidnavierVector, other : PhysicsfluidnavierVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidnavierVector::to_string(self : PhysicsfluidnavierVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_navier_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_navier_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_navier_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_navier_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_navier_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_navier_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_navier_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_navier_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_navier_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_navier_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_navier_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_navier_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_navier_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_navier_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_navier_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_navier_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_navier_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_navier_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_navier_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_navier_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_navier_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_navier_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_navier_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_navier_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_navier_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_navier_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_navier_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_navier_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_navier_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidnavierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_frame_make(size : Int) -> PhysicsfluidnavierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_frame_len(s : PhysicsfluidnavierFrame) -> Int { s.size }

pub fn physics_fluid_navier_frame_get(s : PhysicsfluidnavierFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_frame_set(s : PhysicsfluidnavierFrame, i : Int, v : Double) -> PhysicsfluidnavierFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_frame_sum(s : PhysicsfluidnavierFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_frame_mean(s : PhysicsfluidnavierFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_frame_scale(s : PhysicsfluidnavierFrame, f : Double) -> PhysicsfluidnavierFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_frame_add(a : PhysicsfluidnavierFrame, b : PhysicsfluidnavierFrame) -> PhysicsfluidnavierFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_frame_copy(s : PhysicsfluidnavierFrame) -> PhysicsfluidnavierFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_frame_fill(s : PhysicsfluidnavierFrame, v : Double) -> PhysicsfluidnavierFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_frame_min(s : PhysicsfluidnavierFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_frame_max(s : PhysicsfluidnavierFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_frame_to_string(s : PhysicsfluidnavierFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_table_make(size : Int) -> PhysicsfluidnavierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_table_len(s : PhysicsfluidnavierTable) -> Int { s.size }

pub fn physics_fluid_navier_table_get(s : PhysicsfluidnavierTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_table_set(s : PhysicsfluidnavierTable, i : Int, v : Double) -> PhysicsfluidnavierTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_table_sum(s : PhysicsfluidnavierTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_table_mean(s : PhysicsfluidnavierTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_table_scale(s : PhysicsfluidnavierTable, f : Double) -> PhysicsfluidnavierTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_table_add(a : PhysicsfluidnavierTable, b : PhysicsfluidnavierTable) -> PhysicsfluidnavierTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_table_copy(s : PhysicsfluidnavierTable) -> PhysicsfluidnavierTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_table_fill(s : PhysicsfluidnavierTable, v : Double) -> PhysicsfluidnavierTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_table_min(s : PhysicsfluidnavierTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_table_max(s : PhysicsfluidnavierTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_table_to_string(s : PhysicsfluidnavierTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_graphn_make(size : Int) -> PhysicsfluidnavierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_graphn_len(s : PhysicsfluidnavierGraphN) -> Int { s.size }

pub fn physics_fluid_navier_graphn_get(s : PhysicsfluidnavierGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_graphn_set(s : PhysicsfluidnavierGraphN, i : Int, v : Double) -> PhysicsfluidnavierGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_graphn_sum(s : PhysicsfluidnavierGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_graphn_mean(s : PhysicsfluidnavierGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_graphn_scale(s : PhysicsfluidnavierGraphN, f : Double) -> PhysicsfluidnavierGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_graphn_add(a : PhysicsfluidnavierGraphN, b : PhysicsfluidnavierGraphN) -> PhysicsfluidnavierGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_graphn_copy(s : PhysicsfluidnavierGraphN) -> PhysicsfluidnavierGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_graphn_fill(s : PhysicsfluidnavierGraphN, v : Double) -> PhysicsfluidnavierGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_graphn_min(s : PhysicsfluidnavierGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_graphn_max(s : PhysicsfluidnavierGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_graphn_to_string(s : PhysicsfluidnavierGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_node_make(size : Int) -> PhysicsfluidnavierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_node_len(s : PhysicsfluidnavierNode) -> Int { s.size }

pub fn physics_fluid_navier_node_get(s : PhysicsfluidnavierNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_node_set(s : PhysicsfluidnavierNode, i : Int, v : Double) -> PhysicsfluidnavierNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_node_sum(s : PhysicsfluidnavierNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_node_mean(s : PhysicsfluidnavierNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_node_scale(s : PhysicsfluidnavierNode, f : Double) -> PhysicsfluidnavierNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_node_add(a : PhysicsfluidnavierNode, b : PhysicsfluidnavierNode) -> PhysicsfluidnavierNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_node_copy(s : PhysicsfluidnavierNode) -> PhysicsfluidnavierNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_node_fill(s : PhysicsfluidnavierNode, v : Double) -> PhysicsfluidnavierNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_node_min(s : PhysicsfluidnavierNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_node_max(s : PhysicsfluidnavierNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_node_to_string(s : PhysicsfluidnavierNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_edge_make(size : Int) -> PhysicsfluidnavierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_edge_len(s : PhysicsfluidnavierEdge) -> Int { s.size }

pub fn physics_fluid_navier_edge_get(s : PhysicsfluidnavierEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_edge_set(s : PhysicsfluidnavierEdge, i : Int, v : Double) -> PhysicsfluidnavierEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_edge_sum(s : PhysicsfluidnavierEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_edge_mean(s : PhysicsfluidnavierEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_edge_scale(s : PhysicsfluidnavierEdge, f : Double) -> PhysicsfluidnavierEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_edge_add(a : PhysicsfluidnavierEdge, b : PhysicsfluidnavierEdge) -> PhysicsfluidnavierEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_edge_copy(s : PhysicsfluidnavierEdge) -> PhysicsfluidnavierEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_edge_fill(s : PhysicsfluidnavierEdge, v : Double) -> PhysicsfluidnavierEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_edge_min(s : PhysicsfluidnavierEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_edge_max(s : PhysicsfluidnavierEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_edge_to_string(s : PhysicsfluidnavierEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_path_make(size : Int) -> PhysicsfluidnavierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_path_len(s : PhysicsfluidnavierPath) -> Int { s.size }

pub fn physics_fluid_navier_path_get(s : PhysicsfluidnavierPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_path_set(s : PhysicsfluidnavierPath, i : Int, v : Double) -> PhysicsfluidnavierPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_path_sum(s : PhysicsfluidnavierPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_path_mean(s : PhysicsfluidnavierPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_path_scale(s : PhysicsfluidnavierPath, f : Double) -> PhysicsfluidnavierPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_path_add(a : PhysicsfluidnavierPath, b : PhysicsfluidnavierPath) -> PhysicsfluidnavierPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_path_copy(s : PhysicsfluidnavierPath) -> PhysicsfluidnavierPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_path_fill(s : PhysicsfluidnavierPath, v : Double) -> PhysicsfluidnavierPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_path_min(s : PhysicsfluidnavierPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_path_max(s : PhysicsfluidnavierPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_path_to_string(s : PhysicsfluidnavierPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_cluster_make(size : Int) -> PhysicsfluidnavierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_cluster_len(s : PhysicsfluidnavierCluster) -> Int { s.size }

pub fn physics_fluid_navier_cluster_get(s : PhysicsfluidnavierCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_cluster_set(s : PhysicsfluidnavierCluster, i : Int, v : Double) -> PhysicsfluidnavierCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cluster_sum(s : PhysicsfluidnavierCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_cluster_mean(s : PhysicsfluidnavierCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_cluster_scale(s : PhysicsfluidnavierCluster, f : Double) -> PhysicsfluidnavierCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cluster_add(a : PhysicsfluidnavierCluster, b : PhysicsfluidnavierCluster) -> PhysicsfluidnavierCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_cluster_copy(s : PhysicsfluidnavierCluster) -> PhysicsfluidnavierCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cluster_fill(s : PhysicsfluidnavierCluster, v : Double) -> PhysicsfluidnavierCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cluster_min(s : PhysicsfluidnavierCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_cluster_max(s : PhysicsfluidnavierCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_cluster_to_string(s : PhysicsfluidnavierCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_model_make(size : Int) -> PhysicsfluidnavierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_model_len(s : PhysicsfluidnavierModel) -> Int { s.size }

pub fn physics_fluid_navier_model_get(s : PhysicsfluidnavierModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_model_set(s : PhysicsfluidnavierModel, i : Int, v : Double) -> PhysicsfluidnavierModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_model_sum(s : PhysicsfluidnavierModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_model_mean(s : PhysicsfluidnavierModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_model_scale(s : PhysicsfluidnavierModel, f : Double) -> PhysicsfluidnavierModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_model_add(a : PhysicsfluidnavierModel, b : PhysicsfluidnavierModel) -> PhysicsfluidnavierModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_model_copy(s : PhysicsfluidnavierModel) -> PhysicsfluidnavierModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_model_fill(s : PhysicsfluidnavierModel, v : Double) -> PhysicsfluidnavierModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_model_min(s : PhysicsfluidnavierModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_model_max(s : PhysicsfluidnavierModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_model_to_string(s : PhysicsfluidnavierModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_layer_make(size : Int) -> PhysicsfluidnavierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_layer_len(s : PhysicsfluidnavierLayer) -> Int { s.size }

pub fn physics_fluid_navier_layer_get(s : PhysicsfluidnavierLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_layer_set(s : PhysicsfluidnavierLayer, i : Int, v : Double) -> PhysicsfluidnavierLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_layer_sum(s : PhysicsfluidnavierLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_layer_mean(s : PhysicsfluidnavierLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_layer_scale(s : PhysicsfluidnavierLayer, f : Double) -> PhysicsfluidnavierLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_layer_add(a : PhysicsfluidnavierLayer, b : PhysicsfluidnavierLayer) -> PhysicsfluidnavierLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_layer_copy(s : PhysicsfluidnavierLayer) -> PhysicsfluidnavierLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_layer_fill(s : PhysicsfluidnavierLayer, v : Double) -> PhysicsfluidnavierLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_layer_min(s : PhysicsfluidnavierLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_layer_max(s : PhysicsfluidnavierLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_layer_to_string(s : PhysicsfluidnavierLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_buffer_make(size : Int) -> PhysicsfluidnavierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_buffer_len(s : PhysicsfluidnavierBuffer) -> Int { s.size }

pub fn physics_fluid_navier_buffer_get(s : PhysicsfluidnavierBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_buffer_set(s : PhysicsfluidnavierBuffer, i : Int, v : Double) -> PhysicsfluidnavierBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_buffer_sum(s : PhysicsfluidnavierBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_buffer_mean(s : PhysicsfluidnavierBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_buffer_scale(s : PhysicsfluidnavierBuffer, f : Double) -> PhysicsfluidnavierBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_buffer_add(a : PhysicsfluidnavierBuffer, b : PhysicsfluidnavierBuffer) -> PhysicsfluidnavierBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_buffer_copy(s : PhysicsfluidnavierBuffer) -> PhysicsfluidnavierBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_buffer_fill(s : PhysicsfluidnavierBuffer, v : Double) -> PhysicsfluidnavierBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_buffer_min(s : PhysicsfluidnavierBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_buffer_max(s : PhysicsfluidnavierBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_buffer_to_string(s : PhysicsfluidnavierBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_cursor_make(size : Int) -> PhysicsfluidnavierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_cursor_len(s : PhysicsfluidnavierCursor) -> Int { s.size }

pub fn physics_fluid_navier_cursor_get(s : PhysicsfluidnavierCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_cursor_set(s : PhysicsfluidnavierCursor, i : Int, v : Double) -> PhysicsfluidnavierCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cursor_sum(s : PhysicsfluidnavierCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_cursor_mean(s : PhysicsfluidnavierCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_cursor_scale(s : PhysicsfluidnavierCursor, f : Double) -> PhysicsfluidnavierCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cursor_add(a : PhysicsfluidnavierCursor, b : PhysicsfluidnavierCursor) -> PhysicsfluidnavierCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_cursor_copy(s : PhysicsfluidnavierCursor) -> PhysicsfluidnavierCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cursor_fill(s : PhysicsfluidnavierCursor, v : Double) -> PhysicsfluidnavierCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_cursor_min(s : PhysicsfluidnavierCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_cursor_max(s : PhysicsfluidnavierCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_cursor_to_string(s : PhysicsfluidnavierCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_view_make(size : Int) -> PhysicsfluidnavierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_view_len(s : PhysicsfluidnavierView) -> Int { s.size }

pub fn physics_fluid_navier_view_get(s : PhysicsfluidnavierView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_view_set(s : PhysicsfluidnavierView, i : Int, v : Double) -> PhysicsfluidnavierView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_view_sum(s : PhysicsfluidnavierView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_view_mean(s : PhysicsfluidnavierView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_view_scale(s : PhysicsfluidnavierView, f : Double) -> PhysicsfluidnavierView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_view_add(a : PhysicsfluidnavierView, b : PhysicsfluidnavierView) -> PhysicsfluidnavierView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_view_copy(s : PhysicsfluidnavierView) -> PhysicsfluidnavierView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_view_fill(s : PhysicsfluidnavierView, v : Double) -> PhysicsfluidnavierView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_view_min(s : PhysicsfluidnavierView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_view_max(s : PhysicsfluidnavierView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_view_to_string(s : PhysicsfluidnavierView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_range_make(size : Int) -> PhysicsfluidnavierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_range_len(s : PhysicsfluidnavierRange) -> Int { s.size }

pub fn physics_fluid_navier_range_get(s : PhysicsfluidnavierRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_range_set(s : PhysicsfluidnavierRange, i : Int, v : Double) -> PhysicsfluidnavierRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_range_sum(s : PhysicsfluidnavierRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_range_mean(s : PhysicsfluidnavierRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_range_scale(s : PhysicsfluidnavierRange, f : Double) -> PhysicsfluidnavierRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_range_add(a : PhysicsfluidnavierRange, b : PhysicsfluidnavierRange) -> PhysicsfluidnavierRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_range_copy(s : PhysicsfluidnavierRange) -> PhysicsfluidnavierRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_range_fill(s : PhysicsfluidnavierRange, v : Double) -> PhysicsfluidnavierRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_range_min(s : PhysicsfluidnavierRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_range_max(s : PhysicsfluidnavierRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_range_to_string(s : PhysicsfluidnavierRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_slice_make(size : Int) -> PhysicsfluidnavierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_slice_len(s : PhysicsfluidnavierSlice) -> Int { s.size }

pub fn physics_fluid_navier_slice_get(s : PhysicsfluidnavierSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_slice_set(s : PhysicsfluidnavierSlice, i : Int, v : Double) -> PhysicsfluidnavierSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_slice_sum(s : PhysicsfluidnavierSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_navier_slice_mean(s : PhysicsfluidnavierSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_navier_slice_scale(s : PhysicsfluidnavierSlice, f : Double) -> PhysicsfluidnavierSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_slice_add(a : PhysicsfluidnavierSlice, b : PhysicsfluidnavierSlice) -> PhysicsfluidnavierSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_navier_slice_copy(s : PhysicsfluidnavierSlice) -> PhysicsfluidnavierSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_slice_fill(s : PhysicsfluidnavierSlice, v : Double) -> PhysicsfluidnavierSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_navier_slice_min(s : PhysicsfluidnavierSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_navier_slice_max(s : PhysicsfluidnavierSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_navier_slice_to_string(s : PhysicsfluidnavierSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

