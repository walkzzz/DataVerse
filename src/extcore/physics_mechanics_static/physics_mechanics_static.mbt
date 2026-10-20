///===
/// extcore/physics_mechanics_static

pub(all) struct PhysicsmechanicsstaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_static_make_point(x : Double, y : Double) -> PhysicsmechanicsstaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_static_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsstaticPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsstaticPoint::x(self : PhysicsmechanicsstaticPoint) -> Double { self.x }

pub fn PhysicsmechanicsstaticPoint::y(self : PhysicsmechanicsstaticPoint) -> Double { self.y }

pub fn PhysicsmechanicsstaticPoint::z(self : PhysicsmechanicsstaticPoint) -> Double { self.z }

pub fn PhysicsmechanicsstaticPoint::label(self : PhysicsmechanicsstaticPoint) -> Int { self.label }

pub fn PhysicsmechanicsstaticPoint::dist(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsstaticPoint::add(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::sub(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::scale(self : PhysicsmechanicsstaticPoint, s : Double) -> PhysicsmechanicsstaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::dot(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsstaticPoint::cross(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsstaticPoint::norm(self : PhysicsmechanicsstaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsstaticPoint::normalize(self : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsstaticPoint::negate(self : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::mid(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::lerp(self : PhysicsmechanicsstaticPoint, other : PhysicsmechanicsstaticPoint, t : Double) -> PhysicsmechanicsstaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsstaticPoint::to_string(self : PhysicsmechanicsstaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_static_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsstaticSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsstaticSeries::len(self : PhysicsmechanicsstaticSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsstaticSeries::sum(self : PhysicsmechanicsstaticSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsstaticSeries::mean(self : PhysicsmechanicsstaticSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsstaticSeries::min(self : PhysicsmechanicsstaticSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsstaticSeries::max(self : PhysicsmechanicsstaticSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsstaticSeries::range(self : PhysicsmechanicsstaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsstaticSeries::variance(self : PhysicsmechanicsstaticSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsstaticSeries::std(self : PhysicsmechanicsstaticSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsstaticSeries::median(self : PhysicsmechanicsstaticSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsstaticSeries::scale(self : PhysicsmechanicsstaticSeries, f : Double) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::add(self : PhysicsmechanicsstaticSeries, other : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::sub(self : PhysicsmechanicsstaticSeries, other : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::normalize(self : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsstaticSeries::cumsum(self : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsstaticSeries::to_string(self : PhysicsmechanicsstaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsstaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_static_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsstaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_static_matrix_identity(n : Int) -> PhysicsmechanicsstaticMatrix {
  let m = physics_mechanics_static_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsstaticMatrix::get(self : PhysicsmechanicsstaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsstaticMatrix::transpose(self : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  let result = physics_mechanics_static_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsstaticMatrix::add(self : PhysicsmechanicsstaticMatrix, other : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsstaticMatrix::scale(self : PhysicsmechanicsstaticMatrix, s : Double) -> PhysicsmechanicsstaticMatrix {
  let result = physics_mechanics_static_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsstaticMatrix::multiply(self : PhysicsmechanicsstaticMatrix, other : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  if self.cols != other.rows { return physics_mechanics_static_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_static_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsstaticMatrix::trace(self : PhysicsmechanicsstaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsstaticMatrix::det(self : PhysicsmechanicsstaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsstaticMatrix::norm(self : PhysicsmechanicsstaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsstaticMatrix::to_string(self : PhysicsmechanicsstaticMatrix) -> String {
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

pub(all) struct PhysicsmechanicsstaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_static_make_vector(comps : Array[Double]) -> PhysicsmechanicsstaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_static_vector_zero(dim : Int) -> PhysicsmechanicsstaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsstaticVector::add(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsstaticVector::sub(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsstaticVector::scale(self : PhysicsmechanicsstaticVector, s : Double) -> PhysicsmechanicsstaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsstaticVector::dot(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsstaticVector::norm(self : PhysicsmechanicsstaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsstaticVector::normalize(self : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsstaticVector::dist(self : PhysicsmechanicsstaticVector, other : PhysicsmechanicsstaticVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsstaticVector::to_string(self : PhysicsmechanicsstaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_static_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_static_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_static_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_static_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_static_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_static_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_static_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_static_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_static_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_static_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_static_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_static_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_static_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_static_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_static_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_static_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_static_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_static_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_static_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_static_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_static_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_static_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_static_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_static_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_static_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_static_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_static_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_static_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_static_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsstaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_frame_make(size : Int) -> PhysicsmechanicsstaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_frame_len(s : PhysicsmechanicsstaticFrame) -> Int { s.size }

pub fn physics_mechanics_static_frame_get(s : PhysicsmechanicsstaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_frame_set(s : PhysicsmechanicsstaticFrame, i : Int, v : Double) -> PhysicsmechanicsstaticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_frame_sum(s : PhysicsmechanicsstaticFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_frame_mean(s : PhysicsmechanicsstaticFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_frame_scale(s : PhysicsmechanicsstaticFrame, f : Double) -> PhysicsmechanicsstaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_frame_add(a : PhysicsmechanicsstaticFrame, b : PhysicsmechanicsstaticFrame) -> PhysicsmechanicsstaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_frame_copy(s : PhysicsmechanicsstaticFrame) -> PhysicsmechanicsstaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_frame_fill(s : PhysicsmechanicsstaticFrame, v : Double) -> PhysicsmechanicsstaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_frame_min(s : PhysicsmechanicsstaticFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_frame_max(s : PhysicsmechanicsstaticFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_frame_to_string(s : PhysicsmechanicsstaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_table_make(size : Int) -> PhysicsmechanicsstaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_table_len(s : PhysicsmechanicsstaticTable) -> Int { s.size }

pub fn physics_mechanics_static_table_get(s : PhysicsmechanicsstaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_table_set(s : PhysicsmechanicsstaticTable, i : Int, v : Double) -> PhysicsmechanicsstaticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_table_sum(s : PhysicsmechanicsstaticTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_table_mean(s : PhysicsmechanicsstaticTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_table_scale(s : PhysicsmechanicsstaticTable, f : Double) -> PhysicsmechanicsstaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_table_add(a : PhysicsmechanicsstaticTable, b : PhysicsmechanicsstaticTable) -> PhysicsmechanicsstaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_table_copy(s : PhysicsmechanicsstaticTable) -> PhysicsmechanicsstaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_table_fill(s : PhysicsmechanicsstaticTable, v : Double) -> PhysicsmechanicsstaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_table_min(s : PhysicsmechanicsstaticTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_table_max(s : PhysicsmechanicsstaticTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_table_to_string(s : PhysicsmechanicsstaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_graphn_make(size : Int) -> PhysicsmechanicsstaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_graphn_len(s : PhysicsmechanicsstaticGraphN) -> Int { s.size }

pub fn physics_mechanics_static_graphn_get(s : PhysicsmechanicsstaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_graphn_set(s : PhysicsmechanicsstaticGraphN, i : Int, v : Double) -> PhysicsmechanicsstaticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_graphn_sum(s : PhysicsmechanicsstaticGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_graphn_mean(s : PhysicsmechanicsstaticGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_graphn_scale(s : PhysicsmechanicsstaticGraphN, f : Double) -> PhysicsmechanicsstaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_graphn_add(a : PhysicsmechanicsstaticGraphN, b : PhysicsmechanicsstaticGraphN) -> PhysicsmechanicsstaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_graphn_copy(s : PhysicsmechanicsstaticGraphN) -> PhysicsmechanicsstaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_graphn_fill(s : PhysicsmechanicsstaticGraphN, v : Double) -> PhysicsmechanicsstaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_graphn_min(s : PhysicsmechanicsstaticGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_graphn_max(s : PhysicsmechanicsstaticGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_graphn_to_string(s : PhysicsmechanicsstaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_node_make(size : Int) -> PhysicsmechanicsstaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_node_len(s : PhysicsmechanicsstaticNode) -> Int { s.size }

pub fn physics_mechanics_static_node_get(s : PhysicsmechanicsstaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_node_set(s : PhysicsmechanicsstaticNode, i : Int, v : Double) -> PhysicsmechanicsstaticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_node_sum(s : PhysicsmechanicsstaticNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_node_mean(s : PhysicsmechanicsstaticNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_node_scale(s : PhysicsmechanicsstaticNode, f : Double) -> PhysicsmechanicsstaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_node_add(a : PhysicsmechanicsstaticNode, b : PhysicsmechanicsstaticNode) -> PhysicsmechanicsstaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_node_copy(s : PhysicsmechanicsstaticNode) -> PhysicsmechanicsstaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_node_fill(s : PhysicsmechanicsstaticNode, v : Double) -> PhysicsmechanicsstaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_node_min(s : PhysicsmechanicsstaticNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_node_max(s : PhysicsmechanicsstaticNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_node_to_string(s : PhysicsmechanicsstaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_edge_make(size : Int) -> PhysicsmechanicsstaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_edge_len(s : PhysicsmechanicsstaticEdge) -> Int { s.size }

pub fn physics_mechanics_static_edge_get(s : PhysicsmechanicsstaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_edge_set(s : PhysicsmechanicsstaticEdge, i : Int, v : Double) -> PhysicsmechanicsstaticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_edge_sum(s : PhysicsmechanicsstaticEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_edge_mean(s : PhysicsmechanicsstaticEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_edge_scale(s : PhysicsmechanicsstaticEdge, f : Double) -> PhysicsmechanicsstaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_edge_add(a : PhysicsmechanicsstaticEdge, b : PhysicsmechanicsstaticEdge) -> PhysicsmechanicsstaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_edge_copy(s : PhysicsmechanicsstaticEdge) -> PhysicsmechanicsstaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_edge_fill(s : PhysicsmechanicsstaticEdge, v : Double) -> PhysicsmechanicsstaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_edge_min(s : PhysicsmechanicsstaticEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_edge_max(s : PhysicsmechanicsstaticEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_edge_to_string(s : PhysicsmechanicsstaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_path_make(size : Int) -> PhysicsmechanicsstaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_path_len(s : PhysicsmechanicsstaticPath) -> Int { s.size }

pub fn physics_mechanics_static_path_get(s : PhysicsmechanicsstaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_path_set(s : PhysicsmechanicsstaticPath, i : Int, v : Double) -> PhysicsmechanicsstaticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_path_sum(s : PhysicsmechanicsstaticPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_path_mean(s : PhysicsmechanicsstaticPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_path_scale(s : PhysicsmechanicsstaticPath, f : Double) -> PhysicsmechanicsstaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_path_add(a : PhysicsmechanicsstaticPath, b : PhysicsmechanicsstaticPath) -> PhysicsmechanicsstaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_path_copy(s : PhysicsmechanicsstaticPath) -> PhysicsmechanicsstaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_path_fill(s : PhysicsmechanicsstaticPath, v : Double) -> PhysicsmechanicsstaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_path_min(s : PhysicsmechanicsstaticPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_path_max(s : PhysicsmechanicsstaticPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_path_to_string(s : PhysicsmechanicsstaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_cluster_make(size : Int) -> PhysicsmechanicsstaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_cluster_len(s : PhysicsmechanicsstaticCluster) -> Int { s.size }

pub fn physics_mechanics_static_cluster_get(s : PhysicsmechanicsstaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_cluster_set(s : PhysicsmechanicsstaticCluster, i : Int, v : Double) -> PhysicsmechanicsstaticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cluster_sum(s : PhysicsmechanicsstaticCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_cluster_mean(s : PhysicsmechanicsstaticCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_cluster_scale(s : PhysicsmechanicsstaticCluster, f : Double) -> PhysicsmechanicsstaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cluster_add(a : PhysicsmechanicsstaticCluster, b : PhysicsmechanicsstaticCluster) -> PhysicsmechanicsstaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_cluster_copy(s : PhysicsmechanicsstaticCluster) -> PhysicsmechanicsstaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cluster_fill(s : PhysicsmechanicsstaticCluster, v : Double) -> PhysicsmechanicsstaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cluster_min(s : PhysicsmechanicsstaticCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_cluster_max(s : PhysicsmechanicsstaticCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_cluster_to_string(s : PhysicsmechanicsstaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_model_make(size : Int) -> PhysicsmechanicsstaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_model_len(s : PhysicsmechanicsstaticModel) -> Int { s.size }

pub fn physics_mechanics_static_model_get(s : PhysicsmechanicsstaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_model_set(s : PhysicsmechanicsstaticModel, i : Int, v : Double) -> PhysicsmechanicsstaticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_model_sum(s : PhysicsmechanicsstaticModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_model_mean(s : PhysicsmechanicsstaticModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_model_scale(s : PhysicsmechanicsstaticModel, f : Double) -> PhysicsmechanicsstaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_model_add(a : PhysicsmechanicsstaticModel, b : PhysicsmechanicsstaticModel) -> PhysicsmechanicsstaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_model_copy(s : PhysicsmechanicsstaticModel) -> PhysicsmechanicsstaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_model_fill(s : PhysicsmechanicsstaticModel, v : Double) -> PhysicsmechanicsstaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_model_min(s : PhysicsmechanicsstaticModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_model_max(s : PhysicsmechanicsstaticModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_model_to_string(s : PhysicsmechanicsstaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_layer_make(size : Int) -> PhysicsmechanicsstaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_layer_len(s : PhysicsmechanicsstaticLayer) -> Int { s.size }

pub fn physics_mechanics_static_layer_get(s : PhysicsmechanicsstaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_layer_set(s : PhysicsmechanicsstaticLayer, i : Int, v : Double) -> PhysicsmechanicsstaticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_layer_sum(s : PhysicsmechanicsstaticLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_layer_mean(s : PhysicsmechanicsstaticLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_layer_scale(s : PhysicsmechanicsstaticLayer, f : Double) -> PhysicsmechanicsstaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_layer_add(a : PhysicsmechanicsstaticLayer, b : PhysicsmechanicsstaticLayer) -> PhysicsmechanicsstaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_layer_copy(s : PhysicsmechanicsstaticLayer) -> PhysicsmechanicsstaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_layer_fill(s : PhysicsmechanicsstaticLayer, v : Double) -> PhysicsmechanicsstaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_layer_min(s : PhysicsmechanicsstaticLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_layer_max(s : PhysicsmechanicsstaticLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_layer_to_string(s : PhysicsmechanicsstaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_buffer_make(size : Int) -> PhysicsmechanicsstaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_buffer_len(s : PhysicsmechanicsstaticBuffer) -> Int { s.size }

pub fn physics_mechanics_static_buffer_get(s : PhysicsmechanicsstaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_buffer_set(s : PhysicsmechanicsstaticBuffer, i : Int, v : Double) -> PhysicsmechanicsstaticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_buffer_sum(s : PhysicsmechanicsstaticBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_buffer_mean(s : PhysicsmechanicsstaticBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_buffer_scale(s : PhysicsmechanicsstaticBuffer, f : Double) -> PhysicsmechanicsstaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_buffer_add(a : PhysicsmechanicsstaticBuffer, b : PhysicsmechanicsstaticBuffer) -> PhysicsmechanicsstaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_buffer_copy(s : PhysicsmechanicsstaticBuffer) -> PhysicsmechanicsstaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_buffer_fill(s : PhysicsmechanicsstaticBuffer, v : Double) -> PhysicsmechanicsstaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_buffer_min(s : PhysicsmechanicsstaticBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_buffer_max(s : PhysicsmechanicsstaticBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_buffer_to_string(s : PhysicsmechanicsstaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_cursor_make(size : Int) -> PhysicsmechanicsstaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_cursor_len(s : PhysicsmechanicsstaticCursor) -> Int { s.size }

pub fn physics_mechanics_static_cursor_get(s : PhysicsmechanicsstaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_cursor_set(s : PhysicsmechanicsstaticCursor, i : Int, v : Double) -> PhysicsmechanicsstaticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cursor_sum(s : PhysicsmechanicsstaticCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_cursor_mean(s : PhysicsmechanicsstaticCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_cursor_scale(s : PhysicsmechanicsstaticCursor, f : Double) -> PhysicsmechanicsstaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cursor_add(a : PhysicsmechanicsstaticCursor, b : PhysicsmechanicsstaticCursor) -> PhysicsmechanicsstaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_cursor_copy(s : PhysicsmechanicsstaticCursor) -> PhysicsmechanicsstaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cursor_fill(s : PhysicsmechanicsstaticCursor, v : Double) -> PhysicsmechanicsstaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_cursor_min(s : PhysicsmechanicsstaticCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_cursor_max(s : PhysicsmechanicsstaticCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_cursor_to_string(s : PhysicsmechanicsstaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_view_make(size : Int) -> PhysicsmechanicsstaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_view_len(s : PhysicsmechanicsstaticView) -> Int { s.size }

pub fn physics_mechanics_static_view_get(s : PhysicsmechanicsstaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_view_set(s : PhysicsmechanicsstaticView, i : Int, v : Double) -> PhysicsmechanicsstaticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_view_sum(s : PhysicsmechanicsstaticView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_view_mean(s : PhysicsmechanicsstaticView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_view_scale(s : PhysicsmechanicsstaticView, f : Double) -> PhysicsmechanicsstaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_view_add(a : PhysicsmechanicsstaticView, b : PhysicsmechanicsstaticView) -> PhysicsmechanicsstaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_view_copy(s : PhysicsmechanicsstaticView) -> PhysicsmechanicsstaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_view_fill(s : PhysicsmechanicsstaticView, v : Double) -> PhysicsmechanicsstaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_view_min(s : PhysicsmechanicsstaticView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_view_max(s : PhysicsmechanicsstaticView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_view_to_string(s : PhysicsmechanicsstaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_range_make(size : Int) -> PhysicsmechanicsstaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_range_len(s : PhysicsmechanicsstaticRange) -> Int { s.size }

pub fn physics_mechanics_static_range_get(s : PhysicsmechanicsstaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_range_set(s : PhysicsmechanicsstaticRange, i : Int, v : Double) -> PhysicsmechanicsstaticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_range_sum(s : PhysicsmechanicsstaticRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_range_mean(s : PhysicsmechanicsstaticRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_range_scale(s : PhysicsmechanicsstaticRange, f : Double) -> PhysicsmechanicsstaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_range_add(a : PhysicsmechanicsstaticRange, b : PhysicsmechanicsstaticRange) -> PhysicsmechanicsstaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_range_copy(s : PhysicsmechanicsstaticRange) -> PhysicsmechanicsstaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_range_fill(s : PhysicsmechanicsstaticRange, v : Double) -> PhysicsmechanicsstaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_range_min(s : PhysicsmechanicsstaticRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_range_max(s : PhysicsmechanicsstaticRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_range_to_string(s : PhysicsmechanicsstaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_slice_make(size : Int) -> PhysicsmechanicsstaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_slice_len(s : PhysicsmechanicsstaticSlice) -> Int { s.size }

pub fn physics_mechanics_static_slice_get(s : PhysicsmechanicsstaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_slice_set(s : PhysicsmechanicsstaticSlice, i : Int, v : Double) -> PhysicsmechanicsstaticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_slice_sum(s : PhysicsmechanicsstaticSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_static_slice_mean(s : PhysicsmechanicsstaticSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_static_slice_scale(s : PhysicsmechanicsstaticSlice, f : Double) -> PhysicsmechanicsstaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_slice_add(a : PhysicsmechanicsstaticSlice, b : PhysicsmechanicsstaticSlice) -> PhysicsmechanicsstaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_static_slice_copy(s : PhysicsmechanicsstaticSlice) -> PhysicsmechanicsstaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_slice_fill(s : PhysicsmechanicsstaticSlice, v : Double) -> PhysicsmechanicsstaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_static_slice_min(s : PhysicsmechanicsstaticSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_static_slice_max(s : PhysicsmechanicsstaticSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_static_slice_to_string(s : PhysicsmechanicsstaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

