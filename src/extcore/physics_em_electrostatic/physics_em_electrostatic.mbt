///===
/// extcore/physics_em_electrostatic

pub(all) struct PhysicsemelectrostaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_electrostatic_make_point(x : Double, y : Double) -> PhysicsemelectrostaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_electrostatic_make_point3(x : Double, y : Double, z : Double) -> PhysicsemelectrostaticPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemelectrostaticPoint::x(self : PhysicsemelectrostaticPoint) -> Double { self.x }

pub fn PhysicsemelectrostaticPoint::y(self : PhysicsemelectrostaticPoint) -> Double { self.y }

pub fn PhysicsemelectrostaticPoint::z(self : PhysicsemelectrostaticPoint) -> Double { self.z }

pub fn PhysicsemelectrostaticPoint::label(self : PhysicsemelectrostaticPoint) -> Int { self.label }

pub fn PhysicsemelectrostaticPoint::dist(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemelectrostaticPoint::add(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemelectrostaticPoint::sub(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemelectrostaticPoint::scale(self : PhysicsemelectrostaticPoint, s : Double) -> PhysicsemelectrostaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemelectrostaticPoint::dot(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemelectrostaticPoint::cross(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemelectrostaticPoint::norm(self : PhysicsemelectrostaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemelectrostaticPoint::normalize(self : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemelectrostaticPoint::negate(self : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemelectrostaticPoint::mid(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemelectrostaticPoint::lerp(self : PhysicsemelectrostaticPoint, other : PhysicsemelectrostaticPoint, t : Double) -> PhysicsemelectrostaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemelectrostaticPoint::to_string(self : PhysicsemelectrostaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_electrostatic_make_series(vals : Array[Double], name : String) -> PhysicsemelectrostaticSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemelectrostaticSeries::len(self : PhysicsemelectrostaticSeries) -> Int { self.vals.length() }

pub fn PhysicsemelectrostaticSeries::sum(self : PhysicsemelectrostaticSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemelectrostaticSeries::mean(self : PhysicsemelectrostaticSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemelectrostaticSeries::min(self : PhysicsemelectrostaticSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemelectrostaticSeries::max(self : PhysicsemelectrostaticSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemelectrostaticSeries::range(self : PhysicsemelectrostaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemelectrostaticSeries::variance(self : PhysicsemelectrostaticSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemelectrostaticSeries::std(self : PhysicsemelectrostaticSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemelectrostaticSeries::median(self : PhysicsemelectrostaticSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemelectrostaticSeries::scale(self : PhysicsemelectrostaticSeries, f : Double) -> PhysicsemelectrostaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemelectrostaticSeries::add(self : PhysicsemelectrostaticSeries, other : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemelectrostaticSeries::sub(self : PhysicsemelectrostaticSeries, other : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemelectrostaticSeries::normalize(self : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemelectrostaticSeries::cumsum(self : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemelectrostaticSeries::to_string(self : PhysicsemelectrostaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemelectrostaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_electrostatic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemelectrostaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_electrostatic_matrix_identity(n : Int) -> PhysicsemelectrostaticMatrix {
  let m = physics_em_electrostatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemelectrostaticMatrix::get(self : PhysicsemelectrostaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemelectrostaticMatrix::transpose(self : PhysicsemelectrostaticMatrix) -> PhysicsemelectrostaticMatrix {
  let result = physics_em_electrostatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemelectrostaticMatrix::add(self : PhysicsemelectrostaticMatrix, other : PhysicsemelectrostaticMatrix) -> PhysicsemelectrostaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_electrostatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemelectrostaticMatrix::scale(self : PhysicsemelectrostaticMatrix, s : Double) -> PhysicsemelectrostaticMatrix {
  let result = physics_em_electrostatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemelectrostaticMatrix::multiply(self : PhysicsemelectrostaticMatrix, other : PhysicsemelectrostaticMatrix) -> PhysicsemelectrostaticMatrix {
  if self.cols != other.rows { return physics_em_electrostatic_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_electrostatic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemelectrostaticMatrix::trace(self : PhysicsemelectrostaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemelectrostaticMatrix::det(self : PhysicsemelectrostaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemelectrostaticMatrix::norm(self : PhysicsemelectrostaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemelectrostaticMatrix::to_string(self : PhysicsemelectrostaticMatrix) -> String {
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

pub(all) struct PhysicsemelectrostaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_electrostatic_make_vector(comps : Array[Double]) -> PhysicsemelectrostaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_electrostatic_vector_zero(dim : Int) -> PhysicsemelectrostaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemelectrostaticVector::add(self : PhysicsemelectrostaticVector, other : PhysicsemelectrostaticVector) -> PhysicsemelectrostaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemelectrostaticVector::sub(self : PhysicsemelectrostaticVector, other : PhysicsemelectrostaticVector) -> PhysicsemelectrostaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemelectrostaticVector::scale(self : PhysicsemelectrostaticVector, s : Double) -> PhysicsemelectrostaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemelectrostaticVector::dot(self : PhysicsemelectrostaticVector, other : PhysicsemelectrostaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemelectrostaticVector::norm(self : PhysicsemelectrostaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemelectrostaticVector::normalize(self : PhysicsemelectrostaticVector) -> PhysicsemelectrostaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemelectrostaticVector::dist(self : PhysicsemelectrostaticVector, other : PhysicsemelectrostaticVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemelectrostaticVector::to_string(self : PhysicsemelectrostaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_electrostatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_electrostatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_electrostatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_electrostatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_electrostatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_electrostatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_electrostatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_electrostatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_electrostatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_electrostatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_electrostatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_electrostatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_electrostatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_electrostatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_electrostatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_electrostatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_electrostatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_electrostatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_electrostatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_electrostatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_electrostatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_electrostatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_electrostatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_electrostatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_electrostatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_electrostatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_electrostatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_electrostatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_electrostatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemelectrostaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_frame_make(size : Int) -> PhysicsemelectrostaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_frame_len(s : PhysicsemelectrostaticFrame) -> Int { s.size }

pub fn physics_em_electrostatic_frame_get(s : PhysicsemelectrostaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_frame_set(s : PhysicsemelectrostaticFrame, i : Int, v : Double) -> PhysicsemelectrostaticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_frame_sum(s : PhysicsemelectrostaticFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_frame_mean(s : PhysicsemelectrostaticFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_frame_scale(s : PhysicsemelectrostaticFrame, f : Double) -> PhysicsemelectrostaticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_frame_add(a : PhysicsemelectrostaticFrame, b : PhysicsemelectrostaticFrame) -> PhysicsemelectrostaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_frame_copy(s : PhysicsemelectrostaticFrame) -> PhysicsemelectrostaticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_frame_fill(s : PhysicsemelectrostaticFrame, v : Double) -> PhysicsemelectrostaticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_frame_min(s : PhysicsemelectrostaticFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_frame_max(s : PhysicsemelectrostaticFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_frame_to_string(s : PhysicsemelectrostaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_table_make(size : Int) -> PhysicsemelectrostaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_table_len(s : PhysicsemelectrostaticTable) -> Int { s.size }

pub fn physics_em_electrostatic_table_get(s : PhysicsemelectrostaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_table_set(s : PhysicsemelectrostaticTable, i : Int, v : Double) -> PhysicsemelectrostaticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_table_sum(s : PhysicsemelectrostaticTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_table_mean(s : PhysicsemelectrostaticTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_table_scale(s : PhysicsemelectrostaticTable, f : Double) -> PhysicsemelectrostaticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_table_add(a : PhysicsemelectrostaticTable, b : PhysicsemelectrostaticTable) -> PhysicsemelectrostaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_table_copy(s : PhysicsemelectrostaticTable) -> PhysicsemelectrostaticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_table_fill(s : PhysicsemelectrostaticTable, v : Double) -> PhysicsemelectrostaticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_table_min(s : PhysicsemelectrostaticTable) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_table_max(s : PhysicsemelectrostaticTable) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_table_to_string(s : PhysicsemelectrostaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_graphn_make(size : Int) -> PhysicsemelectrostaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_graphn_len(s : PhysicsemelectrostaticGraphN) -> Int { s.size }

pub fn physics_em_electrostatic_graphn_get(s : PhysicsemelectrostaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_graphn_set(s : PhysicsemelectrostaticGraphN, i : Int, v : Double) -> PhysicsemelectrostaticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_graphn_sum(s : PhysicsemelectrostaticGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_graphn_mean(s : PhysicsemelectrostaticGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_graphn_scale(s : PhysicsemelectrostaticGraphN, f : Double) -> PhysicsemelectrostaticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_graphn_add(a : PhysicsemelectrostaticGraphN, b : PhysicsemelectrostaticGraphN) -> PhysicsemelectrostaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_graphn_copy(s : PhysicsemelectrostaticGraphN) -> PhysicsemelectrostaticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_graphn_fill(s : PhysicsemelectrostaticGraphN, v : Double) -> PhysicsemelectrostaticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_graphn_min(s : PhysicsemelectrostaticGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_graphn_max(s : PhysicsemelectrostaticGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_graphn_to_string(s : PhysicsemelectrostaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_node_make(size : Int) -> PhysicsemelectrostaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_node_len(s : PhysicsemelectrostaticNode) -> Int { s.size }

pub fn physics_em_electrostatic_node_get(s : PhysicsemelectrostaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_node_set(s : PhysicsemelectrostaticNode, i : Int, v : Double) -> PhysicsemelectrostaticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_node_sum(s : PhysicsemelectrostaticNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_node_mean(s : PhysicsemelectrostaticNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_node_scale(s : PhysicsemelectrostaticNode, f : Double) -> PhysicsemelectrostaticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_node_add(a : PhysicsemelectrostaticNode, b : PhysicsemelectrostaticNode) -> PhysicsemelectrostaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_node_copy(s : PhysicsemelectrostaticNode) -> PhysicsemelectrostaticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_node_fill(s : PhysicsemelectrostaticNode, v : Double) -> PhysicsemelectrostaticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_node_min(s : PhysicsemelectrostaticNode) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_node_max(s : PhysicsemelectrostaticNode) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_node_to_string(s : PhysicsemelectrostaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_edge_make(size : Int) -> PhysicsemelectrostaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_edge_len(s : PhysicsemelectrostaticEdge) -> Int { s.size }

pub fn physics_em_electrostatic_edge_get(s : PhysicsemelectrostaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_edge_set(s : PhysicsemelectrostaticEdge, i : Int, v : Double) -> PhysicsemelectrostaticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_edge_sum(s : PhysicsemelectrostaticEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_edge_mean(s : PhysicsemelectrostaticEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_edge_scale(s : PhysicsemelectrostaticEdge, f : Double) -> PhysicsemelectrostaticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_edge_add(a : PhysicsemelectrostaticEdge, b : PhysicsemelectrostaticEdge) -> PhysicsemelectrostaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_edge_copy(s : PhysicsemelectrostaticEdge) -> PhysicsemelectrostaticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_edge_fill(s : PhysicsemelectrostaticEdge, v : Double) -> PhysicsemelectrostaticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_edge_min(s : PhysicsemelectrostaticEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_edge_max(s : PhysicsemelectrostaticEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_edge_to_string(s : PhysicsemelectrostaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_path_make(size : Int) -> PhysicsemelectrostaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_path_len(s : PhysicsemelectrostaticPath) -> Int { s.size }

pub fn physics_em_electrostatic_path_get(s : PhysicsemelectrostaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_path_set(s : PhysicsemelectrostaticPath, i : Int, v : Double) -> PhysicsemelectrostaticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_path_sum(s : PhysicsemelectrostaticPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_path_mean(s : PhysicsemelectrostaticPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_path_scale(s : PhysicsemelectrostaticPath, f : Double) -> PhysicsemelectrostaticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_path_add(a : PhysicsemelectrostaticPath, b : PhysicsemelectrostaticPath) -> PhysicsemelectrostaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_path_copy(s : PhysicsemelectrostaticPath) -> PhysicsemelectrostaticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_path_fill(s : PhysicsemelectrostaticPath, v : Double) -> PhysicsemelectrostaticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_path_min(s : PhysicsemelectrostaticPath) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_path_max(s : PhysicsemelectrostaticPath) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_path_to_string(s : PhysicsemelectrostaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_cluster_make(size : Int) -> PhysicsemelectrostaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_cluster_len(s : PhysicsemelectrostaticCluster) -> Int { s.size }

pub fn physics_em_electrostatic_cluster_get(s : PhysicsemelectrostaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_cluster_set(s : PhysicsemelectrostaticCluster, i : Int, v : Double) -> PhysicsemelectrostaticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cluster_sum(s : PhysicsemelectrostaticCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_cluster_mean(s : PhysicsemelectrostaticCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_cluster_scale(s : PhysicsemelectrostaticCluster, f : Double) -> PhysicsemelectrostaticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cluster_add(a : PhysicsemelectrostaticCluster, b : PhysicsemelectrostaticCluster) -> PhysicsemelectrostaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_cluster_copy(s : PhysicsemelectrostaticCluster) -> PhysicsemelectrostaticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cluster_fill(s : PhysicsemelectrostaticCluster, v : Double) -> PhysicsemelectrostaticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cluster_min(s : PhysicsemelectrostaticCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_cluster_max(s : PhysicsemelectrostaticCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_cluster_to_string(s : PhysicsemelectrostaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_model_make(size : Int) -> PhysicsemelectrostaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_model_len(s : PhysicsemelectrostaticModel) -> Int { s.size }

pub fn physics_em_electrostatic_model_get(s : PhysicsemelectrostaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_model_set(s : PhysicsemelectrostaticModel, i : Int, v : Double) -> PhysicsemelectrostaticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_model_sum(s : PhysicsemelectrostaticModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_model_mean(s : PhysicsemelectrostaticModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_model_scale(s : PhysicsemelectrostaticModel, f : Double) -> PhysicsemelectrostaticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_model_add(a : PhysicsemelectrostaticModel, b : PhysicsemelectrostaticModel) -> PhysicsemelectrostaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_model_copy(s : PhysicsemelectrostaticModel) -> PhysicsemelectrostaticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_model_fill(s : PhysicsemelectrostaticModel, v : Double) -> PhysicsemelectrostaticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_model_min(s : PhysicsemelectrostaticModel) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_model_max(s : PhysicsemelectrostaticModel) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_model_to_string(s : PhysicsemelectrostaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_layer_make(size : Int) -> PhysicsemelectrostaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_layer_len(s : PhysicsemelectrostaticLayer) -> Int { s.size }

pub fn physics_em_electrostatic_layer_get(s : PhysicsemelectrostaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_layer_set(s : PhysicsemelectrostaticLayer, i : Int, v : Double) -> PhysicsemelectrostaticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_layer_sum(s : PhysicsemelectrostaticLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_layer_mean(s : PhysicsemelectrostaticLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_layer_scale(s : PhysicsemelectrostaticLayer, f : Double) -> PhysicsemelectrostaticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_layer_add(a : PhysicsemelectrostaticLayer, b : PhysicsemelectrostaticLayer) -> PhysicsemelectrostaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_layer_copy(s : PhysicsemelectrostaticLayer) -> PhysicsemelectrostaticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_layer_fill(s : PhysicsemelectrostaticLayer, v : Double) -> PhysicsemelectrostaticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_layer_min(s : PhysicsemelectrostaticLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_layer_max(s : PhysicsemelectrostaticLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_layer_to_string(s : PhysicsemelectrostaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_buffer_make(size : Int) -> PhysicsemelectrostaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_buffer_len(s : PhysicsemelectrostaticBuffer) -> Int { s.size }

pub fn physics_em_electrostatic_buffer_get(s : PhysicsemelectrostaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_buffer_set(s : PhysicsemelectrostaticBuffer, i : Int, v : Double) -> PhysicsemelectrostaticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_buffer_sum(s : PhysicsemelectrostaticBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_buffer_mean(s : PhysicsemelectrostaticBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_buffer_scale(s : PhysicsemelectrostaticBuffer, f : Double) -> PhysicsemelectrostaticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_buffer_add(a : PhysicsemelectrostaticBuffer, b : PhysicsemelectrostaticBuffer) -> PhysicsemelectrostaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_buffer_copy(s : PhysicsemelectrostaticBuffer) -> PhysicsemelectrostaticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_buffer_fill(s : PhysicsemelectrostaticBuffer, v : Double) -> PhysicsemelectrostaticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_buffer_min(s : PhysicsemelectrostaticBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_buffer_max(s : PhysicsemelectrostaticBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_buffer_to_string(s : PhysicsemelectrostaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_cursor_make(size : Int) -> PhysicsemelectrostaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_cursor_len(s : PhysicsemelectrostaticCursor) -> Int { s.size }

pub fn physics_em_electrostatic_cursor_get(s : PhysicsemelectrostaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_cursor_set(s : PhysicsemelectrostaticCursor, i : Int, v : Double) -> PhysicsemelectrostaticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cursor_sum(s : PhysicsemelectrostaticCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_cursor_mean(s : PhysicsemelectrostaticCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_cursor_scale(s : PhysicsemelectrostaticCursor, f : Double) -> PhysicsemelectrostaticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cursor_add(a : PhysicsemelectrostaticCursor, b : PhysicsemelectrostaticCursor) -> PhysicsemelectrostaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_cursor_copy(s : PhysicsemelectrostaticCursor) -> PhysicsemelectrostaticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cursor_fill(s : PhysicsemelectrostaticCursor, v : Double) -> PhysicsemelectrostaticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_cursor_min(s : PhysicsemelectrostaticCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_cursor_max(s : PhysicsemelectrostaticCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_cursor_to_string(s : PhysicsemelectrostaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_view_make(size : Int) -> PhysicsemelectrostaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_view_len(s : PhysicsemelectrostaticView) -> Int { s.size }

pub fn physics_em_electrostatic_view_get(s : PhysicsemelectrostaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_view_set(s : PhysicsemelectrostaticView, i : Int, v : Double) -> PhysicsemelectrostaticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_view_sum(s : PhysicsemelectrostaticView) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_view_mean(s : PhysicsemelectrostaticView) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_view_scale(s : PhysicsemelectrostaticView, f : Double) -> PhysicsemelectrostaticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_view_add(a : PhysicsemelectrostaticView, b : PhysicsemelectrostaticView) -> PhysicsemelectrostaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_view_copy(s : PhysicsemelectrostaticView) -> PhysicsemelectrostaticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_view_fill(s : PhysicsemelectrostaticView, v : Double) -> PhysicsemelectrostaticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_view_min(s : PhysicsemelectrostaticView) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_view_max(s : PhysicsemelectrostaticView) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_view_to_string(s : PhysicsemelectrostaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_range_make(size : Int) -> PhysicsemelectrostaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_range_len(s : PhysicsemelectrostaticRange) -> Int { s.size }

pub fn physics_em_electrostatic_range_get(s : PhysicsemelectrostaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_range_set(s : PhysicsemelectrostaticRange, i : Int, v : Double) -> PhysicsemelectrostaticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_range_sum(s : PhysicsemelectrostaticRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_range_mean(s : PhysicsemelectrostaticRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_range_scale(s : PhysicsemelectrostaticRange, f : Double) -> PhysicsemelectrostaticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_range_add(a : PhysicsemelectrostaticRange, b : PhysicsemelectrostaticRange) -> PhysicsemelectrostaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_range_copy(s : PhysicsemelectrostaticRange) -> PhysicsemelectrostaticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_range_fill(s : PhysicsemelectrostaticRange, v : Double) -> PhysicsemelectrostaticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_range_min(s : PhysicsemelectrostaticRange) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_range_max(s : PhysicsemelectrostaticRange) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_range_to_string(s : PhysicsemelectrostaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_slice_make(size : Int) -> PhysicsemelectrostaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_slice_len(s : PhysicsemelectrostaticSlice) -> Int { s.size }

pub fn physics_em_electrostatic_slice_get(s : PhysicsemelectrostaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_slice_set(s : PhysicsemelectrostaticSlice, i : Int, v : Double) -> PhysicsemelectrostaticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_slice_sum(s : PhysicsemelectrostaticSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_electrostatic_slice_mean(s : PhysicsemelectrostaticSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_electrostatic_slice_scale(s : PhysicsemelectrostaticSlice, f : Double) -> PhysicsemelectrostaticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_slice_add(a : PhysicsemelectrostaticSlice, b : PhysicsemelectrostaticSlice) -> PhysicsemelectrostaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_electrostatic_slice_copy(s : PhysicsemelectrostaticSlice) -> PhysicsemelectrostaticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_slice_fill(s : PhysicsemelectrostaticSlice, v : Double) -> PhysicsemelectrostaticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_electrostatic_slice_min(s : PhysicsemelectrostaticSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_electrostatic_slice_max(s : PhysicsemelectrostaticSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_electrostatic_slice_to_string(s : PhysicsemelectrostaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

