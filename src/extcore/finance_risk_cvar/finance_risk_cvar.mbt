///===
/// extcore/finance_risk_cvar

pub(all) struct FinanceriskcvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_cvar_make_point(x : Double, y : Double) -> FinanceriskcvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_cvar_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcvarPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskcvarPoint::x(self : FinanceriskcvarPoint) -> Double { self.x }

pub fn FinanceriskcvarPoint::y(self : FinanceriskcvarPoint) -> Double { self.y }

pub fn FinanceriskcvarPoint::z(self : FinanceriskcvarPoint) -> Double { self.z }

pub fn FinanceriskcvarPoint::label(self : FinanceriskcvarPoint) -> Int { self.label }

pub fn FinanceriskcvarPoint::dist(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskcvarPoint::add(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskcvarPoint::sub(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskcvarPoint::scale(self : FinanceriskcvarPoint, s : Double) -> FinanceriskcvarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskcvarPoint::dot(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskcvarPoint::cross(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskcvarPoint::norm(self : FinanceriskcvarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskcvarPoint::normalize(self : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcvarPoint::negate(self : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskcvarPoint::mid(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskcvarPoint::lerp(self : FinanceriskcvarPoint, other : FinanceriskcvarPoint, t : Double) -> FinanceriskcvarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskcvarPoint::to_string(self : FinanceriskcvarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskcvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_cvar_make_series(vals : Array[Double], name : String) -> FinanceriskcvarSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskcvarSeries::len(self : FinanceriskcvarSeries) -> Int { self.vals.length() }

pub fn FinanceriskcvarSeries::sum(self : FinanceriskcvarSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskcvarSeries::mean(self : FinanceriskcvarSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskcvarSeries::min(self : FinanceriskcvarSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskcvarSeries::max(self : FinanceriskcvarSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskcvarSeries::range(self : FinanceriskcvarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskcvarSeries::variance(self : FinanceriskcvarSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskcvarSeries::std(self : FinanceriskcvarSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskcvarSeries::median(self : FinanceriskcvarSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskcvarSeries::scale(self : FinanceriskcvarSeries, f : Double) -> FinanceriskcvarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskcvarSeries::add(self : FinanceriskcvarSeries, other : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskcvarSeries::sub(self : FinanceriskcvarSeries, other : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskcvarSeries::normalize(self : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskcvarSeries::cumsum(self : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskcvarSeries::to_string(self : FinanceriskcvarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_cvar_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_cvar_matrix_identity(n : Int) -> FinanceriskcvarMatrix {
  let m = finance_risk_cvar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskcvarMatrix::get(self : FinanceriskcvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskcvarMatrix::transpose(self : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  let result = finance_risk_cvar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskcvarMatrix::add(self : FinanceriskcvarMatrix, other : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_cvar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskcvarMatrix::scale(self : FinanceriskcvarMatrix, s : Double) -> FinanceriskcvarMatrix {
  let result = finance_risk_cvar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskcvarMatrix::multiply(self : FinanceriskcvarMatrix, other : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  if self.cols != other.rows { return finance_risk_cvar_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_cvar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskcvarMatrix::trace(self : FinanceriskcvarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskcvarMatrix::det(self : FinanceriskcvarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskcvarMatrix::norm(self : FinanceriskcvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskcvarMatrix::to_string(self : FinanceriskcvarMatrix) -> String {
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

pub(all) struct FinanceriskcvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_cvar_make_vector(comps : Array[Double]) -> FinanceriskcvarVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_cvar_vector_zero(dim : Int) -> FinanceriskcvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskcvarVector::add(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcvarVector::sub(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcvarVector::scale(self : FinanceriskcvarVector, s : Double) -> FinanceriskcvarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskcvarVector::dot(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskcvarVector::norm(self : FinanceriskcvarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskcvarVector::normalize(self : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcvarVector::dist(self : FinanceriskcvarVector, other : FinanceriskcvarVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskcvarVector::to_string(self : FinanceriskcvarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_cvar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_cvar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_cvar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_cvar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_cvar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_cvar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_cvar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_cvar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_cvar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_cvar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_cvar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_cvar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_cvar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_cvar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_cvar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_cvar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_cvar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_cvar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_cvar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_cvar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_cvar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_cvar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_cvar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_cvar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_cvar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_cvar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_cvar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_cvar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_cvar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskcvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_frame_make(size : Int) -> FinanceriskcvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_frame_len(s : FinanceriskcvarFrame) -> Int { s.size }

pub fn finance_risk_cvar_frame_get(s : FinanceriskcvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_frame_set(s : FinanceriskcvarFrame, i : Int, v : Double) -> FinanceriskcvarFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_frame_sum(s : FinanceriskcvarFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_frame_mean(s : FinanceriskcvarFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_frame_scale(s : FinanceriskcvarFrame, f : Double) -> FinanceriskcvarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_frame_add(a : FinanceriskcvarFrame, b : FinanceriskcvarFrame) -> FinanceriskcvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_frame_copy(s : FinanceriskcvarFrame) -> FinanceriskcvarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_frame_fill(s : FinanceriskcvarFrame, v : Double) -> FinanceriskcvarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_frame_min(s : FinanceriskcvarFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_frame_max(s : FinanceriskcvarFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_frame_to_string(s : FinanceriskcvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_table_make(size : Int) -> FinanceriskcvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_table_len(s : FinanceriskcvarTable) -> Int { s.size }

pub fn finance_risk_cvar_table_get(s : FinanceriskcvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_table_set(s : FinanceriskcvarTable, i : Int, v : Double) -> FinanceriskcvarTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_table_sum(s : FinanceriskcvarTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_table_mean(s : FinanceriskcvarTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_table_scale(s : FinanceriskcvarTable, f : Double) -> FinanceriskcvarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_table_add(a : FinanceriskcvarTable, b : FinanceriskcvarTable) -> FinanceriskcvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_table_copy(s : FinanceriskcvarTable) -> FinanceriskcvarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_table_fill(s : FinanceriskcvarTable, v : Double) -> FinanceriskcvarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_table_min(s : FinanceriskcvarTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_table_max(s : FinanceriskcvarTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_table_to_string(s : FinanceriskcvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_graphn_make(size : Int) -> FinanceriskcvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_graphn_len(s : FinanceriskcvarGraphN) -> Int { s.size }

pub fn finance_risk_cvar_graphn_get(s : FinanceriskcvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_graphn_set(s : FinanceriskcvarGraphN, i : Int, v : Double) -> FinanceriskcvarGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_graphn_sum(s : FinanceriskcvarGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_graphn_mean(s : FinanceriskcvarGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_graphn_scale(s : FinanceriskcvarGraphN, f : Double) -> FinanceriskcvarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_graphn_add(a : FinanceriskcvarGraphN, b : FinanceriskcvarGraphN) -> FinanceriskcvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_graphn_copy(s : FinanceriskcvarGraphN) -> FinanceriskcvarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_graphn_fill(s : FinanceriskcvarGraphN, v : Double) -> FinanceriskcvarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_graphn_min(s : FinanceriskcvarGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_graphn_max(s : FinanceriskcvarGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_graphn_to_string(s : FinanceriskcvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_node_make(size : Int) -> FinanceriskcvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_node_len(s : FinanceriskcvarNode) -> Int { s.size }

pub fn finance_risk_cvar_node_get(s : FinanceriskcvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_node_set(s : FinanceriskcvarNode, i : Int, v : Double) -> FinanceriskcvarNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_node_sum(s : FinanceriskcvarNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_node_mean(s : FinanceriskcvarNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_node_scale(s : FinanceriskcvarNode, f : Double) -> FinanceriskcvarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_node_add(a : FinanceriskcvarNode, b : FinanceriskcvarNode) -> FinanceriskcvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_node_copy(s : FinanceriskcvarNode) -> FinanceriskcvarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_node_fill(s : FinanceriskcvarNode, v : Double) -> FinanceriskcvarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_node_min(s : FinanceriskcvarNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_node_max(s : FinanceriskcvarNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_node_to_string(s : FinanceriskcvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_edge_make(size : Int) -> FinanceriskcvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_edge_len(s : FinanceriskcvarEdge) -> Int { s.size }

pub fn finance_risk_cvar_edge_get(s : FinanceriskcvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_edge_set(s : FinanceriskcvarEdge, i : Int, v : Double) -> FinanceriskcvarEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_edge_sum(s : FinanceriskcvarEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_edge_mean(s : FinanceriskcvarEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_edge_scale(s : FinanceriskcvarEdge, f : Double) -> FinanceriskcvarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_edge_add(a : FinanceriskcvarEdge, b : FinanceriskcvarEdge) -> FinanceriskcvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_edge_copy(s : FinanceriskcvarEdge) -> FinanceriskcvarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_edge_fill(s : FinanceriskcvarEdge, v : Double) -> FinanceriskcvarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_edge_min(s : FinanceriskcvarEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_edge_max(s : FinanceriskcvarEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_edge_to_string(s : FinanceriskcvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_path_make(size : Int) -> FinanceriskcvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_path_len(s : FinanceriskcvarPath) -> Int { s.size }

pub fn finance_risk_cvar_path_get(s : FinanceriskcvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_path_set(s : FinanceriskcvarPath, i : Int, v : Double) -> FinanceriskcvarPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_path_sum(s : FinanceriskcvarPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_path_mean(s : FinanceriskcvarPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_path_scale(s : FinanceriskcvarPath, f : Double) -> FinanceriskcvarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_path_add(a : FinanceriskcvarPath, b : FinanceriskcvarPath) -> FinanceriskcvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_path_copy(s : FinanceriskcvarPath) -> FinanceriskcvarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_path_fill(s : FinanceriskcvarPath, v : Double) -> FinanceriskcvarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_path_min(s : FinanceriskcvarPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_path_max(s : FinanceriskcvarPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_path_to_string(s : FinanceriskcvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_cluster_make(size : Int) -> FinanceriskcvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_cluster_len(s : FinanceriskcvarCluster) -> Int { s.size }

pub fn finance_risk_cvar_cluster_get(s : FinanceriskcvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_cluster_set(s : FinanceriskcvarCluster, i : Int, v : Double) -> FinanceriskcvarCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cluster_sum(s : FinanceriskcvarCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_cluster_mean(s : FinanceriskcvarCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_cluster_scale(s : FinanceriskcvarCluster, f : Double) -> FinanceriskcvarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cluster_add(a : FinanceriskcvarCluster, b : FinanceriskcvarCluster) -> FinanceriskcvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_cluster_copy(s : FinanceriskcvarCluster) -> FinanceriskcvarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cluster_fill(s : FinanceriskcvarCluster, v : Double) -> FinanceriskcvarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cluster_min(s : FinanceriskcvarCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_cluster_max(s : FinanceriskcvarCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_cluster_to_string(s : FinanceriskcvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_model_make(size : Int) -> FinanceriskcvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_model_len(s : FinanceriskcvarModel) -> Int { s.size }

pub fn finance_risk_cvar_model_get(s : FinanceriskcvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_model_set(s : FinanceriskcvarModel, i : Int, v : Double) -> FinanceriskcvarModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_model_sum(s : FinanceriskcvarModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_model_mean(s : FinanceriskcvarModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_model_scale(s : FinanceriskcvarModel, f : Double) -> FinanceriskcvarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_model_add(a : FinanceriskcvarModel, b : FinanceriskcvarModel) -> FinanceriskcvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_model_copy(s : FinanceriskcvarModel) -> FinanceriskcvarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_model_fill(s : FinanceriskcvarModel, v : Double) -> FinanceriskcvarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_model_min(s : FinanceriskcvarModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_model_max(s : FinanceriskcvarModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_model_to_string(s : FinanceriskcvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_layer_make(size : Int) -> FinanceriskcvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_layer_len(s : FinanceriskcvarLayer) -> Int { s.size }

pub fn finance_risk_cvar_layer_get(s : FinanceriskcvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_layer_set(s : FinanceriskcvarLayer, i : Int, v : Double) -> FinanceriskcvarLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_layer_sum(s : FinanceriskcvarLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_layer_mean(s : FinanceriskcvarLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_layer_scale(s : FinanceriskcvarLayer, f : Double) -> FinanceriskcvarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_layer_add(a : FinanceriskcvarLayer, b : FinanceriskcvarLayer) -> FinanceriskcvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_layer_copy(s : FinanceriskcvarLayer) -> FinanceriskcvarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_layer_fill(s : FinanceriskcvarLayer, v : Double) -> FinanceriskcvarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_layer_min(s : FinanceriskcvarLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_layer_max(s : FinanceriskcvarLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_layer_to_string(s : FinanceriskcvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_buffer_make(size : Int) -> FinanceriskcvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_buffer_len(s : FinanceriskcvarBuffer) -> Int { s.size }

pub fn finance_risk_cvar_buffer_get(s : FinanceriskcvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_buffer_set(s : FinanceriskcvarBuffer, i : Int, v : Double) -> FinanceriskcvarBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_buffer_sum(s : FinanceriskcvarBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_buffer_mean(s : FinanceriskcvarBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_buffer_scale(s : FinanceriskcvarBuffer, f : Double) -> FinanceriskcvarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_buffer_add(a : FinanceriskcvarBuffer, b : FinanceriskcvarBuffer) -> FinanceriskcvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_buffer_copy(s : FinanceriskcvarBuffer) -> FinanceriskcvarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_buffer_fill(s : FinanceriskcvarBuffer, v : Double) -> FinanceriskcvarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_buffer_min(s : FinanceriskcvarBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_buffer_max(s : FinanceriskcvarBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_buffer_to_string(s : FinanceriskcvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_cursor_make(size : Int) -> FinanceriskcvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_cursor_len(s : FinanceriskcvarCursor) -> Int { s.size }

pub fn finance_risk_cvar_cursor_get(s : FinanceriskcvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_cursor_set(s : FinanceriskcvarCursor, i : Int, v : Double) -> FinanceriskcvarCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cursor_sum(s : FinanceriskcvarCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_cursor_mean(s : FinanceriskcvarCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_cursor_scale(s : FinanceriskcvarCursor, f : Double) -> FinanceriskcvarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cursor_add(a : FinanceriskcvarCursor, b : FinanceriskcvarCursor) -> FinanceriskcvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_cursor_copy(s : FinanceriskcvarCursor) -> FinanceriskcvarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cursor_fill(s : FinanceriskcvarCursor, v : Double) -> FinanceriskcvarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_cursor_min(s : FinanceriskcvarCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_cursor_max(s : FinanceriskcvarCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_cursor_to_string(s : FinanceriskcvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_view_make(size : Int) -> FinanceriskcvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_view_len(s : FinanceriskcvarView) -> Int { s.size }

pub fn finance_risk_cvar_view_get(s : FinanceriskcvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_view_set(s : FinanceriskcvarView, i : Int, v : Double) -> FinanceriskcvarView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_view_sum(s : FinanceriskcvarView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_view_mean(s : FinanceriskcvarView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_view_scale(s : FinanceriskcvarView, f : Double) -> FinanceriskcvarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_view_add(a : FinanceriskcvarView, b : FinanceriskcvarView) -> FinanceriskcvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_view_copy(s : FinanceriskcvarView) -> FinanceriskcvarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_view_fill(s : FinanceriskcvarView, v : Double) -> FinanceriskcvarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_view_min(s : FinanceriskcvarView) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_view_max(s : FinanceriskcvarView) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_view_to_string(s : FinanceriskcvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_range_make(size : Int) -> FinanceriskcvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_range_len(s : FinanceriskcvarRange) -> Int { s.size }

pub fn finance_risk_cvar_range_get(s : FinanceriskcvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_range_set(s : FinanceriskcvarRange, i : Int, v : Double) -> FinanceriskcvarRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_range_sum(s : FinanceriskcvarRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_range_mean(s : FinanceriskcvarRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_range_scale(s : FinanceriskcvarRange, f : Double) -> FinanceriskcvarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_range_add(a : FinanceriskcvarRange, b : FinanceriskcvarRange) -> FinanceriskcvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_range_copy(s : FinanceriskcvarRange) -> FinanceriskcvarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_range_fill(s : FinanceriskcvarRange, v : Double) -> FinanceriskcvarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_range_min(s : FinanceriskcvarRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_range_max(s : FinanceriskcvarRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_range_to_string(s : FinanceriskcvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_slice_make(size : Int) -> FinanceriskcvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_slice_len(s : FinanceriskcvarSlice) -> Int { s.size }

pub fn finance_risk_cvar_slice_get(s : FinanceriskcvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_slice_set(s : FinanceriskcvarSlice, i : Int, v : Double) -> FinanceriskcvarSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_slice_sum(s : FinanceriskcvarSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_cvar_slice_mean(s : FinanceriskcvarSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_cvar_slice_scale(s : FinanceriskcvarSlice, f : Double) -> FinanceriskcvarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_slice_add(a : FinanceriskcvarSlice, b : FinanceriskcvarSlice) -> FinanceriskcvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_cvar_slice_copy(s : FinanceriskcvarSlice) -> FinanceriskcvarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_slice_fill(s : FinanceriskcvarSlice, v : Double) -> FinanceriskcvarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_cvar_slice_min(s : FinanceriskcvarSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_cvar_slice_max(s : FinanceriskcvarSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_cvar_slice_to_string(s : FinanceriskcvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

