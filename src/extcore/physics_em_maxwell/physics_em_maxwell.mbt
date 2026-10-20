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

pub fn PhysicsemmaxwellFrame::len(self : PhysicsemmaxwellFrame) -> Int { self.size }

pub fn PhysicsemmaxwellFrame::get(self : PhysicsemmaxwellFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellFrame::set(self : PhysicsemmaxwellFrame, i : Int, v : Double) -> PhysicsemmaxwellFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellFrame::sum(self : PhysicsemmaxwellFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellFrame::mean(self : PhysicsemmaxwellFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellFrame::scale(self : PhysicsemmaxwellFrame, f : Double) -> PhysicsemmaxwellFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellFrame::add(self : PhysicsemmaxwellFrame, other : PhysicsemmaxwellFrame) -> PhysicsemmaxwellFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellFrame::copy(self : PhysicsemmaxwellFrame) -> PhysicsemmaxwellFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellFrame::fill(self : PhysicsemmaxwellFrame, v : Double) -> PhysicsemmaxwellFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellFrame::min(self : PhysicsemmaxwellFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellFrame::max(self : PhysicsemmaxwellFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellFrame::to_string(self : PhysicsemmaxwellFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_table_make(size : Int) -> PhysicsemmaxwellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellTable::len(self : PhysicsemmaxwellTable) -> Int { self.size }

pub fn PhysicsemmaxwellTable::get(self : PhysicsemmaxwellTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellTable::set(self : PhysicsemmaxwellTable, i : Int, v : Double) -> PhysicsemmaxwellTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellTable::sum(self : PhysicsemmaxwellTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellTable::mean(self : PhysicsemmaxwellTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellTable::scale(self : PhysicsemmaxwellTable, f : Double) -> PhysicsemmaxwellTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellTable::add(self : PhysicsemmaxwellTable, other : PhysicsemmaxwellTable) -> PhysicsemmaxwellTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellTable::copy(self : PhysicsemmaxwellTable) -> PhysicsemmaxwellTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellTable::fill(self : PhysicsemmaxwellTable, v : Double) -> PhysicsemmaxwellTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellTable::min(self : PhysicsemmaxwellTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellTable::max(self : PhysicsemmaxwellTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellTable::to_string(self : PhysicsemmaxwellTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_graphn_make(size : Int) -> PhysicsemmaxwellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellGraphN::len(self : PhysicsemmaxwellGraphN) -> Int { self.size }

pub fn PhysicsemmaxwellGraphN::get(self : PhysicsemmaxwellGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellGraphN::set(self : PhysicsemmaxwellGraphN, i : Int, v : Double) -> PhysicsemmaxwellGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellGraphN::sum(self : PhysicsemmaxwellGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellGraphN::mean(self : PhysicsemmaxwellGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellGraphN::scale(self : PhysicsemmaxwellGraphN, f : Double) -> PhysicsemmaxwellGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellGraphN::add(self : PhysicsemmaxwellGraphN, other : PhysicsemmaxwellGraphN) -> PhysicsemmaxwellGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellGraphN::copy(self : PhysicsemmaxwellGraphN) -> PhysicsemmaxwellGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellGraphN::fill(self : PhysicsemmaxwellGraphN, v : Double) -> PhysicsemmaxwellGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellGraphN::min(self : PhysicsemmaxwellGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellGraphN::max(self : PhysicsemmaxwellGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellGraphN::to_string(self : PhysicsemmaxwellGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_node_make(size : Int) -> PhysicsemmaxwellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellNode::len(self : PhysicsemmaxwellNode) -> Int { self.size }

pub fn PhysicsemmaxwellNode::get(self : PhysicsemmaxwellNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellNode::set(self : PhysicsemmaxwellNode, i : Int, v : Double) -> PhysicsemmaxwellNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellNode::sum(self : PhysicsemmaxwellNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellNode::mean(self : PhysicsemmaxwellNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellNode::scale(self : PhysicsemmaxwellNode, f : Double) -> PhysicsemmaxwellNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellNode::add(self : PhysicsemmaxwellNode, other : PhysicsemmaxwellNode) -> PhysicsemmaxwellNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellNode::copy(self : PhysicsemmaxwellNode) -> PhysicsemmaxwellNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellNode::fill(self : PhysicsemmaxwellNode, v : Double) -> PhysicsemmaxwellNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellNode::min(self : PhysicsemmaxwellNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellNode::max(self : PhysicsemmaxwellNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellNode::to_string(self : PhysicsemmaxwellNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_edge_make(size : Int) -> PhysicsemmaxwellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellEdge::len(self : PhysicsemmaxwellEdge) -> Int { self.size }

pub fn PhysicsemmaxwellEdge::get(self : PhysicsemmaxwellEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellEdge::set(self : PhysicsemmaxwellEdge, i : Int, v : Double) -> PhysicsemmaxwellEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellEdge::sum(self : PhysicsemmaxwellEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellEdge::mean(self : PhysicsemmaxwellEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellEdge::scale(self : PhysicsemmaxwellEdge, f : Double) -> PhysicsemmaxwellEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellEdge::add(self : PhysicsemmaxwellEdge, other : PhysicsemmaxwellEdge) -> PhysicsemmaxwellEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellEdge::copy(self : PhysicsemmaxwellEdge) -> PhysicsemmaxwellEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellEdge::fill(self : PhysicsemmaxwellEdge, v : Double) -> PhysicsemmaxwellEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellEdge::min(self : PhysicsemmaxwellEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellEdge::max(self : PhysicsemmaxwellEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellEdge::to_string(self : PhysicsemmaxwellEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_path_make(size : Int) -> PhysicsemmaxwellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellPath::len(self : PhysicsemmaxwellPath) -> Int { self.size }

pub fn PhysicsemmaxwellPath::get(self : PhysicsemmaxwellPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellPath::set(self : PhysicsemmaxwellPath, i : Int, v : Double) -> PhysicsemmaxwellPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellPath::sum(self : PhysicsemmaxwellPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellPath::mean(self : PhysicsemmaxwellPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellPath::scale(self : PhysicsemmaxwellPath, f : Double) -> PhysicsemmaxwellPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellPath::add(self : PhysicsemmaxwellPath, other : PhysicsemmaxwellPath) -> PhysicsemmaxwellPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellPath::copy(self : PhysicsemmaxwellPath) -> PhysicsemmaxwellPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellPath::fill(self : PhysicsemmaxwellPath, v : Double) -> PhysicsemmaxwellPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellPath::min(self : PhysicsemmaxwellPath) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellPath::max(self : PhysicsemmaxwellPath) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellPath::to_string(self : PhysicsemmaxwellPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_cluster_make(size : Int) -> PhysicsemmaxwellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellCluster::len(self : PhysicsemmaxwellCluster) -> Int { self.size }

pub fn PhysicsemmaxwellCluster::get(self : PhysicsemmaxwellCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellCluster::set(self : PhysicsemmaxwellCluster, i : Int, v : Double) -> PhysicsemmaxwellCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCluster::sum(self : PhysicsemmaxwellCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellCluster::mean(self : PhysicsemmaxwellCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellCluster::scale(self : PhysicsemmaxwellCluster, f : Double) -> PhysicsemmaxwellCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCluster::add(self : PhysicsemmaxwellCluster, other : PhysicsemmaxwellCluster) -> PhysicsemmaxwellCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellCluster::copy(self : PhysicsemmaxwellCluster) -> PhysicsemmaxwellCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCluster::fill(self : PhysicsemmaxwellCluster, v : Double) -> PhysicsemmaxwellCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCluster::min(self : PhysicsemmaxwellCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellCluster::max(self : PhysicsemmaxwellCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellCluster::to_string(self : PhysicsemmaxwellCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_model_make(size : Int) -> PhysicsemmaxwellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellModel::len(self : PhysicsemmaxwellModel) -> Int { self.size }

pub fn PhysicsemmaxwellModel::get(self : PhysicsemmaxwellModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellModel::set(self : PhysicsemmaxwellModel, i : Int, v : Double) -> PhysicsemmaxwellModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellModel::sum(self : PhysicsemmaxwellModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellModel::mean(self : PhysicsemmaxwellModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellModel::scale(self : PhysicsemmaxwellModel, f : Double) -> PhysicsemmaxwellModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellModel::add(self : PhysicsemmaxwellModel, other : PhysicsemmaxwellModel) -> PhysicsemmaxwellModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellModel::copy(self : PhysicsemmaxwellModel) -> PhysicsemmaxwellModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellModel::fill(self : PhysicsemmaxwellModel, v : Double) -> PhysicsemmaxwellModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellModel::min(self : PhysicsemmaxwellModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellModel::max(self : PhysicsemmaxwellModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellModel::to_string(self : PhysicsemmaxwellModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_layer_make(size : Int) -> PhysicsemmaxwellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellLayer::len(self : PhysicsemmaxwellLayer) -> Int { self.size }

pub fn PhysicsemmaxwellLayer::get(self : PhysicsemmaxwellLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellLayer::set(self : PhysicsemmaxwellLayer, i : Int, v : Double) -> PhysicsemmaxwellLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellLayer::sum(self : PhysicsemmaxwellLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellLayer::mean(self : PhysicsemmaxwellLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellLayer::scale(self : PhysicsemmaxwellLayer, f : Double) -> PhysicsemmaxwellLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellLayer::add(self : PhysicsemmaxwellLayer, other : PhysicsemmaxwellLayer) -> PhysicsemmaxwellLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellLayer::copy(self : PhysicsemmaxwellLayer) -> PhysicsemmaxwellLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellLayer::fill(self : PhysicsemmaxwellLayer, v : Double) -> PhysicsemmaxwellLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellLayer::min(self : PhysicsemmaxwellLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellLayer::max(self : PhysicsemmaxwellLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellLayer::to_string(self : PhysicsemmaxwellLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_buffer_make(size : Int) -> PhysicsemmaxwellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellBuffer::len(self : PhysicsemmaxwellBuffer) -> Int { self.size }

pub fn PhysicsemmaxwellBuffer::get(self : PhysicsemmaxwellBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellBuffer::set(self : PhysicsemmaxwellBuffer, i : Int, v : Double) -> PhysicsemmaxwellBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellBuffer::sum(self : PhysicsemmaxwellBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellBuffer::mean(self : PhysicsemmaxwellBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellBuffer::scale(self : PhysicsemmaxwellBuffer, f : Double) -> PhysicsemmaxwellBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellBuffer::add(self : PhysicsemmaxwellBuffer, other : PhysicsemmaxwellBuffer) -> PhysicsemmaxwellBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellBuffer::copy(self : PhysicsemmaxwellBuffer) -> PhysicsemmaxwellBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellBuffer::fill(self : PhysicsemmaxwellBuffer, v : Double) -> PhysicsemmaxwellBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellBuffer::min(self : PhysicsemmaxwellBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellBuffer::max(self : PhysicsemmaxwellBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellBuffer::to_string(self : PhysicsemmaxwellBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_cursor_make(size : Int) -> PhysicsemmaxwellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellCursor::len(self : PhysicsemmaxwellCursor) -> Int { self.size }

pub fn PhysicsemmaxwellCursor::get(self : PhysicsemmaxwellCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellCursor::set(self : PhysicsemmaxwellCursor, i : Int, v : Double) -> PhysicsemmaxwellCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCursor::sum(self : PhysicsemmaxwellCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellCursor::mean(self : PhysicsemmaxwellCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellCursor::scale(self : PhysicsemmaxwellCursor, f : Double) -> PhysicsemmaxwellCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCursor::add(self : PhysicsemmaxwellCursor, other : PhysicsemmaxwellCursor) -> PhysicsemmaxwellCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellCursor::copy(self : PhysicsemmaxwellCursor) -> PhysicsemmaxwellCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCursor::fill(self : PhysicsemmaxwellCursor, v : Double) -> PhysicsemmaxwellCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellCursor::min(self : PhysicsemmaxwellCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellCursor::max(self : PhysicsemmaxwellCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellCursor::to_string(self : PhysicsemmaxwellCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_view_make(size : Int) -> PhysicsemmaxwellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellView::len(self : PhysicsemmaxwellView) -> Int { self.size }

pub fn PhysicsemmaxwellView::get(self : PhysicsemmaxwellView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellView::set(self : PhysicsemmaxwellView, i : Int, v : Double) -> PhysicsemmaxwellView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellView::sum(self : PhysicsemmaxwellView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellView::mean(self : PhysicsemmaxwellView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellView::scale(self : PhysicsemmaxwellView, f : Double) -> PhysicsemmaxwellView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellView::add(self : PhysicsemmaxwellView, other : PhysicsemmaxwellView) -> PhysicsemmaxwellView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellView::copy(self : PhysicsemmaxwellView) -> PhysicsemmaxwellView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellView::fill(self : PhysicsemmaxwellView, v : Double) -> PhysicsemmaxwellView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellView::min(self : PhysicsemmaxwellView) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellView::max(self : PhysicsemmaxwellView) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellView::to_string(self : PhysicsemmaxwellView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_range_make(size : Int) -> PhysicsemmaxwellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellRange::len(self : PhysicsemmaxwellRange) -> Int { self.size }

pub fn PhysicsemmaxwellRange::get(self : PhysicsemmaxwellRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellRange::set(self : PhysicsemmaxwellRange, i : Int, v : Double) -> PhysicsemmaxwellRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellRange::sum(self : PhysicsemmaxwellRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellRange::mean(self : PhysicsemmaxwellRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellRange::scale(self : PhysicsemmaxwellRange, f : Double) -> PhysicsemmaxwellRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellRange::add(self : PhysicsemmaxwellRange, other : PhysicsemmaxwellRange) -> PhysicsemmaxwellRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellRange::copy(self : PhysicsemmaxwellRange) -> PhysicsemmaxwellRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellRange::fill(self : PhysicsemmaxwellRange, v : Double) -> PhysicsemmaxwellRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellRange::min(self : PhysicsemmaxwellRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellRange::max(self : PhysicsemmaxwellRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellRange::to_string(self : PhysicsemmaxwellRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_slice_make(size : Int) -> PhysicsemmaxwellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmaxwellSlice::len(self : PhysicsemmaxwellSlice) -> Int { self.size }

pub fn PhysicsemmaxwellSlice::get(self : PhysicsemmaxwellSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmaxwellSlice::set(self : PhysicsemmaxwellSlice, i : Int, v : Double) -> PhysicsemmaxwellSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellSlice::sum(self : PhysicsemmaxwellSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmaxwellSlice::mean(self : PhysicsemmaxwellSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmaxwellSlice::scale(self : PhysicsemmaxwellSlice, f : Double) -> PhysicsemmaxwellSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellSlice::add(self : PhysicsemmaxwellSlice, other : PhysicsemmaxwellSlice) -> PhysicsemmaxwellSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmaxwellSlice::copy(self : PhysicsemmaxwellSlice) -> PhysicsemmaxwellSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellSlice::fill(self : PhysicsemmaxwellSlice, v : Double) -> PhysicsemmaxwellSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmaxwellSlice::min(self : PhysicsemmaxwellSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemmaxwellSlice::max(self : PhysicsemmaxwellSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemmaxwellSlice::to_string(self : PhysicsemmaxwellSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

