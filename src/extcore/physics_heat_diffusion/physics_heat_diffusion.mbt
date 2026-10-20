///===
/// extcore/physics_heat_diffusion

pub(all) struct PhysicsheatdiffusionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_diffusion_make_point(x : Double, y : Double) -> PhysicsheatdiffusionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_diffusion_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatdiffusionPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatdiffusionPoint::x(self : PhysicsheatdiffusionPoint) -> Double { self.x }

pub fn PhysicsheatdiffusionPoint::y(self : PhysicsheatdiffusionPoint) -> Double { self.y }

pub fn PhysicsheatdiffusionPoint::z(self : PhysicsheatdiffusionPoint) -> Double { self.z }

pub fn PhysicsheatdiffusionPoint::label(self : PhysicsheatdiffusionPoint) -> Int { self.label }

pub fn PhysicsheatdiffusionPoint::dist(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatdiffusionPoint::add(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatdiffusionPoint::sub(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatdiffusionPoint::scale(self : PhysicsheatdiffusionPoint, s : Double) -> PhysicsheatdiffusionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatdiffusionPoint::dot(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatdiffusionPoint::cross(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatdiffusionPoint::norm(self : PhysicsheatdiffusionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatdiffusionPoint::normalize(self : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatdiffusionPoint::negate(self : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatdiffusionPoint::mid(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatdiffusionPoint::lerp(self : PhysicsheatdiffusionPoint, other : PhysicsheatdiffusionPoint, t : Double) -> PhysicsheatdiffusionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatdiffusionPoint::to_string(self : PhysicsheatdiffusionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_diffusion_make_series(vals : Array[Double], name : String) -> PhysicsheatdiffusionSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatdiffusionSeries::len(self : PhysicsheatdiffusionSeries) -> Int { self.vals.length() }

pub fn PhysicsheatdiffusionSeries::sum(self : PhysicsheatdiffusionSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatdiffusionSeries::mean(self : PhysicsheatdiffusionSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatdiffusionSeries::min(self : PhysicsheatdiffusionSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatdiffusionSeries::max(self : PhysicsheatdiffusionSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatdiffusionSeries::range(self : PhysicsheatdiffusionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatdiffusionSeries::variance(self : PhysicsheatdiffusionSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatdiffusionSeries::std(self : PhysicsheatdiffusionSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatdiffusionSeries::median(self : PhysicsheatdiffusionSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatdiffusionSeries::scale(self : PhysicsheatdiffusionSeries, f : Double) -> PhysicsheatdiffusionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatdiffusionSeries::add(self : PhysicsheatdiffusionSeries, other : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatdiffusionSeries::sub(self : PhysicsheatdiffusionSeries, other : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatdiffusionSeries::normalize(self : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatdiffusionSeries::cumsum(self : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatdiffusionSeries::to_string(self : PhysicsheatdiffusionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatdiffusionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_diffusion_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatdiffusionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_diffusion_matrix_identity(n : Int) -> PhysicsheatdiffusionMatrix {
  let m = physics_heat_diffusion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatdiffusionMatrix::get(self : PhysicsheatdiffusionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatdiffusionMatrix::transpose(self : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  let result = physics_heat_diffusion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatdiffusionMatrix::add(self : PhysicsheatdiffusionMatrix, other : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_diffusion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatdiffusionMatrix::scale(self : PhysicsheatdiffusionMatrix, s : Double) -> PhysicsheatdiffusionMatrix {
  let result = physics_heat_diffusion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatdiffusionMatrix::multiply(self : PhysicsheatdiffusionMatrix, other : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  if self.cols != other.rows { return physics_heat_diffusion_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_diffusion_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatdiffusionMatrix::trace(self : PhysicsheatdiffusionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatdiffusionMatrix::det(self : PhysicsheatdiffusionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatdiffusionMatrix::norm(self : PhysicsheatdiffusionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatdiffusionMatrix::to_string(self : PhysicsheatdiffusionMatrix) -> String {
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

pub(all) struct PhysicsheatdiffusionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_diffusion_make_vector(comps : Array[Double]) -> PhysicsheatdiffusionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_diffusion_vector_zero(dim : Int) -> PhysicsheatdiffusionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatdiffusionVector::add(self : PhysicsheatdiffusionVector, other : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatdiffusionVector::sub(self : PhysicsheatdiffusionVector, other : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatdiffusionVector::scale(self : PhysicsheatdiffusionVector, s : Double) -> PhysicsheatdiffusionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatdiffusionVector::dot(self : PhysicsheatdiffusionVector, other : PhysicsheatdiffusionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatdiffusionVector::norm(self : PhysicsheatdiffusionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatdiffusionVector::normalize(self : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatdiffusionVector::dist(self : PhysicsheatdiffusionVector, other : PhysicsheatdiffusionVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatdiffusionVector::to_string(self : PhysicsheatdiffusionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_diffusion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_diffusion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_diffusion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_diffusion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_diffusion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_diffusion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_diffusion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_diffusion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_diffusion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_diffusion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_diffusion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_diffusion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_diffusion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_diffusion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_diffusion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_diffusion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_diffusion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_diffusion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_diffusion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_diffusion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_diffusion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_diffusion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_diffusion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_diffusion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_diffusion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_diffusion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_diffusion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_diffusion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_diffusion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatdiffusionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_frame_make(size : Int) -> PhysicsheatdiffusionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionFrame::len(self : PhysicsheatdiffusionFrame) -> Int { self.size }

pub fn PhysicsheatdiffusionFrame::get(self : PhysicsheatdiffusionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionFrame::set(self : PhysicsheatdiffusionFrame, i : Int, v : Double) -> PhysicsheatdiffusionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionFrame::sum(self : PhysicsheatdiffusionFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionFrame::mean(self : PhysicsheatdiffusionFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionFrame::scale(self : PhysicsheatdiffusionFrame, f : Double) -> PhysicsheatdiffusionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionFrame::add(self : PhysicsheatdiffusionFrame, other : PhysicsheatdiffusionFrame) -> PhysicsheatdiffusionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionFrame::copy(self : PhysicsheatdiffusionFrame) -> PhysicsheatdiffusionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionFrame::fill(self : PhysicsheatdiffusionFrame, v : Double) -> PhysicsheatdiffusionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionFrame::min(self : PhysicsheatdiffusionFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionFrame::max(self : PhysicsheatdiffusionFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionFrame::to_string(self : PhysicsheatdiffusionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_table_make(size : Int) -> PhysicsheatdiffusionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionTable::len(self : PhysicsheatdiffusionTable) -> Int { self.size }

pub fn PhysicsheatdiffusionTable::get(self : PhysicsheatdiffusionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionTable::set(self : PhysicsheatdiffusionTable, i : Int, v : Double) -> PhysicsheatdiffusionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionTable::sum(self : PhysicsheatdiffusionTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionTable::mean(self : PhysicsheatdiffusionTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionTable::scale(self : PhysicsheatdiffusionTable, f : Double) -> PhysicsheatdiffusionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionTable::add(self : PhysicsheatdiffusionTable, other : PhysicsheatdiffusionTable) -> PhysicsheatdiffusionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionTable::copy(self : PhysicsheatdiffusionTable) -> PhysicsheatdiffusionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionTable::fill(self : PhysicsheatdiffusionTable, v : Double) -> PhysicsheatdiffusionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionTable::min(self : PhysicsheatdiffusionTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionTable::max(self : PhysicsheatdiffusionTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionTable::to_string(self : PhysicsheatdiffusionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_graphn_make(size : Int) -> PhysicsheatdiffusionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionGraphN::len(self : PhysicsheatdiffusionGraphN) -> Int { self.size }

pub fn PhysicsheatdiffusionGraphN::get(self : PhysicsheatdiffusionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionGraphN::set(self : PhysicsheatdiffusionGraphN, i : Int, v : Double) -> PhysicsheatdiffusionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionGraphN::sum(self : PhysicsheatdiffusionGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionGraphN::mean(self : PhysicsheatdiffusionGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionGraphN::scale(self : PhysicsheatdiffusionGraphN, f : Double) -> PhysicsheatdiffusionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionGraphN::add(self : PhysicsheatdiffusionGraphN, other : PhysicsheatdiffusionGraphN) -> PhysicsheatdiffusionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionGraphN::copy(self : PhysicsheatdiffusionGraphN) -> PhysicsheatdiffusionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionGraphN::fill(self : PhysicsheatdiffusionGraphN, v : Double) -> PhysicsheatdiffusionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionGraphN::min(self : PhysicsheatdiffusionGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionGraphN::max(self : PhysicsheatdiffusionGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionGraphN::to_string(self : PhysicsheatdiffusionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_node_make(size : Int) -> PhysicsheatdiffusionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionNode::len(self : PhysicsheatdiffusionNode) -> Int { self.size }

pub fn PhysicsheatdiffusionNode::get(self : PhysicsheatdiffusionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionNode::set(self : PhysicsheatdiffusionNode, i : Int, v : Double) -> PhysicsheatdiffusionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionNode::sum(self : PhysicsheatdiffusionNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionNode::mean(self : PhysicsheatdiffusionNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionNode::scale(self : PhysicsheatdiffusionNode, f : Double) -> PhysicsheatdiffusionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionNode::add(self : PhysicsheatdiffusionNode, other : PhysicsheatdiffusionNode) -> PhysicsheatdiffusionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionNode::copy(self : PhysicsheatdiffusionNode) -> PhysicsheatdiffusionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionNode::fill(self : PhysicsheatdiffusionNode, v : Double) -> PhysicsheatdiffusionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionNode::min(self : PhysicsheatdiffusionNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionNode::max(self : PhysicsheatdiffusionNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionNode::to_string(self : PhysicsheatdiffusionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_edge_make(size : Int) -> PhysicsheatdiffusionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionEdge::len(self : PhysicsheatdiffusionEdge) -> Int { self.size }

pub fn PhysicsheatdiffusionEdge::get(self : PhysicsheatdiffusionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionEdge::set(self : PhysicsheatdiffusionEdge, i : Int, v : Double) -> PhysicsheatdiffusionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionEdge::sum(self : PhysicsheatdiffusionEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionEdge::mean(self : PhysicsheatdiffusionEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionEdge::scale(self : PhysicsheatdiffusionEdge, f : Double) -> PhysicsheatdiffusionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionEdge::add(self : PhysicsheatdiffusionEdge, other : PhysicsheatdiffusionEdge) -> PhysicsheatdiffusionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionEdge::copy(self : PhysicsheatdiffusionEdge) -> PhysicsheatdiffusionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionEdge::fill(self : PhysicsheatdiffusionEdge, v : Double) -> PhysicsheatdiffusionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionEdge::min(self : PhysicsheatdiffusionEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionEdge::max(self : PhysicsheatdiffusionEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionEdge::to_string(self : PhysicsheatdiffusionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_path_make(size : Int) -> PhysicsheatdiffusionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionPath::len(self : PhysicsheatdiffusionPath) -> Int { self.size }

pub fn PhysicsheatdiffusionPath::get(self : PhysicsheatdiffusionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionPath::set(self : PhysicsheatdiffusionPath, i : Int, v : Double) -> PhysicsheatdiffusionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionPath::sum(self : PhysicsheatdiffusionPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionPath::mean(self : PhysicsheatdiffusionPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionPath::scale(self : PhysicsheatdiffusionPath, f : Double) -> PhysicsheatdiffusionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionPath::add(self : PhysicsheatdiffusionPath, other : PhysicsheatdiffusionPath) -> PhysicsheatdiffusionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionPath::copy(self : PhysicsheatdiffusionPath) -> PhysicsheatdiffusionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionPath::fill(self : PhysicsheatdiffusionPath, v : Double) -> PhysicsheatdiffusionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionPath::min(self : PhysicsheatdiffusionPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionPath::max(self : PhysicsheatdiffusionPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionPath::to_string(self : PhysicsheatdiffusionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_cluster_make(size : Int) -> PhysicsheatdiffusionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionCluster::len(self : PhysicsheatdiffusionCluster) -> Int { self.size }

pub fn PhysicsheatdiffusionCluster::get(self : PhysicsheatdiffusionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionCluster::set(self : PhysicsheatdiffusionCluster, i : Int, v : Double) -> PhysicsheatdiffusionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCluster::sum(self : PhysicsheatdiffusionCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionCluster::mean(self : PhysicsheatdiffusionCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionCluster::scale(self : PhysicsheatdiffusionCluster, f : Double) -> PhysicsheatdiffusionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCluster::add(self : PhysicsheatdiffusionCluster, other : PhysicsheatdiffusionCluster) -> PhysicsheatdiffusionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionCluster::copy(self : PhysicsheatdiffusionCluster) -> PhysicsheatdiffusionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCluster::fill(self : PhysicsheatdiffusionCluster, v : Double) -> PhysicsheatdiffusionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCluster::min(self : PhysicsheatdiffusionCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionCluster::max(self : PhysicsheatdiffusionCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionCluster::to_string(self : PhysicsheatdiffusionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_model_make(size : Int) -> PhysicsheatdiffusionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionModel::len(self : PhysicsheatdiffusionModel) -> Int { self.size }

pub fn PhysicsheatdiffusionModel::get(self : PhysicsheatdiffusionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionModel::set(self : PhysicsheatdiffusionModel, i : Int, v : Double) -> PhysicsheatdiffusionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionModel::sum(self : PhysicsheatdiffusionModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionModel::mean(self : PhysicsheatdiffusionModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionModel::scale(self : PhysicsheatdiffusionModel, f : Double) -> PhysicsheatdiffusionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionModel::add(self : PhysicsheatdiffusionModel, other : PhysicsheatdiffusionModel) -> PhysicsheatdiffusionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionModel::copy(self : PhysicsheatdiffusionModel) -> PhysicsheatdiffusionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionModel::fill(self : PhysicsheatdiffusionModel, v : Double) -> PhysicsheatdiffusionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionModel::min(self : PhysicsheatdiffusionModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionModel::max(self : PhysicsheatdiffusionModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionModel::to_string(self : PhysicsheatdiffusionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_layer_make(size : Int) -> PhysicsheatdiffusionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionLayer::len(self : PhysicsheatdiffusionLayer) -> Int { self.size }

pub fn PhysicsheatdiffusionLayer::get(self : PhysicsheatdiffusionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionLayer::set(self : PhysicsheatdiffusionLayer, i : Int, v : Double) -> PhysicsheatdiffusionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionLayer::sum(self : PhysicsheatdiffusionLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionLayer::mean(self : PhysicsheatdiffusionLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionLayer::scale(self : PhysicsheatdiffusionLayer, f : Double) -> PhysicsheatdiffusionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionLayer::add(self : PhysicsheatdiffusionLayer, other : PhysicsheatdiffusionLayer) -> PhysicsheatdiffusionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionLayer::copy(self : PhysicsheatdiffusionLayer) -> PhysicsheatdiffusionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionLayer::fill(self : PhysicsheatdiffusionLayer, v : Double) -> PhysicsheatdiffusionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionLayer::min(self : PhysicsheatdiffusionLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionLayer::max(self : PhysicsheatdiffusionLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionLayer::to_string(self : PhysicsheatdiffusionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_buffer_make(size : Int) -> PhysicsheatdiffusionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionBuffer::len(self : PhysicsheatdiffusionBuffer) -> Int { self.size }

pub fn PhysicsheatdiffusionBuffer::get(self : PhysicsheatdiffusionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionBuffer::set(self : PhysicsheatdiffusionBuffer, i : Int, v : Double) -> PhysicsheatdiffusionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionBuffer::sum(self : PhysicsheatdiffusionBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionBuffer::mean(self : PhysicsheatdiffusionBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionBuffer::scale(self : PhysicsheatdiffusionBuffer, f : Double) -> PhysicsheatdiffusionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionBuffer::add(self : PhysicsheatdiffusionBuffer, other : PhysicsheatdiffusionBuffer) -> PhysicsheatdiffusionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionBuffer::copy(self : PhysicsheatdiffusionBuffer) -> PhysicsheatdiffusionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionBuffer::fill(self : PhysicsheatdiffusionBuffer, v : Double) -> PhysicsheatdiffusionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionBuffer::min(self : PhysicsheatdiffusionBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionBuffer::max(self : PhysicsheatdiffusionBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionBuffer::to_string(self : PhysicsheatdiffusionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_cursor_make(size : Int) -> PhysicsheatdiffusionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionCursor::len(self : PhysicsheatdiffusionCursor) -> Int { self.size }

pub fn PhysicsheatdiffusionCursor::get(self : PhysicsheatdiffusionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionCursor::set(self : PhysicsheatdiffusionCursor, i : Int, v : Double) -> PhysicsheatdiffusionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCursor::sum(self : PhysicsheatdiffusionCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionCursor::mean(self : PhysicsheatdiffusionCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionCursor::scale(self : PhysicsheatdiffusionCursor, f : Double) -> PhysicsheatdiffusionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCursor::add(self : PhysicsheatdiffusionCursor, other : PhysicsheatdiffusionCursor) -> PhysicsheatdiffusionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionCursor::copy(self : PhysicsheatdiffusionCursor) -> PhysicsheatdiffusionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCursor::fill(self : PhysicsheatdiffusionCursor, v : Double) -> PhysicsheatdiffusionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionCursor::min(self : PhysicsheatdiffusionCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionCursor::max(self : PhysicsheatdiffusionCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionCursor::to_string(self : PhysicsheatdiffusionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_view_make(size : Int) -> PhysicsheatdiffusionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionView::len(self : PhysicsheatdiffusionView) -> Int { self.size }

pub fn PhysicsheatdiffusionView::get(self : PhysicsheatdiffusionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionView::set(self : PhysicsheatdiffusionView, i : Int, v : Double) -> PhysicsheatdiffusionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionView::sum(self : PhysicsheatdiffusionView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionView::mean(self : PhysicsheatdiffusionView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionView::scale(self : PhysicsheatdiffusionView, f : Double) -> PhysicsheatdiffusionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionView::add(self : PhysicsheatdiffusionView, other : PhysicsheatdiffusionView) -> PhysicsheatdiffusionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionView::copy(self : PhysicsheatdiffusionView) -> PhysicsheatdiffusionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionView::fill(self : PhysicsheatdiffusionView, v : Double) -> PhysicsheatdiffusionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionView::min(self : PhysicsheatdiffusionView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionView::max(self : PhysicsheatdiffusionView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionView::to_string(self : PhysicsheatdiffusionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_range_make(size : Int) -> PhysicsheatdiffusionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionRange::len(self : PhysicsheatdiffusionRange) -> Int { self.size }

pub fn PhysicsheatdiffusionRange::get(self : PhysicsheatdiffusionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionRange::set(self : PhysicsheatdiffusionRange, i : Int, v : Double) -> PhysicsheatdiffusionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionRange::sum(self : PhysicsheatdiffusionRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionRange::mean(self : PhysicsheatdiffusionRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionRange::scale(self : PhysicsheatdiffusionRange, f : Double) -> PhysicsheatdiffusionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionRange::add(self : PhysicsheatdiffusionRange, other : PhysicsheatdiffusionRange) -> PhysicsheatdiffusionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionRange::copy(self : PhysicsheatdiffusionRange) -> PhysicsheatdiffusionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionRange::fill(self : PhysicsheatdiffusionRange, v : Double) -> PhysicsheatdiffusionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionRange::min(self : PhysicsheatdiffusionRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionRange::max(self : PhysicsheatdiffusionRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionRange::to_string(self : PhysicsheatdiffusionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_slice_make(size : Int) -> PhysicsheatdiffusionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatdiffusionSlice::len(self : PhysicsheatdiffusionSlice) -> Int { self.size }

pub fn PhysicsheatdiffusionSlice::get(self : PhysicsheatdiffusionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatdiffusionSlice::set(self : PhysicsheatdiffusionSlice, i : Int, v : Double) -> PhysicsheatdiffusionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionSlice::sum(self : PhysicsheatdiffusionSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatdiffusionSlice::mean(self : PhysicsheatdiffusionSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatdiffusionSlice::scale(self : PhysicsheatdiffusionSlice, f : Double) -> PhysicsheatdiffusionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionSlice::add(self : PhysicsheatdiffusionSlice, other : PhysicsheatdiffusionSlice) -> PhysicsheatdiffusionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatdiffusionSlice::copy(self : PhysicsheatdiffusionSlice) -> PhysicsheatdiffusionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionSlice::fill(self : PhysicsheatdiffusionSlice, v : Double) -> PhysicsheatdiffusionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatdiffusionSlice::min(self : PhysicsheatdiffusionSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatdiffusionSlice::max(self : PhysicsheatdiffusionSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatdiffusionSlice::to_string(self : PhysicsheatdiffusionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

