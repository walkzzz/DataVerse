///===
/// extcore/physics_heat_phase

pub(all) struct PhysicsheatphasePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_phase_make_point(x : Double, y : Double) -> PhysicsheatphasePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_phase_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatphasePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatphasePoint::x(self : PhysicsheatphasePoint) -> Double { self.x }

pub fn PhysicsheatphasePoint::y(self : PhysicsheatphasePoint) -> Double { self.y }

pub fn PhysicsheatphasePoint::z(self : PhysicsheatphasePoint) -> Double { self.z }

pub fn PhysicsheatphasePoint::label(self : PhysicsheatphasePoint) -> Int { self.label }

pub fn PhysicsheatphasePoint::dist(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatphasePoint::add(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatphasePoint::sub(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatphasePoint::scale(self : PhysicsheatphasePoint, s : Double) -> PhysicsheatphasePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatphasePoint::dot(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatphasePoint::cross(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatphasePoint::norm(self : PhysicsheatphasePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatphasePoint::normalize(self : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatphasePoint::negate(self : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatphasePoint::mid(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatphasePoint::lerp(self : PhysicsheatphasePoint, other : PhysicsheatphasePoint, t : Double) -> PhysicsheatphasePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatphasePoint::to_string(self : PhysicsheatphasePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatphaseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_phase_make_series(vals : Array[Double], name : String) -> PhysicsheatphaseSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatphaseSeries::len(self : PhysicsheatphaseSeries) -> Int { self.vals.length() }

pub fn PhysicsheatphaseSeries::sum(self : PhysicsheatphaseSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatphaseSeries::mean(self : PhysicsheatphaseSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatphaseSeries::min(self : PhysicsheatphaseSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatphaseSeries::max(self : PhysicsheatphaseSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatphaseSeries::range(self : PhysicsheatphaseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatphaseSeries::variance(self : PhysicsheatphaseSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatphaseSeries::std(self : PhysicsheatphaseSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatphaseSeries::median(self : PhysicsheatphaseSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatphaseSeries::scale(self : PhysicsheatphaseSeries, f : Double) -> PhysicsheatphaseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatphaseSeries::add(self : PhysicsheatphaseSeries, other : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatphaseSeries::sub(self : PhysicsheatphaseSeries, other : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatphaseSeries::normalize(self : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatphaseSeries::cumsum(self : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatphaseSeries::to_string(self : PhysicsheatphaseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatphaseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_phase_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatphaseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_phase_matrix_identity(n : Int) -> PhysicsheatphaseMatrix {
  let m = physics_heat_phase_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatphaseMatrix::get(self : PhysicsheatphaseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatphaseMatrix::transpose(self : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  let result = physics_heat_phase_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatphaseMatrix::add(self : PhysicsheatphaseMatrix, other : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_phase_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatphaseMatrix::scale(self : PhysicsheatphaseMatrix, s : Double) -> PhysicsheatphaseMatrix {
  let result = physics_heat_phase_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatphaseMatrix::multiply(self : PhysicsheatphaseMatrix, other : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  if self.cols != other.rows { return physics_heat_phase_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_phase_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatphaseMatrix::trace(self : PhysicsheatphaseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatphaseMatrix::det(self : PhysicsheatphaseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatphaseMatrix::norm(self : PhysicsheatphaseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatphaseMatrix::to_string(self : PhysicsheatphaseMatrix) -> String {
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

pub(all) struct PhysicsheatphaseVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_phase_make_vector(comps : Array[Double]) -> PhysicsheatphaseVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_phase_vector_zero(dim : Int) -> PhysicsheatphaseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatphaseVector::add(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatphaseVector::sub(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatphaseVector::scale(self : PhysicsheatphaseVector, s : Double) -> PhysicsheatphaseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatphaseVector::dot(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatphaseVector::norm(self : PhysicsheatphaseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatphaseVector::normalize(self : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatphaseVector::dist(self : PhysicsheatphaseVector, other : PhysicsheatphaseVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatphaseVector::to_string(self : PhysicsheatphaseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_phase_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_phase_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_phase_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_phase_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_phase_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_phase_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_phase_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_phase_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_phase_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_phase_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_phase_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_phase_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_phase_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_phase_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_phase_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_phase_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_phase_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_phase_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_phase_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_phase_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_phase_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_phase_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_phase_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_phase_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_phase_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_phase_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_phase_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_phase_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_phase_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatphaseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_frame_make(size : Int) -> PhysicsheatphaseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_frame_len(s : PhysicsheatphaseFrame) -> Int { s.size }

pub fn physics_heat_phase_frame_get(s : PhysicsheatphaseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_frame_set(s : PhysicsheatphaseFrame, i : Int, v : Double) -> PhysicsheatphaseFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_frame_sum(s : PhysicsheatphaseFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_frame_mean(s : PhysicsheatphaseFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_frame_scale(s : PhysicsheatphaseFrame, f : Double) -> PhysicsheatphaseFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_frame_add(a : PhysicsheatphaseFrame, b : PhysicsheatphaseFrame) -> PhysicsheatphaseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_frame_copy(s : PhysicsheatphaseFrame) -> PhysicsheatphaseFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_frame_fill(s : PhysicsheatphaseFrame, v : Double) -> PhysicsheatphaseFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_frame_min(s : PhysicsheatphaseFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_frame_max(s : PhysicsheatphaseFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_frame_to_string(s : PhysicsheatphaseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_table_make(size : Int) -> PhysicsheatphaseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_table_len(s : PhysicsheatphaseTable) -> Int { s.size }

pub fn physics_heat_phase_table_get(s : PhysicsheatphaseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_table_set(s : PhysicsheatphaseTable, i : Int, v : Double) -> PhysicsheatphaseTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_table_sum(s : PhysicsheatphaseTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_table_mean(s : PhysicsheatphaseTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_table_scale(s : PhysicsheatphaseTable, f : Double) -> PhysicsheatphaseTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_table_add(a : PhysicsheatphaseTable, b : PhysicsheatphaseTable) -> PhysicsheatphaseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_table_copy(s : PhysicsheatphaseTable) -> PhysicsheatphaseTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_table_fill(s : PhysicsheatphaseTable, v : Double) -> PhysicsheatphaseTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_table_min(s : PhysicsheatphaseTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_table_max(s : PhysicsheatphaseTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_table_to_string(s : PhysicsheatphaseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_graphn_make(size : Int) -> PhysicsheatphaseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_graphn_len(s : PhysicsheatphaseGraphN) -> Int { s.size }

pub fn physics_heat_phase_graphn_get(s : PhysicsheatphaseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_graphn_set(s : PhysicsheatphaseGraphN, i : Int, v : Double) -> PhysicsheatphaseGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_graphn_sum(s : PhysicsheatphaseGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_graphn_mean(s : PhysicsheatphaseGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_graphn_scale(s : PhysicsheatphaseGraphN, f : Double) -> PhysicsheatphaseGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_graphn_add(a : PhysicsheatphaseGraphN, b : PhysicsheatphaseGraphN) -> PhysicsheatphaseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_graphn_copy(s : PhysicsheatphaseGraphN) -> PhysicsheatphaseGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_graphn_fill(s : PhysicsheatphaseGraphN, v : Double) -> PhysicsheatphaseGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_graphn_min(s : PhysicsheatphaseGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_graphn_max(s : PhysicsheatphaseGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_graphn_to_string(s : PhysicsheatphaseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_node_make(size : Int) -> PhysicsheatphaseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_node_len(s : PhysicsheatphaseNode) -> Int { s.size }

pub fn physics_heat_phase_node_get(s : PhysicsheatphaseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_node_set(s : PhysicsheatphaseNode, i : Int, v : Double) -> PhysicsheatphaseNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_node_sum(s : PhysicsheatphaseNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_node_mean(s : PhysicsheatphaseNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_node_scale(s : PhysicsheatphaseNode, f : Double) -> PhysicsheatphaseNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_node_add(a : PhysicsheatphaseNode, b : PhysicsheatphaseNode) -> PhysicsheatphaseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_node_copy(s : PhysicsheatphaseNode) -> PhysicsheatphaseNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_node_fill(s : PhysicsheatphaseNode, v : Double) -> PhysicsheatphaseNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_node_min(s : PhysicsheatphaseNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_node_max(s : PhysicsheatphaseNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_node_to_string(s : PhysicsheatphaseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_edge_make(size : Int) -> PhysicsheatphaseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_edge_len(s : PhysicsheatphaseEdge) -> Int { s.size }

pub fn physics_heat_phase_edge_get(s : PhysicsheatphaseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_edge_set(s : PhysicsheatphaseEdge, i : Int, v : Double) -> PhysicsheatphaseEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_edge_sum(s : PhysicsheatphaseEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_edge_mean(s : PhysicsheatphaseEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_edge_scale(s : PhysicsheatphaseEdge, f : Double) -> PhysicsheatphaseEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_edge_add(a : PhysicsheatphaseEdge, b : PhysicsheatphaseEdge) -> PhysicsheatphaseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_edge_copy(s : PhysicsheatphaseEdge) -> PhysicsheatphaseEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_edge_fill(s : PhysicsheatphaseEdge, v : Double) -> PhysicsheatphaseEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_edge_min(s : PhysicsheatphaseEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_edge_max(s : PhysicsheatphaseEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_edge_to_string(s : PhysicsheatphaseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphasePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_path_make(size : Int) -> PhysicsheatphasePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_path_len(s : PhysicsheatphasePath) -> Int { s.size }

pub fn physics_heat_phase_path_get(s : PhysicsheatphasePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_path_set(s : PhysicsheatphasePath, i : Int, v : Double) -> PhysicsheatphasePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_path_sum(s : PhysicsheatphasePath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_path_mean(s : PhysicsheatphasePath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_path_scale(s : PhysicsheatphasePath, f : Double) -> PhysicsheatphasePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_path_add(a : PhysicsheatphasePath, b : PhysicsheatphasePath) -> PhysicsheatphasePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_path_copy(s : PhysicsheatphasePath) -> PhysicsheatphasePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_path_fill(s : PhysicsheatphasePath, v : Double) -> PhysicsheatphasePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_path_min(s : PhysicsheatphasePath) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_path_max(s : PhysicsheatphasePath) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_path_to_string(s : PhysicsheatphasePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_cluster_make(size : Int) -> PhysicsheatphaseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_cluster_len(s : PhysicsheatphaseCluster) -> Int { s.size }

pub fn physics_heat_phase_cluster_get(s : PhysicsheatphaseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_cluster_set(s : PhysicsheatphaseCluster, i : Int, v : Double) -> PhysicsheatphaseCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cluster_sum(s : PhysicsheatphaseCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_cluster_mean(s : PhysicsheatphaseCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_cluster_scale(s : PhysicsheatphaseCluster, f : Double) -> PhysicsheatphaseCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cluster_add(a : PhysicsheatphaseCluster, b : PhysicsheatphaseCluster) -> PhysicsheatphaseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_cluster_copy(s : PhysicsheatphaseCluster) -> PhysicsheatphaseCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cluster_fill(s : PhysicsheatphaseCluster, v : Double) -> PhysicsheatphaseCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cluster_min(s : PhysicsheatphaseCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_cluster_max(s : PhysicsheatphaseCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_cluster_to_string(s : PhysicsheatphaseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_model_make(size : Int) -> PhysicsheatphaseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_model_len(s : PhysicsheatphaseModel) -> Int { s.size }

pub fn physics_heat_phase_model_get(s : PhysicsheatphaseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_model_set(s : PhysicsheatphaseModel, i : Int, v : Double) -> PhysicsheatphaseModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_model_sum(s : PhysicsheatphaseModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_model_mean(s : PhysicsheatphaseModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_model_scale(s : PhysicsheatphaseModel, f : Double) -> PhysicsheatphaseModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_model_add(a : PhysicsheatphaseModel, b : PhysicsheatphaseModel) -> PhysicsheatphaseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_model_copy(s : PhysicsheatphaseModel) -> PhysicsheatphaseModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_model_fill(s : PhysicsheatphaseModel, v : Double) -> PhysicsheatphaseModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_model_min(s : PhysicsheatphaseModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_model_max(s : PhysicsheatphaseModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_model_to_string(s : PhysicsheatphaseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_layer_make(size : Int) -> PhysicsheatphaseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_layer_len(s : PhysicsheatphaseLayer) -> Int { s.size }

pub fn physics_heat_phase_layer_get(s : PhysicsheatphaseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_layer_set(s : PhysicsheatphaseLayer, i : Int, v : Double) -> PhysicsheatphaseLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_layer_sum(s : PhysicsheatphaseLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_layer_mean(s : PhysicsheatphaseLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_layer_scale(s : PhysicsheatphaseLayer, f : Double) -> PhysicsheatphaseLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_layer_add(a : PhysicsheatphaseLayer, b : PhysicsheatphaseLayer) -> PhysicsheatphaseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_layer_copy(s : PhysicsheatphaseLayer) -> PhysicsheatphaseLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_layer_fill(s : PhysicsheatphaseLayer, v : Double) -> PhysicsheatphaseLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_layer_min(s : PhysicsheatphaseLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_layer_max(s : PhysicsheatphaseLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_layer_to_string(s : PhysicsheatphaseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_buffer_make(size : Int) -> PhysicsheatphaseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_buffer_len(s : PhysicsheatphaseBuffer) -> Int { s.size }

pub fn physics_heat_phase_buffer_get(s : PhysicsheatphaseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_buffer_set(s : PhysicsheatphaseBuffer, i : Int, v : Double) -> PhysicsheatphaseBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_buffer_sum(s : PhysicsheatphaseBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_buffer_mean(s : PhysicsheatphaseBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_buffer_scale(s : PhysicsheatphaseBuffer, f : Double) -> PhysicsheatphaseBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_buffer_add(a : PhysicsheatphaseBuffer, b : PhysicsheatphaseBuffer) -> PhysicsheatphaseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_buffer_copy(s : PhysicsheatphaseBuffer) -> PhysicsheatphaseBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_buffer_fill(s : PhysicsheatphaseBuffer, v : Double) -> PhysicsheatphaseBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_buffer_min(s : PhysicsheatphaseBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_buffer_max(s : PhysicsheatphaseBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_buffer_to_string(s : PhysicsheatphaseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_cursor_make(size : Int) -> PhysicsheatphaseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_cursor_len(s : PhysicsheatphaseCursor) -> Int { s.size }

pub fn physics_heat_phase_cursor_get(s : PhysicsheatphaseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_cursor_set(s : PhysicsheatphaseCursor, i : Int, v : Double) -> PhysicsheatphaseCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cursor_sum(s : PhysicsheatphaseCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_cursor_mean(s : PhysicsheatphaseCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_cursor_scale(s : PhysicsheatphaseCursor, f : Double) -> PhysicsheatphaseCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cursor_add(a : PhysicsheatphaseCursor, b : PhysicsheatphaseCursor) -> PhysicsheatphaseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_cursor_copy(s : PhysicsheatphaseCursor) -> PhysicsheatphaseCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cursor_fill(s : PhysicsheatphaseCursor, v : Double) -> PhysicsheatphaseCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_cursor_min(s : PhysicsheatphaseCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_cursor_max(s : PhysicsheatphaseCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_cursor_to_string(s : PhysicsheatphaseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_view_make(size : Int) -> PhysicsheatphaseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_view_len(s : PhysicsheatphaseView) -> Int { s.size }

pub fn physics_heat_phase_view_get(s : PhysicsheatphaseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_view_set(s : PhysicsheatphaseView, i : Int, v : Double) -> PhysicsheatphaseView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_view_sum(s : PhysicsheatphaseView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_view_mean(s : PhysicsheatphaseView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_view_scale(s : PhysicsheatphaseView, f : Double) -> PhysicsheatphaseView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_view_add(a : PhysicsheatphaseView, b : PhysicsheatphaseView) -> PhysicsheatphaseView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_view_copy(s : PhysicsheatphaseView) -> PhysicsheatphaseView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_view_fill(s : PhysicsheatphaseView, v : Double) -> PhysicsheatphaseView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_view_min(s : PhysicsheatphaseView) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_view_max(s : PhysicsheatphaseView) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_view_to_string(s : PhysicsheatphaseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_range_make(size : Int) -> PhysicsheatphaseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_range_len(s : PhysicsheatphaseRange) -> Int { s.size }

pub fn physics_heat_phase_range_get(s : PhysicsheatphaseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_range_set(s : PhysicsheatphaseRange, i : Int, v : Double) -> PhysicsheatphaseRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_range_sum(s : PhysicsheatphaseRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_range_mean(s : PhysicsheatphaseRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_range_scale(s : PhysicsheatphaseRange, f : Double) -> PhysicsheatphaseRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_range_add(a : PhysicsheatphaseRange, b : PhysicsheatphaseRange) -> PhysicsheatphaseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_range_copy(s : PhysicsheatphaseRange) -> PhysicsheatphaseRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_range_fill(s : PhysicsheatphaseRange, v : Double) -> PhysicsheatphaseRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_range_min(s : PhysicsheatphaseRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_range_max(s : PhysicsheatphaseRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_range_to_string(s : PhysicsheatphaseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_slice_make(size : Int) -> PhysicsheatphaseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_slice_len(s : PhysicsheatphaseSlice) -> Int { s.size }

pub fn physics_heat_phase_slice_get(s : PhysicsheatphaseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_slice_set(s : PhysicsheatphaseSlice, i : Int, v : Double) -> PhysicsheatphaseSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_slice_sum(s : PhysicsheatphaseSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_slice_mean(s : PhysicsheatphaseSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_slice_scale(s : PhysicsheatphaseSlice, f : Double) -> PhysicsheatphaseSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_slice_add(a : PhysicsheatphaseSlice, b : PhysicsheatphaseSlice) -> PhysicsheatphaseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_phase_slice_copy(s : PhysicsheatphaseSlice) -> PhysicsheatphaseSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_slice_fill(s : PhysicsheatphaseSlice, v : Double) -> PhysicsheatphaseSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_phase_slice_min(s : PhysicsheatphaseSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_slice_max(s : PhysicsheatphaseSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_slice_to_string(s : PhysicsheatphaseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

