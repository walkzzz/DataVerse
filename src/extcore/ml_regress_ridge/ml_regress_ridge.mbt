///===
/// extcore/ml_regress_ridge

pub(all) struct MlregressridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_ridge_make_point(x : Double, y : Double) -> MlregressridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_ridge_make_point3(x : Double, y : Double, z : Double) -> MlregressridgePoint {
  { x, y, z, label: 0 }
}

pub fn MlregressridgePoint::x(self : MlregressridgePoint) -> Double { self.x }

pub fn MlregressridgePoint::y(self : MlregressridgePoint) -> Double { self.y }

pub fn MlregressridgePoint::z(self : MlregressridgePoint) -> Double { self.z }

pub fn MlregressridgePoint::label(self : MlregressridgePoint) -> Int { self.label }

pub fn MlregressridgePoint::dist(self : MlregressridgePoint, other : MlregressridgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregressridgePoint::add(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregressridgePoint::sub(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregressridgePoint::scale(self : MlregressridgePoint, s : Double) -> MlregressridgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregressridgePoint::dot(self : MlregressridgePoint, other : MlregressridgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregressridgePoint::cross(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregressridgePoint::norm(self : MlregressridgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregressridgePoint::normalize(self : MlregressridgePoint) -> MlregressridgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressridgePoint::negate(self : MlregressridgePoint) -> MlregressridgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregressridgePoint::mid(self : MlregressridgePoint, other : MlregressridgePoint) -> MlregressridgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregressridgePoint::lerp(self : MlregressridgePoint, other : MlregressridgePoint, t : Double) -> MlregressridgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregressridgePoint::to_string(self : MlregressridgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregressridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_ridge_make_series(vals : Array[Double], name : String) -> MlregressridgeSeries {
  { vals, name, meta: 0 }
}

pub fn MlregressridgeSeries::len(self : MlregressridgeSeries) -> Int { self.vals.length() }

pub fn MlregressridgeSeries::sum(self : MlregressridgeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregressridgeSeries::mean(self : MlregressridgeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregressridgeSeries::min(self : MlregressridgeSeries) -> Double { @_common.min(self.vals) }

pub fn MlregressridgeSeries::max(self : MlregressridgeSeries) -> Double { @_common.max(self.vals) }

pub fn MlregressridgeSeries::range(self : MlregressridgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregressridgeSeries::variance(self : MlregressridgeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregressridgeSeries::std(self : MlregressridgeSeries) -> Double { @_common.std(self.vals) }

pub fn MlregressridgeSeries::median(self : MlregressridgeSeries) -> Double { @_common.median(self.vals) }

pub fn MlregressridgeSeries::scale(self : MlregressridgeSeries, f : Double) -> MlregressridgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregressridgeSeries::add(self : MlregressridgeSeries, other : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregressridgeSeries::sub(self : MlregressridgeSeries, other : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregressridgeSeries::normalize(self : MlregressridgeSeries) -> MlregressridgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregressridgeSeries::cumsum(self : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregressridgeSeries::to_string(self : MlregressridgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_ridge_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_ridge_matrix_identity(n : Int) -> MlregressridgeMatrix {
  let m = ml_regress_ridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregressridgeMatrix::get(self : MlregressridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregressridgeMatrix::transpose(self : MlregressridgeMatrix) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregressridgeMatrix::add(self : MlregressridgeMatrix, other : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_ridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregressridgeMatrix::scale(self : MlregressridgeMatrix, s : Double) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregressridgeMatrix::multiply(self : MlregressridgeMatrix, other : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if self.cols != other.rows { return ml_regress_ridge_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_ridge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregressridgeMatrix::trace(self : MlregressridgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregressridgeMatrix::det(self : MlregressridgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregressridgeMatrix::norm(self : MlregressridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregressridgeMatrix::to_string(self : MlregressridgeMatrix) -> String {
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

pub(all) struct MlregressridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_ridge_make_vector(comps : Array[Double]) -> MlregressridgeVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_ridge_vector_zero(dim : Int) -> MlregressridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregressridgeVector::add(self : MlregressridgeVector, other : MlregressridgeVector) -> MlregressridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressridgeVector::sub(self : MlregressridgeVector, other : MlregressridgeVector) -> MlregressridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregressridgeVector::scale(self : MlregressridgeVector, s : Double) -> MlregressridgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregressridgeVector::dot(self : MlregressridgeVector, other : MlregressridgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregressridgeVector::norm(self : MlregressridgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregressridgeVector::normalize(self : MlregressridgeVector) -> MlregressridgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregressridgeVector::dist(self : MlregressridgeVector, other : MlregressridgeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregressridgeVector::to_string(self : MlregressridgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_ridge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_ridge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_ridge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_ridge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_ridge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_ridge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_ridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_ridge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_ridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_ridge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_ridge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_ridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_ridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_ridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_ridge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_ridge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_ridge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_ridge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_ridge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_ridge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_ridge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_ridge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_ridge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_ridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_ridge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_ridge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_ridge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_ridge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_ridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregressridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_frame_make(size : Int) -> MlregressridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_frame_len(s : MlregressridgeFrame) -> Int { s.size }

pub fn ml_regress_ridge_frame_get(s : MlregressridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_frame_set(s : MlregressridgeFrame, i : Int, v : Double) -> MlregressridgeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_sum(s : MlregressridgeFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_frame_mean(s : MlregressridgeFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_frame_scale(s : MlregressridgeFrame, f : Double) -> MlregressridgeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_add(a : MlregressridgeFrame, b : MlregressridgeFrame) -> MlregressridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_frame_copy(s : MlregressridgeFrame) -> MlregressridgeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_fill(s : MlregressridgeFrame, v : Double) -> MlregressridgeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_min(s : MlregressridgeFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_frame_max(s : MlregressridgeFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_frame_to_string(s : MlregressridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_table_make(size : Int) -> MlregressridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_table_len(s : MlregressridgeTable) -> Int { s.size }

pub fn ml_regress_ridge_table_get(s : MlregressridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_table_set(s : MlregressridgeTable, i : Int, v : Double) -> MlregressridgeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_sum(s : MlregressridgeTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_table_mean(s : MlregressridgeTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_table_scale(s : MlregressridgeTable, f : Double) -> MlregressridgeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_add(a : MlregressridgeTable, b : MlregressridgeTable) -> MlregressridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_table_copy(s : MlregressridgeTable) -> MlregressridgeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_fill(s : MlregressridgeTable, v : Double) -> MlregressridgeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_min(s : MlregressridgeTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_table_max(s : MlregressridgeTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_table_to_string(s : MlregressridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_graphn_make(size : Int) -> MlregressridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_graphn_len(s : MlregressridgeGraphN) -> Int { s.size }

pub fn ml_regress_ridge_graphn_get(s : MlregressridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_graphn_set(s : MlregressridgeGraphN, i : Int, v : Double) -> MlregressridgeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_sum(s : MlregressridgeGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_graphn_mean(s : MlregressridgeGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_graphn_scale(s : MlregressridgeGraphN, f : Double) -> MlregressridgeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_add(a : MlregressridgeGraphN, b : MlregressridgeGraphN) -> MlregressridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_graphn_copy(s : MlregressridgeGraphN) -> MlregressridgeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_fill(s : MlregressridgeGraphN, v : Double) -> MlregressridgeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_min(s : MlregressridgeGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_graphn_max(s : MlregressridgeGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_graphn_to_string(s : MlregressridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_node_make(size : Int) -> MlregressridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_node_len(s : MlregressridgeNode) -> Int { s.size }

pub fn ml_regress_ridge_node_get(s : MlregressridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_node_set(s : MlregressridgeNode, i : Int, v : Double) -> MlregressridgeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_sum(s : MlregressridgeNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_node_mean(s : MlregressridgeNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_node_scale(s : MlregressridgeNode, f : Double) -> MlregressridgeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_add(a : MlregressridgeNode, b : MlregressridgeNode) -> MlregressridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_node_copy(s : MlregressridgeNode) -> MlregressridgeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_fill(s : MlregressridgeNode, v : Double) -> MlregressridgeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_min(s : MlregressridgeNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_node_max(s : MlregressridgeNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_node_to_string(s : MlregressridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_edge_make(size : Int) -> MlregressridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_edge_len(s : MlregressridgeEdge) -> Int { s.size }

pub fn ml_regress_ridge_edge_get(s : MlregressridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_edge_set(s : MlregressridgeEdge, i : Int, v : Double) -> MlregressridgeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_sum(s : MlregressridgeEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_edge_mean(s : MlregressridgeEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_edge_scale(s : MlregressridgeEdge, f : Double) -> MlregressridgeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_add(a : MlregressridgeEdge, b : MlregressridgeEdge) -> MlregressridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_edge_copy(s : MlregressridgeEdge) -> MlregressridgeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_fill(s : MlregressridgeEdge, v : Double) -> MlregressridgeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_min(s : MlregressridgeEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_edge_max(s : MlregressridgeEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_edge_to_string(s : MlregressridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_path_make(size : Int) -> MlregressridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_path_len(s : MlregressridgePath) -> Int { s.size }

pub fn ml_regress_ridge_path_get(s : MlregressridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_path_set(s : MlregressridgePath, i : Int, v : Double) -> MlregressridgePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_sum(s : MlregressridgePath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_path_mean(s : MlregressridgePath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_path_scale(s : MlregressridgePath, f : Double) -> MlregressridgePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_add(a : MlregressridgePath, b : MlregressridgePath) -> MlregressridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_path_copy(s : MlregressridgePath) -> MlregressridgePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_fill(s : MlregressridgePath, v : Double) -> MlregressridgePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_min(s : MlregressridgePath) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_path_max(s : MlregressridgePath) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_path_to_string(s : MlregressridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cluster_make(size : Int) -> MlregressridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_cluster_len(s : MlregressridgeCluster) -> Int { s.size }

pub fn ml_regress_ridge_cluster_get(s : MlregressridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_cluster_set(s : MlregressridgeCluster, i : Int, v : Double) -> MlregressridgeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_sum(s : MlregressridgeCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_cluster_mean(s : MlregressridgeCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_cluster_scale(s : MlregressridgeCluster, f : Double) -> MlregressridgeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_add(a : MlregressridgeCluster, b : MlregressridgeCluster) -> MlregressridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_cluster_copy(s : MlregressridgeCluster) -> MlregressridgeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_fill(s : MlregressridgeCluster, v : Double) -> MlregressridgeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_min(s : MlregressridgeCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_cluster_max(s : MlregressridgeCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_cluster_to_string(s : MlregressridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_model_make(size : Int) -> MlregressridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_model_len(s : MlregressridgeModel) -> Int { s.size }

pub fn ml_regress_ridge_model_get(s : MlregressridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_model_set(s : MlregressridgeModel, i : Int, v : Double) -> MlregressridgeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_sum(s : MlregressridgeModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_model_mean(s : MlregressridgeModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_model_scale(s : MlregressridgeModel, f : Double) -> MlregressridgeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_add(a : MlregressridgeModel, b : MlregressridgeModel) -> MlregressridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_model_copy(s : MlregressridgeModel) -> MlregressridgeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_fill(s : MlregressridgeModel, v : Double) -> MlregressridgeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_min(s : MlregressridgeModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_model_max(s : MlregressridgeModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_model_to_string(s : MlregressridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_layer_make(size : Int) -> MlregressridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_layer_len(s : MlregressridgeLayer) -> Int { s.size }

pub fn ml_regress_ridge_layer_get(s : MlregressridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_layer_set(s : MlregressridgeLayer, i : Int, v : Double) -> MlregressridgeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_sum(s : MlregressridgeLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_layer_mean(s : MlregressridgeLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_layer_scale(s : MlregressridgeLayer, f : Double) -> MlregressridgeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_add(a : MlregressridgeLayer, b : MlregressridgeLayer) -> MlregressridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_layer_copy(s : MlregressridgeLayer) -> MlregressridgeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_fill(s : MlregressridgeLayer, v : Double) -> MlregressridgeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_min(s : MlregressridgeLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_layer_max(s : MlregressridgeLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_layer_to_string(s : MlregressridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_buffer_make(size : Int) -> MlregressridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_buffer_len(s : MlregressridgeBuffer) -> Int { s.size }

pub fn ml_regress_ridge_buffer_get(s : MlregressridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_buffer_set(s : MlregressridgeBuffer, i : Int, v : Double) -> MlregressridgeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_sum(s : MlregressridgeBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_buffer_mean(s : MlregressridgeBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_buffer_scale(s : MlregressridgeBuffer, f : Double) -> MlregressridgeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_add(a : MlregressridgeBuffer, b : MlregressridgeBuffer) -> MlregressridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_buffer_copy(s : MlregressridgeBuffer) -> MlregressridgeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_fill(s : MlregressridgeBuffer, v : Double) -> MlregressridgeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_min(s : MlregressridgeBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_buffer_max(s : MlregressridgeBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_buffer_to_string(s : MlregressridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cursor_make(size : Int) -> MlregressridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_cursor_len(s : MlregressridgeCursor) -> Int { s.size }

pub fn ml_regress_ridge_cursor_get(s : MlregressridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_cursor_set(s : MlregressridgeCursor, i : Int, v : Double) -> MlregressridgeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_sum(s : MlregressridgeCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_cursor_mean(s : MlregressridgeCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_cursor_scale(s : MlregressridgeCursor, f : Double) -> MlregressridgeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_add(a : MlregressridgeCursor, b : MlregressridgeCursor) -> MlregressridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_cursor_copy(s : MlregressridgeCursor) -> MlregressridgeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_fill(s : MlregressridgeCursor, v : Double) -> MlregressridgeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_min(s : MlregressridgeCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_cursor_max(s : MlregressridgeCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_cursor_to_string(s : MlregressridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_view_make(size : Int) -> MlregressridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_view_len(s : MlregressridgeView) -> Int { s.size }

pub fn ml_regress_ridge_view_get(s : MlregressridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_view_set(s : MlregressridgeView, i : Int, v : Double) -> MlregressridgeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_sum(s : MlregressridgeView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_view_mean(s : MlregressridgeView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_view_scale(s : MlregressridgeView, f : Double) -> MlregressridgeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_add(a : MlregressridgeView, b : MlregressridgeView) -> MlregressridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_view_copy(s : MlregressridgeView) -> MlregressridgeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_fill(s : MlregressridgeView, v : Double) -> MlregressridgeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_min(s : MlregressridgeView) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_view_max(s : MlregressridgeView) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_view_to_string(s : MlregressridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_range_make(size : Int) -> MlregressridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_range_len(s : MlregressridgeRange) -> Int { s.size }

pub fn ml_regress_ridge_range_get(s : MlregressridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_range_set(s : MlregressridgeRange, i : Int, v : Double) -> MlregressridgeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_sum(s : MlregressridgeRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_range_mean(s : MlregressridgeRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_range_scale(s : MlregressridgeRange, f : Double) -> MlregressridgeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_add(a : MlregressridgeRange, b : MlregressridgeRange) -> MlregressridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_range_copy(s : MlregressridgeRange) -> MlregressridgeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_fill(s : MlregressridgeRange, v : Double) -> MlregressridgeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_min(s : MlregressridgeRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_range_max(s : MlregressridgeRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_range_to_string(s : MlregressridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_slice_make(size : Int) -> MlregressridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_slice_len(s : MlregressridgeSlice) -> Int { s.size }

pub fn ml_regress_ridge_slice_get(s : MlregressridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_slice_set(s : MlregressridgeSlice, i : Int, v : Double) -> MlregressridgeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_sum(s : MlregressridgeSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_slice_mean(s : MlregressridgeSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_slice_scale(s : MlregressridgeSlice, f : Double) -> MlregressridgeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_add(a : MlregressridgeSlice, b : MlregressridgeSlice) -> MlregressridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_slice_copy(s : MlregressridgeSlice) -> MlregressridgeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_fill(s : MlregressridgeSlice, v : Double) -> MlregressridgeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_min(s : MlregressridgeSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_slice_max(s : MlregressridgeSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_slice_to_string(s : MlregressridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

