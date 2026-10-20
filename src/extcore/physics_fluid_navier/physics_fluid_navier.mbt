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

pub fn PhysicsfluidnavierFrame::len(self : PhysicsfluidnavierFrame) -> Int { self.size }

pub fn PhysicsfluidnavierFrame::get(self : PhysicsfluidnavierFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierFrame::set(self : PhysicsfluidnavierFrame, i : Int, v : Double) -> PhysicsfluidnavierFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierFrame::sum(self : PhysicsfluidnavierFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierFrame::mean(self : PhysicsfluidnavierFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierFrame::scale(self : PhysicsfluidnavierFrame, f : Double) -> PhysicsfluidnavierFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierFrame::add(self : PhysicsfluidnavierFrame, other : PhysicsfluidnavierFrame) -> PhysicsfluidnavierFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierFrame::copy(self : PhysicsfluidnavierFrame) -> PhysicsfluidnavierFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierFrame::fill(self : PhysicsfluidnavierFrame, v : Double) -> PhysicsfluidnavierFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierFrame::min(self : PhysicsfluidnavierFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierFrame::max(self : PhysicsfluidnavierFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierFrame::to_string(self : PhysicsfluidnavierFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_table_make(size : Int) -> PhysicsfluidnavierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierTable::len(self : PhysicsfluidnavierTable) -> Int { self.size }

pub fn PhysicsfluidnavierTable::get(self : PhysicsfluidnavierTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierTable::set(self : PhysicsfluidnavierTable, i : Int, v : Double) -> PhysicsfluidnavierTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierTable::sum(self : PhysicsfluidnavierTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierTable::mean(self : PhysicsfluidnavierTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierTable::scale(self : PhysicsfluidnavierTable, f : Double) -> PhysicsfluidnavierTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierTable::add(self : PhysicsfluidnavierTable, other : PhysicsfluidnavierTable) -> PhysicsfluidnavierTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierTable::copy(self : PhysicsfluidnavierTable) -> PhysicsfluidnavierTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierTable::fill(self : PhysicsfluidnavierTable, v : Double) -> PhysicsfluidnavierTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierTable::min(self : PhysicsfluidnavierTable) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierTable::max(self : PhysicsfluidnavierTable) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierTable::to_string(self : PhysicsfluidnavierTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_graphn_make(size : Int) -> PhysicsfluidnavierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierGraphN::len(self : PhysicsfluidnavierGraphN) -> Int { self.size }

pub fn PhysicsfluidnavierGraphN::get(self : PhysicsfluidnavierGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierGraphN::set(self : PhysicsfluidnavierGraphN, i : Int, v : Double) -> PhysicsfluidnavierGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierGraphN::sum(self : PhysicsfluidnavierGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierGraphN::mean(self : PhysicsfluidnavierGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierGraphN::scale(self : PhysicsfluidnavierGraphN, f : Double) -> PhysicsfluidnavierGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierGraphN::add(self : PhysicsfluidnavierGraphN, other : PhysicsfluidnavierGraphN) -> PhysicsfluidnavierGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierGraphN::copy(self : PhysicsfluidnavierGraphN) -> PhysicsfluidnavierGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierGraphN::fill(self : PhysicsfluidnavierGraphN, v : Double) -> PhysicsfluidnavierGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierGraphN::min(self : PhysicsfluidnavierGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierGraphN::max(self : PhysicsfluidnavierGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierGraphN::to_string(self : PhysicsfluidnavierGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_node_make(size : Int) -> PhysicsfluidnavierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierNode::len(self : PhysicsfluidnavierNode) -> Int { self.size }

pub fn PhysicsfluidnavierNode::get(self : PhysicsfluidnavierNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierNode::set(self : PhysicsfluidnavierNode, i : Int, v : Double) -> PhysicsfluidnavierNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierNode::sum(self : PhysicsfluidnavierNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierNode::mean(self : PhysicsfluidnavierNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierNode::scale(self : PhysicsfluidnavierNode, f : Double) -> PhysicsfluidnavierNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierNode::add(self : PhysicsfluidnavierNode, other : PhysicsfluidnavierNode) -> PhysicsfluidnavierNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierNode::copy(self : PhysicsfluidnavierNode) -> PhysicsfluidnavierNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierNode::fill(self : PhysicsfluidnavierNode, v : Double) -> PhysicsfluidnavierNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierNode::min(self : PhysicsfluidnavierNode) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierNode::max(self : PhysicsfluidnavierNode) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierNode::to_string(self : PhysicsfluidnavierNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_edge_make(size : Int) -> PhysicsfluidnavierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierEdge::len(self : PhysicsfluidnavierEdge) -> Int { self.size }

pub fn PhysicsfluidnavierEdge::get(self : PhysicsfluidnavierEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierEdge::set(self : PhysicsfluidnavierEdge, i : Int, v : Double) -> PhysicsfluidnavierEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierEdge::sum(self : PhysicsfluidnavierEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierEdge::mean(self : PhysicsfluidnavierEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierEdge::scale(self : PhysicsfluidnavierEdge, f : Double) -> PhysicsfluidnavierEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierEdge::add(self : PhysicsfluidnavierEdge, other : PhysicsfluidnavierEdge) -> PhysicsfluidnavierEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierEdge::copy(self : PhysicsfluidnavierEdge) -> PhysicsfluidnavierEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierEdge::fill(self : PhysicsfluidnavierEdge, v : Double) -> PhysicsfluidnavierEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierEdge::min(self : PhysicsfluidnavierEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierEdge::max(self : PhysicsfluidnavierEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierEdge::to_string(self : PhysicsfluidnavierEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_path_make(size : Int) -> PhysicsfluidnavierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierPath::len(self : PhysicsfluidnavierPath) -> Int { self.size }

pub fn PhysicsfluidnavierPath::get(self : PhysicsfluidnavierPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierPath::set(self : PhysicsfluidnavierPath, i : Int, v : Double) -> PhysicsfluidnavierPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierPath::sum(self : PhysicsfluidnavierPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierPath::mean(self : PhysicsfluidnavierPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierPath::scale(self : PhysicsfluidnavierPath, f : Double) -> PhysicsfluidnavierPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierPath::add(self : PhysicsfluidnavierPath, other : PhysicsfluidnavierPath) -> PhysicsfluidnavierPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierPath::copy(self : PhysicsfluidnavierPath) -> PhysicsfluidnavierPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierPath::fill(self : PhysicsfluidnavierPath, v : Double) -> PhysicsfluidnavierPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierPath::min(self : PhysicsfluidnavierPath) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierPath::max(self : PhysicsfluidnavierPath) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierPath::to_string(self : PhysicsfluidnavierPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_cluster_make(size : Int) -> PhysicsfluidnavierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierCluster::len(self : PhysicsfluidnavierCluster) -> Int { self.size }

pub fn PhysicsfluidnavierCluster::get(self : PhysicsfluidnavierCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierCluster::set(self : PhysicsfluidnavierCluster, i : Int, v : Double) -> PhysicsfluidnavierCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCluster::sum(self : PhysicsfluidnavierCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierCluster::mean(self : PhysicsfluidnavierCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierCluster::scale(self : PhysicsfluidnavierCluster, f : Double) -> PhysicsfluidnavierCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCluster::add(self : PhysicsfluidnavierCluster, other : PhysicsfluidnavierCluster) -> PhysicsfluidnavierCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierCluster::copy(self : PhysicsfluidnavierCluster) -> PhysicsfluidnavierCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCluster::fill(self : PhysicsfluidnavierCluster, v : Double) -> PhysicsfluidnavierCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCluster::min(self : PhysicsfluidnavierCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierCluster::max(self : PhysicsfluidnavierCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierCluster::to_string(self : PhysicsfluidnavierCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_model_make(size : Int) -> PhysicsfluidnavierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierModel::len(self : PhysicsfluidnavierModel) -> Int { self.size }

pub fn PhysicsfluidnavierModel::get(self : PhysicsfluidnavierModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierModel::set(self : PhysicsfluidnavierModel, i : Int, v : Double) -> PhysicsfluidnavierModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierModel::sum(self : PhysicsfluidnavierModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierModel::mean(self : PhysicsfluidnavierModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierModel::scale(self : PhysicsfluidnavierModel, f : Double) -> PhysicsfluidnavierModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierModel::add(self : PhysicsfluidnavierModel, other : PhysicsfluidnavierModel) -> PhysicsfluidnavierModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierModel::copy(self : PhysicsfluidnavierModel) -> PhysicsfluidnavierModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierModel::fill(self : PhysicsfluidnavierModel, v : Double) -> PhysicsfluidnavierModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierModel::min(self : PhysicsfluidnavierModel) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierModel::max(self : PhysicsfluidnavierModel) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierModel::to_string(self : PhysicsfluidnavierModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_layer_make(size : Int) -> PhysicsfluidnavierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierLayer::len(self : PhysicsfluidnavierLayer) -> Int { self.size }

pub fn PhysicsfluidnavierLayer::get(self : PhysicsfluidnavierLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierLayer::set(self : PhysicsfluidnavierLayer, i : Int, v : Double) -> PhysicsfluidnavierLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierLayer::sum(self : PhysicsfluidnavierLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierLayer::mean(self : PhysicsfluidnavierLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierLayer::scale(self : PhysicsfluidnavierLayer, f : Double) -> PhysicsfluidnavierLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierLayer::add(self : PhysicsfluidnavierLayer, other : PhysicsfluidnavierLayer) -> PhysicsfluidnavierLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierLayer::copy(self : PhysicsfluidnavierLayer) -> PhysicsfluidnavierLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierLayer::fill(self : PhysicsfluidnavierLayer, v : Double) -> PhysicsfluidnavierLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierLayer::min(self : PhysicsfluidnavierLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierLayer::max(self : PhysicsfluidnavierLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierLayer::to_string(self : PhysicsfluidnavierLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_buffer_make(size : Int) -> PhysicsfluidnavierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierBuffer::len(self : PhysicsfluidnavierBuffer) -> Int { self.size }

pub fn PhysicsfluidnavierBuffer::get(self : PhysicsfluidnavierBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierBuffer::set(self : PhysicsfluidnavierBuffer, i : Int, v : Double) -> PhysicsfluidnavierBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierBuffer::sum(self : PhysicsfluidnavierBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierBuffer::mean(self : PhysicsfluidnavierBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierBuffer::scale(self : PhysicsfluidnavierBuffer, f : Double) -> PhysicsfluidnavierBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierBuffer::add(self : PhysicsfluidnavierBuffer, other : PhysicsfluidnavierBuffer) -> PhysicsfluidnavierBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierBuffer::copy(self : PhysicsfluidnavierBuffer) -> PhysicsfluidnavierBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierBuffer::fill(self : PhysicsfluidnavierBuffer, v : Double) -> PhysicsfluidnavierBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierBuffer::min(self : PhysicsfluidnavierBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierBuffer::max(self : PhysicsfluidnavierBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierBuffer::to_string(self : PhysicsfluidnavierBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_cursor_make(size : Int) -> PhysicsfluidnavierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierCursor::len(self : PhysicsfluidnavierCursor) -> Int { self.size }

pub fn PhysicsfluidnavierCursor::get(self : PhysicsfluidnavierCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierCursor::set(self : PhysicsfluidnavierCursor, i : Int, v : Double) -> PhysicsfluidnavierCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCursor::sum(self : PhysicsfluidnavierCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierCursor::mean(self : PhysicsfluidnavierCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierCursor::scale(self : PhysicsfluidnavierCursor, f : Double) -> PhysicsfluidnavierCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCursor::add(self : PhysicsfluidnavierCursor, other : PhysicsfluidnavierCursor) -> PhysicsfluidnavierCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierCursor::copy(self : PhysicsfluidnavierCursor) -> PhysicsfluidnavierCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCursor::fill(self : PhysicsfluidnavierCursor, v : Double) -> PhysicsfluidnavierCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierCursor::min(self : PhysicsfluidnavierCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierCursor::max(self : PhysicsfluidnavierCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierCursor::to_string(self : PhysicsfluidnavierCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_view_make(size : Int) -> PhysicsfluidnavierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierView::len(self : PhysicsfluidnavierView) -> Int { self.size }

pub fn PhysicsfluidnavierView::get(self : PhysicsfluidnavierView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierView::set(self : PhysicsfluidnavierView, i : Int, v : Double) -> PhysicsfluidnavierView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierView::sum(self : PhysicsfluidnavierView) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierView::mean(self : PhysicsfluidnavierView) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierView::scale(self : PhysicsfluidnavierView, f : Double) -> PhysicsfluidnavierView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierView::add(self : PhysicsfluidnavierView, other : PhysicsfluidnavierView) -> PhysicsfluidnavierView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierView::copy(self : PhysicsfluidnavierView) -> PhysicsfluidnavierView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierView::fill(self : PhysicsfluidnavierView, v : Double) -> PhysicsfluidnavierView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierView::min(self : PhysicsfluidnavierView) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierView::max(self : PhysicsfluidnavierView) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierView::to_string(self : PhysicsfluidnavierView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_range_make(size : Int) -> PhysicsfluidnavierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierRange::len(self : PhysicsfluidnavierRange) -> Int { self.size }

pub fn PhysicsfluidnavierRange::get(self : PhysicsfluidnavierRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierRange::set(self : PhysicsfluidnavierRange, i : Int, v : Double) -> PhysicsfluidnavierRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierRange::sum(self : PhysicsfluidnavierRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierRange::mean(self : PhysicsfluidnavierRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierRange::scale(self : PhysicsfluidnavierRange, f : Double) -> PhysicsfluidnavierRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierRange::add(self : PhysicsfluidnavierRange, other : PhysicsfluidnavierRange) -> PhysicsfluidnavierRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierRange::copy(self : PhysicsfluidnavierRange) -> PhysicsfluidnavierRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierRange::fill(self : PhysicsfluidnavierRange, v : Double) -> PhysicsfluidnavierRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierRange::min(self : PhysicsfluidnavierRange) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierRange::max(self : PhysicsfluidnavierRange) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierRange::to_string(self : PhysicsfluidnavierRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_slice_make(size : Int) -> PhysicsfluidnavierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsfluidnavierSlice::len(self : PhysicsfluidnavierSlice) -> Int { self.size }

pub fn PhysicsfluidnavierSlice::get(self : PhysicsfluidnavierSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsfluidnavierSlice::set(self : PhysicsfluidnavierSlice, i : Int, v : Double) -> PhysicsfluidnavierSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierSlice::sum(self : PhysicsfluidnavierSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsfluidnavierSlice::mean(self : PhysicsfluidnavierSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsfluidnavierSlice::scale(self : PhysicsfluidnavierSlice, f : Double) -> PhysicsfluidnavierSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierSlice::add(self : PhysicsfluidnavierSlice, other : PhysicsfluidnavierSlice) -> PhysicsfluidnavierSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsfluidnavierSlice::copy(self : PhysicsfluidnavierSlice) -> PhysicsfluidnavierSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierSlice::fill(self : PhysicsfluidnavierSlice, v : Double) -> PhysicsfluidnavierSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsfluidnavierSlice::min(self : PhysicsfluidnavierSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsfluidnavierSlice::max(self : PhysicsfluidnavierSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsfluidnavierSlice::to_string(self : PhysicsfluidnavierSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

