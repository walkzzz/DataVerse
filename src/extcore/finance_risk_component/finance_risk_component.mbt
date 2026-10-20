///===
/// extcore/finance_risk_component

pub(all) struct FinanceriskcomponentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_component_make_point(x : Double, y : Double) -> FinanceriskcomponentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_component_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcomponentPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskcomponentPoint::x(self : FinanceriskcomponentPoint) -> Double { self.x }

pub fn FinanceriskcomponentPoint::y(self : FinanceriskcomponentPoint) -> Double { self.y }

pub fn FinanceriskcomponentPoint::z(self : FinanceriskcomponentPoint) -> Double { self.z }

pub fn FinanceriskcomponentPoint::label(self : FinanceriskcomponentPoint) -> Int { self.label }

pub fn FinanceriskcomponentPoint::dist(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskcomponentPoint::add(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskcomponentPoint::sub(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskcomponentPoint::scale(self : FinanceriskcomponentPoint, s : Double) -> FinanceriskcomponentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskcomponentPoint::dot(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskcomponentPoint::cross(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskcomponentPoint::norm(self : FinanceriskcomponentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskcomponentPoint::normalize(self : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcomponentPoint::negate(self : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskcomponentPoint::mid(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint) -> FinanceriskcomponentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskcomponentPoint::lerp(self : FinanceriskcomponentPoint, other : FinanceriskcomponentPoint, t : Double) -> FinanceriskcomponentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskcomponentPoint::to_string(self : FinanceriskcomponentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskcomponentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_component_make_series(vals : Array[Double], name : String) -> FinanceriskcomponentSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskcomponentSeries::len(self : FinanceriskcomponentSeries) -> Int { self.vals.length() }

pub fn FinanceriskcomponentSeries::sum(self : FinanceriskcomponentSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskcomponentSeries::mean(self : FinanceriskcomponentSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskcomponentSeries::min(self : FinanceriskcomponentSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskcomponentSeries::max(self : FinanceriskcomponentSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskcomponentSeries::range(self : FinanceriskcomponentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskcomponentSeries::variance(self : FinanceriskcomponentSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskcomponentSeries::std(self : FinanceriskcomponentSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskcomponentSeries::median(self : FinanceriskcomponentSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskcomponentSeries::scale(self : FinanceriskcomponentSeries, f : Double) -> FinanceriskcomponentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskcomponentSeries::add(self : FinanceriskcomponentSeries, other : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskcomponentSeries::sub(self : FinanceriskcomponentSeries, other : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskcomponentSeries::normalize(self : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskcomponentSeries::cumsum(self : FinanceriskcomponentSeries) -> FinanceriskcomponentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskcomponentSeries::to_string(self : FinanceriskcomponentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcomponentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_component_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcomponentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_component_matrix_identity(n : Int) -> FinanceriskcomponentMatrix {
  let m = finance_risk_component_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskcomponentMatrix::get(self : FinanceriskcomponentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskcomponentMatrix::transpose(self : FinanceriskcomponentMatrix) -> FinanceriskcomponentMatrix {
  let result = finance_risk_component_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskcomponentMatrix::add(self : FinanceriskcomponentMatrix, other : FinanceriskcomponentMatrix) -> FinanceriskcomponentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_component_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskcomponentMatrix::scale(self : FinanceriskcomponentMatrix, s : Double) -> FinanceriskcomponentMatrix {
  let result = finance_risk_component_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskcomponentMatrix::multiply(self : FinanceriskcomponentMatrix, other : FinanceriskcomponentMatrix) -> FinanceriskcomponentMatrix {
  if self.cols != other.rows { return finance_risk_component_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_component_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskcomponentMatrix::trace(self : FinanceriskcomponentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskcomponentMatrix::det(self : FinanceriskcomponentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskcomponentMatrix::norm(self : FinanceriskcomponentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskcomponentMatrix::to_string(self : FinanceriskcomponentMatrix) -> String {
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

pub(all) struct FinanceriskcomponentVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_component_make_vector(comps : Array[Double]) -> FinanceriskcomponentVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_component_vector_zero(dim : Int) -> FinanceriskcomponentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskcomponentVector::add(self : FinanceriskcomponentVector, other : FinanceriskcomponentVector) -> FinanceriskcomponentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcomponentVector::sub(self : FinanceriskcomponentVector, other : FinanceriskcomponentVector) -> FinanceriskcomponentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcomponentVector::scale(self : FinanceriskcomponentVector, s : Double) -> FinanceriskcomponentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskcomponentVector::dot(self : FinanceriskcomponentVector, other : FinanceriskcomponentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskcomponentVector::norm(self : FinanceriskcomponentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskcomponentVector::normalize(self : FinanceriskcomponentVector) -> FinanceriskcomponentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcomponentVector::dist(self : FinanceriskcomponentVector, other : FinanceriskcomponentVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskcomponentVector::to_string(self : FinanceriskcomponentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_component_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_component_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_component_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_component_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_component_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_component_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_component_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_component_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_component_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_component_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_component_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_component_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_component_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_component_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_component_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_component_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_component_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_component_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_component_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_component_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_component_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_component_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_component_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_component_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_component_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_component_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_component_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_component_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_component_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskcomponentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_frame_make(size : Int) -> FinanceriskcomponentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_frame_len(s : FinanceriskcomponentFrame) -> Int { s.size }

pub fn finance_risk_component_frame_get(s : FinanceriskcomponentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_frame_set(s : FinanceriskcomponentFrame, i : Int, v : Double) -> FinanceriskcomponentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_sum(s : FinanceriskcomponentFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_frame_mean(s : FinanceriskcomponentFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_frame_scale(s : FinanceriskcomponentFrame, f : Double) -> FinanceriskcomponentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_add(a : FinanceriskcomponentFrame, b : FinanceriskcomponentFrame) -> FinanceriskcomponentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_frame_copy(s : FinanceriskcomponentFrame) -> FinanceriskcomponentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_fill(s : FinanceriskcomponentFrame, v : Double) -> FinanceriskcomponentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_frame_min(s : FinanceriskcomponentFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_frame_max(s : FinanceriskcomponentFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_frame_to_string(s : FinanceriskcomponentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_table_make(size : Int) -> FinanceriskcomponentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_table_len(s : FinanceriskcomponentTable) -> Int { s.size }

pub fn finance_risk_component_table_get(s : FinanceriskcomponentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_table_set(s : FinanceriskcomponentTable, i : Int, v : Double) -> FinanceriskcomponentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_sum(s : FinanceriskcomponentTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_table_mean(s : FinanceriskcomponentTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_table_scale(s : FinanceriskcomponentTable, f : Double) -> FinanceriskcomponentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_add(a : FinanceriskcomponentTable, b : FinanceriskcomponentTable) -> FinanceriskcomponentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_table_copy(s : FinanceriskcomponentTable) -> FinanceriskcomponentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_fill(s : FinanceriskcomponentTable, v : Double) -> FinanceriskcomponentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_table_min(s : FinanceriskcomponentTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_table_max(s : FinanceriskcomponentTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_table_to_string(s : FinanceriskcomponentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_graphn_make(size : Int) -> FinanceriskcomponentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_graphn_len(s : FinanceriskcomponentGraphN) -> Int { s.size }

pub fn finance_risk_component_graphn_get(s : FinanceriskcomponentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_graphn_set(s : FinanceriskcomponentGraphN, i : Int, v : Double) -> FinanceriskcomponentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_sum(s : FinanceriskcomponentGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_graphn_mean(s : FinanceriskcomponentGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_graphn_scale(s : FinanceriskcomponentGraphN, f : Double) -> FinanceriskcomponentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_add(a : FinanceriskcomponentGraphN, b : FinanceriskcomponentGraphN) -> FinanceriskcomponentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_graphn_copy(s : FinanceriskcomponentGraphN) -> FinanceriskcomponentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_fill(s : FinanceriskcomponentGraphN, v : Double) -> FinanceriskcomponentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_graphn_min(s : FinanceriskcomponentGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_graphn_max(s : FinanceriskcomponentGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_graphn_to_string(s : FinanceriskcomponentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_node_make(size : Int) -> FinanceriskcomponentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_node_len(s : FinanceriskcomponentNode) -> Int { s.size }

pub fn finance_risk_component_node_get(s : FinanceriskcomponentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_node_set(s : FinanceriskcomponentNode, i : Int, v : Double) -> FinanceriskcomponentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_sum(s : FinanceriskcomponentNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_node_mean(s : FinanceriskcomponentNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_node_scale(s : FinanceriskcomponentNode, f : Double) -> FinanceriskcomponentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_add(a : FinanceriskcomponentNode, b : FinanceriskcomponentNode) -> FinanceriskcomponentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_node_copy(s : FinanceriskcomponentNode) -> FinanceriskcomponentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_fill(s : FinanceriskcomponentNode, v : Double) -> FinanceriskcomponentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_node_min(s : FinanceriskcomponentNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_node_max(s : FinanceriskcomponentNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_node_to_string(s : FinanceriskcomponentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_edge_make(size : Int) -> FinanceriskcomponentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_edge_len(s : FinanceriskcomponentEdge) -> Int { s.size }

pub fn finance_risk_component_edge_get(s : FinanceriskcomponentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_edge_set(s : FinanceriskcomponentEdge, i : Int, v : Double) -> FinanceriskcomponentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_sum(s : FinanceriskcomponentEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_edge_mean(s : FinanceriskcomponentEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_edge_scale(s : FinanceriskcomponentEdge, f : Double) -> FinanceriskcomponentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_add(a : FinanceriskcomponentEdge, b : FinanceriskcomponentEdge) -> FinanceriskcomponentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_edge_copy(s : FinanceriskcomponentEdge) -> FinanceriskcomponentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_fill(s : FinanceriskcomponentEdge, v : Double) -> FinanceriskcomponentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_edge_min(s : FinanceriskcomponentEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_edge_max(s : FinanceriskcomponentEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_edge_to_string(s : FinanceriskcomponentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_path_make(size : Int) -> FinanceriskcomponentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_path_len(s : FinanceriskcomponentPath) -> Int { s.size }

pub fn finance_risk_component_path_get(s : FinanceriskcomponentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_path_set(s : FinanceriskcomponentPath, i : Int, v : Double) -> FinanceriskcomponentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_sum(s : FinanceriskcomponentPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_path_mean(s : FinanceriskcomponentPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_path_scale(s : FinanceriskcomponentPath, f : Double) -> FinanceriskcomponentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_add(a : FinanceriskcomponentPath, b : FinanceriskcomponentPath) -> FinanceriskcomponentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_path_copy(s : FinanceriskcomponentPath) -> FinanceriskcomponentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_fill(s : FinanceriskcomponentPath, v : Double) -> FinanceriskcomponentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_path_min(s : FinanceriskcomponentPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_path_max(s : FinanceriskcomponentPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_path_to_string(s : FinanceriskcomponentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_cluster_make(size : Int) -> FinanceriskcomponentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_cluster_len(s : FinanceriskcomponentCluster) -> Int { s.size }

pub fn finance_risk_component_cluster_get(s : FinanceriskcomponentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_cluster_set(s : FinanceriskcomponentCluster, i : Int, v : Double) -> FinanceriskcomponentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_sum(s : FinanceriskcomponentCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_cluster_mean(s : FinanceriskcomponentCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_cluster_scale(s : FinanceriskcomponentCluster, f : Double) -> FinanceriskcomponentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_add(a : FinanceriskcomponentCluster, b : FinanceriskcomponentCluster) -> FinanceriskcomponentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_cluster_copy(s : FinanceriskcomponentCluster) -> FinanceriskcomponentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_fill(s : FinanceriskcomponentCluster, v : Double) -> FinanceriskcomponentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cluster_min(s : FinanceriskcomponentCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_cluster_max(s : FinanceriskcomponentCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_cluster_to_string(s : FinanceriskcomponentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_model_make(size : Int) -> FinanceriskcomponentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_model_len(s : FinanceriskcomponentModel) -> Int { s.size }

pub fn finance_risk_component_model_get(s : FinanceriskcomponentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_model_set(s : FinanceriskcomponentModel, i : Int, v : Double) -> FinanceriskcomponentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_sum(s : FinanceriskcomponentModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_model_mean(s : FinanceriskcomponentModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_model_scale(s : FinanceriskcomponentModel, f : Double) -> FinanceriskcomponentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_add(a : FinanceriskcomponentModel, b : FinanceriskcomponentModel) -> FinanceriskcomponentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_model_copy(s : FinanceriskcomponentModel) -> FinanceriskcomponentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_fill(s : FinanceriskcomponentModel, v : Double) -> FinanceriskcomponentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_model_min(s : FinanceriskcomponentModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_model_max(s : FinanceriskcomponentModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_model_to_string(s : FinanceriskcomponentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_layer_make(size : Int) -> FinanceriskcomponentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_layer_len(s : FinanceriskcomponentLayer) -> Int { s.size }

pub fn finance_risk_component_layer_get(s : FinanceriskcomponentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_layer_set(s : FinanceriskcomponentLayer, i : Int, v : Double) -> FinanceriskcomponentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_sum(s : FinanceriskcomponentLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_layer_mean(s : FinanceriskcomponentLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_layer_scale(s : FinanceriskcomponentLayer, f : Double) -> FinanceriskcomponentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_add(a : FinanceriskcomponentLayer, b : FinanceriskcomponentLayer) -> FinanceriskcomponentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_layer_copy(s : FinanceriskcomponentLayer) -> FinanceriskcomponentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_fill(s : FinanceriskcomponentLayer, v : Double) -> FinanceriskcomponentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_layer_min(s : FinanceriskcomponentLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_layer_max(s : FinanceriskcomponentLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_layer_to_string(s : FinanceriskcomponentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_buffer_make(size : Int) -> FinanceriskcomponentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_buffer_len(s : FinanceriskcomponentBuffer) -> Int { s.size }

pub fn finance_risk_component_buffer_get(s : FinanceriskcomponentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_buffer_set(s : FinanceriskcomponentBuffer, i : Int, v : Double) -> FinanceriskcomponentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_sum(s : FinanceriskcomponentBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_buffer_mean(s : FinanceriskcomponentBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_buffer_scale(s : FinanceriskcomponentBuffer, f : Double) -> FinanceriskcomponentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_add(a : FinanceriskcomponentBuffer, b : FinanceriskcomponentBuffer) -> FinanceriskcomponentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_buffer_copy(s : FinanceriskcomponentBuffer) -> FinanceriskcomponentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_fill(s : FinanceriskcomponentBuffer, v : Double) -> FinanceriskcomponentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_buffer_min(s : FinanceriskcomponentBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_buffer_max(s : FinanceriskcomponentBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_buffer_to_string(s : FinanceriskcomponentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_cursor_make(size : Int) -> FinanceriskcomponentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_cursor_len(s : FinanceriskcomponentCursor) -> Int { s.size }

pub fn finance_risk_component_cursor_get(s : FinanceriskcomponentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_cursor_set(s : FinanceriskcomponentCursor, i : Int, v : Double) -> FinanceriskcomponentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_sum(s : FinanceriskcomponentCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_cursor_mean(s : FinanceriskcomponentCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_cursor_scale(s : FinanceriskcomponentCursor, f : Double) -> FinanceriskcomponentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_add(a : FinanceriskcomponentCursor, b : FinanceriskcomponentCursor) -> FinanceriskcomponentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_cursor_copy(s : FinanceriskcomponentCursor) -> FinanceriskcomponentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_fill(s : FinanceriskcomponentCursor, v : Double) -> FinanceriskcomponentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_cursor_min(s : FinanceriskcomponentCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_cursor_max(s : FinanceriskcomponentCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_cursor_to_string(s : FinanceriskcomponentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_view_make(size : Int) -> FinanceriskcomponentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_view_len(s : FinanceriskcomponentView) -> Int { s.size }

pub fn finance_risk_component_view_get(s : FinanceriskcomponentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_view_set(s : FinanceriskcomponentView, i : Int, v : Double) -> FinanceriskcomponentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_sum(s : FinanceriskcomponentView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_view_mean(s : FinanceriskcomponentView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_view_scale(s : FinanceriskcomponentView, f : Double) -> FinanceriskcomponentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_add(a : FinanceriskcomponentView, b : FinanceriskcomponentView) -> FinanceriskcomponentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_view_copy(s : FinanceriskcomponentView) -> FinanceriskcomponentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_fill(s : FinanceriskcomponentView, v : Double) -> FinanceriskcomponentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_view_min(s : FinanceriskcomponentView) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_view_max(s : FinanceriskcomponentView) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_view_to_string(s : FinanceriskcomponentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_range_make(size : Int) -> FinanceriskcomponentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_range_len(s : FinanceriskcomponentRange) -> Int { s.size }

pub fn finance_risk_component_range_get(s : FinanceriskcomponentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_range_set(s : FinanceriskcomponentRange, i : Int, v : Double) -> FinanceriskcomponentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_sum(s : FinanceriskcomponentRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_range_mean(s : FinanceriskcomponentRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_range_scale(s : FinanceriskcomponentRange, f : Double) -> FinanceriskcomponentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_add(a : FinanceriskcomponentRange, b : FinanceriskcomponentRange) -> FinanceriskcomponentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_range_copy(s : FinanceriskcomponentRange) -> FinanceriskcomponentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_fill(s : FinanceriskcomponentRange, v : Double) -> FinanceriskcomponentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_range_min(s : FinanceriskcomponentRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_range_max(s : FinanceriskcomponentRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_range_to_string(s : FinanceriskcomponentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcomponentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_component_slice_make(size : Int) -> FinanceriskcomponentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_component_slice_len(s : FinanceriskcomponentSlice) -> Int { s.size }

pub fn finance_risk_component_slice_get(s : FinanceriskcomponentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_component_slice_set(s : FinanceriskcomponentSlice, i : Int, v : Double) -> FinanceriskcomponentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_sum(s : FinanceriskcomponentSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_component_slice_mean(s : FinanceriskcomponentSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_component_slice_scale(s : FinanceriskcomponentSlice, f : Double) -> FinanceriskcomponentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_add(a : FinanceriskcomponentSlice, b : FinanceriskcomponentSlice) -> FinanceriskcomponentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_component_slice_copy(s : FinanceriskcomponentSlice) -> FinanceriskcomponentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_fill(s : FinanceriskcomponentSlice, v : Double) -> FinanceriskcomponentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_component_slice_min(s : FinanceriskcomponentSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_component_slice_max(s : FinanceriskcomponentSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_component_slice_to_string(s : FinanceriskcomponentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

