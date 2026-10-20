///===
/// extcore/physics_heat_source

pub(all) struct PhysicsheatsourcePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_source_make_point(x : Double, y : Double) -> PhysicsheatsourcePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_source_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatsourcePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatsourcePoint::x(self : PhysicsheatsourcePoint) -> Double { self.x }

pub fn PhysicsheatsourcePoint::y(self : PhysicsheatsourcePoint) -> Double { self.y }

pub fn PhysicsheatsourcePoint::z(self : PhysicsheatsourcePoint) -> Double { self.z }

pub fn PhysicsheatsourcePoint::label(self : PhysicsheatsourcePoint) -> Int { self.label }

pub fn PhysicsheatsourcePoint::dist(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatsourcePoint::add(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatsourcePoint::sub(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatsourcePoint::scale(self : PhysicsheatsourcePoint, s : Double) -> PhysicsheatsourcePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatsourcePoint::dot(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatsourcePoint::cross(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatsourcePoint::norm(self : PhysicsheatsourcePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatsourcePoint::normalize(self : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatsourcePoint::negate(self : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatsourcePoint::mid(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatsourcePoint::lerp(self : PhysicsheatsourcePoint, other : PhysicsheatsourcePoint, t : Double) -> PhysicsheatsourcePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatsourcePoint::to_string(self : PhysicsheatsourcePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatsourceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_source_make_series(vals : Array[Double], name : String) -> PhysicsheatsourceSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatsourceSeries::len(self : PhysicsheatsourceSeries) -> Int { self.vals.length() }

pub fn PhysicsheatsourceSeries::sum(self : PhysicsheatsourceSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatsourceSeries::mean(self : PhysicsheatsourceSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatsourceSeries::min(self : PhysicsheatsourceSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatsourceSeries::max(self : PhysicsheatsourceSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatsourceSeries::range(self : PhysicsheatsourceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatsourceSeries::variance(self : PhysicsheatsourceSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatsourceSeries::std(self : PhysicsheatsourceSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatsourceSeries::median(self : PhysicsheatsourceSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatsourceSeries::scale(self : PhysicsheatsourceSeries, f : Double) -> PhysicsheatsourceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatsourceSeries::add(self : PhysicsheatsourceSeries, other : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatsourceSeries::sub(self : PhysicsheatsourceSeries, other : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatsourceSeries::normalize(self : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatsourceSeries::cumsum(self : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatsourceSeries::to_string(self : PhysicsheatsourceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatsourceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_source_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatsourceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_source_matrix_identity(n : Int) -> PhysicsheatsourceMatrix {
  let m = physics_heat_source_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatsourceMatrix::get(self : PhysicsheatsourceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatsourceMatrix::transpose(self : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  let result = physics_heat_source_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatsourceMatrix::add(self : PhysicsheatsourceMatrix, other : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_source_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatsourceMatrix::scale(self : PhysicsheatsourceMatrix, s : Double) -> PhysicsheatsourceMatrix {
  let result = physics_heat_source_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatsourceMatrix::multiply(self : PhysicsheatsourceMatrix, other : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  if self.cols != other.rows { return physics_heat_source_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_source_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatsourceMatrix::trace(self : PhysicsheatsourceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatsourceMatrix::det(self : PhysicsheatsourceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatsourceMatrix::norm(self : PhysicsheatsourceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatsourceMatrix::to_string(self : PhysicsheatsourceMatrix) -> String {
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

pub(all) struct PhysicsheatsourceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_source_make_vector(comps : Array[Double]) -> PhysicsheatsourceVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_source_vector_zero(dim : Int) -> PhysicsheatsourceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatsourceVector::add(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatsourceVector::sub(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatsourceVector::scale(self : PhysicsheatsourceVector, s : Double) -> PhysicsheatsourceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatsourceVector::dot(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatsourceVector::norm(self : PhysicsheatsourceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatsourceVector::normalize(self : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatsourceVector::dist(self : PhysicsheatsourceVector, other : PhysicsheatsourceVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatsourceVector::to_string(self : PhysicsheatsourceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_source_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_source_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_source_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_source_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_source_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_source_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_source_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_source_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_source_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_source_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_source_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_source_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_source_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_source_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_source_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_source_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_source_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_source_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_source_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_source_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_source_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_source_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_source_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_source_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_source_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_source_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_source_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_source_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_source_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatsourceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_frame_make(size : Int) -> PhysicsheatsourceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_frame_len(s : PhysicsheatsourceFrame) -> Int { s.size }

pub fn physics_heat_source_frame_get(s : PhysicsheatsourceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_frame_set(s : PhysicsheatsourceFrame, i : Int, v : Double) -> PhysicsheatsourceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_frame_sum(s : PhysicsheatsourceFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_frame_mean(s : PhysicsheatsourceFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_frame_scale(s : PhysicsheatsourceFrame, f : Double) -> PhysicsheatsourceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_frame_add(a : PhysicsheatsourceFrame, b : PhysicsheatsourceFrame) -> PhysicsheatsourceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_frame_copy(s : PhysicsheatsourceFrame) -> PhysicsheatsourceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_frame_fill(s : PhysicsheatsourceFrame, v : Double) -> PhysicsheatsourceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_frame_min(s : PhysicsheatsourceFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_frame_max(s : PhysicsheatsourceFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_frame_to_string(s : PhysicsheatsourceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_table_make(size : Int) -> PhysicsheatsourceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_table_len(s : PhysicsheatsourceTable) -> Int { s.size }

pub fn physics_heat_source_table_get(s : PhysicsheatsourceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_table_set(s : PhysicsheatsourceTable, i : Int, v : Double) -> PhysicsheatsourceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_table_sum(s : PhysicsheatsourceTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_table_mean(s : PhysicsheatsourceTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_table_scale(s : PhysicsheatsourceTable, f : Double) -> PhysicsheatsourceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_table_add(a : PhysicsheatsourceTable, b : PhysicsheatsourceTable) -> PhysicsheatsourceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_table_copy(s : PhysicsheatsourceTable) -> PhysicsheatsourceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_table_fill(s : PhysicsheatsourceTable, v : Double) -> PhysicsheatsourceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_table_min(s : PhysicsheatsourceTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_table_max(s : PhysicsheatsourceTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_table_to_string(s : PhysicsheatsourceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_graphn_make(size : Int) -> PhysicsheatsourceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_graphn_len(s : PhysicsheatsourceGraphN) -> Int { s.size }

pub fn physics_heat_source_graphn_get(s : PhysicsheatsourceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_graphn_set(s : PhysicsheatsourceGraphN, i : Int, v : Double) -> PhysicsheatsourceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_graphn_sum(s : PhysicsheatsourceGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_graphn_mean(s : PhysicsheatsourceGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_graphn_scale(s : PhysicsheatsourceGraphN, f : Double) -> PhysicsheatsourceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_graphn_add(a : PhysicsheatsourceGraphN, b : PhysicsheatsourceGraphN) -> PhysicsheatsourceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_graphn_copy(s : PhysicsheatsourceGraphN) -> PhysicsheatsourceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_graphn_fill(s : PhysicsheatsourceGraphN, v : Double) -> PhysicsheatsourceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_graphn_min(s : PhysicsheatsourceGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_graphn_max(s : PhysicsheatsourceGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_graphn_to_string(s : PhysicsheatsourceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_node_make(size : Int) -> PhysicsheatsourceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_node_len(s : PhysicsheatsourceNode) -> Int { s.size }

pub fn physics_heat_source_node_get(s : PhysicsheatsourceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_node_set(s : PhysicsheatsourceNode, i : Int, v : Double) -> PhysicsheatsourceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_node_sum(s : PhysicsheatsourceNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_node_mean(s : PhysicsheatsourceNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_node_scale(s : PhysicsheatsourceNode, f : Double) -> PhysicsheatsourceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_node_add(a : PhysicsheatsourceNode, b : PhysicsheatsourceNode) -> PhysicsheatsourceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_node_copy(s : PhysicsheatsourceNode) -> PhysicsheatsourceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_node_fill(s : PhysicsheatsourceNode, v : Double) -> PhysicsheatsourceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_node_min(s : PhysicsheatsourceNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_node_max(s : PhysicsheatsourceNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_node_to_string(s : PhysicsheatsourceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_edge_make(size : Int) -> PhysicsheatsourceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_edge_len(s : PhysicsheatsourceEdge) -> Int { s.size }

pub fn physics_heat_source_edge_get(s : PhysicsheatsourceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_edge_set(s : PhysicsheatsourceEdge, i : Int, v : Double) -> PhysicsheatsourceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_edge_sum(s : PhysicsheatsourceEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_edge_mean(s : PhysicsheatsourceEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_edge_scale(s : PhysicsheatsourceEdge, f : Double) -> PhysicsheatsourceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_edge_add(a : PhysicsheatsourceEdge, b : PhysicsheatsourceEdge) -> PhysicsheatsourceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_edge_copy(s : PhysicsheatsourceEdge) -> PhysicsheatsourceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_edge_fill(s : PhysicsheatsourceEdge, v : Double) -> PhysicsheatsourceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_edge_min(s : PhysicsheatsourceEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_edge_max(s : PhysicsheatsourceEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_edge_to_string(s : PhysicsheatsourceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourcePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_path_make(size : Int) -> PhysicsheatsourcePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_path_len(s : PhysicsheatsourcePath) -> Int { s.size }

pub fn physics_heat_source_path_get(s : PhysicsheatsourcePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_path_set(s : PhysicsheatsourcePath, i : Int, v : Double) -> PhysicsheatsourcePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_path_sum(s : PhysicsheatsourcePath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_path_mean(s : PhysicsheatsourcePath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_path_scale(s : PhysicsheatsourcePath, f : Double) -> PhysicsheatsourcePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_path_add(a : PhysicsheatsourcePath, b : PhysicsheatsourcePath) -> PhysicsheatsourcePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_path_copy(s : PhysicsheatsourcePath) -> PhysicsheatsourcePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_path_fill(s : PhysicsheatsourcePath, v : Double) -> PhysicsheatsourcePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_path_min(s : PhysicsheatsourcePath) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_path_max(s : PhysicsheatsourcePath) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_path_to_string(s : PhysicsheatsourcePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_cluster_make(size : Int) -> PhysicsheatsourceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_cluster_len(s : PhysicsheatsourceCluster) -> Int { s.size }

pub fn physics_heat_source_cluster_get(s : PhysicsheatsourceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_cluster_set(s : PhysicsheatsourceCluster, i : Int, v : Double) -> PhysicsheatsourceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cluster_sum(s : PhysicsheatsourceCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_cluster_mean(s : PhysicsheatsourceCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_cluster_scale(s : PhysicsheatsourceCluster, f : Double) -> PhysicsheatsourceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cluster_add(a : PhysicsheatsourceCluster, b : PhysicsheatsourceCluster) -> PhysicsheatsourceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_cluster_copy(s : PhysicsheatsourceCluster) -> PhysicsheatsourceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cluster_fill(s : PhysicsheatsourceCluster, v : Double) -> PhysicsheatsourceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cluster_min(s : PhysicsheatsourceCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_cluster_max(s : PhysicsheatsourceCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_cluster_to_string(s : PhysicsheatsourceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_model_make(size : Int) -> PhysicsheatsourceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_model_len(s : PhysicsheatsourceModel) -> Int { s.size }

pub fn physics_heat_source_model_get(s : PhysicsheatsourceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_model_set(s : PhysicsheatsourceModel, i : Int, v : Double) -> PhysicsheatsourceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_model_sum(s : PhysicsheatsourceModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_model_mean(s : PhysicsheatsourceModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_model_scale(s : PhysicsheatsourceModel, f : Double) -> PhysicsheatsourceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_model_add(a : PhysicsheatsourceModel, b : PhysicsheatsourceModel) -> PhysicsheatsourceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_model_copy(s : PhysicsheatsourceModel) -> PhysicsheatsourceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_model_fill(s : PhysicsheatsourceModel, v : Double) -> PhysicsheatsourceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_model_min(s : PhysicsheatsourceModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_model_max(s : PhysicsheatsourceModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_model_to_string(s : PhysicsheatsourceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_layer_make(size : Int) -> PhysicsheatsourceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_layer_len(s : PhysicsheatsourceLayer) -> Int { s.size }

pub fn physics_heat_source_layer_get(s : PhysicsheatsourceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_layer_set(s : PhysicsheatsourceLayer, i : Int, v : Double) -> PhysicsheatsourceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_layer_sum(s : PhysicsheatsourceLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_layer_mean(s : PhysicsheatsourceLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_layer_scale(s : PhysicsheatsourceLayer, f : Double) -> PhysicsheatsourceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_layer_add(a : PhysicsheatsourceLayer, b : PhysicsheatsourceLayer) -> PhysicsheatsourceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_layer_copy(s : PhysicsheatsourceLayer) -> PhysicsheatsourceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_layer_fill(s : PhysicsheatsourceLayer, v : Double) -> PhysicsheatsourceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_layer_min(s : PhysicsheatsourceLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_layer_max(s : PhysicsheatsourceLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_layer_to_string(s : PhysicsheatsourceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_buffer_make(size : Int) -> PhysicsheatsourceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_buffer_len(s : PhysicsheatsourceBuffer) -> Int { s.size }

pub fn physics_heat_source_buffer_get(s : PhysicsheatsourceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_buffer_set(s : PhysicsheatsourceBuffer, i : Int, v : Double) -> PhysicsheatsourceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_buffer_sum(s : PhysicsheatsourceBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_buffer_mean(s : PhysicsheatsourceBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_buffer_scale(s : PhysicsheatsourceBuffer, f : Double) -> PhysicsheatsourceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_buffer_add(a : PhysicsheatsourceBuffer, b : PhysicsheatsourceBuffer) -> PhysicsheatsourceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_buffer_copy(s : PhysicsheatsourceBuffer) -> PhysicsheatsourceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_buffer_fill(s : PhysicsheatsourceBuffer, v : Double) -> PhysicsheatsourceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_buffer_min(s : PhysicsheatsourceBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_buffer_max(s : PhysicsheatsourceBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_buffer_to_string(s : PhysicsheatsourceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_cursor_make(size : Int) -> PhysicsheatsourceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_cursor_len(s : PhysicsheatsourceCursor) -> Int { s.size }

pub fn physics_heat_source_cursor_get(s : PhysicsheatsourceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_cursor_set(s : PhysicsheatsourceCursor, i : Int, v : Double) -> PhysicsheatsourceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cursor_sum(s : PhysicsheatsourceCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_cursor_mean(s : PhysicsheatsourceCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_cursor_scale(s : PhysicsheatsourceCursor, f : Double) -> PhysicsheatsourceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cursor_add(a : PhysicsheatsourceCursor, b : PhysicsheatsourceCursor) -> PhysicsheatsourceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_cursor_copy(s : PhysicsheatsourceCursor) -> PhysicsheatsourceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cursor_fill(s : PhysicsheatsourceCursor, v : Double) -> PhysicsheatsourceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_cursor_min(s : PhysicsheatsourceCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_cursor_max(s : PhysicsheatsourceCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_cursor_to_string(s : PhysicsheatsourceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_view_make(size : Int) -> PhysicsheatsourceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_view_len(s : PhysicsheatsourceView) -> Int { s.size }

pub fn physics_heat_source_view_get(s : PhysicsheatsourceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_view_set(s : PhysicsheatsourceView, i : Int, v : Double) -> PhysicsheatsourceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_view_sum(s : PhysicsheatsourceView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_view_mean(s : PhysicsheatsourceView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_view_scale(s : PhysicsheatsourceView, f : Double) -> PhysicsheatsourceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_view_add(a : PhysicsheatsourceView, b : PhysicsheatsourceView) -> PhysicsheatsourceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_view_copy(s : PhysicsheatsourceView) -> PhysicsheatsourceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_view_fill(s : PhysicsheatsourceView, v : Double) -> PhysicsheatsourceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_view_min(s : PhysicsheatsourceView) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_view_max(s : PhysicsheatsourceView) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_view_to_string(s : PhysicsheatsourceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_range_make(size : Int) -> PhysicsheatsourceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_range_len(s : PhysicsheatsourceRange) -> Int { s.size }

pub fn physics_heat_source_range_get(s : PhysicsheatsourceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_range_set(s : PhysicsheatsourceRange, i : Int, v : Double) -> PhysicsheatsourceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_range_sum(s : PhysicsheatsourceRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_range_mean(s : PhysicsheatsourceRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_range_scale(s : PhysicsheatsourceRange, f : Double) -> PhysicsheatsourceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_range_add(a : PhysicsheatsourceRange, b : PhysicsheatsourceRange) -> PhysicsheatsourceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_range_copy(s : PhysicsheatsourceRange) -> PhysicsheatsourceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_range_fill(s : PhysicsheatsourceRange, v : Double) -> PhysicsheatsourceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_range_min(s : PhysicsheatsourceRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_range_max(s : PhysicsheatsourceRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_range_to_string(s : PhysicsheatsourceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_slice_make(size : Int) -> PhysicsheatsourceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_slice_len(s : PhysicsheatsourceSlice) -> Int { s.size }

pub fn physics_heat_source_slice_get(s : PhysicsheatsourceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_slice_set(s : PhysicsheatsourceSlice, i : Int, v : Double) -> PhysicsheatsourceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_source_slice_sum(s : PhysicsheatsourceSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_slice_mean(s : PhysicsheatsourceSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_slice_scale(s : PhysicsheatsourceSlice, f : Double) -> PhysicsheatsourceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_slice_add(a : PhysicsheatsourceSlice, b : PhysicsheatsourceSlice) -> PhysicsheatsourceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_source_slice_copy(s : PhysicsheatsourceSlice) -> PhysicsheatsourceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_slice_fill(s : PhysicsheatsourceSlice, v : Double) -> PhysicsheatsourceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_source_slice_min(s : PhysicsheatsourceSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_slice_max(s : PhysicsheatsourceSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_slice_to_string(s : PhysicsheatsourceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

