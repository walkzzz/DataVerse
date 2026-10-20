///===
/// extcore/physics_em_fDTD

pub(all) struct PhysicsemfDTDPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_fDTD_make_point(x : Double, y : Double) -> PhysicsemfDTDPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_fDTD_make_point3(x : Double, y : Double, z : Double) -> PhysicsemfDTDPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemfDTDPoint::x(self : PhysicsemfDTDPoint) -> Double { self.x }

pub fn PhysicsemfDTDPoint::y(self : PhysicsemfDTDPoint) -> Double { self.y }

pub fn PhysicsemfDTDPoint::z(self : PhysicsemfDTDPoint) -> Double { self.z }

pub fn PhysicsemfDTDPoint::label(self : PhysicsemfDTDPoint) -> Int { self.label }

pub fn PhysicsemfDTDPoint::dist(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemfDTDPoint::add(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemfDTDPoint::sub(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemfDTDPoint::scale(self : PhysicsemfDTDPoint, s : Double) -> PhysicsemfDTDPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemfDTDPoint::dot(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemfDTDPoint::cross(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemfDTDPoint::norm(self : PhysicsemfDTDPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemfDTDPoint::normalize(self : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemfDTDPoint::negate(self : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemfDTDPoint::mid(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemfDTDPoint::lerp(self : PhysicsemfDTDPoint, other : PhysicsemfDTDPoint, t : Double) -> PhysicsemfDTDPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemfDTDPoint::to_string(self : PhysicsemfDTDPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemfDTDSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_fDTD_make_series(vals : Array[Double], name : String) -> PhysicsemfDTDSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemfDTDSeries::len(self : PhysicsemfDTDSeries) -> Int { self.vals.length() }

pub fn PhysicsemfDTDSeries::sum(self : PhysicsemfDTDSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemfDTDSeries::mean(self : PhysicsemfDTDSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemfDTDSeries::min(self : PhysicsemfDTDSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemfDTDSeries::max(self : PhysicsemfDTDSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemfDTDSeries::range(self : PhysicsemfDTDSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemfDTDSeries::variance(self : PhysicsemfDTDSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemfDTDSeries::std(self : PhysicsemfDTDSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemfDTDSeries::median(self : PhysicsemfDTDSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemfDTDSeries::scale(self : PhysicsemfDTDSeries, f : Double) -> PhysicsemfDTDSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemfDTDSeries::add(self : PhysicsemfDTDSeries, other : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemfDTDSeries::sub(self : PhysicsemfDTDSeries, other : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemfDTDSeries::normalize(self : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemfDTDSeries::cumsum(self : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemfDTDSeries::to_string(self : PhysicsemfDTDSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemfDTDMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_fDTD_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemfDTDMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_fDTD_matrix_identity(n : Int) -> PhysicsemfDTDMatrix {
  let m = physics_em_fDTD_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemfDTDMatrix::get(self : PhysicsemfDTDMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemfDTDMatrix::transpose(self : PhysicsemfDTDMatrix) -> PhysicsemfDTDMatrix {
  let result = physics_em_fDTD_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemfDTDMatrix::add(self : PhysicsemfDTDMatrix, other : PhysicsemfDTDMatrix) -> PhysicsemfDTDMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_fDTD_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemfDTDMatrix::scale(self : PhysicsemfDTDMatrix, s : Double) -> PhysicsemfDTDMatrix {
  let result = physics_em_fDTD_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemfDTDMatrix::multiply(self : PhysicsemfDTDMatrix, other : PhysicsemfDTDMatrix) -> PhysicsemfDTDMatrix {
  if self.cols != other.rows { return physics_em_fDTD_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_fDTD_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemfDTDMatrix::trace(self : PhysicsemfDTDMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemfDTDMatrix::det(self : PhysicsemfDTDMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemfDTDMatrix::norm(self : PhysicsemfDTDMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemfDTDMatrix::to_string(self : PhysicsemfDTDMatrix) -> String {
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

pub(all) struct PhysicsemfDTDVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_fDTD_make_vector(comps : Array[Double]) -> PhysicsemfDTDVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_fDTD_vector_zero(dim : Int) -> PhysicsemfDTDVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemfDTDVector::add(self : PhysicsemfDTDVector, other : PhysicsemfDTDVector) -> PhysicsemfDTDVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemfDTDVector::sub(self : PhysicsemfDTDVector, other : PhysicsemfDTDVector) -> PhysicsemfDTDVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemfDTDVector::scale(self : PhysicsemfDTDVector, s : Double) -> PhysicsemfDTDVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemfDTDVector::dot(self : PhysicsemfDTDVector, other : PhysicsemfDTDVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemfDTDVector::norm(self : PhysicsemfDTDVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemfDTDVector::normalize(self : PhysicsemfDTDVector) -> PhysicsemfDTDVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemfDTDVector::dist(self : PhysicsemfDTDVector, other : PhysicsemfDTDVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemfDTDVector::to_string(self : PhysicsemfDTDVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_fDTD_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_fDTD_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_fDTD_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_fDTD_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_fDTD_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_fDTD_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_fDTD_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_fDTD_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_fDTD_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_fDTD_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_fDTD_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_fDTD_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_fDTD_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_fDTD_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_fDTD_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_fDTD_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_fDTD_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_fDTD_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_fDTD_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_fDTD_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_fDTD_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_fDTD_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_fDTD_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_fDTD_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_fDTD_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_fDTD_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_fDTD_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_fDTD_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_fDTD_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemfDTDFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_frame_make(size : Int) -> PhysicsemfDTDFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDFrame::len(self : PhysicsemfDTDFrame) -> Int { self.size }

pub fn PhysicsemfDTDFrame::get(self : PhysicsemfDTDFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDFrame::set(self : PhysicsemfDTDFrame, i : Int, v : Double) -> PhysicsemfDTDFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDFrame::sum(self : PhysicsemfDTDFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDFrame::mean(self : PhysicsemfDTDFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDFrame::scale(self : PhysicsemfDTDFrame, f : Double) -> PhysicsemfDTDFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDFrame::add(self : PhysicsemfDTDFrame, other : PhysicsemfDTDFrame) -> PhysicsemfDTDFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDFrame::copy(self : PhysicsemfDTDFrame) -> PhysicsemfDTDFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDFrame::fill(self : PhysicsemfDTDFrame, v : Double) -> PhysicsemfDTDFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDFrame::min(self : PhysicsemfDTDFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDFrame::max(self : PhysicsemfDTDFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDFrame::to_string(self : PhysicsemfDTDFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_table_make(size : Int) -> PhysicsemfDTDTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDTable::len(self : PhysicsemfDTDTable) -> Int { self.size }

pub fn PhysicsemfDTDTable::get(self : PhysicsemfDTDTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDTable::set(self : PhysicsemfDTDTable, i : Int, v : Double) -> PhysicsemfDTDTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDTable::sum(self : PhysicsemfDTDTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDTable::mean(self : PhysicsemfDTDTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDTable::scale(self : PhysicsemfDTDTable, f : Double) -> PhysicsemfDTDTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDTable::add(self : PhysicsemfDTDTable, other : PhysicsemfDTDTable) -> PhysicsemfDTDTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDTable::copy(self : PhysicsemfDTDTable) -> PhysicsemfDTDTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDTable::fill(self : PhysicsemfDTDTable, v : Double) -> PhysicsemfDTDTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDTable::min(self : PhysicsemfDTDTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDTable::max(self : PhysicsemfDTDTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDTable::to_string(self : PhysicsemfDTDTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_graphn_make(size : Int) -> PhysicsemfDTDGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDGraphN::len(self : PhysicsemfDTDGraphN) -> Int { self.size }

pub fn PhysicsemfDTDGraphN::get(self : PhysicsemfDTDGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDGraphN::set(self : PhysicsemfDTDGraphN, i : Int, v : Double) -> PhysicsemfDTDGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDGraphN::sum(self : PhysicsemfDTDGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDGraphN::mean(self : PhysicsemfDTDGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDGraphN::scale(self : PhysicsemfDTDGraphN, f : Double) -> PhysicsemfDTDGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDGraphN::add(self : PhysicsemfDTDGraphN, other : PhysicsemfDTDGraphN) -> PhysicsemfDTDGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDGraphN::copy(self : PhysicsemfDTDGraphN) -> PhysicsemfDTDGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDGraphN::fill(self : PhysicsemfDTDGraphN, v : Double) -> PhysicsemfDTDGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDGraphN::min(self : PhysicsemfDTDGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDGraphN::max(self : PhysicsemfDTDGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDGraphN::to_string(self : PhysicsemfDTDGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_node_make(size : Int) -> PhysicsemfDTDNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDNode::len(self : PhysicsemfDTDNode) -> Int { self.size }

pub fn PhysicsemfDTDNode::get(self : PhysicsemfDTDNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDNode::set(self : PhysicsemfDTDNode, i : Int, v : Double) -> PhysicsemfDTDNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDNode::sum(self : PhysicsemfDTDNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDNode::mean(self : PhysicsemfDTDNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDNode::scale(self : PhysicsemfDTDNode, f : Double) -> PhysicsemfDTDNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDNode::add(self : PhysicsemfDTDNode, other : PhysicsemfDTDNode) -> PhysicsemfDTDNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDNode::copy(self : PhysicsemfDTDNode) -> PhysicsemfDTDNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDNode::fill(self : PhysicsemfDTDNode, v : Double) -> PhysicsemfDTDNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDNode::min(self : PhysicsemfDTDNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDNode::max(self : PhysicsemfDTDNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDNode::to_string(self : PhysicsemfDTDNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_edge_make(size : Int) -> PhysicsemfDTDEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDEdge::len(self : PhysicsemfDTDEdge) -> Int { self.size }

pub fn PhysicsemfDTDEdge::get(self : PhysicsemfDTDEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDEdge::set(self : PhysicsemfDTDEdge, i : Int, v : Double) -> PhysicsemfDTDEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDEdge::sum(self : PhysicsemfDTDEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDEdge::mean(self : PhysicsemfDTDEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDEdge::scale(self : PhysicsemfDTDEdge, f : Double) -> PhysicsemfDTDEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDEdge::add(self : PhysicsemfDTDEdge, other : PhysicsemfDTDEdge) -> PhysicsemfDTDEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDEdge::copy(self : PhysicsemfDTDEdge) -> PhysicsemfDTDEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDEdge::fill(self : PhysicsemfDTDEdge, v : Double) -> PhysicsemfDTDEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDEdge::min(self : PhysicsemfDTDEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDEdge::max(self : PhysicsemfDTDEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDEdge::to_string(self : PhysicsemfDTDEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_path_make(size : Int) -> PhysicsemfDTDPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDPath::len(self : PhysicsemfDTDPath) -> Int { self.size }

pub fn PhysicsemfDTDPath::get(self : PhysicsemfDTDPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDPath::set(self : PhysicsemfDTDPath, i : Int, v : Double) -> PhysicsemfDTDPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDPath::sum(self : PhysicsemfDTDPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDPath::mean(self : PhysicsemfDTDPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDPath::scale(self : PhysicsemfDTDPath, f : Double) -> PhysicsemfDTDPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDPath::add(self : PhysicsemfDTDPath, other : PhysicsemfDTDPath) -> PhysicsemfDTDPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDPath::copy(self : PhysicsemfDTDPath) -> PhysicsemfDTDPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDPath::fill(self : PhysicsemfDTDPath, v : Double) -> PhysicsemfDTDPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDPath::min(self : PhysicsemfDTDPath) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDPath::max(self : PhysicsemfDTDPath) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDPath::to_string(self : PhysicsemfDTDPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_cluster_make(size : Int) -> PhysicsemfDTDCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDCluster::len(self : PhysicsemfDTDCluster) -> Int { self.size }

pub fn PhysicsemfDTDCluster::get(self : PhysicsemfDTDCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDCluster::set(self : PhysicsemfDTDCluster, i : Int, v : Double) -> PhysicsemfDTDCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCluster::sum(self : PhysicsemfDTDCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDCluster::mean(self : PhysicsemfDTDCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDCluster::scale(self : PhysicsemfDTDCluster, f : Double) -> PhysicsemfDTDCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCluster::add(self : PhysicsemfDTDCluster, other : PhysicsemfDTDCluster) -> PhysicsemfDTDCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDCluster::copy(self : PhysicsemfDTDCluster) -> PhysicsemfDTDCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCluster::fill(self : PhysicsemfDTDCluster, v : Double) -> PhysicsemfDTDCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCluster::min(self : PhysicsemfDTDCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDCluster::max(self : PhysicsemfDTDCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDCluster::to_string(self : PhysicsemfDTDCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_model_make(size : Int) -> PhysicsemfDTDModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDModel::len(self : PhysicsemfDTDModel) -> Int { self.size }

pub fn PhysicsemfDTDModel::get(self : PhysicsemfDTDModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDModel::set(self : PhysicsemfDTDModel, i : Int, v : Double) -> PhysicsemfDTDModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDModel::sum(self : PhysicsemfDTDModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDModel::mean(self : PhysicsemfDTDModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDModel::scale(self : PhysicsemfDTDModel, f : Double) -> PhysicsemfDTDModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDModel::add(self : PhysicsemfDTDModel, other : PhysicsemfDTDModel) -> PhysicsemfDTDModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDModel::copy(self : PhysicsemfDTDModel) -> PhysicsemfDTDModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDModel::fill(self : PhysicsemfDTDModel, v : Double) -> PhysicsemfDTDModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDModel::min(self : PhysicsemfDTDModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDModel::max(self : PhysicsemfDTDModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDModel::to_string(self : PhysicsemfDTDModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_layer_make(size : Int) -> PhysicsemfDTDLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDLayer::len(self : PhysicsemfDTDLayer) -> Int { self.size }

pub fn PhysicsemfDTDLayer::get(self : PhysicsemfDTDLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDLayer::set(self : PhysicsemfDTDLayer, i : Int, v : Double) -> PhysicsemfDTDLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDLayer::sum(self : PhysicsemfDTDLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDLayer::mean(self : PhysicsemfDTDLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDLayer::scale(self : PhysicsemfDTDLayer, f : Double) -> PhysicsemfDTDLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDLayer::add(self : PhysicsemfDTDLayer, other : PhysicsemfDTDLayer) -> PhysicsemfDTDLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDLayer::copy(self : PhysicsemfDTDLayer) -> PhysicsemfDTDLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDLayer::fill(self : PhysicsemfDTDLayer, v : Double) -> PhysicsemfDTDLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDLayer::min(self : PhysicsemfDTDLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDLayer::max(self : PhysicsemfDTDLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDLayer::to_string(self : PhysicsemfDTDLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_buffer_make(size : Int) -> PhysicsemfDTDBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDBuffer::len(self : PhysicsemfDTDBuffer) -> Int { self.size }

pub fn PhysicsemfDTDBuffer::get(self : PhysicsemfDTDBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDBuffer::set(self : PhysicsemfDTDBuffer, i : Int, v : Double) -> PhysicsemfDTDBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDBuffer::sum(self : PhysicsemfDTDBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDBuffer::mean(self : PhysicsemfDTDBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDBuffer::scale(self : PhysicsemfDTDBuffer, f : Double) -> PhysicsemfDTDBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDBuffer::add(self : PhysicsemfDTDBuffer, other : PhysicsemfDTDBuffer) -> PhysicsemfDTDBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDBuffer::copy(self : PhysicsemfDTDBuffer) -> PhysicsemfDTDBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDBuffer::fill(self : PhysicsemfDTDBuffer, v : Double) -> PhysicsemfDTDBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDBuffer::min(self : PhysicsemfDTDBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDBuffer::max(self : PhysicsemfDTDBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDBuffer::to_string(self : PhysicsemfDTDBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_cursor_make(size : Int) -> PhysicsemfDTDCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDCursor::len(self : PhysicsemfDTDCursor) -> Int { self.size }

pub fn PhysicsemfDTDCursor::get(self : PhysicsemfDTDCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDCursor::set(self : PhysicsemfDTDCursor, i : Int, v : Double) -> PhysicsemfDTDCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCursor::sum(self : PhysicsemfDTDCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDCursor::mean(self : PhysicsemfDTDCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDCursor::scale(self : PhysicsemfDTDCursor, f : Double) -> PhysicsemfDTDCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCursor::add(self : PhysicsemfDTDCursor, other : PhysicsemfDTDCursor) -> PhysicsemfDTDCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDCursor::copy(self : PhysicsemfDTDCursor) -> PhysicsemfDTDCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCursor::fill(self : PhysicsemfDTDCursor, v : Double) -> PhysicsemfDTDCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDCursor::min(self : PhysicsemfDTDCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDCursor::max(self : PhysicsemfDTDCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDCursor::to_string(self : PhysicsemfDTDCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_view_make(size : Int) -> PhysicsemfDTDView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDView::len(self : PhysicsemfDTDView) -> Int { self.size }

pub fn PhysicsemfDTDView::get(self : PhysicsemfDTDView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDView::set(self : PhysicsemfDTDView, i : Int, v : Double) -> PhysicsemfDTDView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDView::sum(self : PhysicsemfDTDView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDView::mean(self : PhysicsemfDTDView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDView::scale(self : PhysicsemfDTDView, f : Double) -> PhysicsemfDTDView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDView::add(self : PhysicsemfDTDView, other : PhysicsemfDTDView) -> PhysicsemfDTDView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDView::copy(self : PhysicsemfDTDView) -> PhysicsemfDTDView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDView::fill(self : PhysicsemfDTDView, v : Double) -> PhysicsemfDTDView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDView::min(self : PhysicsemfDTDView) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDView::max(self : PhysicsemfDTDView) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDView::to_string(self : PhysicsemfDTDView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_range_make(size : Int) -> PhysicsemfDTDRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDRange::len(self : PhysicsemfDTDRange) -> Int { self.size }

pub fn PhysicsemfDTDRange::get(self : PhysicsemfDTDRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDRange::set(self : PhysicsemfDTDRange, i : Int, v : Double) -> PhysicsemfDTDRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDRange::sum(self : PhysicsemfDTDRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDRange::mean(self : PhysicsemfDTDRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDRange::scale(self : PhysicsemfDTDRange, f : Double) -> PhysicsemfDTDRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDRange::add(self : PhysicsemfDTDRange, other : PhysicsemfDTDRange) -> PhysicsemfDTDRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDRange::copy(self : PhysicsemfDTDRange) -> PhysicsemfDTDRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDRange::fill(self : PhysicsemfDTDRange, v : Double) -> PhysicsemfDTDRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDRange::min(self : PhysicsemfDTDRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDRange::max(self : PhysicsemfDTDRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDRange::to_string(self : PhysicsemfDTDRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_slice_make(size : Int) -> PhysicsemfDTDSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemfDTDSlice::len(self : PhysicsemfDTDSlice) -> Int { self.size }

pub fn PhysicsemfDTDSlice::get(self : PhysicsemfDTDSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemfDTDSlice::set(self : PhysicsemfDTDSlice, i : Int, v : Double) -> PhysicsemfDTDSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDSlice::sum(self : PhysicsemfDTDSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemfDTDSlice::mean(self : PhysicsemfDTDSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemfDTDSlice::scale(self : PhysicsemfDTDSlice, f : Double) -> PhysicsemfDTDSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDSlice::add(self : PhysicsemfDTDSlice, other : PhysicsemfDTDSlice) -> PhysicsemfDTDSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemfDTDSlice::copy(self : PhysicsemfDTDSlice) -> PhysicsemfDTDSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDSlice::fill(self : PhysicsemfDTDSlice, v : Double) -> PhysicsemfDTDSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemfDTDSlice::min(self : PhysicsemfDTDSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemfDTDSlice::max(self : PhysicsemfDTDSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemfDTDSlice::to_string(self : PhysicsemfDTDSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

