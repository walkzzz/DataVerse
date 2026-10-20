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

pub fn physics_em_fDTD_frame_len(s : PhysicsemfDTDFrame) -> Int { s.size }

pub fn physics_em_fDTD_frame_get(s : PhysicsemfDTDFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_frame_set(s : PhysicsemfDTDFrame, i : Int, v : Double) -> PhysicsemfDTDFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_frame_sum(s : PhysicsemfDTDFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_frame_mean(s : PhysicsemfDTDFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_frame_scale(s : PhysicsemfDTDFrame, f : Double) -> PhysicsemfDTDFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_frame_add(a : PhysicsemfDTDFrame, b : PhysicsemfDTDFrame) -> PhysicsemfDTDFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_frame_copy(s : PhysicsemfDTDFrame) -> PhysicsemfDTDFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_frame_fill(s : PhysicsemfDTDFrame, v : Double) -> PhysicsemfDTDFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_frame_min(s : PhysicsemfDTDFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_frame_max(s : PhysicsemfDTDFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_frame_to_string(s : PhysicsemfDTDFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_table_make(size : Int) -> PhysicsemfDTDTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_table_len(s : PhysicsemfDTDTable) -> Int { s.size }

pub fn physics_em_fDTD_table_get(s : PhysicsemfDTDTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_table_set(s : PhysicsemfDTDTable, i : Int, v : Double) -> PhysicsemfDTDTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_table_sum(s : PhysicsemfDTDTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_table_mean(s : PhysicsemfDTDTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_table_scale(s : PhysicsemfDTDTable, f : Double) -> PhysicsemfDTDTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_table_add(a : PhysicsemfDTDTable, b : PhysicsemfDTDTable) -> PhysicsemfDTDTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_table_copy(s : PhysicsemfDTDTable) -> PhysicsemfDTDTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_table_fill(s : PhysicsemfDTDTable, v : Double) -> PhysicsemfDTDTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_table_min(s : PhysicsemfDTDTable) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_table_max(s : PhysicsemfDTDTable) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_table_to_string(s : PhysicsemfDTDTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_graphn_make(size : Int) -> PhysicsemfDTDGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_graphn_len(s : PhysicsemfDTDGraphN) -> Int { s.size }

pub fn physics_em_fDTD_graphn_get(s : PhysicsemfDTDGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_graphn_set(s : PhysicsemfDTDGraphN, i : Int, v : Double) -> PhysicsemfDTDGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_graphn_sum(s : PhysicsemfDTDGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_graphn_mean(s : PhysicsemfDTDGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_graphn_scale(s : PhysicsemfDTDGraphN, f : Double) -> PhysicsemfDTDGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_graphn_add(a : PhysicsemfDTDGraphN, b : PhysicsemfDTDGraphN) -> PhysicsemfDTDGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_graphn_copy(s : PhysicsemfDTDGraphN) -> PhysicsemfDTDGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_graphn_fill(s : PhysicsemfDTDGraphN, v : Double) -> PhysicsemfDTDGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_graphn_min(s : PhysicsemfDTDGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_graphn_max(s : PhysicsemfDTDGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_graphn_to_string(s : PhysicsemfDTDGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_node_make(size : Int) -> PhysicsemfDTDNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_node_len(s : PhysicsemfDTDNode) -> Int { s.size }

pub fn physics_em_fDTD_node_get(s : PhysicsemfDTDNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_node_set(s : PhysicsemfDTDNode, i : Int, v : Double) -> PhysicsemfDTDNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_node_sum(s : PhysicsemfDTDNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_node_mean(s : PhysicsemfDTDNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_node_scale(s : PhysicsemfDTDNode, f : Double) -> PhysicsemfDTDNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_node_add(a : PhysicsemfDTDNode, b : PhysicsemfDTDNode) -> PhysicsemfDTDNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_node_copy(s : PhysicsemfDTDNode) -> PhysicsemfDTDNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_node_fill(s : PhysicsemfDTDNode, v : Double) -> PhysicsemfDTDNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_node_min(s : PhysicsemfDTDNode) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_node_max(s : PhysicsemfDTDNode) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_node_to_string(s : PhysicsemfDTDNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_edge_make(size : Int) -> PhysicsemfDTDEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_edge_len(s : PhysicsemfDTDEdge) -> Int { s.size }

pub fn physics_em_fDTD_edge_get(s : PhysicsemfDTDEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_edge_set(s : PhysicsemfDTDEdge, i : Int, v : Double) -> PhysicsemfDTDEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_edge_sum(s : PhysicsemfDTDEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_edge_mean(s : PhysicsemfDTDEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_edge_scale(s : PhysicsemfDTDEdge, f : Double) -> PhysicsemfDTDEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_edge_add(a : PhysicsemfDTDEdge, b : PhysicsemfDTDEdge) -> PhysicsemfDTDEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_edge_copy(s : PhysicsemfDTDEdge) -> PhysicsemfDTDEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_edge_fill(s : PhysicsemfDTDEdge, v : Double) -> PhysicsemfDTDEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_edge_min(s : PhysicsemfDTDEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_edge_max(s : PhysicsemfDTDEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_edge_to_string(s : PhysicsemfDTDEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_path_make(size : Int) -> PhysicsemfDTDPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_path_len(s : PhysicsemfDTDPath) -> Int { s.size }

pub fn physics_em_fDTD_path_get(s : PhysicsemfDTDPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_path_set(s : PhysicsemfDTDPath, i : Int, v : Double) -> PhysicsemfDTDPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_path_sum(s : PhysicsemfDTDPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_path_mean(s : PhysicsemfDTDPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_path_scale(s : PhysicsemfDTDPath, f : Double) -> PhysicsemfDTDPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_path_add(a : PhysicsemfDTDPath, b : PhysicsemfDTDPath) -> PhysicsemfDTDPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_path_copy(s : PhysicsemfDTDPath) -> PhysicsemfDTDPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_path_fill(s : PhysicsemfDTDPath, v : Double) -> PhysicsemfDTDPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_path_min(s : PhysicsemfDTDPath) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_path_max(s : PhysicsemfDTDPath) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_path_to_string(s : PhysicsemfDTDPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_cluster_make(size : Int) -> PhysicsemfDTDCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_cluster_len(s : PhysicsemfDTDCluster) -> Int { s.size }

pub fn physics_em_fDTD_cluster_get(s : PhysicsemfDTDCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_cluster_set(s : PhysicsemfDTDCluster, i : Int, v : Double) -> PhysicsemfDTDCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cluster_sum(s : PhysicsemfDTDCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_cluster_mean(s : PhysicsemfDTDCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_cluster_scale(s : PhysicsemfDTDCluster, f : Double) -> PhysicsemfDTDCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cluster_add(a : PhysicsemfDTDCluster, b : PhysicsemfDTDCluster) -> PhysicsemfDTDCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_cluster_copy(s : PhysicsemfDTDCluster) -> PhysicsemfDTDCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cluster_fill(s : PhysicsemfDTDCluster, v : Double) -> PhysicsemfDTDCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cluster_min(s : PhysicsemfDTDCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_cluster_max(s : PhysicsemfDTDCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_cluster_to_string(s : PhysicsemfDTDCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_model_make(size : Int) -> PhysicsemfDTDModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_model_len(s : PhysicsemfDTDModel) -> Int { s.size }

pub fn physics_em_fDTD_model_get(s : PhysicsemfDTDModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_model_set(s : PhysicsemfDTDModel, i : Int, v : Double) -> PhysicsemfDTDModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_model_sum(s : PhysicsemfDTDModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_model_mean(s : PhysicsemfDTDModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_model_scale(s : PhysicsemfDTDModel, f : Double) -> PhysicsemfDTDModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_model_add(a : PhysicsemfDTDModel, b : PhysicsemfDTDModel) -> PhysicsemfDTDModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_model_copy(s : PhysicsemfDTDModel) -> PhysicsemfDTDModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_model_fill(s : PhysicsemfDTDModel, v : Double) -> PhysicsemfDTDModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_model_min(s : PhysicsemfDTDModel) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_model_max(s : PhysicsemfDTDModel) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_model_to_string(s : PhysicsemfDTDModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_layer_make(size : Int) -> PhysicsemfDTDLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_layer_len(s : PhysicsemfDTDLayer) -> Int { s.size }

pub fn physics_em_fDTD_layer_get(s : PhysicsemfDTDLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_layer_set(s : PhysicsemfDTDLayer, i : Int, v : Double) -> PhysicsemfDTDLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_layer_sum(s : PhysicsemfDTDLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_layer_mean(s : PhysicsemfDTDLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_layer_scale(s : PhysicsemfDTDLayer, f : Double) -> PhysicsemfDTDLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_layer_add(a : PhysicsemfDTDLayer, b : PhysicsemfDTDLayer) -> PhysicsemfDTDLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_layer_copy(s : PhysicsemfDTDLayer) -> PhysicsemfDTDLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_layer_fill(s : PhysicsemfDTDLayer, v : Double) -> PhysicsemfDTDLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_layer_min(s : PhysicsemfDTDLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_layer_max(s : PhysicsemfDTDLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_layer_to_string(s : PhysicsemfDTDLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_buffer_make(size : Int) -> PhysicsemfDTDBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_buffer_len(s : PhysicsemfDTDBuffer) -> Int { s.size }

pub fn physics_em_fDTD_buffer_get(s : PhysicsemfDTDBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_buffer_set(s : PhysicsemfDTDBuffer, i : Int, v : Double) -> PhysicsemfDTDBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_buffer_sum(s : PhysicsemfDTDBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_buffer_mean(s : PhysicsemfDTDBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_buffer_scale(s : PhysicsemfDTDBuffer, f : Double) -> PhysicsemfDTDBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_buffer_add(a : PhysicsemfDTDBuffer, b : PhysicsemfDTDBuffer) -> PhysicsemfDTDBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_buffer_copy(s : PhysicsemfDTDBuffer) -> PhysicsemfDTDBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_buffer_fill(s : PhysicsemfDTDBuffer, v : Double) -> PhysicsemfDTDBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_buffer_min(s : PhysicsemfDTDBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_buffer_max(s : PhysicsemfDTDBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_buffer_to_string(s : PhysicsemfDTDBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_cursor_make(size : Int) -> PhysicsemfDTDCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_cursor_len(s : PhysicsemfDTDCursor) -> Int { s.size }

pub fn physics_em_fDTD_cursor_get(s : PhysicsemfDTDCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_cursor_set(s : PhysicsemfDTDCursor, i : Int, v : Double) -> PhysicsemfDTDCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cursor_sum(s : PhysicsemfDTDCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_cursor_mean(s : PhysicsemfDTDCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_cursor_scale(s : PhysicsemfDTDCursor, f : Double) -> PhysicsemfDTDCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cursor_add(a : PhysicsemfDTDCursor, b : PhysicsemfDTDCursor) -> PhysicsemfDTDCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_cursor_copy(s : PhysicsemfDTDCursor) -> PhysicsemfDTDCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cursor_fill(s : PhysicsemfDTDCursor, v : Double) -> PhysicsemfDTDCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_cursor_min(s : PhysicsemfDTDCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_cursor_max(s : PhysicsemfDTDCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_cursor_to_string(s : PhysicsemfDTDCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_view_make(size : Int) -> PhysicsemfDTDView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_view_len(s : PhysicsemfDTDView) -> Int { s.size }

pub fn physics_em_fDTD_view_get(s : PhysicsemfDTDView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_view_set(s : PhysicsemfDTDView, i : Int, v : Double) -> PhysicsemfDTDView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_view_sum(s : PhysicsemfDTDView) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_view_mean(s : PhysicsemfDTDView) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_view_scale(s : PhysicsemfDTDView, f : Double) -> PhysicsemfDTDView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_view_add(a : PhysicsemfDTDView, b : PhysicsemfDTDView) -> PhysicsemfDTDView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_view_copy(s : PhysicsemfDTDView) -> PhysicsemfDTDView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_view_fill(s : PhysicsemfDTDView, v : Double) -> PhysicsemfDTDView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_view_min(s : PhysicsemfDTDView) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_view_max(s : PhysicsemfDTDView) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_view_to_string(s : PhysicsemfDTDView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_range_make(size : Int) -> PhysicsemfDTDRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_range_len(s : PhysicsemfDTDRange) -> Int { s.size }

pub fn physics_em_fDTD_range_get(s : PhysicsemfDTDRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_range_set(s : PhysicsemfDTDRange, i : Int, v : Double) -> PhysicsemfDTDRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_range_sum(s : PhysicsemfDTDRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_range_mean(s : PhysicsemfDTDRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_range_scale(s : PhysicsemfDTDRange, f : Double) -> PhysicsemfDTDRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_range_add(a : PhysicsemfDTDRange, b : PhysicsemfDTDRange) -> PhysicsemfDTDRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_range_copy(s : PhysicsemfDTDRange) -> PhysicsemfDTDRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_range_fill(s : PhysicsemfDTDRange, v : Double) -> PhysicsemfDTDRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_range_min(s : PhysicsemfDTDRange) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_range_max(s : PhysicsemfDTDRange) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_range_to_string(s : PhysicsemfDTDRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_slice_make(size : Int) -> PhysicsemfDTDSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_slice_len(s : PhysicsemfDTDSlice) -> Int { s.size }

pub fn physics_em_fDTD_slice_get(s : PhysicsemfDTDSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_slice_set(s : PhysicsemfDTDSlice, i : Int, v : Double) -> PhysicsemfDTDSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_slice_sum(s : PhysicsemfDTDSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_slice_mean(s : PhysicsemfDTDSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_slice_scale(s : PhysicsemfDTDSlice, f : Double) -> PhysicsemfDTDSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_slice_add(a : PhysicsemfDTDSlice, b : PhysicsemfDTDSlice) -> PhysicsemfDTDSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fDTD_slice_copy(s : PhysicsemfDTDSlice) -> PhysicsemfDTDSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_slice_fill(s : PhysicsemfDTDSlice, v : Double) -> PhysicsemfDTDSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fDTD_slice_min(s : PhysicsemfDTDSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_slice_max(s : PhysicsemfDTDSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_slice_to_string(s : PhysicsemfDTDSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

