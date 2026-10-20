///===
/// extcore/finance_risk_scenario

pub(all) struct FinanceriskscenarioPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_scenario_make_point(x : Double, y : Double) -> FinanceriskscenarioPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_scenario_make_point3(x : Double, y : Double, z : Double) -> FinanceriskscenarioPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskscenarioPoint::x(self : FinanceriskscenarioPoint) -> Double { self.x }

pub fn FinanceriskscenarioPoint::y(self : FinanceriskscenarioPoint) -> Double { self.y }

pub fn FinanceriskscenarioPoint::z(self : FinanceriskscenarioPoint) -> Double { self.z }

pub fn FinanceriskscenarioPoint::label(self : FinanceriskscenarioPoint) -> Int { self.label }

pub fn FinanceriskscenarioPoint::dist(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskscenarioPoint::add(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskscenarioPoint::sub(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskscenarioPoint::scale(self : FinanceriskscenarioPoint, s : Double) -> FinanceriskscenarioPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskscenarioPoint::dot(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskscenarioPoint::cross(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskscenarioPoint::norm(self : FinanceriskscenarioPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskscenarioPoint::normalize(self : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskscenarioPoint::negate(self : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskscenarioPoint::mid(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint) -> FinanceriskscenarioPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskscenarioPoint::lerp(self : FinanceriskscenarioPoint, other : FinanceriskscenarioPoint, t : Double) -> FinanceriskscenarioPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskscenarioPoint::to_string(self : FinanceriskscenarioPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_scenario_make_series(vals : Array[Double], name : String) -> FinanceriskscenarioSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskscenarioSeries::len(self : FinanceriskscenarioSeries) -> Int { self.vals.length() }

pub fn FinanceriskscenarioSeries::sum(self : FinanceriskscenarioSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskscenarioSeries::mean(self : FinanceriskscenarioSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskscenarioSeries::min(self : FinanceriskscenarioSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskscenarioSeries::max(self : FinanceriskscenarioSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskscenarioSeries::range(self : FinanceriskscenarioSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskscenarioSeries::variance(self : FinanceriskscenarioSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskscenarioSeries::std(self : FinanceriskscenarioSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskscenarioSeries::median(self : FinanceriskscenarioSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskscenarioSeries::scale(self : FinanceriskscenarioSeries, f : Double) -> FinanceriskscenarioSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskscenarioSeries::add(self : FinanceriskscenarioSeries, other : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskscenarioSeries::sub(self : FinanceriskscenarioSeries, other : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskscenarioSeries::normalize(self : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskscenarioSeries::cumsum(self : FinanceriskscenarioSeries) -> FinanceriskscenarioSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskscenarioSeries::to_string(self : FinanceriskscenarioSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskscenarioMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_scenario_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskscenarioMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_scenario_matrix_identity(n : Int) -> FinanceriskscenarioMatrix {
  let m = finance_risk_scenario_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskscenarioMatrix::get(self : FinanceriskscenarioMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskscenarioMatrix::transpose(self : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskscenarioMatrix::add(self : FinanceriskscenarioMatrix, other : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_scenario_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskscenarioMatrix::scale(self : FinanceriskscenarioMatrix, s : Double) -> FinanceriskscenarioMatrix {
  let result = finance_risk_scenario_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskscenarioMatrix::multiply(self : FinanceriskscenarioMatrix, other : FinanceriskscenarioMatrix) -> FinanceriskscenarioMatrix {
  if self.cols != other.rows { return finance_risk_scenario_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_scenario_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskscenarioMatrix::trace(self : FinanceriskscenarioMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskscenarioMatrix::det(self : FinanceriskscenarioMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskscenarioMatrix::norm(self : FinanceriskscenarioMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskscenarioMatrix::to_string(self : FinanceriskscenarioMatrix) -> String {
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

pub(all) struct FinanceriskscenarioVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_scenario_make_vector(comps : Array[Double]) -> FinanceriskscenarioVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_scenario_vector_zero(dim : Int) -> FinanceriskscenarioVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskscenarioVector::add(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskscenarioVector::sub(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskscenarioVector::scale(self : FinanceriskscenarioVector, s : Double) -> FinanceriskscenarioVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskscenarioVector::dot(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskscenarioVector::norm(self : FinanceriskscenarioVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskscenarioVector::normalize(self : FinanceriskscenarioVector) -> FinanceriskscenarioVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskscenarioVector::dist(self : FinanceriskscenarioVector, other : FinanceriskscenarioVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskscenarioVector::to_string(self : FinanceriskscenarioVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_scenario_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_scenario_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_scenario_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_scenario_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_scenario_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_scenario_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_scenario_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_scenario_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_scenario_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_scenario_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_scenario_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_scenario_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_scenario_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_scenario_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_scenario_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_scenario_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_scenario_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_scenario_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_scenario_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_scenario_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_scenario_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_scenario_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_scenario_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_scenario_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_scenario_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_scenario_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_scenario_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_scenario_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_scenario_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskscenarioFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_frame_make(size : Int) -> FinanceriskscenarioFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_frame_len(s : FinanceriskscenarioFrame) -> Int { s.size }

pub fn finance_risk_scenario_frame_get(s : FinanceriskscenarioFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_frame_set(s : FinanceriskscenarioFrame, i : Int, v : Double) -> FinanceriskscenarioFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_sum(s : FinanceriskscenarioFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_frame_mean(s : FinanceriskscenarioFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_frame_scale(s : FinanceriskscenarioFrame, f : Double) -> FinanceriskscenarioFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_add(a : FinanceriskscenarioFrame, b : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_frame_copy(s : FinanceriskscenarioFrame) -> FinanceriskscenarioFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_fill(s : FinanceriskscenarioFrame, v : Double) -> FinanceriskscenarioFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_frame_min(s : FinanceriskscenarioFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_frame_max(s : FinanceriskscenarioFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_frame_to_string(s : FinanceriskscenarioFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_table_make(size : Int) -> FinanceriskscenarioTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_table_len(s : FinanceriskscenarioTable) -> Int { s.size }

pub fn finance_risk_scenario_table_get(s : FinanceriskscenarioTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_table_set(s : FinanceriskscenarioTable, i : Int, v : Double) -> FinanceriskscenarioTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_sum(s : FinanceriskscenarioTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_table_mean(s : FinanceriskscenarioTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_table_scale(s : FinanceriskscenarioTable, f : Double) -> FinanceriskscenarioTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_add(a : FinanceriskscenarioTable, b : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_table_copy(s : FinanceriskscenarioTable) -> FinanceriskscenarioTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_fill(s : FinanceriskscenarioTable, v : Double) -> FinanceriskscenarioTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_table_min(s : FinanceriskscenarioTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_table_max(s : FinanceriskscenarioTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_table_to_string(s : FinanceriskscenarioTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_graphn_make(size : Int) -> FinanceriskscenarioGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_graphn_len(s : FinanceriskscenarioGraphN) -> Int { s.size }

pub fn finance_risk_scenario_graphn_get(s : FinanceriskscenarioGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_graphn_set(s : FinanceriskscenarioGraphN, i : Int, v : Double) -> FinanceriskscenarioGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_sum(s : FinanceriskscenarioGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_graphn_mean(s : FinanceriskscenarioGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_graphn_scale(s : FinanceriskscenarioGraphN, f : Double) -> FinanceriskscenarioGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_add(a : FinanceriskscenarioGraphN, b : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_graphn_copy(s : FinanceriskscenarioGraphN) -> FinanceriskscenarioGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_fill(s : FinanceriskscenarioGraphN, v : Double) -> FinanceriskscenarioGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_graphn_min(s : FinanceriskscenarioGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_graphn_max(s : FinanceriskscenarioGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_graphn_to_string(s : FinanceriskscenarioGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_node_make(size : Int) -> FinanceriskscenarioNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_node_len(s : FinanceriskscenarioNode) -> Int { s.size }

pub fn finance_risk_scenario_node_get(s : FinanceriskscenarioNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_node_set(s : FinanceriskscenarioNode, i : Int, v : Double) -> FinanceriskscenarioNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_sum(s : FinanceriskscenarioNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_node_mean(s : FinanceriskscenarioNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_node_scale(s : FinanceriskscenarioNode, f : Double) -> FinanceriskscenarioNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_add(a : FinanceriskscenarioNode, b : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_node_copy(s : FinanceriskscenarioNode) -> FinanceriskscenarioNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_fill(s : FinanceriskscenarioNode, v : Double) -> FinanceriskscenarioNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_node_min(s : FinanceriskscenarioNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_node_max(s : FinanceriskscenarioNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_node_to_string(s : FinanceriskscenarioNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_edge_make(size : Int) -> FinanceriskscenarioEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_edge_len(s : FinanceriskscenarioEdge) -> Int { s.size }

pub fn finance_risk_scenario_edge_get(s : FinanceriskscenarioEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_edge_set(s : FinanceriskscenarioEdge, i : Int, v : Double) -> FinanceriskscenarioEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_sum(s : FinanceriskscenarioEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_edge_mean(s : FinanceriskscenarioEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_edge_scale(s : FinanceriskscenarioEdge, f : Double) -> FinanceriskscenarioEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_add(a : FinanceriskscenarioEdge, b : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_edge_copy(s : FinanceriskscenarioEdge) -> FinanceriskscenarioEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_fill(s : FinanceriskscenarioEdge, v : Double) -> FinanceriskscenarioEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_edge_min(s : FinanceriskscenarioEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_edge_max(s : FinanceriskscenarioEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_edge_to_string(s : FinanceriskscenarioEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_path_make(size : Int) -> FinanceriskscenarioPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_path_len(s : FinanceriskscenarioPath) -> Int { s.size }

pub fn finance_risk_scenario_path_get(s : FinanceriskscenarioPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_path_set(s : FinanceriskscenarioPath, i : Int, v : Double) -> FinanceriskscenarioPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_sum(s : FinanceriskscenarioPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_path_mean(s : FinanceriskscenarioPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_path_scale(s : FinanceriskscenarioPath, f : Double) -> FinanceriskscenarioPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_add(a : FinanceriskscenarioPath, b : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_path_copy(s : FinanceriskscenarioPath) -> FinanceriskscenarioPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_fill(s : FinanceriskscenarioPath, v : Double) -> FinanceriskscenarioPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_path_min(s : FinanceriskscenarioPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_path_max(s : FinanceriskscenarioPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_path_to_string(s : FinanceriskscenarioPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cluster_make(size : Int) -> FinanceriskscenarioCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_cluster_len(s : FinanceriskscenarioCluster) -> Int { s.size }

pub fn finance_risk_scenario_cluster_get(s : FinanceriskscenarioCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_cluster_set(s : FinanceriskscenarioCluster, i : Int, v : Double) -> FinanceriskscenarioCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_sum(s : FinanceriskscenarioCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_cluster_mean(s : FinanceriskscenarioCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_cluster_scale(s : FinanceriskscenarioCluster, f : Double) -> FinanceriskscenarioCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_add(a : FinanceriskscenarioCluster, b : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_cluster_copy(s : FinanceriskscenarioCluster) -> FinanceriskscenarioCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_fill(s : FinanceriskscenarioCluster, v : Double) -> FinanceriskscenarioCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cluster_min(s : FinanceriskscenarioCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_cluster_max(s : FinanceriskscenarioCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_cluster_to_string(s : FinanceriskscenarioCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_model_make(size : Int) -> FinanceriskscenarioModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_model_len(s : FinanceriskscenarioModel) -> Int { s.size }

pub fn finance_risk_scenario_model_get(s : FinanceriskscenarioModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_model_set(s : FinanceriskscenarioModel, i : Int, v : Double) -> FinanceriskscenarioModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_sum(s : FinanceriskscenarioModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_model_mean(s : FinanceriskscenarioModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_model_scale(s : FinanceriskscenarioModel, f : Double) -> FinanceriskscenarioModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_add(a : FinanceriskscenarioModel, b : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_model_copy(s : FinanceriskscenarioModel) -> FinanceriskscenarioModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_fill(s : FinanceriskscenarioModel, v : Double) -> FinanceriskscenarioModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_model_min(s : FinanceriskscenarioModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_model_max(s : FinanceriskscenarioModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_model_to_string(s : FinanceriskscenarioModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_layer_make(size : Int) -> FinanceriskscenarioLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_layer_len(s : FinanceriskscenarioLayer) -> Int { s.size }

pub fn finance_risk_scenario_layer_get(s : FinanceriskscenarioLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_layer_set(s : FinanceriskscenarioLayer, i : Int, v : Double) -> FinanceriskscenarioLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_sum(s : FinanceriskscenarioLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_layer_mean(s : FinanceriskscenarioLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_layer_scale(s : FinanceriskscenarioLayer, f : Double) -> FinanceriskscenarioLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_add(a : FinanceriskscenarioLayer, b : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_layer_copy(s : FinanceriskscenarioLayer) -> FinanceriskscenarioLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_fill(s : FinanceriskscenarioLayer, v : Double) -> FinanceriskscenarioLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_layer_min(s : FinanceriskscenarioLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_layer_max(s : FinanceriskscenarioLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_layer_to_string(s : FinanceriskscenarioLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_buffer_make(size : Int) -> FinanceriskscenarioBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_buffer_len(s : FinanceriskscenarioBuffer) -> Int { s.size }

pub fn finance_risk_scenario_buffer_get(s : FinanceriskscenarioBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_buffer_set(s : FinanceriskscenarioBuffer, i : Int, v : Double) -> FinanceriskscenarioBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_sum(s : FinanceriskscenarioBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_buffer_mean(s : FinanceriskscenarioBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_buffer_scale(s : FinanceriskscenarioBuffer, f : Double) -> FinanceriskscenarioBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_add(a : FinanceriskscenarioBuffer, b : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_buffer_copy(s : FinanceriskscenarioBuffer) -> FinanceriskscenarioBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_fill(s : FinanceriskscenarioBuffer, v : Double) -> FinanceriskscenarioBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_buffer_min(s : FinanceriskscenarioBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_buffer_max(s : FinanceriskscenarioBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_buffer_to_string(s : FinanceriskscenarioBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_cursor_make(size : Int) -> FinanceriskscenarioCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_cursor_len(s : FinanceriskscenarioCursor) -> Int { s.size }

pub fn finance_risk_scenario_cursor_get(s : FinanceriskscenarioCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_cursor_set(s : FinanceriskscenarioCursor, i : Int, v : Double) -> FinanceriskscenarioCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_sum(s : FinanceriskscenarioCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_cursor_mean(s : FinanceriskscenarioCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_cursor_scale(s : FinanceriskscenarioCursor, f : Double) -> FinanceriskscenarioCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_add(a : FinanceriskscenarioCursor, b : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_cursor_copy(s : FinanceriskscenarioCursor) -> FinanceriskscenarioCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_fill(s : FinanceriskscenarioCursor, v : Double) -> FinanceriskscenarioCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_cursor_min(s : FinanceriskscenarioCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_cursor_max(s : FinanceriskscenarioCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_cursor_to_string(s : FinanceriskscenarioCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_view_make(size : Int) -> FinanceriskscenarioView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_view_len(s : FinanceriskscenarioView) -> Int { s.size }

pub fn finance_risk_scenario_view_get(s : FinanceriskscenarioView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_view_set(s : FinanceriskscenarioView, i : Int, v : Double) -> FinanceriskscenarioView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_sum(s : FinanceriskscenarioView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_view_mean(s : FinanceriskscenarioView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_view_scale(s : FinanceriskscenarioView, f : Double) -> FinanceriskscenarioView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_add(a : FinanceriskscenarioView, b : FinanceriskscenarioView) -> FinanceriskscenarioView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_view_copy(s : FinanceriskscenarioView) -> FinanceriskscenarioView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_fill(s : FinanceriskscenarioView, v : Double) -> FinanceriskscenarioView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_view_min(s : FinanceriskscenarioView) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_view_max(s : FinanceriskscenarioView) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_view_to_string(s : FinanceriskscenarioView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_range_make(size : Int) -> FinanceriskscenarioRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_range_len(s : FinanceriskscenarioRange) -> Int { s.size }

pub fn finance_risk_scenario_range_get(s : FinanceriskscenarioRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_range_set(s : FinanceriskscenarioRange, i : Int, v : Double) -> FinanceriskscenarioRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_sum(s : FinanceriskscenarioRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_range_mean(s : FinanceriskscenarioRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_range_scale(s : FinanceriskscenarioRange, f : Double) -> FinanceriskscenarioRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_add(a : FinanceriskscenarioRange, b : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_range_copy(s : FinanceriskscenarioRange) -> FinanceriskscenarioRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_fill(s : FinanceriskscenarioRange, v : Double) -> FinanceriskscenarioRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_range_min(s : FinanceriskscenarioRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_range_max(s : FinanceriskscenarioRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_range_to_string(s : FinanceriskscenarioRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskscenarioSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_scenario_slice_make(size : Int) -> FinanceriskscenarioSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_scenario_slice_len(s : FinanceriskscenarioSlice) -> Int { s.size }

pub fn finance_risk_scenario_slice_get(s : FinanceriskscenarioSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_scenario_slice_set(s : FinanceriskscenarioSlice, i : Int, v : Double) -> FinanceriskscenarioSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_sum(s : FinanceriskscenarioSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_scenario_slice_mean(s : FinanceriskscenarioSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_scenario_slice_scale(s : FinanceriskscenarioSlice, f : Double) -> FinanceriskscenarioSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_add(a : FinanceriskscenarioSlice, b : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_scenario_slice_copy(s : FinanceriskscenarioSlice) -> FinanceriskscenarioSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_fill(s : FinanceriskscenarioSlice, v : Double) -> FinanceriskscenarioSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_scenario_slice_min(s : FinanceriskscenarioSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_scenario_slice_max(s : FinanceriskscenarioSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_scenario_slice_to_string(s : FinanceriskscenarioSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

