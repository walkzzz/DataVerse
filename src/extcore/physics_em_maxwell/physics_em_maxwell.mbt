///===
/// extcore/physics_em_maxwell

pub(all) struct PhysicsemmaxwellPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_maxwell_make_point(x : Double, y : Double) -> PhysicsemmaxwellPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_maxwell_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmaxwellPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemmaxwellPoint::x(self : PhysicsemmaxwellPoint) -> Double { self.x }

pub fn PhysicsemmaxwellPoint::y(self : PhysicsemmaxwellPoint) -> Double { self.y }

pub fn PhysicsemmaxwellPoint::z(self : PhysicsemmaxwellPoint) -> Double { self.z }

pub fn PhysicsemmaxwellPoint::label(self : PhysicsemmaxwellPoint) -> Int { self.label }

pub fn PhysicsemmaxwellPoint::dist(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemmaxwellPoint::add(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemmaxwellPoint::sub(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemmaxwellPoint::scale(self : PhysicsemmaxwellPoint, s : Double) -> PhysicsemmaxwellPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemmaxwellPoint::dot(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemmaxwellPoint::cross(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemmaxwellPoint::norm(self : PhysicsemmaxwellPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemmaxwellPoint::normalize(self : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmaxwellPoint::negate(self : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemmaxwellPoint::mid(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemmaxwellPoint::lerp(self : PhysicsemmaxwellPoint, other : PhysicsemmaxwellPoint, t : Double) -> PhysicsemmaxwellPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemmaxwellPoint::to_string(self : PhysicsemmaxwellPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_maxwell_make_series(vals : Array[Double], name : String) -> PhysicsemmaxwellSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemmaxwellSeries::len(self : PhysicsemmaxwellSeries) -> Int { self.vals.length() }

pub fn PhysicsemmaxwellSeries::sum(self : PhysicsemmaxwellSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemmaxwellSeries::mean(self : PhysicsemmaxwellSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemmaxwellSeries::min(self : PhysicsemmaxwellSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemmaxwellSeries::max(self : PhysicsemmaxwellSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemmaxwellSeries::range(self : PhysicsemmaxwellSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemmaxwellSeries::variance(self : PhysicsemmaxwellSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemmaxwellSeries::std(self : PhysicsemmaxwellSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemmaxwellSeries::median(self : PhysicsemmaxwellSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemmaxwellSeries::scale(self : PhysicsemmaxwellSeries, f : Double) -> PhysicsemmaxwellSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemmaxwellSeries::add(self : PhysicsemmaxwellSeries, other : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemmaxwellSeries::sub(self : PhysicsemmaxwellSeries, other : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemmaxwellSeries::normalize(self : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemmaxwellSeries::cumsum(self : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemmaxwellSeries::to_string(self : PhysicsemmaxwellSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmaxwellMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_maxwell_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmaxwellMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_maxwell_matrix_identity(n : Int) -> PhysicsemmaxwellMatrix {
  let m = physics_em_maxwell_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemmaxwellMatrix::get(self : PhysicsemmaxwellMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemmaxwellMatrix::transpose(self : PhysicsemmaxwellMatrix) -> PhysicsemmaxwellMatrix {
  let result = physics_em_maxwell_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemmaxwellMatrix::add(self : PhysicsemmaxwellMatrix, other : PhysicsemmaxwellMatrix) -> PhysicsemmaxwellMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_maxwell_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemmaxwellMatrix::scale(self : PhysicsemmaxwellMatrix, s : Double) -> PhysicsemmaxwellMatrix {
  let result = physics_em_maxwell_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemmaxwellMatrix::multiply(self : PhysicsemmaxwellMatrix, other : PhysicsemmaxwellMatrix) -> PhysicsemmaxwellMatrix {
  if self.cols != other.rows { return physics_em_maxwell_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_maxwell_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemmaxwellMatrix::trace(self : PhysicsemmaxwellMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemmaxwellMatrix::det(self : PhysicsemmaxwellMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemmaxwellMatrix::norm(self : PhysicsemmaxwellMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemmaxwellMatrix::to_string(self : PhysicsemmaxwellMatrix) -> String {
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

pub(all) struct PhysicsemmaxwellVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_maxwell_make_vector(comps : Array[Double]) -> PhysicsemmaxwellVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_maxwell_vector_zero(dim : Int) -> PhysicsemmaxwellVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemmaxwellVector::add(self : PhysicsemmaxwellVector, other : PhysicsemmaxwellVector) -> PhysicsemmaxwellVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmaxwellVector::sub(self : PhysicsemmaxwellVector, other : PhysicsemmaxwellVector) -> PhysicsemmaxwellVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmaxwellVector::scale(self : PhysicsemmaxwellVector, s : Double) -> PhysicsemmaxwellVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemmaxwellVector::dot(self : PhysicsemmaxwellVector, other : PhysicsemmaxwellVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemmaxwellVector::norm(self : PhysicsemmaxwellVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemmaxwellVector::normalize(self : PhysicsemmaxwellVector) -> PhysicsemmaxwellVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmaxwellVector::dist(self : PhysicsemmaxwellVector, other : PhysicsemmaxwellVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemmaxwellVector::to_string(self : PhysicsemmaxwellVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_maxwell_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_maxwell_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_maxwell_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_maxwell_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_maxwell_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_maxwell_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_maxwell_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_maxwell_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_maxwell_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_maxwell_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_maxwell_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_maxwell_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_maxwell_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_maxwell_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_maxwell_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_maxwell_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_maxwell_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_maxwell_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_maxwell_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_maxwell_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_maxwell_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_maxwell_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_maxwell_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_maxwell_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_maxwell_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_maxwell_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_maxwell_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_maxwell_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_maxwell_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemmaxwellFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_frame_make(size : Int) -> PhysicsemmaxwellFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_frame_len(s : PhysicsemmaxwellFrame) -> Int { s.size }

pub fn physics_em_maxwell_frame_get(s : PhysicsemmaxwellFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_frame_set(s : PhysicsemmaxwellFrame, i : Int, v : Double) -> PhysicsemmaxwellFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_frame_sum(s : PhysicsemmaxwellFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_frame_mean(s : PhysicsemmaxwellFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_frame_scale(s : PhysicsemmaxwellFrame, f : Double) -> PhysicsemmaxwellFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_frame_add(a : PhysicsemmaxwellFrame, b : PhysicsemmaxwellFrame) -> PhysicsemmaxwellFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_frame_copy(s : PhysicsemmaxwellFrame) -> PhysicsemmaxwellFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_frame_fill(s : PhysicsemmaxwellFrame, v : Double) -> PhysicsemmaxwellFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_frame_min(s : PhysicsemmaxwellFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_frame_max(s : PhysicsemmaxwellFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_frame_to_string(s : PhysicsemmaxwellFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_table_make(size : Int) -> PhysicsemmaxwellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_table_len(s : PhysicsemmaxwellTable) -> Int { s.size }

pub fn physics_em_maxwell_table_get(s : PhysicsemmaxwellTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_table_set(s : PhysicsemmaxwellTable, i : Int, v : Double) -> PhysicsemmaxwellTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_table_sum(s : PhysicsemmaxwellTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_table_mean(s : PhysicsemmaxwellTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_table_scale(s : PhysicsemmaxwellTable, f : Double) -> PhysicsemmaxwellTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_table_add(a : PhysicsemmaxwellTable, b : PhysicsemmaxwellTable) -> PhysicsemmaxwellTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_table_copy(s : PhysicsemmaxwellTable) -> PhysicsemmaxwellTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_table_fill(s : PhysicsemmaxwellTable, v : Double) -> PhysicsemmaxwellTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_table_min(s : PhysicsemmaxwellTable) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_table_max(s : PhysicsemmaxwellTable) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_table_to_string(s : PhysicsemmaxwellTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_graphn_make(size : Int) -> PhysicsemmaxwellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_graphn_len(s : PhysicsemmaxwellGraphN) -> Int { s.size }

pub fn physics_em_maxwell_graphn_get(s : PhysicsemmaxwellGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_graphn_set(s : PhysicsemmaxwellGraphN, i : Int, v : Double) -> PhysicsemmaxwellGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_graphn_sum(s : PhysicsemmaxwellGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_graphn_mean(s : PhysicsemmaxwellGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_graphn_scale(s : PhysicsemmaxwellGraphN, f : Double) -> PhysicsemmaxwellGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_graphn_add(a : PhysicsemmaxwellGraphN, b : PhysicsemmaxwellGraphN) -> PhysicsemmaxwellGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_graphn_copy(s : PhysicsemmaxwellGraphN) -> PhysicsemmaxwellGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_graphn_fill(s : PhysicsemmaxwellGraphN, v : Double) -> PhysicsemmaxwellGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_graphn_min(s : PhysicsemmaxwellGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_graphn_max(s : PhysicsemmaxwellGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_graphn_to_string(s : PhysicsemmaxwellGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_node_make(size : Int) -> PhysicsemmaxwellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_node_len(s : PhysicsemmaxwellNode) -> Int { s.size }

pub fn physics_em_maxwell_node_get(s : PhysicsemmaxwellNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_node_set(s : PhysicsemmaxwellNode, i : Int, v : Double) -> PhysicsemmaxwellNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_node_sum(s : PhysicsemmaxwellNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_node_mean(s : PhysicsemmaxwellNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_node_scale(s : PhysicsemmaxwellNode, f : Double) -> PhysicsemmaxwellNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_node_add(a : PhysicsemmaxwellNode, b : PhysicsemmaxwellNode) -> PhysicsemmaxwellNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_node_copy(s : PhysicsemmaxwellNode) -> PhysicsemmaxwellNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_node_fill(s : PhysicsemmaxwellNode, v : Double) -> PhysicsemmaxwellNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_node_min(s : PhysicsemmaxwellNode) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_node_max(s : PhysicsemmaxwellNode) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_node_to_string(s : PhysicsemmaxwellNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_edge_make(size : Int) -> PhysicsemmaxwellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_edge_len(s : PhysicsemmaxwellEdge) -> Int { s.size }

pub fn physics_em_maxwell_edge_get(s : PhysicsemmaxwellEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_edge_set(s : PhysicsemmaxwellEdge, i : Int, v : Double) -> PhysicsemmaxwellEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_edge_sum(s : PhysicsemmaxwellEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_edge_mean(s : PhysicsemmaxwellEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_edge_scale(s : PhysicsemmaxwellEdge, f : Double) -> PhysicsemmaxwellEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_edge_add(a : PhysicsemmaxwellEdge, b : PhysicsemmaxwellEdge) -> PhysicsemmaxwellEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_edge_copy(s : PhysicsemmaxwellEdge) -> PhysicsemmaxwellEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_edge_fill(s : PhysicsemmaxwellEdge, v : Double) -> PhysicsemmaxwellEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_edge_min(s : PhysicsemmaxwellEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_edge_max(s : PhysicsemmaxwellEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_edge_to_string(s : PhysicsemmaxwellEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_path_make(size : Int) -> PhysicsemmaxwellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_path_len(s : PhysicsemmaxwellPath) -> Int { s.size }

pub fn physics_em_maxwell_path_get(s : PhysicsemmaxwellPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_path_set(s : PhysicsemmaxwellPath, i : Int, v : Double) -> PhysicsemmaxwellPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_path_sum(s : PhysicsemmaxwellPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_path_mean(s : PhysicsemmaxwellPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_path_scale(s : PhysicsemmaxwellPath, f : Double) -> PhysicsemmaxwellPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_path_add(a : PhysicsemmaxwellPath, b : PhysicsemmaxwellPath) -> PhysicsemmaxwellPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_path_copy(s : PhysicsemmaxwellPath) -> PhysicsemmaxwellPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_path_fill(s : PhysicsemmaxwellPath, v : Double) -> PhysicsemmaxwellPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_path_min(s : PhysicsemmaxwellPath) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_path_max(s : PhysicsemmaxwellPath) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_path_to_string(s : PhysicsemmaxwellPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_cluster_make(size : Int) -> PhysicsemmaxwellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_cluster_len(s : PhysicsemmaxwellCluster) -> Int { s.size }

pub fn physics_em_maxwell_cluster_get(s : PhysicsemmaxwellCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_cluster_set(s : PhysicsemmaxwellCluster, i : Int, v : Double) -> PhysicsemmaxwellCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cluster_sum(s : PhysicsemmaxwellCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_cluster_mean(s : PhysicsemmaxwellCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_cluster_scale(s : PhysicsemmaxwellCluster, f : Double) -> PhysicsemmaxwellCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cluster_add(a : PhysicsemmaxwellCluster, b : PhysicsemmaxwellCluster) -> PhysicsemmaxwellCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_cluster_copy(s : PhysicsemmaxwellCluster) -> PhysicsemmaxwellCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cluster_fill(s : PhysicsemmaxwellCluster, v : Double) -> PhysicsemmaxwellCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cluster_min(s : PhysicsemmaxwellCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_cluster_max(s : PhysicsemmaxwellCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_cluster_to_string(s : PhysicsemmaxwellCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_model_make(size : Int) -> PhysicsemmaxwellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_model_len(s : PhysicsemmaxwellModel) -> Int { s.size }

pub fn physics_em_maxwell_model_get(s : PhysicsemmaxwellModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_model_set(s : PhysicsemmaxwellModel, i : Int, v : Double) -> PhysicsemmaxwellModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_model_sum(s : PhysicsemmaxwellModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_model_mean(s : PhysicsemmaxwellModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_model_scale(s : PhysicsemmaxwellModel, f : Double) -> PhysicsemmaxwellModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_model_add(a : PhysicsemmaxwellModel, b : PhysicsemmaxwellModel) -> PhysicsemmaxwellModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_model_copy(s : PhysicsemmaxwellModel) -> PhysicsemmaxwellModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_model_fill(s : PhysicsemmaxwellModel, v : Double) -> PhysicsemmaxwellModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_model_min(s : PhysicsemmaxwellModel) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_model_max(s : PhysicsemmaxwellModel) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_model_to_string(s : PhysicsemmaxwellModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_layer_make(size : Int) -> PhysicsemmaxwellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_layer_len(s : PhysicsemmaxwellLayer) -> Int { s.size }

pub fn physics_em_maxwell_layer_get(s : PhysicsemmaxwellLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_layer_set(s : PhysicsemmaxwellLayer, i : Int, v : Double) -> PhysicsemmaxwellLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_layer_sum(s : PhysicsemmaxwellLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_layer_mean(s : PhysicsemmaxwellLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_layer_scale(s : PhysicsemmaxwellLayer, f : Double) -> PhysicsemmaxwellLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_layer_add(a : PhysicsemmaxwellLayer, b : PhysicsemmaxwellLayer) -> PhysicsemmaxwellLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_layer_copy(s : PhysicsemmaxwellLayer) -> PhysicsemmaxwellLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_layer_fill(s : PhysicsemmaxwellLayer, v : Double) -> PhysicsemmaxwellLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_layer_min(s : PhysicsemmaxwellLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_layer_max(s : PhysicsemmaxwellLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_layer_to_string(s : PhysicsemmaxwellLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_buffer_make(size : Int) -> PhysicsemmaxwellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_buffer_len(s : PhysicsemmaxwellBuffer) -> Int { s.size }

pub fn physics_em_maxwell_buffer_get(s : PhysicsemmaxwellBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_buffer_set(s : PhysicsemmaxwellBuffer, i : Int, v : Double) -> PhysicsemmaxwellBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_buffer_sum(s : PhysicsemmaxwellBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_buffer_mean(s : PhysicsemmaxwellBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_buffer_scale(s : PhysicsemmaxwellBuffer, f : Double) -> PhysicsemmaxwellBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_buffer_add(a : PhysicsemmaxwellBuffer, b : PhysicsemmaxwellBuffer) -> PhysicsemmaxwellBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_buffer_copy(s : PhysicsemmaxwellBuffer) -> PhysicsemmaxwellBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_buffer_fill(s : PhysicsemmaxwellBuffer, v : Double) -> PhysicsemmaxwellBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_buffer_min(s : PhysicsemmaxwellBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_buffer_max(s : PhysicsemmaxwellBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_buffer_to_string(s : PhysicsemmaxwellBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_cursor_make(size : Int) -> PhysicsemmaxwellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_cursor_len(s : PhysicsemmaxwellCursor) -> Int { s.size }

pub fn physics_em_maxwell_cursor_get(s : PhysicsemmaxwellCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_cursor_set(s : PhysicsemmaxwellCursor, i : Int, v : Double) -> PhysicsemmaxwellCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cursor_sum(s : PhysicsemmaxwellCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_cursor_mean(s : PhysicsemmaxwellCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_cursor_scale(s : PhysicsemmaxwellCursor, f : Double) -> PhysicsemmaxwellCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cursor_add(a : PhysicsemmaxwellCursor, b : PhysicsemmaxwellCursor) -> PhysicsemmaxwellCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_cursor_copy(s : PhysicsemmaxwellCursor) -> PhysicsemmaxwellCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cursor_fill(s : PhysicsemmaxwellCursor, v : Double) -> PhysicsemmaxwellCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_cursor_min(s : PhysicsemmaxwellCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_cursor_max(s : PhysicsemmaxwellCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_cursor_to_string(s : PhysicsemmaxwellCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_view_make(size : Int) -> PhysicsemmaxwellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_view_len(s : PhysicsemmaxwellView) -> Int { s.size }

pub fn physics_em_maxwell_view_get(s : PhysicsemmaxwellView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_view_set(s : PhysicsemmaxwellView, i : Int, v : Double) -> PhysicsemmaxwellView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_view_sum(s : PhysicsemmaxwellView) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_view_mean(s : PhysicsemmaxwellView) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_view_scale(s : PhysicsemmaxwellView, f : Double) -> PhysicsemmaxwellView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_view_add(a : PhysicsemmaxwellView, b : PhysicsemmaxwellView) -> PhysicsemmaxwellView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_view_copy(s : PhysicsemmaxwellView) -> PhysicsemmaxwellView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_view_fill(s : PhysicsemmaxwellView, v : Double) -> PhysicsemmaxwellView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_view_min(s : PhysicsemmaxwellView) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_view_max(s : PhysicsemmaxwellView) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_view_to_string(s : PhysicsemmaxwellView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_range_make(size : Int) -> PhysicsemmaxwellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_range_len(s : PhysicsemmaxwellRange) -> Int { s.size }

pub fn physics_em_maxwell_range_get(s : PhysicsemmaxwellRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_range_set(s : PhysicsemmaxwellRange, i : Int, v : Double) -> PhysicsemmaxwellRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_range_sum(s : PhysicsemmaxwellRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_range_mean(s : PhysicsemmaxwellRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_range_scale(s : PhysicsemmaxwellRange, f : Double) -> PhysicsemmaxwellRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_range_add(a : PhysicsemmaxwellRange, b : PhysicsemmaxwellRange) -> PhysicsemmaxwellRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_range_copy(s : PhysicsemmaxwellRange) -> PhysicsemmaxwellRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_range_fill(s : PhysicsemmaxwellRange, v : Double) -> PhysicsemmaxwellRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_range_min(s : PhysicsemmaxwellRange) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_range_max(s : PhysicsemmaxwellRange) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_range_to_string(s : PhysicsemmaxwellRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_slice_make(size : Int) -> PhysicsemmaxwellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_slice_len(s : PhysicsemmaxwellSlice) -> Int { s.size }

pub fn physics_em_maxwell_slice_get(s : PhysicsemmaxwellSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_slice_set(s : PhysicsemmaxwellSlice, i : Int, v : Double) -> PhysicsemmaxwellSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_slice_sum(s : PhysicsemmaxwellSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_slice_mean(s : PhysicsemmaxwellSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_slice_scale(s : PhysicsemmaxwellSlice, f : Double) -> PhysicsemmaxwellSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_slice_add(a : PhysicsemmaxwellSlice, b : PhysicsemmaxwellSlice) -> PhysicsemmaxwellSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_maxwell_slice_copy(s : PhysicsemmaxwellSlice) -> PhysicsemmaxwellSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_slice_fill(s : PhysicsemmaxwellSlice, v : Double) -> PhysicsemmaxwellSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_maxwell_slice_min(s : PhysicsemmaxwellSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_slice_max(s : PhysicsemmaxwellSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_slice_to_string(s : PhysicsemmaxwellSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

