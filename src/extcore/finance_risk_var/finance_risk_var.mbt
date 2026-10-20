///===
/// extcore/finance_risk_var

pub(all) struct FinanceriskvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_var_make_point(x : Double, y : Double) -> FinanceriskvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_var_make_point3(x : Double, y : Double, z : Double) -> FinanceriskvarPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskvarPoint::x(self : FinanceriskvarPoint) -> Double { self.x }

pub fn FinanceriskvarPoint::y(self : FinanceriskvarPoint) -> Double { self.y }

pub fn FinanceriskvarPoint::z(self : FinanceriskvarPoint) -> Double { self.z }

pub fn FinanceriskvarPoint::label(self : FinanceriskvarPoint) -> Int { self.label }

pub fn FinanceriskvarPoint::dist(self : FinanceriskvarPoint, other : FinanceriskvarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskvarPoint::add(self : FinanceriskvarPoint, other : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskvarPoint::sub(self : FinanceriskvarPoint, other : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskvarPoint::scale(self : FinanceriskvarPoint, s : Double) -> FinanceriskvarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskvarPoint::dot(self : FinanceriskvarPoint, other : FinanceriskvarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskvarPoint::cross(self : FinanceriskvarPoint, other : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskvarPoint::norm(self : FinanceriskvarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskvarPoint::normalize(self : FinanceriskvarPoint) -> FinanceriskvarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskvarPoint::negate(self : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskvarPoint::mid(self : FinanceriskvarPoint, other : FinanceriskvarPoint) -> FinanceriskvarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskvarPoint::lerp(self : FinanceriskvarPoint, other : FinanceriskvarPoint, t : Double) -> FinanceriskvarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskvarPoint::to_string(self : FinanceriskvarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_var_make_series(vals : Array[Double], name : String) -> FinanceriskvarSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskvarSeries::len(self : FinanceriskvarSeries) -> Int { self.vals.length() }

pub fn FinanceriskvarSeries::sum(self : FinanceriskvarSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskvarSeries::mean(self : FinanceriskvarSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskvarSeries::min(self : FinanceriskvarSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskvarSeries::max(self : FinanceriskvarSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskvarSeries::range(self : FinanceriskvarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskvarSeries::variance(self : FinanceriskvarSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskvarSeries::std(self : FinanceriskvarSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskvarSeries::median(self : FinanceriskvarSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskvarSeries::scale(self : FinanceriskvarSeries, f : Double) -> FinanceriskvarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskvarSeries::add(self : FinanceriskvarSeries, other : FinanceriskvarSeries) -> FinanceriskvarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskvarSeries::sub(self : FinanceriskvarSeries, other : FinanceriskvarSeries) -> FinanceriskvarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskvarSeries::normalize(self : FinanceriskvarSeries) -> FinanceriskvarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskvarSeries::cumsum(self : FinanceriskvarSeries) -> FinanceriskvarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskvarSeries::to_string(self : FinanceriskvarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_var_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_var_matrix_identity(n : Int) -> FinanceriskvarMatrix {
  let m = finance_risk_var_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskvarMatrix::get(self : FinanceriskvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskvarMatrix::transpose(self : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskvarMatrix::add(self : FinanceriskvarMatrix, other : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskvarMatrix::scale(self : FinanceriskvarMatrix, s : Double) -> FinanceriskvarMatrix {
  let result = finance_risk_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskvarMatrix::multiply(self : FinanceriskvarMatrix, other : FinanceriskvarMatrix) -> FinanceriskvarMatrix {
  if self.cols != other.rows { return finance_risk_var_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_var_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskvarMatrix::trace(self : FinanceriskvarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskvarMatrix::det(self : FinanceriskvarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskvarMatrix::norm(self : FinanceriskvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskvarMatrix::to_string(self : FinanceriskvarMatrix) -> String {
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

pub(all) struct FinanceriskvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_var_make_vector(comps : Array[Double]) -> FinanceriskvarVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_var_vector_zero(dim : Int) -> FinanceriskvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskvarVector::add(self : FinanceriskvarVector, other : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskvarVector::sub(self : FinanceriskvarVector, other : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskvarVector::scale(self : FinanceriskvarVector, s : Double) -> FinanceriskvarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskvarVector::dot(self : FinanceriskvarVector, other : FinanceriskvarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskvarVector::norm(self : FinanceriskvarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskvarVector::normalize(self : FinanceriskvarVector) -> FinanceriskvarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskvarVector::dist(self : FinanceriskvarVector, other : FinanceriskvarVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskvarVector::to_string(self : FinanceriskvarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_var_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_var_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_var_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_var_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_var_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_var_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_var_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_var_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_var_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_var_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_var_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_var_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_var_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_var_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_var_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_var_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_var_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_var_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_var_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_var_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_var_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_var_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_var_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_var_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_var_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_var_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_var_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_var_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_var_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_frame_make(size : Int) -> FinanceriskvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_frame_len(s : FinanceriskvarFrame) -> Int { s.size }

pub fn finance_risk_var_frame_get(s : FinanceriskvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_frame_set(s : FinanceriskvarFrame, i : Int, v : Double) -> FinanceriskvarFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_sum(s : FinanceriskvarFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_frame_mean(s : FinanceriskvarFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_frame_scale(s : FinanceriskvarFrame, f : Double) -> FinanceriskvarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_add(a : FinanceriskvarFrame, b : FinanceriskvarFrame) -> FinanceriskvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_frame_copy(s : FinanceriskvarFrame) -> FinanceriskvarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_fill(s : FinanceriskvarFrame, v : Double) -> FinanceriskvarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_frame_min(s : FinanceriskvarFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_frame_max(s : FinanceriskvarFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_frame_to_string(s : FinanceriskvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_table_make(size : Int) -> FinanceriskvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_table_len(s : FinanceriskvarTable) -> Int { s.size }

pub fn finance_risk_var_table_get(s : FinanceriskvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_table_set(s : FinanceriskvarTable, i : Int, v : Double) -> FinanceriskvarTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_sum(s : FinanceriskvarTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_table_mean(s : FinanceriskvarTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_table_scale(s : FinanceriskvarTable, f : Double) -> FinanceriskvarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_add(a : FinanceriskvarTable, b : FinanceriskvarTable) -> FinanceriskvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_table_copy(s : FinanceriskvarTable) -> FinanceriskvarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_fill(s : FinanceriskvarTable, v : Double) -> FinanceriskvarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_table_min(s : FinanceriskvarTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_table_max(s : FinanceriskvarTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_table_to_string(s : FinanceriskvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_graphn_make(size : Int) -> FinanceriskvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_graphn_len(s : FinanceriskvarGraphN) -> Int { s.size }

pub fn finance_risk_var_graphn_get(s : FinanceriskvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_graphn_set(s : FinanceriskvarGraphN, i : Int, v : Double) -> FinanceriskvarGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_sum(s : FinanceriskvarGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_graphn_mean(s : FinanceriskvarGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_graphn_scale(s : FinanceriskvarGraphN, f : Double) -> FinanceriskvarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_add(a : FinanceriskvarGraphN, b : FinanceriskvarGraphN) -> FinanceriskvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_graphn_copy(s : FinanceriskvarGraphN) -> FinanceriskvarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_fill(s : FinanceriskvarGraphN, v : Double) -> FinanceriskvarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_graphn_min(s : FinanceriskvarGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_graphn_max(s : FinanceriskvarGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_graphn_to_string(s : FinanceriskvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_node_make(size : Int) -> FinanceriskvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_node_len(s : FinanceriskvarNode) -> Int { s.size }

pub fn finance_risk_var_node_get(s : FinanceriskvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_node_set(s : FinanceriskvarNode, i : Int, v : Double) -> FinanceriskvarNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_sum(s : FinanceriskvarNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_node_mean(s : FinanceriskvarNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_node_scale(s : FinanceriskvarNode, f : Double) -> FinanceriskvarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_add(a : FinanceriskvarNode, b : FinanceriskvarNode) -> FinanceriskvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_node_copy(s : FinanceriskvarNode) -> FinanceriskvarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_fill(s : FinanceriskvarNode, v : Double) -> FinanceriskvarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_node_min(s : FinanceriskvarNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_node_max(s : FinanceriskvarNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_node_to_string(s : FinanceriskvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_edge_make(size : Int) -> FinanceriskvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_edge_len(s : FinanceriskvarEdge) -> Int { s.size }

pub fn finance_risk_var_edge_get(s : FinanceriskvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_edge_set(s : FinanceriskvarEdge, i : Int, v : Double) -> FinanceriskvarEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_sum(s : FinanceriskvarEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_edge_mean(s : FinanceriskvarEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_edge_scale(s : FinanceriskvarEdge, f : Double) -> FinanceriskvarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_add(a : FinanceriskvarEdge, b : FinanceriskvarEdge) -> FinanceriskvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_edge_copy(s : FinanceriskvarEdge) -> FinanceriskvarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_fill(s : FinanceriskvarEdge, v : Double) -> FinanceriskvarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_edge_min(s : FinanceriskvarEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_edge_max(s : FinanceriskvarEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_edge_to_string(s : FinanceriskvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_path_make(size : Int) -> FinanceriskvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_path_len(s : FinanceriskvarPath) -> Int { s.size }

pub fn finance_risk_var_path_get(s : FinanceriskvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_path_set(s : FinanceriskvarPath, i : Int, v : Double) -> FinanceriskvarPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_sum(s : FinanceriskvarPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_path_mean(s : FinanceriskvarPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_path_scale(s : FinanceriskvarPath, f : Double) -> FinanceriskvarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_add(a : FinanceriskvarPath, b : FinanceriskvarPath) -> FinanceriskvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_path_copy(s : FinanceriskvarPath) -> FinanceriskvarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_fill(s : FinanceriskvarPath, v : Double) -> FinanceriskvarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_path_min(s : FinanceriskvarPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_path_max(s : FinanceriskvarPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_path_to_string(s : FinanceriskvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_cluster_make(size : Int) -> FinanceriskvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_cluster_len(s : FinanceriskvarCluster) -> Int { s.size }

pub fn finance_risk_var_cluster_get(s : FinanceriskvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_cluster_set(s : FinanceriskvarCluster, i : Int, v : Double) -> FinanceriskvarCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_sum(s : FinanceriskvarCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_cluster_mean(s : FinanceriskvarCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_cluster_scale(s : FinanceriskvarCluster, f : Double) -> FinanceriskvarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_add(a : FinanceriskvarCluster, b : FinanceriskvarCluster) -> FinanceriskvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_cluster_copy(s : FinanceriskvarCluster) -> FinanceriskvarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_fill(s : FinanceriskvarCluster, v : Double) -> FinanceriskvarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cluster_min(s : FinanceriskvarCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_cluster_max(s : FinanceriskvarCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_cluster_to_string(s : FinanceriskvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_model_make(size : Int) -> FinanceriskvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_model_len(s : FinanceriskvarModel) -> Int { s.size }

pub fn finance_risk_var_model_get(s : FinanceriskvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_model_set(s : FinanceriskvarModel, i : Int, v : Double) -> FinanceriskvarModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_sum(s : FinanceriskvarModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_model_mean(s : FinanceriskvarModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_model_scale(s : FinanceriskvarModel, f : Double) -> FinanceriskvarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_add(a : FinanceriskvarModel, b : FinanceriskvarModel) -> FinanceriskvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_model_copy(s : FinanceriskvarModel) -> FinanceriskvarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_fill(s : FinanceriskvarModel, v : Double) -> FinanceriskvarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_model_min(s : FinanceriskvarModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_model_max(s : FinanceriskvarModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_model_to_string(s : FinanceriskvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_layer_make(size : Int) -> FinanceriskvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_layer_len(s : FinanceriskvarLayer) -> Int { s.size }

pub fn finance_risk_var_layer_get(s : FinanceriskvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_layer_set(s : FinanceriskvarLayer, i : Int, v : Double) -> FinanceriskvarLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_sum(s : FinanceriskvarLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_layer_mean(s : FinanceriskvarLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_layer_scale(s : FinanceriskvarLayer, f : Double) -> FinanceriskvarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_add(a : FinanceriskvarLayer, b : FinanceriskvarLayer) -> FinanceriskvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_layer_copy(s : FinanceriskvarLayer) -> FinanceriskvarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_fill(s : FinanceriskvarLayer, v : Double) -> FinanceriskvarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_layer_min(s : FinanceriskvarLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_layer_max(s : FinanceriskvarLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_layer_to_string(s : FinanceriskvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_buffer_make(size : Int) -> FinanceriskvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_buffer_len(s : FinanceriskvarBuffer) -> Int { s.size }

pub fn finance_risk_var_buffer_get(s : FinanceriskvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_buffer_set(s : FinanceriskvarBuffer, i : Int, v : Double) -> FinanceriskvarBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_sum(s : FinanceriskvarBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_buffer_mean(s : FinanceriskvarBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_buffer_scale(s : FinanceriskvarBuffer, f : Double) -> FinanceriskvarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_add(a : FinanceriskvarBuffer, b : FinanceriskvarBuffer) -> FinanceriskvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_buffer_copy(s : FinanceriskvarBuffer) -> FinanceriskvarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_fill(s : FinanceriskvarBuffer, v : Double) -> FinanceriskvarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_buffer_min(s : FinanceriskvarBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_buffer_max(s : FinanceriskvarBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_buffer_to_string(s : FinanceriskvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_cursor_make(size : Int) -> FinanceriskvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_cursor_len(s : FinanceriskvarCursor) -> Int { s.size }

pub fn finance_risk_var_cursor_get(s : FinanceriskvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_cursor_set(s : FinanceriskvarCursor, i : Int, v : Double) -> FinanceriskvarCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_sum(s : FinanceriskvarCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_cursor_mean(s : FinanceriskvarCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_cursor_scale(s : FinanceriskvarCursor, f : Double) -> FinanceriskvarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_add(a : FinanceriskvarCursor, b : FinanceriskvarCursor) -> FinanceriskvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_cursor_copy(s : FinanceriskvarCursor) -> FinanceriskvarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_fill(s : FinanceriskvarCursor, v : Double) -> FinanceriskvarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_cursor_min(s : FinanceriskvarCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_cursor_max(s : FinanceriskvarCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_cursor_to_string(s : FinanceriskvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_view_make(size : Int) -> FinanceriskvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_view_len(s : FinanceriskvarView) -> Int { s.size }

pub fn finance_risk_var_view_get(s : FinanceriskvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_view_set(s : FinanceriskvarView, i : Int, v : Double) -> FinanceriskvarView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_sum(s : FinanceriskvarView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_view_mean(s : FinanceriskvarView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_view_scale(s : FinanceriskvarView, f : Double) -> FinanceriskvarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_add(a : FinanceriskvarView, b : FinanceriskvarView) -> FinanceriskvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_view_copy(s : FinanceriskvarView) -> FinanceriskvarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_fill(s : FinanceriskvarView, v : Double) -> FinanceriskvarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_view_min(s : FinanceriskvarView) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_view_max(s : FinanceriskvarView) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_view_to_string(s : FinanceriskvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_range_make(size : Int) -> FinanceriskvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_range_len(s : FinanceriskvarRange) -> Int { s.size }

pub fn finance_risk_var_range_get(s : FinanceriskvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_range_set(s : FinanceriskvarRange, i : Int, v : Double) -> FinanceriskvarRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_sum(s : FinanceriskvarRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_range_mean(s : FinanceriskvarRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_range_scale(s : FinanceriskvarRange, f : Double) -> FinanceriskvarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_add(a : FinanceriskvarRange, b : FinanceriskvarRange) -> FinanceriskvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_range_copy(s : FinanceriskvarRange) -> FinanceriskvarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_fill(s : FinanceriskvarRange, v : Double) -> FinanceriskvarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_range_min(s : FinanceriskvarRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_range_max(s : FinanceriskvarRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_range_to_string(s : FinanceriskvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_var_slice_make(size : Int) -> FinanceriskvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_var_slice_len(s : FinanceriskvarSlice) -> Int { s.size }

pub fn finance_risk_var_slice_get(s : FinanceriskvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_var_slice_set(s : FinanceriskvarSlice, i : Int, v : Double) -> FinanceriskvarSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_sum(s : FinanceriskvarSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_var_slice_mean(s : FinanceriskvarSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_var_slice_scale(s : FinanceriskvarSlice, f : Double) -> FinanceriskvarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_add(a : FinanceriskvarSlice, b : FinanceriskvarSlice) -> FinanceriskvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_var_slice_copy(s : FinanceriskvarSlice) -> FinanceriskvarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_fill(s : FinanceriskvarSlice, v : Double) -> FinanceriskvarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_var_slice_min(s : FinanceriskvarSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_var_slice_max(s : FinanceriskvarSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_var_slice_to_string(s : FinanceriskvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

