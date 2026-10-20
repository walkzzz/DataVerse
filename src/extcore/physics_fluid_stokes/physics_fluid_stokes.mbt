///===
/// extcore/physics_fluid_stokes

pub(all) struct PhysicsfluidstokesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_stokes_make_point(x : Double, y : Double) -> PhysicsfluidstokesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_stokes_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidstokesPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluidstokesPoint::x(self : PhysicsfluidstokesPoint) -> Double { self.x }

pub fn PhysicsfluidstokesPoint::y(self : PhysicsfluidstokesPoint) -> Double { self.y }

pub fn PhysicsfluidstokesPoint::z(self : PhysicsfluidstokesPoint) -> Double { self.z }

pub fn PhysicsfluidstokesPoint::label(self : PhysicsfluidstokesPoint) -> Int { self.label }

pub fn PhysicsfluidstokesPoint::dist(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluidstokesPoint::add(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluidstokesPoint::sub(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluidstokesPoint::scale(self : PhysicsfluidstokesPoint, s : Double) -> PhysicsfluidstokesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluidstokesPoint::dot(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluidstokesPoint::cross(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluidstokesPoint::norm(self : PhysicsfluidstokesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluidstokesPoint::normalize(self : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidstokesPoint::negate(self : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluidstokesPoint::mid(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint) -> PhysicsfluidstokesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluidstokesPoint::lerp(self : PhysicsfluidstokesPoint, other : PhysicsfluidstokesPoint, t : Double) -> PhysicsfluidstokesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluidstokesPoint::to_string(self : PhysicsfluidstokesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_stokes_make_series(vals : Array[Double], name : String) -> PhysicsfluidstokesSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluidstokesSeries::len(self : PhysicsfluidstokesSeries) -> Int { self.vals.length() }

pub fn PhysicsfluidstokesSeries::sum(self : PhysicsfluidstokesSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluidstokesSeries::mean(self : PhysicsfluidstokesSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluidstokesSeries::min(self : PhysicsfluidstokesSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluidstokesSeries::max(self : PhysicsfluidstokesSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluidstokesSeries::range(self : PhysicsfluidstokesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluidstokesSeries::variance(self : PhysicsfluidstokesSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluidstokesSeries::std(self : PhysicsfluidstokesSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluidstokesSeries::median(self : PhysicsfluidstokesSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluidstokesSeries::scale(self : PhysicsfluidstokesSeries, f : Double) -> PhysicsfluidstokesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluidstokesSeries::add(self : PhysicsfluidstokesSeries, other : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluidstokesSeries::sub(self : PhysicsfluidstokesSeries, other : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluidstokesSeries::normalize(self : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluidstokesSeries::cumsum(self : PhysicsfluidstokesSeries) -> PhysicsfluidstokesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluidstokesSeries::to_string(self : PhysicsfluidstokesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidstokesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_stokes_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidstokesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_stokes_matrix_identity(n : Int) -> PhysicsfluidstokesMatrix {
  let m = physics_fluid_stokes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluidstokesMatrix::get(self : PhysicsfluidstokesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluidstokesMatrix::transpose(self : PhysicsfluidstokesMatrix) -> PhysicsfluidstokesMatrix {
  let result = physics_fluid_stokes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluidstokesMatrix::add(self : PhysicsfluidstokesMatrix, other : PhysicsfluidstokesMatrix) -> PhysicsfluidstokesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_stokes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluidstokesMatrix::scale(self : PhysicsfluidstokesMatrix, s : Double) -> PhysicsfluidstokesMatrix {
  let result = physics_fluid_stokes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluidstokesMatrix::multiply(self : PhysicsfluidstokesMatrix, other : PhysicsfluidstokesMatrix) -> PhysicsfluidstokesMatrix {
  if self.cols != other.rows { return physics_fluid_stokes_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_stokes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluidstokesMatrix::trace(self : PhysicsfluidstokesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluidstokesMatrix::det(self : PhysicsfluidstokesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluidstokesMatrix::norm(self : PhysicsfluidstokesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluidstokesMatrix::to_string(self : PhysicsfluidstokesMatrix) -> String {
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

pub(all) struct PhysicsfluidstokesVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_stokes_make_vector(comps : Array[Double]) -> PhysicsfluidstokesVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_stokes_vector_zero(dim : Int) -> PhysicsfluidstokesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluidstokesVector::add(self : PhysicsfluidstokesVector, other : PhysicsfluidstokesVector) -> PhysicsfluidstokesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidstokesVector::sub(self : PhysicsfluidstokesVector, other : PhysicsfluidstokesVector) -> PhysicsfluidstokesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluidstokesVector::scale(self : PhysicsfluidstokesVector, s : Double) -> PhysicsfluidstokesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluidstokesVector::dot(self : PhysicsfluidstokesVector, other : PhysicsfluidstokesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluidstokesVector::norm(self : PhysicsfluidstokesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluidstokesVector::normalize(self : PhysicsfluidstokesVector) -> PhysicsfluidstokesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluidstokesVector::dist(self : PhysicsfluidstokesVector, other : PhysicsfluidstokesVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluidstokesVector::to_string(self : PhysicsfluidstokesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_stokes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_stokes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_stokes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_stokes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_stokes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_stokes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_stokes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_stokes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_stokes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_stokes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_stokes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_stokes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_stokes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_stokes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_stokes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_stokes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_stokes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_stokes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_stokes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_stokes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_stokes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_stokes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_stokes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_stokes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_stokes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_stokes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_stokes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_stokes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_stokes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidstokesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_frame_make(size : Int) -> PhysicsfluidstokesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_frame_len(s : PhysicsfluidstokesFrame) -> Int { s.size }

pub fn physics_fluid_stokes_frame_get(s : PhysicsfluidstokesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_frame_set(s : PhysicsfluidstokesFrame, i : Int, v : Double) -> PhysicsfluidstokesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_frame_sum(s : PhysicsfluidstokesFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_frame_mean(s : PhysicsfluidstokesFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_frame_scale(s : PhysicsfluidstokesFrame, f : Double) -> PhysicsfluidstokesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_frame_add(a : PhysicsfluidstokesFrame, b : PhysicsfluidstokesFrame) -> PhysicsfluidstokesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_frame_copy(s : PhysicsfluidstokesFrame) -> PhysicsfluidstokesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_frame_fill(s : PhysicsfluidstokesFrame, v : Double) -> PhysicsfluidstokesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_frame_min(s : PhysicsfluidstokesFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_frame_max(s : PhysicsfluidstokesFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_frame_to_string(s : PhysicsfluidstokesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_table_make(size : Int) -> PhysicsfluidstokesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_table_len(s : PhysicsfluidstokesTable) -> Int { s.size }

pub fn physics_fluid_stokes_table_get(s : PhysicsfluidstokesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_table_set(s : PhysicsfluidstokesTable, i : Int, v : Double) -> PhysicsfluidstokesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_table_sum(s : PhysicsfluidstokesTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_table_mean(s : PhysicsfluidstokesTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_table_scale(s : PhysicsfluidstokesTable, f : Double) -> PhysicsfluidstokesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_table_add(a : PhysicsfluidstokesTable, b : PhysicsfluidstokesTable) -> PhysicsfluidstokesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_table_copy(s : PhysicsfluidstokesTable) -> PhysicsfluidstokesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_table_fill(s : PhysicsfluidstokesTable, v : Double) -> PhysicsfluidstokesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_table_min(s : PhysicsfluidstokesTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_table_max(s : PhysicsfluidstokesTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_table_to_string(s : PhysicsfluidstokesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_graphn_make(size : Int) -> PhysicsfluidstokesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_graphn_len(s : PhysicsfluidstokesGraphN) -> Int { s.size }

pub fn physics_fluid_stokes_graphn_get(s : PhysicsfluidstokesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_graphn_set(s : PhysicsfluidstokesGraphN, i : Int, v : Double) -> PhysicsfluidstokesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_graphn_sum(s : PhysicsfluidstokesGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_graphn_mean(s : PhysicsfluidstokesGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_graphn_scale(s : PhysicsfluidstokesGraphN, f : Double) -> PhysicsfluidstokesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_graphn_add(a : PhysicsfluidstokesGraphN, b : PhysicsfluidstokesGraphN) -> PhysicsfluidstokesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_graphn_copy(s : PhysicsfluidstokesGraphN) -> PhysicsfluidstokesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_graphn_fill(s : PhysicsfluidstokesGraphN, v : Double) -> PhysicsfluidstokesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_graphn_min(s : PhysicsfluidstokesGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_graphn_max(s : PhysicsfluidstokesGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_graphn_to_string(s : PhysicsfluidstokesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_node_make(size : Int) -> PhysicsfluidstokesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_node_len(s : PhysicsfluidstokesNode) -> Int { s.size }

pub fn physics_fluid_stokes_node_get(s : PhysicsfluidstokesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_node_set(s : PhysicsfluidstokesNode, i : Int, v : Double) -> PhysicsfluidstokesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_node_sum(s : PhysicsfluidstokesNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_node_mean(s : PhysicsfluidstokesNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_node_scale(s : PhysicsfluidstokesNode, f : Double) -> PhysicsfluidstokesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_node_add(a : PhysicsfluidstokesNode, b : PhysicsfluidstokesNode) -> PhysicsfluidstokesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_node_copy(s : PhysicsfluidstokesNode) -> PhysicsfluidstokesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_node_fill(s : PhysicsfluidstokesNode, v : Double) -> PhysicsfluidstokesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_node_min(s : PhysicsfluidstokesNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_node_max(s : PhysicsfluidstokesNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_node_to_string(s : PhysicsfluidstokesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_edge_make(size : Int) -> PhysicsfluidstokesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_edge_len(s : PhysicsfluidstokesEdge) -> Int { s.size }

pub fn physics_fluid_stokes_edge_get(s : PhysicsfluidstokesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_edge_set(s : PhysicsfluidstokesEdge, i : Int, v : Double) -> PhysicsfluidstokesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_edge_sum(s : PhysicsfluidstokesEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_edge_mean(s : PhysicsfluidstokesEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_edge_scale(s : PhysicsfluidstokesEdge, f : Double) -> PhysicsfluidstokesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_edge_add(a : PhysicsfluidstokesEdge, b : PhysicsfluidstokesEdge) -> PhysicsfluidstokesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_edge_copy(s : PhysicsfluidstokesEdge) -> PhysicsfluidstokesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_edge_fill(s : PhysicsfluidstokesEdge, v : Double) -> PhysicsfluidstokesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_edge_min(s : PhysicsfluidstokesEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_edge_max(s : PhysicsfluidstokesEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_edge_to_string(s : PhysicsfluidstokesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_path_make(size : Int) -> PhysicsfluidstokesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_path_len(s : PhysicsfluidstokesPath) -> Int { s.size }

pub fn physics_fluid_stokes_path_get(s : PhysicsfluidstokesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_path_set(s : PhysicsfluidstokesPath, i : Int, v : Double) -> PhysicsfluidstokesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_path_sum(s : PhysicsfluidstokesPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_path_mean(s : PhysicsfluidstokesPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_path_scale(s : PhysicsfluidstokesPath, f : Double) -> PhysicsfluidstokesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_path_add(a : PhysicsfluidstokesPath, b : PhysicsfluidstokesPath) -> PhysicsfluidstokesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_path_copy(s : PhysicsfluidstokesPath) -> PhysicsfluidstokesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_path_fill(s : PhysicsfluidstokesPath, v : Double) -> PhysicsfluidstokesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_path_min(s : PhysicsfluidstokesPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_path_max(s : PhysicsfluidstokesPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_path_to_string(s : PhysicsfluidstokesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_cluster_make(size : Int) -> PhysicsfluidstokesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_cluster_len(s : PhysicsfluidstokesCluster) -> Int { s.size }

pub fn physics_fluid_stokes_cluster_get(s : PhysicsfluidstokesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_cluster_set(s : PhysicsfluidstokesCluster, i : Int, v : Double) -> PhysicsfluidstokesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cluster_sum(s : PhysicsfluidstokesCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_cluster_mean(s : PhysicsfluidstokesCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_cluster_scale(s : PhysicsfluidstokesCluster, f : Double) -> PhysicsfluidstokesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cluster_add(a : PhysicsfluidstokesCluster, b : PhysicsfluidstokesCluster) -> PhysicsfluidstokesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_cluster_copy(s : PhysicsfluidstokesCluster) -> PhysicsfluidstokesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cluster_fill(s : PhysicsfluidstokesCluster, v : Double) -> PhysicsfluidstokesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cluster_min(s : PhysicsfluidstokesCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_cluster_max(s : PhysicsfluidstokesCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_cluster_to_string(s : PhysicsfluidstokesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_model_make(size : Int) -> PhysicsfluidstokesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_model_len(s : PhysicsfluidstokesModel) -> Int { s.size }

pub fn physics_fluid_stokes_model_get(s : PhysicsfluidstokesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_model_set(s : PhysicsfluidstokesModel, i : Int, v : Double) -> PhysicsfluidstokesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_model_sum(s : PhysicsfluidstokesModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_model_mean(s : PhysicsfluidstokesModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_model_scale(s : PhysicsfluidstokesModel, f : Double) -> PhysicsfluidstokesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_model_add(a : PhysicsfluidstokesModel, b : PhysicsfluidstokesModel) -> PhysicsfluidstokesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_model_copy(s : PhysicsfluidstokesModel) -> PhysicsfluidstokesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_model_fill(s : PhysicsfluidstokesModel, v : Double) -> PhysicsfluidstokesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_model_min(s : PhysicsfluidstokesModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_model_max(s : PhysicsfluidstokesModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_model_to_string(s : PhysicsfluidstokesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_layer_make(size : Int) -> PhysicsfluidstokesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_layer_len(s : PhysicsfluidstokesLayer) -> Int { s.size }

pub fn physics_fluid_stokes_layer_get(s : PhysicsfluidstokesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_layer_set(s : PhysicsfluidstokesLayer, i : Int, v : Double) -> PhysicsfluidstokesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_layer_sum(s : PhysicsfluidstokesLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_layer_mean(s : PhysicsfluidstokesLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_layer_scale(s : PhysicsfluidstokesLayer, f : Double) -> PhysicsfluidstokesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_layer_add(a : PhysicsfluidstokesLayer, b : PhysicsfluidstokesLayer) -> PhysicsfluidstokesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_layer_copy(s : PhysicsfluidstokesLayer) -> PhysicsfluidstokesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_layer_fill(s : PhysicsfluidstokesLayer, v : Double) -> PhysicsfluidstokesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_layer_min(s : PhysicsfluidstokesLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_layer_max(s : PhysicsfluidstokesLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_layer_to_string(s : PhysicsfluidstokesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_buffer_make(size : Int) -> PhysicsfluidstokesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_buffer_len(s : PhysicsfluidstokesBuffer) -> Int { s.size }

pub fn physics_fluid_stokes_buffer_get(s : PhysicsfluidstokesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_buffer_set(s : PhysicsfluidstokesBuffer, i : Int, v : Double) -> PhysicsfluidstokesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_buffer_sum(s : PhysicsfluidstokesBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_buffer_mean(s : PhysicsfluidstokesBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_buffer_scale(s : PhysicsfluidstokesBuffer, f : Double) -> PhysicsfluidstokesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_buffer_add(a : PhysicsfluidstokesBuffer, b : PhysicsfluidstokesBuffer) -> PhysicsfluidstokesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_buffer_copy(s : PhysicsfluidstokesBuffer) -> PhysicsfluidstokesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_buffer_fill(s : PhysicsfluidstokesBuffer, v : Double) -> PhysicsfluidstokesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_buffer_min(s : PhysicsfluidstokesBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_buffer_max(s : PhysicsfluidstokesBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_buffer_to_string(s : PhysicsfluidstokesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_cursor_make(size : Int) -> PhysicsfluidstokesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_cursor_len(s : PhysicsfluidstokesCursor) -> Int { s.size }

pub fn physics_fluid_stokes_cursor_get(s : PhysicsfluidstokesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_cursor_set(s : PhysicsfluidstokesCursor, i : Int, v : Double) -> PhysicsfluidstokesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cursor_sum(s : PhysicsfluidstokesCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_cursor_mean(s : PhysicsfluidstokesCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_cursor_scale(s : PhysicsfluidstokesCursor, f : Double) -> PhysicsfluidstokesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cursor_add(a : PhysicsfluidstokesCursor, b : PhysicsfluidstokesCursor) -> PhysicsfluidstokesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_cursor_copy(s : PhysicsfluidstokesCursor) -> PhysicsfluidstokesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cursor_fill(s : PhysicsfluidstokesCursor, v : Double) -> PhysicsfluidstokesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_cursor_min(s : PhysicsfluidstokesCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_cursor_max(s : PhysicsfluidstokesCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_cursor_to_string(s : PhysicsfluidstokesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_view_make(size : Int) -> PhysicsfluidstokesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_view_len(s : PhysicsfluidstokesView) -> Int { s.size }

pub fn physics_fluid_stokes_view_get(s : PhysicsfluidstokesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_view_set(s : PhysicsfluidstokesView, i : Int, v : Double) -> PhysicsfluidstokesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_view_sum(s : PhysicsfluidstokesView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_view_mean(s : PhysicsfluidstokesView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_view_scale(s : PhysicsfluidstokesView, f : Double) -> PhysicsfluidstokesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_view_add(a : PhysicsfluidstokesView, b : PhysicsfluidstokesView) -> PhysicsfluidstokesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_view_copy(s : PhysicsfluidstokesView) -> PhysicsfluidstokesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_view_fill(s : PhysicsfluidstokesView, v : Double) -> PhysicsfluidstokesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_view_min(s : PhysicsfluidstokesView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_view_max(s : PhysicsfluidstokesView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_view_to_string(s : PhysicsfluidstokesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_range_make(size : Int) -> PhysicsfluidstokesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_range_len(s : PhysicsfluidstokesRange) -> Int { s.size }

pub fn physics_fluid_stokes_range_get(s : PhysicsfluidstokesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_range_set(s : PhysicsfluidstokesRange, i : Int, v : Double) -> PhysicsfluidstokesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_range_sum(s : PhysicsfluidstokesRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_range_mean(s : PhysicsfluidstokesRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_range_scale(s : PhysicsfluidstokesRange, f : Double) -> PhysicsfluidstokesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_range_add(a : PhysicsfluidstokesRange, b : PhysicsfluidstokesRange) -> PhysicsfluidstokesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_range_copy(s : PhysicsfluidstokesRange) -> PhysicsfluidstokesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_range_fill(s : PhysicsfluidstokesRange, v : Double) -> PhysicsfluidstokesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_range_min(s : PhysicsfluidstokesRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_range_max(s : PhysicsfluidstokesRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_range_to_string(s : PhysicsfluidstokesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidstokesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_stokes_slice_make(size : Int) -> PhysicsfluidstokesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_stokes_slice_len(s : PhysicsfluidstokesSlice) -> Int { s.size }

pub fn physics_fluid_stokes_slice_get(s : PhysicsfluidstokesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_stokes_slice_set(s : PhysicsfluidstokesSlice, i : Int, v : Double) -> PhysicsfluidstokesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_slice_sum(s : PhysicsfluidstokesSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_stokes_slice_mean(s : PhysicsfluidstokesSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_stokes_slice_scale(s : PhysicsfluidstokesSlice, f : Double) -> PhysicsfluidstokesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_slice_add(a : PhysicsfluidstokesSlice, b : PhysicsfluidstokesSlice) -> PhysicsfluidstokesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_stokes_slice_copy(s : PhysicsfluidstokesSlice) -> PhysicsfluidstokesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_slice_fill(s : PhysicsfluidstokesSlice, v : Double) -> PhysicsfluidstokesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_stokes_slice_min(s : PhysicsfluidstokesSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_stokes_slice_max(s : PhysicsfluidstokesSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_stokes_slice_to_string(s : PhysicsfluidstokesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

