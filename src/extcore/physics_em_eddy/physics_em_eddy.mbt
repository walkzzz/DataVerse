///===
/// extcore/physics_em_eddy

pub(all) struct PhysicsemeddyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_eddy_make_point(x : Double, y : Double) -> PhysicsemeddyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_eddy_make_point3(x : Double, y : Double, z : Double) -> PhysicsemeddyPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemeddyPoint::x(self : PhysicsemeddyPoint) -> Double { self.x }

pub fn PhysicsemeddyPoint::y(self : PhysicsemeddyPoint) -> Double { self.y }

pub fn PhysicsemeddyPoint::z(self : PhysicsemeddyPoint) -> Double { self.z }

pub fn PhysicsemeddyPoint::label(self : PhysicsemeddyPoint) -> Int { self.label }

pub fn PhysicsemeddyPoint::dist(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemeddyPoint::add(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemeddyPoint::sub(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemeddyPoint::scale(self : PhysicsemeddyPoint, s : Double) -> PhysicsemeddyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemeddyPoint::dot(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemeddyPoint::cross(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemeddyPoint::norm(self : PhysicsemeddyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemeddyPoint::normalize(self : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemeddyPoint::negate(self : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemeddyPoint::mid(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint) -> PhysicsemeddyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemeddyPoint::lerp(self : PhysicsemeddyPoint, other : PhysicsemeddyPoint, t : Double) -> PhysicsemeddyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemeddyPoint::to_string(self : PhysicsemeddyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemeddySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_eddy_make_series(vals : Array[Double], name : String) -> PhysicsemeddySeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemeddySeries::len(self : PhysicsemeddySeries) -> Int { self.vals.length() }

pub fn PhysicsemeddySeries::sum(self : PhysicsemeddySeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemeddySeries::mean(self : PhysicsemeddySeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemeddySeries::min(self : PhysicsemeddySeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemeddySeries::max(self : PhysicsemeddySeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemeddySeries::range(self : PhysicsemeddySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemeddySeries::variance(self : PhysicsemeddySeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemeddySeries::std(self : PhysicsemeddySeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemeddySeries::median(self : PhysicsemeddySeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemeddySeries::scale(self : PhysicsemeddySeries, f : Double) -> PhysicsemeddySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemeddySeries::add(self : PhysicsemeddySeries, other : PhysicsemeddySeries) -> PhysicsemeddySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemeddySeries::sub(self : PhysicsemeddySeries, other : PhysicsemeddySeries) -> PhysicsemeddySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemeddySeries::normalize(self : PhysicsemeddySeries) -> PhysicsemeddySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemeddySeries::cumsum(self : PhysicsemeddySeries) -> PhysicsemeddySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemeddySeries::to_string(self : PhysicsemeddySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemeddyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_eddy_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemeddyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_eddy_matrix_identity(n : Int) -> PhysicsemeddyMatrix {
  let m = physics_em_eddy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemeddyMatrix::get(self : PhysicsemeddyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemeddyMatrix::transpose(self : PhysicsemeddyMatrix) -> PhysicsemeddyMatrix {
  let result = physics_em_eddy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemeddyMatrix::add(self : PhysicsemeddyMatrix, other : PhysicsemeddyMatrix) -> PhysicsemeddyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_eddy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemeddyMatrix::scale(self : PhysicsemeddyMatrix, s : Double) -> PhysicsemeddyMatrix {
  let result = physics_em_eddy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemeddyMatrix::multiply(self : PhysicsemeddyMatrix, other : PhysicsemeddyMatrix) -> PhysicsemeddyMatrix {
  if self.cols != other.rows { return physics_em_eddy_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_eddy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemeddyMatrix::trace(self : PhysicsemeddyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemeddyMatrix::det(self : PhysicsemeddyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemeddyMatrix::norm(self : PhysicsemeddyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemeddyMatrix::to_string(self : PhysicsemeddyMatrix) -> String {
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

pub(all) struct PhysicsemeddyVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_eddy_make_vector(comps : Array[Double]) -> PhysicsemeddyVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_eddy_vector_zero(dim : Int) -> PhysicsemeddyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemeddyVector::add(self : PhysicsemeddyVector, other : PhysicsemeddyVector) -> PhysicsemeddyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemeddyVector::sub(self : PhysicsemeddyVector, other : PhysicsemeddyVector) -> PhysicsemeddyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemeddyVector::scale(self : PhysicsemeddyVector, s : Double) -> PhysicsemeddyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemeddyVector::dot(self : PhysicsemeddyVector, other : PhysicsemeddyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemeddyVector::norm(self : PhysicsemeddyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemeddyVector::normalize(self : PhysicsemeddyVector) -> PhysicsemeddyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemeddyVector::dist(self : PhysicsemeddyVector, other : PhysicsemeddyVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemeddyVector::to_string(self : PhysicsemeddyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_eddy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_eddy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_eddy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_eddy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_eddy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_eddy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_eddy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_eddy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_eddy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_eddy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_eddy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_eddy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_eddy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_eddy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_eddy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_eddy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_eddy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_eddy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_eddy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_eddy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_eddy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_eddy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_eddy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_eddy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_eddy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_eddy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_eddy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_eddy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_eddy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemeddyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_frame_make(size : Int) -> PhysicsemeddyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_frame_len(s : PhysicsemeddyFrame) -> Int { s.size }

pub fn physics_em_eddy_frame_get(s : PhysicsemeddyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_frame_set(s : PhysicsemeddyFrame, i : Int, v : Double) -> PhysicsemeddyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_frame_sum(s : PhysicsemeddyFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_frame_mean(s : PhysicsemeddyFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_frame_scale(s : PhysicsemeddyFrame, f : Double) -> PhysicsemeddyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_frame_add(a : PhysicsemeddyFrame, b : PhysicsemeddyFrame) -> PhysicsemeddyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_frame_copy(s : PhysicsemeddyFrame) -> PhysicsemeddyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_frame_fill(s : PhysicsemeddyFrame, v : Double) -> PhysicsemeddyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_frame_min(s : PhysicsemeddyFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_frame_max(s : PhysicsemeddyFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_frame_to_string(s : PhysicsemeddyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_table_make(size : Int) -> PhysicsemeddyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_table_len(s : PhysicsemeddyTable) -> Int { s.size }

pub fn physics_em_eddy_table_get(s : PhysicsemeddyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_table_set(s : PhysicsemeddyTable, i : Int, v : Double) -> PhysicsemeddyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_table_sum(s : PhysicsemeddyTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_table_mean(s : PhysicsemeddyTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_table_scale(s : PhysicsemeddyTable, f : Double) -> PhysicsemeddyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_table_add(a : PhysicsemeddyTable, b : PhysicsemeddyTable) -> PhysicsemeddyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_table_copy(s : PhysicsemeddyTable) -> PhysicsemeddyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_table_fill(s : PhysicsemeddyTable, v : Double) -> PhysicsemeddyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_table_min(s : PhysicsemeddyTable) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_table_max(s : PhysicsemeddyTable) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_table_to_string(s : PhysicsemeddyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_graphn_make(size : Int) -> PhysicsemeddyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_graphn_len(s : PhysicsemeddyGraphN) -> Int { s.size }

pub fn physics_em_eddy_graphn_get(s : PhysicsemeddyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_graphn_set(s : PhysicsemeddyGraphN, i : Int, v : Double) -> PhysicsemeddyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_graphn_sum(s : PhysicsemeddyGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_graphn_mean(s : PhysicsemeddyGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_graphn_scale(s : PhysicsemeddyGraphN, f : Double) -> PhysicsemeddyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_graphn_add(a : PhysicsemeddyGraphN, b : PhysicsemeddyGraphN) -> PhysicsemeddyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_graphn_copy(s : PhysicsemeddyGraphN) -> PhysicsemeddyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_graphn_fill(s : PhysicsemeddyGraphN, v : Double) -> PhysicsemeddyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_graphn_min(s : PhysicsemeddyGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_graphn_max(s : PhysicsemeddyGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_graphn_to_string(s : PhysicsemeddyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_node_make(size : Int) -> PhysicsemeddyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_node_len(s : PhysicsemeddyNode) -> Int { s.size }

pub fn physics_em_eddy_node_get(s : PhysicsemeddyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_node_set(s : PhysicsemeddyNode, i : Int, v : Double) -> PhysicsemeddyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_node_sum(s : PhysicsemeddyNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_node_mean(s : PhysicsemeddyNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_node_scale(s : PhysicsemeddyNode, f : Double) -> PhysicsemeddyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_node_add(a : PhysicsemeddyNode, b : PhysicsemeddyNode) -> PhysicsemeddyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_node_copy(s : PhysicsemeddyNode) -> PhysicsemeddyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_node_fill(s : PhysicsemeddyNode, v : Double) -> PhysicsemeddyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_node_min(s : PhysicsemeddyNode) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_node_max(s : PhysicsemeddyNode) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_node_to_string(s : PhysicsemeddyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_edge_make(size : Int) -> PhysicsemeddyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_edge_len(s : PhysicsemeddyEdge) -> Int { s.size }

pub fn physics_em_eddy_edge_get(s : PhysicsemeddyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_edge_set(s : PhysicsemeddyEdge, i : Int, v : Double) -> PhysicsemeddyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_edge_sum(s : PhysicsemeddyEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_edge_mean(s : PhysicsemeddyEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_edge_scale(s : PhysicsemeddyEdge, f : Double) -> PhysicsemeddyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_edge_add(a : PhysicsemeddyEdge, b : PhysicsemeddyEdge) -> PhysicsemeddyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_edge_copy(s : PhysicsemeddyEdge) -> PhysicsemeddyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_edge_fill(s : PhysicsemeddyEdge, v : Double) -> PhysicsemeddyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_edge_min(s : PhysicsemeddyEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_edge_max(s : PhysicsemeddyEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_edge_to_string(s : PhysicsemeddyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_path_make(size : Int) -> PhysicsemeddyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_path_len(s : PhysicsemeddyPath) -> Int { s.size }

pub fn physics_em_eddy_path_get(s : PhysicsemeddyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_path_set(s : PhysicsemeddyPath, i : Int, v : Double) -> PhysicsemeddyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_path_sum(s : PhysicsemeddyPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_path_mean(s : PhysicsemeddyPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_path_scale(s : PhysicsemeddyPath, f : Double) -> PhysicsemeddyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_path_add(a : PhysicsemeddyPath, b : PhysicsemeddyPath) -> PhysicsemeddyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_path_copy(s : PhysicsemeddyPath) -> PhysicsemeddyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_path_fill(s : PhysicsemeddyPath, v : Double) -> PhysicsemeddyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_path_min(s : PhysicsemeddyPath) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_path_max(s : PhysicsemeddyPath) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_path_to_string(s : PhysicsemeddyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_cluster_make(size : Int) -> PhysicsemeddyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_cluster_len(s : PhysicsemeddyCluster) -> Int { s.size }

pub fn physics_em_eddy_cluster_get(s : PhysicsemeddyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_cluster_set(s : PhysicsemeddyCluster, i : Int, v : Double) -> PhysicsemeddyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cluster_sum(s : PhysicsemeddyCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_cluster_mean(s : PhysicsemeddyCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_cluster_scale(s : PhysicsemeddyCluster, f : Double) -> PhysicsemeddyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cluster_add(a : PhysicsemeddyCluster, b : PhysicsemeddyCluster) -> PhysicsemeddyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_cluster_copy(s : PhysicsemeddyCluster) -> PhysicsemeddyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cluster_fill(s : PhysicsemeddyCluster, v : Double) -> PhysicsemeddyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cluster_min(s : PhysicsemeddyCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_cluster_max(s : PhysicsemeddyCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_cluster_to_string(s : PhysicsemeddyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_model_make(size : Int) -> PhysicsemeddyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_model_len(s : PhysicsemeddyModel) -> Int { s.size }

pub fn physics_em_eddy_model_get(s : PhysicsemeddyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_model_set(s : PhysicsemeddyModel, i : Int, v : Double) -> PhysicsemeddyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_model_sum(s : PhysicsemeddyModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_model_mean(s : PhysicsemeddyModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_model_scale(s : PhysicsemeddyModel, f : Double) -> PhysicsemeddyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_model_add(a : PhysicsemeddyModel, b : PhysicsemeddyModel) -> PhysicsemeddyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_model_copy(s : PhysicsemeddyModel) -> PhysicsemeddyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_model_fill(s : PhysicsemeddyModel, v : Double) -> PhysicsemeddyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_model_min(s : PhysicsemeddyModel) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_model_max(s : PhysicsemeddyModel) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_model_to_string(s : PhysicsemeddyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_layer_make(size : Int) -> PhysicsemeddyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_layer_len(s : PhysicsemeddyLayer) -> Int { s.size }

pub fn physics_em_eddy_layer_get(s : PhysicsemeddyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_layer_set(s : PhysicsemeddyLayer, i : Int, v : Double) -> PhysicsemeddyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_layer_sum(s : PhysicsemeddyLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_layer_mean(s : PhysicsemeddyLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_layer_scale(s : PhysicsemeddyLayer, f : Double) -> PhysicsemeddyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_layer_add(a : PhysicsemeddyLayer, b : PhysicsemeddyLayer) -> PhysicsemeddyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_layer_copy(s : PhysicsemeddyLayer) -> PhysicsemeddyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_layer_fill(s : PhysicsemeddyLayer, v : Double) -> PhysicsemeddyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_layer_min(s : PhysicsemeddyLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_layer_max(s : PhysicsemeddyLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_layer_to_string(s : PhysicsemeddyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_buffer_make(size : Int) -> PhysicsemeddyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_buffer_len(s : PhysicsemeddyBuffer) -> Int { s.size }

pub fn physics_em_eddy_buffer_get(s : PhysicsemeddyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_buffer_set(s : PhysicsemeddyBuffer, i : Int, v : Double) -> PhysicsemeddyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_buffer_sum(s : PhysicsemeddyBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_buffer_mean(s : PhysicsemeddyBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_buffer_scale(s : PhysicsemeddyBuffer, f : Double) -> PhysicsemeddyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_buffer_add(a : PhysicsemeddyBuffer, b : PhysicsemeddyBuffer) -> PhysicsemeddyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_buffer_copy(s : PhysicsemeddyBuffer) -> PhysicsemeddyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_buffer_fill(s : PhysicsemeddyBuffer, v : Double) -> PhysicsemeddyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_buffer_min(s : PhysicsemeddyBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_buffer_max(s : PhysicsemeddyBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_buffer_to_string(s : PhysicsemeddyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_cursor_make(size : Int) -> PhysicsemeddyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_cursor_len(s : PhysicsemeddyCursor) -> Int { s.size }

pub fn physics_em_eddy_cursor_get(s : PhysicsemeddyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_cursor_set(s : PhysicsemeddyCursor, i : Int, v : Double) -> PhysicsemeddyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cursor_sum(s : PhysicsemeddyCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_cursor_mean(s : PhysicsemeddyCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_cursor_scale(s : PhysicsemeddyCursor, f : Double) -> PhysicsemeddyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cursor_add(a : PhysicsemeddyCursor, b : PhysicsemeddyCursor) -> PhysicsemeddyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_cursor_copy(s : PhysicsemeddyCursor) -> PhysicsemeddyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cursor_fill(s : PhysicsemeddyCursor, v : Double) -> PhysicsemeddyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_cursor_min(s : PhysicsemeddyCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_cursor_max(s : PhysicsemeddyCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_cursor_to_string(s : PhysicsemeddyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_view_make(size : Int) -> PhysicsemeddyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_view_len(s : PhysicsemeddyView) -> Int { s.size }

pub fn physics_em_eddy_view_get(s : PhysicsemeddyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_view_set(s : PhysicsemeddyView, i : Int, v : Double) -> PhysicsemeddyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_view_sum(s : PhysicsemeddyView) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_view_mean(s : PhysicsemeddyView) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_view_scale(s : PhysicsemeddyView, f : Double) -> PhysicsemeddyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_view_add(a : PhysicsemeddyView, b : PhysicsemeddyView) -> PhysicsemeddyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_view_copy(s : PhysicsemeddyView) -> PhysicsemeddyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_view_fill(s : PhysicsemeddyView, v : Double) -> PhysicsemeddyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_view_min(s : PhysicsemeddyView) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_view_max(s : PhysicsemeddyView) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_view_to_string(s : PhysicsemeddyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_range_make(size : Int) -> PhysicsemeddyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_range_len(s : PhysicsemeddyRange) -> Int { s.size }

pub fn physics_em_eddy_range_get(s : PhysicsemeddyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_range_set(s : PhysicsemeddyRange, i : Int, v : Double) -> PhysicsemeddyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_range_sum(s : PhysicsemeddyRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_range_mean(s : PhysicsemeddyRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_range_scale(s : PhysicsemeddyRange, f : Double) -> PhysicsemeddyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_range_add(a : PhysicsemeddyRange, b : PhysicsemeddyRange) -> PhysicsemeddyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_range_copy(s : PhysicsemeddyRange) -> PhysicsemeddyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_range_fill(s : PhysicsemeddyRange, v : Double) -> PhysicsemeddyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_range_min(s : PhysicsemeddyRange) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_range_max(s : PhysicsemeddyRange) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_range_to_string(s : PhysicsemeddyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemeddySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_eddy_slice_make(size : Int) -> PhysicsemeddySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_eddy_slice_len(s : PhysicsemeddySlice) -> Int { s.size }

pub fn physics_em_eddy_slice_get(s : PhysicsemeddySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_eddy_slice_set(s : PhysicsemeddySlice, i : Int, v : Double) -> PhysicsemeddySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_slice_sum(s : PhysicsemeddySlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_eddy_slice_mean(s : PhysicsemeddySlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_eddy_slice_scale(s : PhysicsemeddySlice, f : Double) -> PhysicsemeddySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_slice_add(a : PhysicsemeddySlice, b : PhysicsemeddySlice) -> PhysicsemeddySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_eddy_slice_copy(s : PhysicsemeddySlice) -> PhysicsemeddySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_slice_fill(s : PhysicsemeddySlice, v : Double) -> PhysicsemeddySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_eddy_slice_min(s : PhysicsemeddySlice) -> Double { @_common.min(s.data) }

pub fn physics_em_eddy_slice_max(s : PhysicsemeddySlice) -> Double { @_common.max(s.data) }

pub fn physics_em_eddy_slice_to_string(s : PhysicsemeddySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

