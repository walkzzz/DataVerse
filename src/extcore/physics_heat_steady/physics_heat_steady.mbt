///===
/// extcore/physics_heat_steady

pub(all) struct PhysicsheatsteadyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_steady_make_point(x : Double, y : Double) -> PhysicsheatsteadyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_steady_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatsteadyPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatsteadyPoint::x(self : PhysicsheatsteadyPoint) -> Double { self.x }

pub fn PhysicsheatsteadyPoint::y(self : PhysicsheatsteadyPoint) -> Double { self.y }

pub fn PhysicsheatsteadyPoint::z(self : PhysicsheatsteadyPoint) -> Double { self.z }

pub fn PhysicsheatsteadyPoint::label(self : PhysicsheatsteadyPoint) -> Int { self.label }

pub fn PhysicsheatsteadyPoint::dist(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatsteadyPoint::add(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatsteadyPoint::sub(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatsteadyPoint::scale(self : PhysicsheatsteadyPoint, s : Double) -> PhysicsheatsteadyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatsteadyPoint::dot(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatsteadyPoint::cross(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatsteadyPoint::norm(self : PhysicsheatsteadyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatsteadyPoint::normalize(self : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatsteadyPoint::negate(self : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatsteadyPoint::mid(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatsteadyPoint::lerp(self : PhysicsheatsteadyPoint, other : PhysicsheatsteadyPoint, t : Double) -> PhysicsheatsteadyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatsteadyPoint::to_string(self : PhysicsheatsteadyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatsteadySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_steady_make_series(vals : Array[Double], name : String) -> PhysicsheatsteadySeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatsteadySeries::len(self : PhysicsheatsteadySeries) -> Int { self.vals.length() }

pub fn PhysicsheatsteadySeries::sum(self : PhysicsheatsteadySeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatsteadySeries::mean(self : PhysicsheatsteadySeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatsteadySeries::min(self : PhysicsheatsteadySeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatsteadySeries::max(self : PhysicsheatsteadySeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatsteadySeries::range(self : PhysicsheatsteadySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatsteadySeries::variance(self : PhysicsheatsteadySeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatsteadySeries::std(self : PhysicsheatsteadySeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatsteadySeries::median(self : PhysicsheatsteadySeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatsteadySeries::scale(self : PhysicsheatsteadySeries, f : Double) -> PhysicsheatsteadySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatsteadySeries::add(self : PhysicsheatsteadySeries, other : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatsteadySeries::sub(self : PhysicsheatsteadySeries, other : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatsteadySeries::normalize(self : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatsteadySeries::cumsum(self : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatsteadySeries::to_string(self : PhysicsheatsteadySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatsteadyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_steady_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatsteadyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_steady_matrix_identity(n : Int) -> PhysicsheatsteadyMatrix {
  let m = physics_heat_steady_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatsteadyMatrix::get(self : PhysicsheatsteadyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatsteadyMatrix::transpose(self : PhysicsheatsteadyMatrix) -> PhysicsheatsteadyMatrix {
  let result = physics_heat_steady_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatsteadyMatrix::add(self : PhysicsheatsteadyMatrix, other : PhysicsheatsteadyMatrix) -> PhysicsheatsteadyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_steady_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatsteadyMatrix::scale(self : PhysicsheatsteadyMatrix, s : Double) -> PhysicsheatsteadyMatrix {
  let result = physics_heat_steady_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatsteadyMatrix::multiply(self : PhysicsheatsteadyMatrix, other : PhysicsheatsteadyMatrix) -> PhysicsheatsteadyMatrix {
  if self.cols != other.rows { return physics_heat_steady_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_steady_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatsteadyMatrix::trace(self : PhysicsheatsteadyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatsteadyMatrix::det(self : PhysicsheatsteadyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatsteadyMatrix::norm(self : PhysicsheatsteadyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatsteadyMatrix::to_string(self : PhysicsheatsteadyMatrix) -> String {
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

pub(all) struct PhysicsheatsteadyVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_steady_make_vector(comps : Array[Double]) -> PhysicsheatsteadyVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_steady_vector_zero(dim : Int) -> PhysicsheatsteadyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatsteadyVector::add(self : PhysicsheatsteadyVector, other : PhysicsheatsteadyVector) -> PhysicsheatsteadyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatsteadyVector::sub(self : PhysicsheatsteadyVector, other : PhysicsheatsteadyVector) -> PhysicsheatsteadyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatsteadyVector::scale(self : PhysicsheatsteadyVector, s : Double) -> PhysicsheatsteadyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatsteadyVector::dot(self : PhysicsheatsteadyVector, other : PhysicsheatsteadyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatsteadyVector::norm(self : PhysicsheatsteadyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatsteadyVector::normalize(self : PhysicsheatsteadyVector) -> PhysicsheatsteadyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatsteadyVector::dist(self : PhysicsheatsteadyVector, other : PhysicsheatsteadyVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatsteadyVector::to_string(self : PhysicsheatsteadyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_steady_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_steady_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_steady_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_steady_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_steady_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_steady_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_steady_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_steady_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_steady_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_steady_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_steady_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_steady_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_steady_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_steady_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_steady_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_steady_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_steady_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_steady_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_steady_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_steady_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_steady_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_steady_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_steady_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_steady_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_steady_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_steady_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_steady_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_steady_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_steady_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatsteadyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_frame_make(size : Int) -> PhysicsheatsteadyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_frame_len(s : PhysicsheatsteadyFrame) -> Int { s.size }

pub fn physics_heat_steady_frame_get(s : PhysicsheatsteadyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_frame_set(s : PhysicsheatsteadyFrame, i : Int, v : Double) -> PhysicsheatsteadyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_frame_sum(s : PhysicsheatsteadyFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_frame_mean(s : PhysicsheatsteadyFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_frame_scale(s : PhysicsheatsteadyFrame, f : Double) -> PhysicsheatsteadyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_frame_add(a : PhysicsheatsteadyFrame, b : PhysicsheatsteadyFrame) -> PhysicsheatsteadyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_frame_copy(s : PhysicsheatsteadyFrame) -> PhysicsheatsteadyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_frame_fill(s : PhysicsheatsteadyFrame, v : Double) -> PhysicsheatsteadyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_frame_min(s : PhysicsheatsteadyFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_frame_max(s : PhysicsheatsteadyFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_frame_to_string(s : PhysicsheatsteadyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_table_make(size : Int) -> PhysicsheatsteadyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_table_len(s : PhysicsheatsteadyTable) -> Int { s.size }

pub fn physics_heat_steady_table_get(s : PhysicsheatsteadyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_table_set(s : PhysicsheatsteadyTable, i : Int, v : Double) -> PhysicsheatsteadyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_table_sum(s : PhysicsheatsteadyTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_table_mean(s : PhysicsheatsteadyTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_table_scale(s : PhysicsheatsteadyTable, f : Double) -> PhysicsheatsteadyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_table_add(a : PhysicsheatsteadyTable, b : PhysicsheatsteadyTable) -> PhysicsheatsteadyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_table_copy(s : PhysicsheatsteadyTable) -> PhysicsheatsteadyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_table_fill(s : PhysicsheatsteadyTable, v : Double) -> PhysicsheatsteadyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_table_min(s : PhysicsheatsteadyTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_table_max(s : PhysicsheatsteadyTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_table_to_string(s : PhysicsheatsteadyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_graphn_make(size : Int) -> PhysicsheatsteadyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_graphn_len(s : PhysicsheatsteadyGraphN) -> Int { s.size }

pub fn physics_heat_steady_graphn_get(s : PhysicsheatsteadyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_graphn_set(s : PhysicsheatsteadyGraphN, i : Int, v : Double) -> PhysicsheatsteadyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_graphn_sum(s : PhysicsheatsteadyGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_graphn_mean(s : PhysicsheatsteadyGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_graphn_scale(s : PhysicsheatsteadyGraphN, f : Double) -> PhysicsheatsteadyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_graphn_add(a : PhysicsheatsteadyGraphN, b : PhysicsheatsteadyGraphN) -> PhysicsheatsteadyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_graphn_copy(s : PhysicsheatsteadyGraphN) -> PhysicsheatsteadyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_graphn_fill(s : PhysicsheatsteadyGraphN, v : Double) -> PhysicsheatsteadyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_graphn_min(s : PhysicsheatsteadyGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_graphn_max(s : PhysicsheatsteadyGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_graphn_to_string(s : PhysicsheatsteadyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_node_make(size : Int) -> PhysicsheatsteadyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_node_len(s : PhysicsheatsteadyNode) -> Int { s.size }

pub fn physics_heat_steady_node_get(s : PhysicsheatsteadyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_node_set(s : PhysicsheatsteadyNode, i : Int, v : Double) -> PhysicsheatsteadyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_node_sum(s : PhysicsheatsteadyNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_node_mean(s : PhysicsheatsteadyNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_node_scale(s : PhysicsheatsteadyNode, f : Double) -> PhysicsheatsteadyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_node_add(a : PhysicsheatsteadyNode, b : PhysicsheatsteadyNode) -> PhysicsheatsteadyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_node_copy(s : PhysicsheatsteadyNode) -> PhysicsheatsteadyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_node_fill(s : PhysicsheatsteadyNode, v : Double) -> PhysicsheatsteadyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_node_min(s : PhysicsheatsteadyNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_node_max(s : PhysicsheatsteadyNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_node_to_string(s : PhysicsheatsteadyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_edge_make(size : Int) -> PhysicsheatsteadyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_edge_len(s : PhysicsheatsteadyEdge) -> Int { s.size }

pub fn physics_heat_steady_edge_get(s : PhysicsheatsteadyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_edge_set(s : PhysicsheatsteadyEdge, i : Int, v : Double) -> PhysicsheatsteadyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_edge_sum(s : PhysicsheatsteadyEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_edge_mean(s : PhysicsheatsteadyEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_edge_scale(s : PhysicsheatsteadyEdge, f : Double) -> PhysicsheatsteadyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_edge_add(a : PhysicsheatsteadyEdge, b : PhysicsheatsteadyEdge) -> PhysicsheatsteadyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_edge_copy(s : PhysicsheatsteadyEdge) -> PhysicsheatsteadyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_edge_fill(s : PhysicsheatsteadyEdge, v : Double) -> PhysicsheatsteadyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_edge_min(s : PhysicsheatsteadyEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_edge_max(s : PhysicsheatsteadyEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_edge_to_string(s : PhysicsheatsteadyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_path_make(size : Int) -> PhysicsheatsteadyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_path_len(s : PhysicsheatsteadyPath) -> Int { s.size }

pub fn physics_heat_steady_path_get(s : PhysicsheatsteadyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_path_set(s : PhysicsheatsteadyPath, i : Int, v : Double) -> PhysicsheatsteadyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_path_sum(s : PhysicsheatsteadyPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_path_mean(s : PhysicsheatsteadyPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_path_scale(s : PhysicsheatsteadyPath, f : Double) -> PhysicsheatsteadyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_path_add(a : PhysicsheatsteadyPath, b : PhysicsheatsteadyPath) -> PhysicsheatsteadyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_path_copy(s : PhysicsheatsteadyPath) -> PhysicsheatsteadyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_path_fill(s : PhysicsheatsteadyPath, v : Double) -> PhysicsheatsteadyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_path_min(s : PhysicsheatsteadyPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_path_max(s : PhysicsheatsteadyPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_path_to_string(s : PhysicsheatsteadyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_cluster_make(size : Int) -> PhysicsheatsteadyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_cluster_len(s : PhysicsheatsteadyCluster) -> Int { s.size }

pub fn physics_heat_steady_cluster_get(s : PhysicsheatsteadyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_cluster_set(s : PhysicsheatsteadyCluster, i : Int, v : Double) -> PhysicsheatsteadyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cluster_sum(s : PhysicsheatsteadyCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_cluster_mean(s : PhysicsheatsteadyCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_cluster_scale(s : PhysicsheatsteadyCluster, f : Double) -> PhysicsheatsteadyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cluster_add(a : PhysicsheatsteadyCluster, b : PhysicsheatsteadyCluster) -> PhysicsheatsteadyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_cluster_copy(s : PhysicsheatsteadyCluster) -> PhysicsheatsteadyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cluster_fill(s : PhysicsheatsteadyCluster, v : Double) -> PhysicsheatsteadyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cluster_min(s : PhysicsheatsteadyCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_cluster_max(s : PhysicsheatsteadyCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_cluster_to_string(s : PhysicsheatsteadyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_model_make(size : Int) -> PhysicsheatsteadyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_model_len(s : PhysicsheatsteadyModel) -> Int { s.size }

pub fn physics_heat_steady_model_get(s : PhysicsheatsteadyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_model_set(s : PhysicsheatsteadyModel, i : Int, v : Double) -> PhysicsheatsteadyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_model_sum(s : PhysicsheatsteadyModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_model_mean(s : PhysicsheatsteadyModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_model_scale(s : PhysicsheatsteadyModel, f : Double) -> PhysicsheatsteadyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_model_add(a : PhysicsheatsteadyModel, b : PhysicsheatsteadyModel) -> PhysicsheatsteadyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_model_copy(s : PhysicsheatsteadyModel) -> PhysicsheatsteadyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_model_fill(s : PhysicsheatsteadyModel, v : Double) -> PhysicsheatsteadyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_model_min(s : PhysicsheatsteadyModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_model_max(s : PhysicsheatsteadyModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_model_to_string(s : PhysicsheatsteadyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_layer_make(size : Int) -> PhysicsheatsteadyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_layer_len(s : PhysicsheatsteadyLayer) -> Int { s.size }

pub fn physics_heat_steady_layer_get(s : PhysicsheatsteadyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_layer_set(s : PhysicsheatsteadyLayer, i : Int, v : Double) -> PhysicsheatsteadyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_layer_sum(s : PhysicsheatsteadyLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_layer_mean(s : PhysicsheatsteadyLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_layer_scale(s : PhysicsheatsteadyLayer, f : Double) -> PhysicsheatsteadyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_layer_add(a : PhysicsheatsteadyLayer, b : PhysicsheatsteadyLayer) -> PhysicsheatsteadyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_layer_copy(s : PhysicsheatsteadyLayer) -> PhysicsheatsteadyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_layer_fill(s : PhysicsheatsteadyLayer, v : Double) -> PhysicsheatsteadyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_layer_min(s : PhysicsheatsteadyLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_layer_max(s : PhysicsheatsteadyLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_layer_to_string(s : PhysicsheatsteadyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_buffer_make(size : Int) -> PhysicsheatsteadyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_buffer_len(s : PhysicsheatsteadyBuffer) -> Int { s.size }

pub fn physics_heat_steady_buffer_get(s : PhysicsheatsteadyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_buffer_set(s : PhysicsheatsteadyBuffer, i : Int, v : Double) -> PhysicsheatsteadyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_buffer_sum(s : PhysicsheatsteadyBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_buffer_mean(s : PhysicsheatsteadyBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_buffer_scale(s : PhysicsheatsteadyBuffer, f : Double) -> PhysicsheatsteadyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_buffer_add(a : PhysicsheatsteadyBuffer, b : PhysicsheatsteadyBuffer) -> PhysicsheatsteadyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_buffer_copy(s : PhysicsheatsteadyBuffer) -> PhysicsheatsteadyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_buffer_fill(s : PhysicsheatsteadyBuffer, v : Double) -> PhysicsheatsteadyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_buffer_min(s : PhysicsheatsteadyBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_buffer_max(s : PhysicsheatsteadyBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_buffer_to_string(s : PhysicsheatsteadyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_cursor_make(size : Int) -> PhysicsheatsteadyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_cursor_len(s : PhysicsheatsteadyCursor) -> Int { s.size }

pub fn physics_heat_steady_cursor_get(s : PhysicsheatsteadyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_cursor_set(s : PhysicsheatsteadyCursor, i : Int, v : Double) -> PhysicsheatsteadyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cursor_sum(s : PhysicsheatsteadyCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_cursor_mean(s : PhysicsheatsteadyCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_cursor_scale(s : PhysicsheatsteadyCursor, f : Double) -> PhysicsheatsteadyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cursor_add(a : PhysicsheatsteadyCursor, b : PhysicsheatsteadyCursor) -> PhysicsheatsteadyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_cursor_copy(s : PhysicsheatsteadyCursor) -> PhysicsheatsteadyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cursor_fill(s : PhysicsheatsteadyCursor, v : Double) -> PhysicsheatsteadyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_cursor_min(s : PhysicsheatsteadyCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_cursor_max(s : PhysicsheatsteadyCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_cursor_to_string(s : PhysicsheatsteadyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_view_make(size : Int) -> PhysicsheatsteadyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_view_len(s : PhysicsheatsteadyView) -> Int { s.size }

pub fn physics_heat_steady_view_get(s : PhysicsheatsteadyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_view_set(s : PhysicsheatsteadyView, i : Int, v : Double) -> PhysicsheatsteadyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_view_sum(s : PhysicsheatsteadyView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_view_mean(s : PhysicsheatsteadyView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_view_scale(s : PhysicsheatsteadyView, f : Double) -> PhysicsheatsteadyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_view_add(a : PhysicsheatsteadyView, b : PhysicsheatsteadyView) -> PhysicsheatsteadyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_view_copy(s : PhysicsheatsteadyView) -> PhysicsheatsteadyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_view_fill(s : PhysicsheatsteadyView, v : Double) -> PhysicsheatsteadyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_view_min(s : PhysicsheatsteadyView) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_view_max(s : PhysicsheatsteadyView) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_view_to_string(s : PhysicsheatsteadyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_range_make(size : Int) -> PhysicsheatsteadyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_range_len(s : PhysicsheatsteadyRange) -> Int { s.size }

pub fn physics_heat_steady_range_get(s : PhysicsheatsteadyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_range_set(s : PhysicsheatsteadyRange, i : Int, v : Double) -> PhysicsheatsteadyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_range_sum(s : PhysicsheatsteadyRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_range_mean(s : PhysicsheatsteadyRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_range_scale(s : PhysicsheatsteadyRange, f : Double) -> PhysicsheatsteadyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_range_add(a : PhysicsheatsteadyRange, b : PhysicsheatsteadyRange) -> PhysicsheatsteadyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_range_copy(s : PhysicsheatsteadyRange) -> PhysicsheatsteadyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_range_fill(s : PhysicsheatsteadyRange, v : Double) -> PhysicsheatsteadyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_range_min(s : PhysicsheatsteadyRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_range_max(s : PhysicsheatsteadyRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_range_to_string(s : PhysicsheatsteadyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_slice_make(size : Int) -> PhysicsheatsteadySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_slice_len(s : PhysicsheatsteadySlice) -> Int { s.size }

pub fn physics_heat_steady_slice_get(s : PhysicsheatsteadySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_slice_set(s : PhysicsheatsteadySlice, i : Int, v : Double) -> PhysicsheatsteadySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_slice_sum(s : PhysicsheatsteadySlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_steady_slice_mean(s : PhysicsheatsteadySlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_steady_slice_scale(s : PhysicsheatsteadySlice, f : Double) -> PhysicsheatsteadySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_slice_add(a : PhysicsheatsteadySlice, b : PhysicsheatsteadySlice) -> PhysicsheatsteadySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_steady_slice_copy(s : PhysicsheatsteadySlice) -> PhysicsheatsteadySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_slice_fill(s : PhysicsheatsteadySlice, v : Double) -> PhysicsheatsteadySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_steady_slice_min(s : PhysicsheatsteadySlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_steady_slice_max(s : PhysicsheatsteadySlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_steady_slice_to_string(s : PhysicsheatsteadySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

