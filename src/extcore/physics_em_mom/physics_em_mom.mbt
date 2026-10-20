///===
/// extcore/physics_em_mom

pub(all) struct PhysicsemmomPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_mom_make_point(x : Double, y : Double) -> PhysicsemmomPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_mom_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmomPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemmomPoint::x(self : PhysicsemmomPoint) -> Double { self.x }

pub fn PhysicsemmomPoint::y(self : PhysicsemmomPoint) -> Double { self.y }

pub fn PhysicsemmomPoint::z(self : PhysicsemmomPoint) -> Double { self.z }

pub fn PhysicsemmomPoint::label(self : PhysicsemmomPoint) -> Int { self.label }

pub fn PhysicsemmomPoint::dist(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemmomPoint::add(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemmomPoint::sub(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemmomPoint::scale(self : PhysicsemmomPoint, s : Double) -> PhysicsemmomPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemmomPoint::dot(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemmomPoint::cross(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemmomPoint::norm(self : PhysicsemmomPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemmomPoint::normalize(self : PhysicsemmomPoint) -> PhysicsemmomPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmomPoint::negate(self : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemmomPoint::mid(self : PhysicsemmomPoint, other : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemmomPoint::lerp(self : PhysicsemmomPoint, other : PhysicsemmomPoint, t : Double) -> PhysicsemmomPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemmomPoint::to_string(self : PhysicsemmomPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemmomSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_mom_make_series(vals : Array[Double], name : String) -> PhysicsemmomSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemmomSeries::len(self : PhysicsemmomSeries) -> Int { self.vals.length() }

pub fn PhysicsemmomSeries::sum(self : PhysicsemmomSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemmomSeries::mean(self : PhysicsemmomSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemmomSeries::min(self : PhysicsemmomSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemmomSeries::max(self : PhysicsemmomSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemmomSeries::range(self : PhysicsemmomSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemmomSeries::variance(self : PhysicsemmomSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemmomSeries::std(self : PhysicsemmomSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemmomSeries::median(self : PhysicsemmomSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemmomSeries::scale(self : PhysicsemmomSeries, f : Double) -> PhysicsemmomSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemmomSeries::add(self : PhysicsemmomSeries, other : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemmomSeries::sub(self : PhysicsemmomSeries, other : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemmomSeries::normalize(self : PhysicsemmomSeries) -> PhysicsemmomSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemmomSeries::cumsum(self : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemmomSeries::to_string(self : PhysicsemmomSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmomMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_mom_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmomMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_mom_matrix_identity(n : Int) -> PhysicsemmomMatrix {
  let m = physics_em_mom_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemmomMatrix::get(self : PhysicsemmomMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemmomMatrix::transpose(self : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  let result = physics_em_mom_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemmomMatrix::add(self : PhysicsemmomMatrix, other : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_mom_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemmomMatrix::scale(self : PhysicsemmomMatrix, s : Double) -> PhysicsemmomMatrix {
  let result = physics_em_mom_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemmomMatrix::multiply(self : PhysicsemmomMatrix, other : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  if self.cols != other.rows { return physics_em_mom_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_mom_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemmomMatrix::trace(self : PhysicsemmomMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemmomMatrix::det(self : PhysicsemmomMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemmomMatrix::norm(self : PhysicsemmomMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemmomMatrix::to_string(self : PhysicsemmomMatrix) -> String {
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

pub(all) struct PhysicsemmomVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_mom_make_vector(comps : Array[Double]) -> PhysicsemmomVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_mom_vector_zero(dim : Int) -> PhysicsemmomVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemmomVector::add(self : PhysicsemmomVector, other : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmomVector::sub(self : PhysicsemmomVector, other : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmomVector::scale(self : PhysicsemmomVector, s : Double) -> PhysicsemmomVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemmomVector::dot(self : PhysicsemmomVector, other : PhysicsemmomVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemmomVector::norm(self : PhysicsemmomVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemmomVector::normalize(self : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmomVector::dist(self : PhysicsemmomVector, other : PhysicsemmomVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemmomVector::to_string(self : PhysicsemmomVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_mom_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_mom_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_mom_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_mom_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_mom_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_mom_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_mom_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_mom_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_mom_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_mom_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_mom_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_mom_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_mom_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_mom_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_mom_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_mom_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_mom_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_mom_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_mom_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_mom_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_mom_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_mom_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_mom_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_mom_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_mom_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_mom_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_mom_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_mom_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_mom_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemmomFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_frame_make(size : Int) -> PhysicsemmomFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_frame_len(s : PhysicsemmomFrame) -> Int { s.size }

pub fn physics_em_mom_frame_get(s : PhysicsemmomFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_frame_set(s : PhysicsemmomFrame, i : Int, v : Double) -> PhysicsemmomFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_frame_sum(s : PhysicsemmomFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_frame_mean(s : PhysicsemmomFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_frame_scale(s : PhysicsemmomFrame, f : Double) -> PhysicsemmomFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_frame_add(a : PhysicsemmomFrame, b : PhysicsemmomFrame) -> PhysicsemmomFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_frame_copy(s : PhysicsemmomFrame) -> PhysicsemmomFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_frame_fill(s : PhysicsemmomFrame, v : Double) -> PhysicsemmomFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_frame_min(s : PhysicsemmomFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_frame_max(s : PhysicsemmomFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_frame_to_string(s : PhysicsemmomFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_table_make(size : Int) -> PhysicsemmomTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_table_len(s : PhysicsemmomTable) -> Int { s.size }

pub fn physics_em_mom_table_get(s : PhysicsemmomTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_table_set(s : PhysicsemmomTable, i : Int, v : Double) -> PhysicsemmomTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_table_sum(s : PhysicsemmomTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_table_mean(s : PhysicsemmomTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_table_scale(s : PhysicsemmomTable, f : Double) -> PhysicsemmomTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_table_add(a : PhysicsemmomTable, b : PhysicsemmomTable) -> PhysicsemmomTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_table_copy(s : PhysicsemmomTable) -> PhysicsemmomTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_table_fill(s : PhysicsemmomTable, v : Double) -> PhysicsemmomTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_table_min(s : PhysicsemmomTable) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_table_max(s : PhysicsemmomTable) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_table_to_string(s : PhysicsemmomTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_graphn_make(size : Int) -> PhysicsemmomGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_graphn_len(s : PhysicsemmomGraphN) -> Int { s.size }

pub fn physics_em_mom_graphn_get(s : PhysicsemmomGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_graphn_set(s : PhysicsemmomGraphN, i : Int, v : Double) -> PhysicsemmomGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_graphn_sum(s : PhysicsemmomGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_graphn_mean(s : PhysicsemmomGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_graphn_scale(s : PhysicsemmomGraphN, f : Double) -> PhysicsemmomGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_graphn_add(a : PhysicsemmomGraphN, b : PhysicsemmomGraphN) -> PhysicsemmomGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_graphn_copy(s : PhysicsemmomGraphN) -> PhysicsemmomGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_graphn_fill(s : PhysicsemmomGraphN, v : Double) -> PhysicsemmomGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_graphn_min(s : PhysicsemmomGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_graphn_max(s : PhysicsemmomGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_graphn_to_string(s : PhysicsemmomGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_node_make(size : Int) -> PhysicsemmomNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_node_len(s : PhysicsemmomNode) -> Int { s.size }

pub fn physics_em_mom_node_get(s : PhysicsemmomNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_node_set(s : PhysicsemmomNode, i : Int, v : Double) -> PhysicsemmomNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_node_sum(s : PhysicsemmomNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_node_mean(s : PhysicsemmomNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_node_scale(s : PhysicsemmomNode, f : Double) -> PhysicsemmomNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_node_add(a : PhysicsemmomNode, b : PhysicsemmomNode) -> PhysicsemmomNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_node_copy(s : PhysicsemmomNode) -> PhysicsemmomNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_node_fill(s : PhysicsemmomNode, v : Double) -> PhysicsemmomNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_node_min(s : PhysicsemmomNode) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_node_max(s : PhysicsemmomNode) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_node_to_string(s : PhysicsemmomNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_edge_make(size : Int) -> PhysicsemmomEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_edge_len(s : PhysicsemmomEdge) -> Int { s.size }

pub fn physics_em_mom_edge_get(s : PhysicsemmomEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_edge_set(s : PhysicsemmomEdge, i : Int, v : Double) -> PhysicsemmomEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_edge_sum(s : PhysicsemmomEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_edge_mean(s : PhysicsemmomEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_edge_scale(s : PhysicsemmomEdge, f : Double) -> PhysicsemmomEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_edge_add(a : PhysicsemmomEdge, b : PhysicsemmomEdge) -> PhysicsemmomEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_edge_copy(s : PhysicsemmomEdge) -> PhysicsemmomEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_edge_fill(s : PhysicsemmomEdge, v : Double) -> PhysicsemmomEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_edge_min(s : PhysicsemmomEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_edge_max(s : PhysicsemmomEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_edge_to_string(s : PhysicsemmomEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_path_make(size : Int) -> PhysicsemmomPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_path_len(s : PhysicsemmomPath) -> Int { s.size }

pub fn physics_em_mom_path_get(s : PhysicsemmomPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_path_set(s : PhysicsemmomPath, i : Int, v : Double) -> PhysicsemmomPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_path_sum(s : PhysicsemmomPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_path_mean(s : PhysicsemmomPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_path_scale(s : PhysicsemmomPath, f : Double) -> PhysicsemmomPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_path_add(a : PhysicsemmomPath, b : PhysicsemmomPath) -> PhysicsemmomPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_path_copy(s : PhysicsemmomPath) -> PhysicsemmomPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_path_fill(s : PhysicsemmomPath, v : Double) -> PhysicsemmomPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_path_min(s : PhysicsemmomPath) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_path_max(s : PhysicsemmomPath) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_path_to_string(s : PhysicsemmomPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_cluster_make(size : Int) -> PhysicsemmomCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_cluster_len(s : PhysicsemmomCluster) -> Int { s.size }

pub fn physics_em_mom_cluster_get(s : PhysicsemmomCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_cluster_set(s : PhysicsemmomCluster, i : Int, v : Double) -> PhysicsemmomCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cluster_sum(s : PhysicsemmomCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_cluster_mean(s : PhysicsemmomCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_cluster_scale(s : PhysicsemmomCluster, f : Double) -> PhysicsemmomCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cluster_add(a : PhysicsemmomCluster, b : PhysicsemmomCluster) -> PhysicsemmomCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_cluster_copy(s : PhysicsemmomCluster) -> PhysicsemmomCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cluster_fill(s : PhysicsemmomCluster, v : Double) -> PhysicsemmomCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cluster_min(s : PhysicsemmomCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_cluster_max(s : PhysicsemmomCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_cluster_to_string(s : PhysicsemmomCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_model_make(size : Int) -> PhysicsemmomModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_model_len(s : PhysicsemmomModel) -> Int { s.size }

pub fn physics_em_mom_model_get(s : PhysicsemmomModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_model_set(s : PhysicsemmomModel, i : Int, v : Double) -> PhysicsemmomModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_model_sum(s : PhysicsemmomModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_model_mean(s : PhysicsemmomModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_model_scale(s : PhysicsemmomModel, f : Double) -> PhysicsemmomModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_model_add(a : PhysicsemmomModel, b : PhysicsemmomModel) -> PhysicsemmomModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_model_copy(s : PhysicsemmomModel) -> PhysicsemmomModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_model_fill(s : PhysicsemmomModel, v : Double) -> PhysicsemmomModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_model_min(s : PhysicsemmomModel) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_model_max(s : PhysicsemmomModel) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_model_to_string(s : PhysicsemmomModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_layer_make(size : Int) -> PhysicsemmomLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_layer_len(s : PhysicsemmomLayer) -> Int { s.size }

pub fn physics_em_mom_layer_get(s : PhysicsemmomLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_layer_set(s : PhysicsemmomLayer, i : Int, v : Double) -> PhysicsemmomLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_layer_sum(s : PhysicsemmomLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_layer_mean(s : PhysicsemmomLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_layer_scale(s : PhysicsemmomLayer, f : Double) -> PhysicsemmomLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_layer_add(a : PhysicsemmomLayer, b : PhysicsemmomLayer) -> PhysicsemmomLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_layer_copy(s : PhysicsemmomLayer) -> PhysicsemmomLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_layer_fill(s : PhysicsemmomLayer, v : Double) -> PhysicsemmomLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_layer_min(s : PhysicsemmomLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_layer_max(s : PhysicsemmomLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_layer_to_string(s : PhysicsemmomLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_buffer_make(size : Int) -> PhysicsemmomBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_buffer_len(s : PhysicsemmomBuffer) -> Int { s.size }

pub fn physics_em_mom_buffer_get(s : PhysicsemmomBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_buffer_set(s : PhysicsemmomBuffer, i : Int, v : Double) -> PhysicsemmomBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_buffer_sum(s : PhysicsemmomBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_buffer_mean(s : PhysicsemmomBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_buffer_scale(s : PhysicsemmomBuffer, f : Double) -> PhysicsemmomBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_buffer_add(a : PhysicsemmomBuffer, b : PhysicsemmomBuffer) -> PhysicsemmomBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_buffer_copy(s : PhysicsemmomBuffer) -> PhysicsemmomBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_buffer_fill(s : PhysicsemmomBuffer, v : Double) -> PhysicsemmomBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_buffer_min(s : PhysicsemmomBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_buffer_max(s : PhysicsemmomBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_buffer_to_string(s : PhysicsemmomBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_cursor_make(size : Int) -> PhysicsemmomCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_cursor_len(s : PhysicsemmomCursor) -> Int { s.size }

pub fn physics_em_mom_cursor_get(s : PhysicsemmomCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_cursor_set(s : PhysicsemmomCursor, i : Int, v : Double) -> PhysicsemmomCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cursor_sum(s : PhysicsemmomCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_cursor_mean(s : PhysicsemmomCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_cursor_scale(s : PhysicsemmomCursor, f : Double) -> PhysicsemmomCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cursor_add(a : PhysicsemmomCursor, b : PhysicsemmomCursor) -> PhysicsemmomCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_cursor_copy(s : PhysicsemmomCursor) -> PhysicsemmomCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cursor_fill(s : PhysicsemmomCursor, v : Double) -> PhysicsemmomCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_cursor_min(s : PhysicsemmomCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_cursor_max(s : PhysicsemmomCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_cursor_to_string(s : PhysicsemmomCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_view_make(size : Int) -> PhysicsemmomView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_view_len(s : PhysicsemmomView) -> Int { s.size }

pub fn physics_em_mom_view_get(s : PhysicsemmomView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_view_set(s : PhysicsemmomView, i : Int, v : Double) -> PhysicsemmomView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_view_sum(s : PhysicsemmomView) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_view_mean(s : PhysicsemmomView) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_view_scale(s : PhysicsemmomView, f : Double) -> PhysicsemmomView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_view_add(a : PhysicsemmomView, b : PhysicsemmomView) -> PhysicsemmomView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_view_copy(s : PhysicsemmomView) -> PhysicsemmomView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_view_fill(s : PhysicsemmomView, v : Double) -> PhysicsemmomView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_view_min(s : PhysicsemmomView) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_view_max(s : PhysicsemmomView) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_view_to_string(s : PhysicsemmomView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_range_make(size : Int) -> PhysicsemmomRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_range_len(s : PhysicsemmomRange) -> Int { s.size }

pub fn physics_em_mom_range_get(s : PhysicsemmomRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_range_set(s : PhysicsemmomRange, i : Int, v : Double) -> PhysicsemmomRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_range_sum(s : PhysicsemmomRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_range_mean(s : PhysicsemmomRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_range_scale(s : PhysicsemmomRange, f : Double) -> PhysicsemmomRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_range_add(a : PhysicsemmomRange, b : PhysicsemmomRange) -> PhysicsemmomRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_range_copy(s : PhysicsemmomRange) -> PhysicsemmomRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_range_fill(s : PhysicsemmomRange, v : Double) -> PhysicsemmomRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_range_min(s : PhysicsemmomRange) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_range_max(s : PhysicsemmomRange) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_range_to_string(s : PhysicsemmomRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_slice_make(size : Int) -> PhysicsemmomSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_slice_len(s : PhysicsemmomSlice) -> Int { s.size }

pub fn physics_em_mom_slice_get(s : PhysicsemmomSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_slice_set(s : PhysicsemmomSlice, i : Int, v : Double) -> PhysicsemmomSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_mom_slice_sum(s : PhysicsemmomSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_mom_slice_mean(s : PhysicsemmomSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_mom_slice_scale(s : PhysicsemmomSlice, f : Double) -> PhysicsemmomSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_slice_add(a : PhysicsemmomSlice, b : PhysicsemmomSlice) -> PhysicsemmomSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_mom_slice_copy(s : PhysicsemmomSlice) -> PhysicsemmomSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_slice_fill(s : PhysicsemmomSlice, v : Double) -> PhysicsemmomSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_mom_slice_min(s : PhysicsemmomSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_mom_slice_max(s : PhysicsemmomSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_mom_slice_to_string(s : PhysicsemmomSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

