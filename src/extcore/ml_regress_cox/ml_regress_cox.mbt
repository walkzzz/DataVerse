///===
/// extcore/ml_regress_cox

pub(all) struct MlregresscoxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_cox_make_point(x : Double, y : Double) -> MlregresscoxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_cox_make_point3(x : Double, y : Double, z : Double) -> MlregresscoxPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresscoxPoint::x(self : MlregresscoxPoint) -> Double { self.x }

pub fn MlregresscoxPoint::y(self : MlregresscoxPoint) -> Double { self.y }

pub fn MlregresscoxPoint::z(self : MlregresscoxPoint) -> Double { self.z }

pub fn MlregresscoxPoint::label(self : MlregresscoxPoint) -> Int { self.label }

pub fn MlregresscoxPoint::dist(self : MlregresscoxPoint, other : MlregresscoxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresscoxPoint::add(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresscoxPoint::sub(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresscoxPoint::scale(self : MlregresscoxPoint, s : Double) -> MlregresscoxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresscoxPoint::dot(self : MlregresscoxPoint, other : MlregresscoxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresscoxPoint::cross(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresscoxPoint::norm(self : MlregresscoxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresscoxPoint::normalize(self : MlregresscoxPoint) -> MlregresscoxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresscoxPoint::negate(self : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresscoxPoint::mid(self : MlregresscoxPoint, other : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresscoxPoint::lerp(self : MlregresscoxPoint, other : MlregresscoxPoint, t : Double) -> MlregresscoxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresscoxPoint::to_string(self : MlregresscoxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresscoxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_cox_make_series(vals : Array[Double], name : String) -> MlregresscoxSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresscoxSeries::len(self : MlregresscoxSeries) -> Int { self.vals.length() }

pub fn MlregresscoxSeries::sum(self : MlregresscoxSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresscoxSeries::mean(self : MlregresscoxSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresscoxSeries::min(self : MlregresscoxSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresscoxSeries::max(self : MlregresscoxSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresscoxSeries::range(self : MlregresscoxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresscoxSeries::variance(self : MlregresscoxSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresscoxSeries::std(self : MlregresscoxSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresscoxSeries::median(self : MlregresscoxSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresscoxSeries::scale(self : MlregresscoxSeries, f : Double) -> MlregresscoxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresscoxSeries::add(self : MlregresscoxSeries, other : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresscoxSeries::sub(self : MlregresscoxSeries, other : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresscoxSeries::normalize(self : MlregresscoxSeries) -> MlregresscoxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresscoxSeries::cumsum(self : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresscoxSeries::to_string(self : MlregresscoxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresscoxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_cox_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresscoxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_cox_matrix_identity(n : Int) -> MlregresscoxMatrix {
  let m = ml_regress_cox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresscoxMatrix::get(self : MlregresscoxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresscoxMatrix::transpose(self : MlregresscoxMatrix) -> MlregresscoxMatrix {
  let result = ml_regress_cox_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresscoxMatrix::add(self : MlregresscoxMatrix, other : MlregresscoxMatrix) -> MlregresscoxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_cox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresscoxMatrix::scale(self : MlregresscoxMatrix, s : Double) -> MlregresscoxMatrix {
  let result = ml_regress_cox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresscoxMatrix::multiply(self : MlregresscoxMatrix, other : MlregresscoxMatrix) -> MlregresscoxMatrix {
  if self.cols != other.rows { return ml_regress_cox_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_cox_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresscoxMatrix::trace(self : MlregresscoxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresscoxMatrix::det(self : MlregresscoxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresscoxMatrix::norm(self : MlregresscoxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresscoxMatrix::to_string(self : MlregresscoxMatrix) -> String {
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

pub(all) struct MlregresscoxVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_cox_make_vector(comps : Array[Double]) -> MlregresscoxVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_cox_vector_zero(dim : Int) -> MlregresscoxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresscoxVector::add(self : MlregresscoxVector, other : MlregresscoxVector) -> MlregresscoxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresscoxVector::sub(self : MlregresscoxVector, other : MlregresscoxVector) -> MlregresscoxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresscoxVector::scale(self : MlregresscoxVector, s : Double) -> MlregresscoxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresscoxVector::dot(self : MlregresscoxVector, other : MlregresscoxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresscoxVector::norm(self : MlregresscoxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresscoxVector::normalize(self : MlregresscoxVector) -> MlregresscoxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresscoxVector::dist(self : MlregresscoxVector, other : MlregresscoxVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresscoxVector::to_string(self : MlregresscoxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_cox_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_cox_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_cox_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_cox_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_cox_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_cox_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_cox_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_cox_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_cox_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_cox_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_cox_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_cox_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_cox_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_cox_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_cox_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_cox_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_cox_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_cox_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_cox_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_cox_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_cox_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_cox_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_cox_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_cox_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_cox_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_cox_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_cox_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_cox_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_cox_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresscoxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_frame_make(size : Int) -> MlregresscoxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_frame_len(s : MlregresscoxFrame) -> Int { s.size }

pub fn ml_regress_cox_frame_get(s : MlregresscoxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_frame_set(s : MlregresscoxFrame, i : Int, v : Double) -> MlregresscoxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_frame_sum(s : MlregresscoxFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_frame_mean(s : MlregresscoxFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_frame_scale(s : MlregresscoxFrame, f : Double) -> MlregresscoxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_frame_add(a : MlregresscoxFrame, b : MlregresscoxFrame) -> MlregresscoxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_frame_copy(s : MlregresscoxFrame) -> MlregresscoxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_frame_fill(s : MlregresscoxFrame, v : Double) -> MlregresscoxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_frame_min(s : MlregresscoxFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_frame_max(s : MlregresscoxFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_frame_to_string(s : MlregresscoxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_table_make(size : Int) -> MlregresscoxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_table_len(s : MlregresscoxTable) -> Int { s.size }

pub fn ml_regress_cox_table_get(s : MlregresscoxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_table_set(s : MlregresscoxTable, i : Int, v : Double) -> MlregresscoxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_table_sum(s : MlregresscoxTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_table_mean(s : MlregresscoxTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_table_scale(s : MlregresscoxTable, f : Double) -> MlregresscoxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_table_add(a : MlregresscoxTable, b : MlregresscoxTable) -> MlregresscoxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_table_copy(s : MlregresscoxTable) -> MlregresscoxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_table_fill(s : MlregresscoxTable, v : Double) -> MlregresscoxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_table_min(s : MlregresscoxTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_table_max(s : MlregresscoxTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_table_to_string(s : MlregresscoxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_graphn_make(size : Int) -> MlregresscoxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_graphn_len(s : MlregresscoxGraphN) -> Int { s.size }

pub fn ml_regress_cox_graphn_get(s : MlregresscoxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_graphn_set(s : MlregresscoxGraphN, i : Int, v : Double) -> MlregresscoxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_graphn_sum(s : MlregresscoxGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_graphn_mean(s : MlregresscoxGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_graphn_scale(s : MlregresscoxGraphN, f : Double) -> MlregresscoxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_graphn_add(a : MlregresscoxGraphN, b : MlregresscoxGraphN) -> MlregresscoxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_graphn_copy(s : MlregresscoxGraphN) -> MlregresscoxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_graphn_fill(s : MlregresscoxGraphN, v : Double) -> MlregresscoxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_graphn_min(s : MlregresscoxGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_graphn_max(s : MlregresscoxGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_graphn_to_string(s : MlregresscoxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_node_make(size : Int) -> MlregresscoxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_node_len(s : MlregresscoxNode) -> Int { s.size }

pub fn ml_regress_cox_node_get(s : MlregresscoxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_node_set(s : MlregresscoxNode, i : Int, v : Double) -> MlregresscoxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_node_sum(s : MlregresscoxNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_node_mean(s : MlregresscoxNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_node_scale(s : MlregresscoxNode, f : Double) -> MlregresscoxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_node_add(a : MlregresscoxNode, b : MlregresscoxNode) -> MlregresscoxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_node_copy(s : MlregresscoxNode) -> MlregresscoxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_node_fill(s : MlregresscoxNode, v : Double) -> MlregresscoxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_node_min(s : MlregresscoxNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_node_max(s : MlregresscoxNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_node_to_string(s : MlregresscoxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_edge_make(size : Int) -> MlregresscoxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_edge_len(s : MlregresscoxEdge) -> Int { s.size }

pub fn ml_regress_cox_edge_get(s : MlregresscoxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_edge_set(s : MlregresscoxEdge, i : Int, v : Double) -> MlregresscoxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_edge_sum(s : MlregresscoxEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_edge_mean(s : MlregresscoxEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_edge_scale(s : MlregresscoxEdge, f : Double) -> MlregresscoxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_edge_add(a : MlregresscoxEdge, b : MlregresscoxEdge) -> MlregresscoxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_edge_copy(s : MlregresscoxEdge) -> MlregresscoxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_edge_fill(s : MlregresscoxEdge, v : Double) -> MlregresscoxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_edge_min(s : MlregresscoxEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_edge_max(s : MlregresscoxEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_edge_to_string(s : MlregresscoxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_path_make(size : Int) -> MlregresscoxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_path_len(s : MlregresscoxPath) -> Int { s.size }

pub fn ml_regress_cox_path_get(s : MlregresscoxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_path_set(s : MlregresscoxPath, i : Int, v : Double) -> MlregresscoxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_path_sum(s : MlregresscoxPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_path_mean(s : MlregresscoxPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_path_scale(s : MlregresscoxPath, f : Double) -> MlregresscoxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_path_add(a : MlregresscoxPath, b : MlregresscoxPath) -> MlregresscoxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_path_copy(s : MlregresscoxPath) -> MlregresscoxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_path_fill(s : MlregresscoxPath, v : Double) -> MlregresscoxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_path_min(s : MlregresscoxPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_path_max(s : MlregresscoxPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_path_to_string(s : MlregresscoxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_cluster_make(size : Int) -> MlregresscoxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_cluster_len(s : MlregresscoxCluster) -> Int { s.size }

pub fn ml_regress_cox_cluster_get(s : MlregresscoxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_cluster_set(s : MlregresscoxCluster, i : Int, v : Double) -> MlregresscoxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cluster_sum(s : MlregresscoxCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_cluster_mean(s : MlregresscoxCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_cluster_scale(s : MlregresscoxCluster, f : Double) -> MlregresscoxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cluster_add(a : MlregresscoxCluster, b : MlregresscoxCluster) -> MlregresscoxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_cluster_copy(s : MlregresscoxCluster) -> MlregresscoxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cluster_fill(s : MlregresscoxCluster, v : Double) -> MlregresscoxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cluster_min(s : MlregresscoxCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_cluster_max(s : MlregresscoxCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_cluster_to_string(s : MlregresscoxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_model_make(size : Int) -> MlregresscoxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_model_len(s : MlregresscoxModel) -> Int { s.size }

pub fn ml_regress_cox_model_get(s : MlregresscoxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_model_set(s : MlregresscoxModel, i : Int, v : Double) -> MlregresscoxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_model_sum(s : MlregresscoxModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_model_mean(s : MlregresscoxModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_model_scale(s : MlregresscoxModel, f : Double) -> MlregresscoxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_model_add(a : MlregresscoxModel, b : MlregresscoxModel) -> MlregresscoxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_model_copy(s : MlregresscoxModel) -> MlregresscoxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_model_fill(s : MlregresscoxModel, v : Double) -> MlregresscoxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_model_min(s : MlregresscoxModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_model_max(s : MlregresscoxModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_model_to_string(s : MlregresscoxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_layer_make(size : Int) -> MlregresscoxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_layer_len(s : MlregresscoxLayer) -> Int { s.size }

pub fn ml_regress_cox_layer_get(s : MlregresscoxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_layer_set(s : MlregresscoxLayer, i : Int, v : Double) -> MlregresscoxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_layer_sum(s : MlregresscoxLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_layer_mean(s : MlregresscoxLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_layer_scale(s : MlregresscoxLayer, f : Double) -> MlregresscoxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_layer_add(a : MlregresscoxLayer, b : MlregresscoxLayer) -> MlregresscoxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_layer_copy(s : MlregresscoxLayer) -> MlregresscoxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_layer_fill(s : MlregresscoxLayer, v : Double) -> MlregresscoxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_layer_min(s : MlregresscoxLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_layer_max(s : MlregresscoxLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_layer_to_string(s : MlregresscoxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_buffer_make(size : Int) -> MlregresscoxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_buffer_len(s : MlregresscoxBuffer) -> Int { s.size }

pub fn ml_regress_cox_buffer_get(s : MlregresscoxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_buffer_set(s : MlregresscoxBuffer, i : Int, v : Double) -> MlregresscoxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_buffer_sum(s : MlregresscoxBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_buffer_mean(s : MlregresscoxBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_buffer_scale(s : MlregresscoxBuffer, f : Double) -> MlregresscoxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_buffer_add(a : MlregresscoxBuffer, b : MlregresscoxBuffer) -> MlregresscoxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_buffer_copy(s : MlregresscoxBuffer) -> MlregresscoxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_buffer_fill(s : MlregresscoxBuffer, v : Double) -> MlregresscoxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_buffer_min(s : MlregresscoxBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_buffer_max(s : MlregresscoxBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_buffer_to_string(s : MlregresscoxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_cursor_make(size : Int) -> MlregresscoxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_cursor_len(s : MlregresscoxCursor) -> Int { s.size }

pub fn ml_regress_cox_cursor_get(s : MlregresscoxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_cursor_set(s : MlregresscoxCursor, i : Int, v : Double) -> MlregresscoxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cursor_sum(s : MlregresscoxCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_cursor_mean(s : MlregresscoxCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_cursor_scale(s : MlregresscoxCursor, f : Double) -> MlregresscoxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cursor_add(a : MlregresscoxCursor, b : MlregresscoxCursor) -> MlregresscoxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_cursor_copy(s : MlregresscoxCursor) -> MlregresscoxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cursor_fill(s : MlregresscoxCursor, v : Double) -> MlregresscoxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_cursor_min(s : MlregresscoxCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_cursor_max(s : MlregresscoxCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_cursor_to_string(s : MlregresscoxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_view_make(size : Int) -> MlregresscoxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_view_len(s : MlregresscoxView) -> Int { s.size }

pub fn ml_regress_cox_view_get(s : MlregresscoxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_view_set(s : MlregresscoxView, i : Int, v : Double) -> MlregresscoxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_view_sum(s : MlregresscoxView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_view_mean(s : MlregresscoxView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_view_scale(s : MlregresscoxView, f : Double) -> MlregresscoxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_view_add(a : MlregresscoxView, b : MlregresscoxView) -> MlregresscoxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_view_copy(s : MlregresscoxView) -> MlregresscoxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_view_fill(s : MlregresscoxView, v : Double) -> MlregresscoxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_view_min(s : MlregresscoxView) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_view_max(s : MlregresscoxView) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_view_to_string(s : MlregresscoxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_range_make(size : Int) -> MlregresscoxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_range_len(s : MlregresscoxRange) -> Int { s.size }

pub fn ml_regress_cox_range_get(s : MlregresscoxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_range_set(s : MlregresscoxRange, i : Int, v : Double) -> MlregresscoxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_range_sum(s : MlregresscoxRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_range_mean(s : MlregresscoxRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_range_scale(s : MlregresscoxRange, f : Double) -> MlregresscoxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_range_add(a : MlregresscoxRange, b : MlregresscoxRange) -> MlregresscoxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_range_copy(s : MlregresscoxRange) -> MlregresscoxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_range_fill(s : MlregresscoxRange, v : Double) -> MlregresscoxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_range_min(s : MlregresscoxRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_range_max(s : MlregresscoxRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_range_to_string(s : MlregresscoxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_slice_make(size : Int) -> MlregresscoxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_slice_len(s : MlregresscoxSlice) -> Int { s.size }

pub fn ml_regress_cox_slice_get(s : MlregresscoxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_slice_set(s : MlregresscoxSlice, i : Int, v : Double) -> MlregresscoxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_slice_sum(s : MlregresscoxSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_cox_slice_mean(s : MlregresscoxSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_cox_slice_scale(s : MlregresscoxSlice, f : Double) -> MlregresscoxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_slice_add(a : MlregresscoxSlice, b : MlregresscoxSlice) -> MlregresscoxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_cox_slice_copy(s : MlregresscoxSlice) -> MlregresscoxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_slice_fill(s : MlregresscoxSlice, v : Double) -> MlregresscoxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_cox_slice_min(s : MlregresscoxSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_cox_slice_max(s : MlregresscoxSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_cox_slice_to_string(s : MlregresscoxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

