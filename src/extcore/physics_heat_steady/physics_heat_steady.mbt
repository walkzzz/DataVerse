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

pub fn PhysicsheatsteadyFrame::len(self : PhysicsheatsteadyFrame) -> Int { self.size }

pub fn PhysicsheatsteadyFrame::get(self : PhysicsheatsteadyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyFrame::set(self : PhysicsheatsteadyFrame, i : Int, v : Double) -> PhysicsheatsteadyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyFrame::sum(self : PhysicsheatsteadyFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyFrame::mean(self : PhysicsheatsteadyFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyFrame::scale(self : PhysicsheatsteadyFrame, f : Double) -> PhysicsheatsteadyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyFrame::add(self : PhysicsheatsteadyFrame, other : PhysicsheatsteadyFrame) -> PhysicsheatsteadyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyFrame::copy(self : PhysicsheatsteadyFrame) -> PhysicsheatsteadyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyFrame::fill(self : PhysicsheatsteadyFrame, v : Double) -> PhysicsheatsteadyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyFrame::min(self : PhysicsheatsteadyFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyFrame::max(self : PhysicsheatsteadyFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyFrame::to_string(self : PhysicsheatsteadyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_table_make(size : Int) -> PhysicsheatsteadyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyTable::len(self : PhysicsheatsteadyTable) -> Int { self.size }

pub fn PhysicsheatsteadyTable::get(self : PhysicsheatsteadyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyTable::set(self : PhysicsheatsteadyTable, i : Int, v : Double) -> PhysicsheatsteadyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyTable::sum(self : PhysicsheatsteadyTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyTable::mean(self : PhysicsheatsteadyTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyTable::scale(self : PhysicsheatsteadyTable, f : Double) -> PhysicsheatsteadyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyTable::add(self : PhysicsheatsteadyTable, other : PhysicsheatsteadyTable) -> PhysicsheatsteadyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyTable::copy(self : PhysicsheatsteadyTable) -> PhysicsheatsteadyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyTable::fill(self : PhysicsheatsteadyTable, v : Double) -> PhysicsheatsteadyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyTable::min(self : PhysicsheatsteadyTable) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyTable::max(self : PhysicsheatsteadyTable) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyTable::to_string(self : PhysicsheatsteadyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_graphn_make(size : Int) -> PhysicsheatsteadyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyGraphN::len(self : PhysicsheatsteadyGraphN) -> Int { self.size }

pub fn PhysicsheatsteadyGraphN::get(self : PhysicsheatsteadyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyGraphN::set(self : PhysicsheatsteadyGraphN, i : Int, v : Double) -> PhysicsheatsteadyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyGraphN::sum(self : PhysicsheatsteadyGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyGraphN::mean(self : PhysicsheatsteadyGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyGraphN::scale(self : PhysicsheatsteadyGraphN, f : Double) -> PhysicsheatsteadyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyGraphN::add(self : PhysicsheatsteadyGraphN, other : PhysicsheatsteadyGraphN) -> PhysicsheatsteadyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyGraphN::copy(self : PhysicsheatsteadyGraphN) -> PhysicsheatsteadyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyGraphN::fill(self : PhysicsheatsteadyGraphN, v : Double) -> PhysicsheatsteadyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyGraphN::min(self : PhysicsheatsteadyGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyGraphN::max(self : PhysicsheatsteadyGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyGraphN::to_string(self : PhysicsheatsteadyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_node_make(size : Int) -> PhysicsheatsteadyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyNode::len(self : PhysicsheatsteadyNode) -> Int { self.size }

pub fn PhysicsheatsteadyNode::get(self : PhysicsheatsteadyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyNode::set(self : PhysicsheatsteadyNode, i : Int, v : Double) -> PhysicsheatsteadyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyNode::sum(self : PhysicsheatsteadyNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyNode::mean(self : PhysicsheatsteadyNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyNode::scale(self : PhysicsheatsteadyNode, f : Double) -> PhysicsheatsteadyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyNode::add(self : PhysicsheatsteadyNode, other : PhysicsheatsteadyNode) -> PhysicsheatsteadyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyNode::copy(self : PhysicsheatsteadyNode) -> PhysicsheatsteadyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyNode::fill(self : PhysicsheatsteadyNode, v : Double) -> PhysicsheatsteadyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyNode::min(self : PhysicsheatsteadyNode) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyNode::max(self : PhysicsheatsteadyNode) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyNode::to_string(self : PhysicsheatsteadyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_edge_make(size : Int) -> PhysicsheatsteadyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyEdge::len(self : PhysicsheatsteadyEdge) -> Int { self.size }

pub fn PhysicsheatsteadyEdge::get(self : PhysicsheatsteadyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyEdge::set(self : PhysicsheatsteadyEdge, i : Int, v : Double) -> PhysicsheatsteadyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyEdge::sum(self : PhysicsheatsteadyEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyEdge::mean(self : PhysicsheatsteadyEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyEdge::scale(self : PhysicsheatsteadyEdge, f : Double) -> PhysicsheatsteadyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyEdge::add(self : PhysicsheatsteadyEdge, other : PhysicsheatsteadyEdge) -> PhysicsheatsteadyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyEdge::copy(self : PhysicsheatsteadyEdge) -> PhysicsheatsteadyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyEdge::fill(self : PhysicsheatsteadyEdge, v : Double) -> PhysicsheatsteadyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyEdge::min(self : PhysicsheatsteadyEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyEdge::max(self : PhysicsheatsteadyEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyEdge::to_string(self : PhysicsheatsteadyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_path_make(size : Int) -> PhysicsheatsteadyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyPath::len(self : PhysicsheatsteadyPath) -> Int { self.size }

pub fn PhysicsheatsteadyPath::get(self : PhysicsheatsteadyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyPath::set(self : PhysicsheatsteadyPath, i : Int, v : Double) -> PhysicsheatsteadyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyPath::sum(self : PhysicsheatsteadyPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyPath::mean(self : PhysicsheatsteadyPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyPath::scale(self : PhysicsheatsteadyPath, f : Double) -> PhysicsheatsteadyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyPath::add(self : PhysicsheatsteadyPath, other : PhysicsheatsteadyPath) -> PhysicsheatsteadyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyPath::copy(self : PhysicsheatsteadyPath) -> PhysicsheatsteadyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyPath::fill(self : PhysicsheatsteadyPath, v : Double) -> PhysicsheatsteadyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyPath::min(self : PhysicsheatsteadyPath) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyPath::max(self : PhysicsheatsteadyPath) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyPath::to_string(self : PhysicsheatsteadyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_cluster_make(size : Int) -> PhysicsheatsteadyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyCluster::len(self : PhysicsheatsteadyCluster) -> Int { self.size }

pub fn PhysicsheatsteadyCluster::get(self : PhysicsheatsteadyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyCluster::set(self : PhysicsheatsteadyCluster, i : Int, v : Double) -> PhysicsheatsteadyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCluster::sum(self : PhysicsheatsteadyCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyCluster::mean(self : PhysicsheatsteadyCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyCluster::scale(self : PhysicsheatsteadyCluster, f : Double) -> PhysicsheatsteadyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCluster::add(self : PhysicsheatsteadyCluster, other : PhysicsheatsteadyCluster) -> PhysicsheatsteadyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyCluster::copy(self : PhysicsheatsteadyCluster) -> PhysicsheatsteadyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCluster::fill(self : PhysicsheatsteadyCluster, v : Double) -> PhysicsheatsteadyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCluster::min(self : PhysicsheatsteadyCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyCluster::max(self : PhysicsheatsteadyCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyCluster::to_string(self : PhysicsheatsteadyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_model_make(size : Int) -> PhysicsheatsteadyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyModel::len(self : PhysicsheatsteadyModel) -> Int { self.size }

pub fn PhysicsheatsteadyModel::get(self : PhysicsheatsteadyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyModel::set(self : PhysicsheatsteadyModel, i : Int, v : Double) -> PhysicsheatsteadyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyModel::sum(self : PhysicsheatsteadyModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyModel::mean(self : PhysicsheatsteadyModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyModel::scale(self : PhysicsheatsteadyModel, f : Double) -> PhysicsheatsteadyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyModel::add(self : PhysicsheatsteadyModel, other : PhysicsheatsteadyModel) -> PhysicsheatsteadyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyModel::copy(self : PhysicsheatsteadyModel) -> PhysicsheatsteadyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyModel::fill(self : PhysicsheatsteadyModel, v : Double) -> PhysicsheatsteadyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyModel::min(self : PhysicsheatsteadyModel) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyModel::max(self : PhysicsheatsteadyModel) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyModel::to_string(self : PhysicsheatsteadyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_layer_make(size : Int) -> PhysicsheatsteadyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyLayer::len(self : PhysicsheatsteadyLayer) -> Int { self.size }

pub fn PhysicsheatsteadyLayer::get(self : PhysicsheatsteadyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyLayer::set(self : PhysicsheatsteadyLayer, i : Int, v : Double) -> PhysicsheatsteadyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyLayer::sum(self : PhysicsheatsteadyLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyLayer::mean(self : PhysicsheatsteadyLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyLayer::scale(self : PhysicsheatsteadyLayer, f : Double) -> PhysicsheatsteadyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyLayer::add(self : PhysicsheatsteadyLayer, other : PhysicsheatsteadyLayer) -> PhysicsheatsteadyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyLayer::copy(self : PhysicsheatsteadyLayer) -> PhysicsheatsteadyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyLayer::fill(self : PhysicsheatsteadyLayer, v : Double) -> PhysicsheatsteadyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyLayer::min(self : PhysicsheatsteadyLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyLayer::max(self : PhysicsheatsteadyLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyLayer::to_string(self : PhysicsheatsteadyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_buffer_make(size : Int) -> PhysicsheatsteadyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyBuffer::len(self : PhysicsheatsteadyBuffer) -> Int { self.size }

pub fn PhysicsheatsteadyBuffer::get(self : PhysicsheatsteadyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyBuffer::set(self : PhysicsheatsteadyBuffer, i : Int, v : Double) -> PhysicsheatsteadyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyBuffer::sum(self : PhysicsheatsteadyBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyBuffer::mean(self : PhysicsheatsteadyBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyBuffer::scale(self : PhysicsheatsteadyBuffer, f : Double) -> PhysicsheatsteadyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyBuffer::add(self : PhysicsheatsteadyBuffer, other : PhysicsheatsteadyBuffer) -> PhysicsheatsteadyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyBuffer::copy(self : PhysicsheatsteadyBuffer) -> PhysicsheatsteadyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyBuffer::fill(self : PhysicsheatsteadyBuffer, v : Double) -> PhysicsheatsteadyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyBuffer::min(self : PhysicsheatsteadyBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyBuffer::max(self : PhysicsheatsteadyBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyBuffer::to_string(self : PhysicsheatsteadyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_cursor_make(size : Int) -> PhysicsheatsteadyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyCursor::len(self : PhysicsheatsteadyCursor) -> Int { self.size }

pub fn PhysicsheatsteadyCursor::get(self : PhysicsheatsteadyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyCursor::set(self : PhysicsheatsteadyCursor, i : Int, v : Double) -> PhysicsheatsteadyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCursor::sum(self : PhysicsheatsteadyCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyCursor::mean(self : PhysicsheatsteadyCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyCursor::scale(self : PhysicsheatsteadyCursor, f : Double) -> PhysicsheatsteadyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCursor::add(self : PhysicsheatsteadyCursor, other : PhysicsheatsteadyCursor) -> PhysicsheatsteadyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyCursor::copy(self : PhysicsheatsteadyCursor) -> PhysicsheatsteadyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCursor::fill(self : PhysicsheatsteadyCursor, v : Double) -> PhysicsheatsteadyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyCursor::min(self : PhysicsheatsteadyCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyCursor::max(self : PhysicsheatsteadyCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyCursor::to_string(self : PhysicsheatsteadyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_view_make(size : Int) -> PhysicsheatsteadyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyView::len(self : PhysicsheatsteadyView) -> Int { self.size }

pub fn PhysicsheatsteadyView::get(self : PhysicsheatsteadyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyView::set(self : PhysicsheatsteadyView, i : Int, v : Double) -> PhysicsheatsteadyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyView::sum(self : PhysicsheatsteadyView) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyView::mean(self : PhysicsheatsteadyView) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyView::scale(self : PhysicsheatsteadyView, f : Double) -> PhysicsheatsteadyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyView::add(self : PhysicsheatsteadyView, other : PhysicsheatsteadyView) -> PhysicsheatsteadyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyView::copy(self : PhysicsheatsteadyView) -> PhysicsheatsteadyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyView::fill(self : PhysicsheatsteadyView, v : Double) -> PhysicsheatsteadyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyView::min(self : PhysicsheatsteadyView) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyView::max(self : PhysicsheatsteadyView) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyView::to_string(self : PhysicsheatsteadyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_range_make(size : Int) -> PhysicsheatsteadyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadyRange::len(self : PhysicsheatsteadyRange) -> Int { self.size }

pub fn PhysicsheatsteadyRange::get(self : PhysicsheatsteadyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadyRange::set(self : PhysicsheatsteadyRange, i : Int, v : Double) -> PhysicsheatsteadyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyRange::sum(self : PhysicsheatsteadyRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadyRange::mean(self : PhysicsheatsteadyRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadyRange::scale(self : PhysicsheatsteadyRange, f : Double) -> PhysicsheatsteadyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyRange::add(self : PhysicsheatsteadyRange, other : PhysicsheatsteadyRange) -> PhysicsheatsteadyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadyRange::copy(self : PhysicsheatsteadyRange) -> PhysicsheatsteadyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyRange::fill(self : PhysicsheatsteadyRange, v : Double) -> PhysicsheatsteadyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadyRange::min(self : PhysicsheatsteadyRange) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadyRange::max(self : PhysicsheatsteadyRange) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadyRange::to_string(self : PhysicsheatsteadyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_slice_make(size : Int) -> PhysicsheatsteadySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsheatsteadySlice::len(self : PhysicsheatsteadySlice) -> Int { self.size }

pub fn PhysicsheatsteadySlice::get(self : PhysicsheatsteadySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsheatsteadySlice::set(self : PhysicsheatsteadySlice, i : Int, v : Double) -> PhysicsheatsteadySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadySlice::sum(self : PhysicsheatsteadySlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsheatsteadySlice::mean(self : PhysicsheatsteadySlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsheatsteadySlice::scale(self : PhysicsheatsteadySlice, f : Double) -> PhysicsheatsteadySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadySlice::add(self : PhysicsheatsteadySlice, other : PhysicsheatsteadySlice) -> PhysicsheatsteadySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsheatsteadySlice::copy(self : PhysicsheatsteadySlice) -> PhysicsheatsteadySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadySlice::fill(self : PhysicsheatsteadySlice, v : Double) -> PhysicsheatsteadySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsheatsteadySlice::min(self : PhysicsheatsteadySlice) -> Double { @_common.min(self.data) }

pub fn PhysicsheatsteadySlice::max(self : PhysicsheatsteadySlice) -> Double { @_common.max(self.data) }

pub fn PhysicsheatsteadySlice::to_string(self : PhysicsheatsteadySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

