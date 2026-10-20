///===
/// extcore/finance_risk_coherent

pub(all) struct FinanceriskcoherentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_coherent_make_point(x : Double, y : Double) -> FinanceriskcoherentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_coherent_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcoherentPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskcoherentPoint::x(self : FinanceriskcoherentPoint) -> Double { self.x }

pub fn FinanceriskcoherentPoint::y(self : FinanceriskcoherentPoint) -> Double { self.y }

pub fn FinanceriskcoherentPoint::z(self : FinanceriskcoherentPoint) -> Double { self.z }

pub fn FinanceriskcoherentPoint::label(self : FinanceriskcoherentPoint) -> Int { self.label }

pub fn FinanceriskcoherentPoint::dist(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskcoherentPoint::add(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskcoherentPoint::sub(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskcoherentPoint::scale(self : FinanceriskcoherentPoint, s : Double) -> FinanceriskcoherentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskcoherentPoint::dot(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskcoherentPoint::cross(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskcoherentPoint::norm(self : FinanceriskcoherentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskcoherentPoint::normalize(self : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcoherentPoint::negate(self : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskcoherentPoint::mid(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskcoherentPoint::lerp(self : FinanceriskcoherentPoint, other : FinanceriskcoherentPoint, t : Double) -> FinanceriskcoherentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskcoherentPoint::to_string(self : FinanceriskcoherentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskcoherentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_coherent_make_series(vals : Array[Double], name : String) -> FinanceriskcoherentSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskcoherentSeries::len(self : FinanceriskcoherentSeries) -> Int { self.vals.length() }

pub fn FinanceriskcoherentSeries::sum(self : FinanceriskcoherentSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskcoherentSeries::mean(self : FinanceriskcoherentSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskcoherentSeries::min(self : FinanceriskcoherentSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskcoherentSeries::max(self : FinanceriskcoherentSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskcoherentSeries::range(self : FinanceriskcoherentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskcoherentSeries::variance(self : FinanceriskcoherentSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskcoherentSeries::std(self : FinanceriskcoherentSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskcoherentSeries::median(self : FinanceriskcoherentSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskcoherentSeries::scale(self : FinanceriskcoherentSeries, f : Double) -> FinanceriskcoherentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskcoherentSeries::add(self : FinanceriskcoherentSeries, other : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskcoherentSeries::sub(self : FinanceriskcoherentSeries, other : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskcoherentSeries::normalize(self : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskcoherentSeries::cumsum(self : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskcoherentSeries::to_string(self : FinanceriskcoherentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcoherentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_coherent_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcoherentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_coherent_matrix_identity(n : Int) -> FinanceriskcoherentMatrix {
  let m = finance_risk_coherent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskcoherentMatrix::get(self : FinanceriskcoherentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskcoherentMatrix::transpose(self : FinanceriskcoherentMatrix) -> FinanceriskcoherentMatrix {
  let result = finance_risk_coherent_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskcoherentMatrix::add(self : FinanceriskcoherentMatrix, other : FinanceriskcoherentMatrix) -> FinanceriskcoherentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_coherent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskcoherentMatrix::scale(self : FinanceriskcoherentMatrix, s : Double) -> FinanceriskcoherentMatrix {
  let result = finance_risk_coherent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskcoherentMatrix::multiply(self : FinanceriskcoherentMatrix, other : FinanceriskcoherentMatrix) -> FinanceriskcoherentMatrix {
  if self.cols != other.rows { return finance_risk_coherent_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_coherent_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskcoherentMatrix::trace(self : FinanceriskcoherentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskcoherentMatrix::det(self : FinanceriskcoherentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskcoherentMatrix::norm(self : FinanceriskcoherentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskcoherentMatrix::to_string(self : FinanceriskcoherentMatrix) -> String {
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

pub(all) struct FinanceriskcoherentVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_coherent_make_vector(comps : Array[Double]) -> FinanceriskcoherentVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_coherent_vector_zero(dim : Int) -> FinanceriskcoherentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskcoherentVector::add(self : FinanceriskcoherentVector, other : FinanceriskcoherentVector) -> FinanceriskcoherentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcoherentVector::sub(self : FinanceriskcoherentVector, other : FinanceriskcoherentVector) -> FinanceriskcoherentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskcoherentVector::scale(self : FinanceriskcoherentVector, s : Double) -> FinanceriskcoherentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskcoherentVector::dot(self : FinanceriskcoherentVector, other : FinanceriskcoherentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskcoherentVector::norm(self : FinanceriskcoherentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskcoherentVector::normalize(self : FinanceriskcoherentVector) -> FinanceriskcoherentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskcoherentVector::dist(self : FinanceriskcoherentVector, other : FinanceriskcoherentVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskcoherentVector::to_string(self : FinanceriskcoherentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_coherent_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_coherent_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_coherent_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_coherent_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_coherent_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_coherent_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_coherent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_coherent_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_coherent_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_coherent_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_coherent_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_coherent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_coherent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_coherent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_coherent_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_coherent_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_coherent_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_coherent_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_coherent_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_coherent_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_coherent_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_coherent_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_coherent_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_coherent_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_coherent_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_coherent_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_coherent_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_coherent_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_coherent_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskcoherentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_frame_make(size : Int) -> FinanceriskcoherentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_frame_len(s : FinanceriskcoherentFrame) -> Int { s.size }

pub fn finance_risk_coherent_frame_get(s : FinanceriskcoherentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_frame_set(s : FinanceriskcoherentFrame, i : Int, v : Double) -> FinanceriskcoherentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_frame_sum(s : FinanceriskcoherentFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_frame_mean(s : FinanceriskcoherentFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_frame_scale(s : FinanceriskcoherentFrame, f : Double) -> FinanceriskcoherentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_frame_add(a : FinanceriskcoherentFrame, b : FinanceriskcoherentFrame) -> FinanceriskcoherentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_frame_copy(s : FinanceriskcoherentFrame) -> FinanceriskcoherentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_frame_fill(s : FinanceriskcoherentFrame, v : Double) -> FinanceriskcoherentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_frame_min(s : FinanceriskcoherentFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_frame_max(s : FinanceriskcoherentFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_frame_to_string(s : FinanceriskcoherentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_table_make(size : Int) -> FinanceriskcoherentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_table_len(s : FinanceriskcoherentTable) -> Int { s.size }

pub fn finance_risk_coherent_table_get(s : FinanceriskcoherentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_table_set(s : FinanceriskcoherentTable, i : Int, v : Double) -> FinanceriskcoherentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_table_sum(s : FinanceriskcoherentTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_table_mean(s : FinanceriskcoherentTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_table_scale(s : FinanceriskcoherentTable, f : Double) -> FinanceriskcoherentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_table_add(a : FinanceriskcoherentTable, b : FinanceriskcoherentTable) -> FinanceriskcoherentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_table_copy(s : FinanceriskcoherentTable) -> FinanceriskcoherentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_table_fill(s : FinanceriskcoherentTable, v : Double) -> FinanceriskcoherentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_table_min(s : FinanceriskcoherentTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_table_max(s : FinanceriskcoherentTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_table_to_string(s : FinanceriskcoherentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_graphn_make(size : Int) -> FinanceriskcoherentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_graphn_len(s : FinanceriskcoherentGraphN) -> Int { s.size }

pub fn finance_risk_coherent_graphn_get(s : FinanceriskcoherentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_graphn_set(s : FinanceriskcoherentGraphN, i : Int, v : Double) -> FinanceriskcoherentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_graphn_sum(s : FinanceriskcoherentGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_graphn_mean(s : FinanceriskcoherentGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_graphn_scale(s : FinanceriskcoherentGraphN, f : Double) -> FinanceriskcoherentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_graphn_add(a : FinanceriskcoherentGraphN, b : FinanceriskcoherentGraphN) -> FinanceriskcoherentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_graphn_copy(s : FinanceriskcoherentGraphN) -> FinanceriskcoherentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_graphn_fill(s : FinanceriskcoherentGraphN, v : Double) -> FinanceriskcoherentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_graphn_min(s : FinanceriskcoherentGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_graphn_max(s : FinanceriskcoherentGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_graphn_to_string(s : FinanceriskcoherentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_node_make(size : Int) -> FinanceriskcoherentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_node_len(s : FinanceriskcoherentNode) -> Int { s.size }

pub fn finance_risk_coherent_node_get(s : FinanceriskcoherentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_node_set(s : FinanceriskcoherentNode, i : Int, v : Double) -> FinanceriskcoherentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_node_sum(s : FinanceriskcoherentNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_node_mean(s : FinanceriskcoherentNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_node_scale(s : FinanceriskcoherentNode, f : Double) -> FinanceriskcoherentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_node_add(a : FinanceriskcoherentNode, b : FinanceriskcoherentNode) -> FinanceriskcoherentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_node_copy(s : FinanceriskcoherentNode) -> FinanceriskcoherentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_node_fill(s : FinanceriskcoherentNode, v : Double) -> FinanceriskcoherentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_node_min(s : FinanceriskcoherentNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_node_max(s : FinanceriskcoherentNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_node_to_string(s : FinanceriskcoherentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_edge_make(size : Int) -> FinanceriskcoherentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_edge_len(s : FinanceriskcoherentEdge) -> Int { s.size }

pub fn finance_risk_coherent_edge_get(s : FinanceriskcoherentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_edge_set(s : FinanceriskcoherentEdge, i : Int, v : Double) -> FinanceriskcoherentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_edge_sum(s : FinanceriskcoherentEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_edge_mean(s : FinanceriskcoherentEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_edge_scale(s : FinanceriskcoherentEdge, f : Double) -> FinanceriskcoherentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_edge_add(a : FinanceriskcoherentEdge, b : FinanceriskcoherentEdge) -> FinanceriskcoherentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_edge_copy(s : FinanceriskcoherentEdge) -> FinanceriskcoherentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_edge_fill(s : FinanceriskcoherentEdge, v : Double) -> FinanceriskcoherentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_edge_min(s : FinanceriskcoherentEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_edge_max(s : FinanceriskcoherentEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_edge_to_string(s : FinanceriskcoherentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_path_make(size : Int) -> FinanceriskcoherentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_path_len(s : FinanceriskcoherentPath) -> Int { s.size }

pub fn finance_risk_coherent_path_get(s : FinanceriskcoherentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_path_set(s : FinanceriskcoherentPath, i : Int, v : Double) -> FinanceriskcoherentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_path_sum(s : FinanceriskcoherentPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_path_mean(s : FinanceriskcoherentPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_path_scale(s : FinanceriskcoherentPath, f : Double) -> FinanceriskcoherentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_path_add(a : FinanceriskcoherentPath, b : FinanceriskcoherentPath) -> FinanceriskcoherentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_path_copy(s : FinanceriskcoherentPath) -> FinanceriskcoherentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_path_fill(s : FinanceriskcoherentPath, v : Double) -> FinanceriskcoherentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_path_min(s : FinanceriskcoherentPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_path_max(s : FinanceriskcoherentPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_path_to_string(s : FinanceriskcoherentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_cluster_make(size : Int) -> FinanceriskcoherentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_cluster_len(s : FinanceriskcoherentCluster) -> Int { s.size }

pub fn finance_risk_coherent_cluster_get(s : FinanceriskcoherentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_cluster_set(s : FinanceriskcoherentCluster, i : Int, v : Double) -> FinanceriskcoherentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cluster_sum(s : FinanceriskcoherentCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_cluster_mean(s : FinanceriskcoherentCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_cluster_scale(s : FinanceriskcoherentCluster, f : Double) -> FinanceriskcoherentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cluster_add(a : FinanceriskcoherentCluster, b : FinanceriskcoherentCluster) -> FinanceriskcoherentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_cluster_copy(s : FinanceriskcoherentCluster) -> FinanceriskcoherentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cluster_fill(s : FinanceriskcoherentCluster, v : Double) -> FinanceriskcoherentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cluster_min(s : FinanceriskcoherentCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_cluster_max(s : FinanceriskcoherentCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_cluster_to_string(s : FinanceriskcoherentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_model_make(size : Int) -> FinanceriskcoherentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_model_len(s : FinanceriskcoherentModel) -> Int { s.size }

pub fn finance_risk_coherent_model_get(s : FinanceriskcoherentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_model_set(s : FinanceriskcoherentModel, i : Int, v : Double) -> FinanceriskcoherentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_model_sum(s : FinanceriskcoherentModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_model_mean(s : FinanceriskcoherentModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_model_scale(s : FinanceriskcoherentModel, f : Double) -> FinanceriskcoherentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_model_add(a : FinanceriskcoherentModel, b : FinanceriskcoherentModel) -> FinanceriskcoherentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_model_copy(s : FinanceriskcoherentModel) -> FinanceriskcoherentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_model_fill(s : FinanceriskcoherentModel, v : Double) -> FinanceriskcoherentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_model_min(s : FinanceriskcoherentModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_model_max(s : FinanceriskcoherentModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_model_to_string(s : FinanceriskcoherentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_layer_make(size : Int) -> FinanceriskcoherentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_layer_len(s : FinanceriskcoherentLayer) -> Int { s.size }

pub fn finance_risk_coherent_layer_get(s : FinanceriskcoherentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_layer_set(s : FinanceriskcoherentLayer, i : Int, v : Double) -> FinanceriskcoherentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_layer_sum(s : FinanceriskcoherentLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_layer_mean(s : FinanceriskcoherentLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_layer_scale(s : FinanceriskcoherentLayer, f : Double) -> FinanceriskcoherentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_layer_add(a : FinanceriskcoherentLayer, b : FinanceriskcoherentLayer) -> FinanceriskcoherentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_layer_copy(s : FinanceriskcoherentLayer) -> FinanceriskcoherentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_layer_fill(s : FinanceriskcoherentLayer, v : Double) -> FinanceriskcoherentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_layer_min(s : FinanceriskcoherentLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_layer_max(s : FinanceriskcoherentLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_layer_to_string(s : FinanceriskcoherentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_buffer_make(size : Int) -> FinanceriskcoherentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_buffer_len(s : FinanceriskcoherentBuffer) -> Int { s.size }

pub fn finance_risk_coherent_buffer_get(s : FinanceriskcoherentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_buffer_set(s : FinanceriskcoherentBuffer, i : Int, v : Double) -> FinanceriskcoherentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_buffer_sum(s : FinanceriskcoherentBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_buffer_mean(s : FinanceriskcoherentBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_buffer_scale(s : FinanceriskcoherentBuffer, f : Double) -> FinanceriskcoherentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_buffer_add(a : FinanceriskcoherentBuffer, b : FinanceriskcoherentBuffer) -> FinanceriskcoherentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_buffer_copy(s : FinanceriskcoherentBuffer) -> FinanceriskcoherentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_buffer_fill(s : FinanceriskcoherentBuffer, v : Double) -> FinanceriskcoherentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_buffer_min(s : FinanceriskcoherentBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_buffer_max(s : FinanceriskcoherentBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_buffer_to_string(s : FinanceriskcoherentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_cursor_make(size : Int) -> FinanceriskcoherentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_cursor_len(s : FinanceriskcoherentCursor) -> Int { s.size }

pub fn finance_risk_coherent_cursor_get(s : FinanceriskcoherentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_cursor_set(s : FinanceriskcoherentCursor, i : Int, v : Double) -> FinanceriskcoherentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cursor_sum(s : FinanceriskcoherentCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_cursor_mean(s : FinanceriskcoherentCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_cursor_scale(s : FinanceriskcoherentCursor, f : Double) -> FinanceriskcoherentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cursor_add(a : FinanceriskcoherentCursor, b : FinanceriskcoherentCursor) -> FinanceriskcoherentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_cursor_copy(s : FinanceriskcoherentCursor) -> FinanceriskcoherentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cursor_fill(s : FinanceriskcoherentCursor, v : Double) -> FinanceriskcoherentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_cursor_min(s : FinanceriskcoherentCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_cursor_max(s : FinanceriskcoherentCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_cursor_to_string(s : FinanceriskcoherentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_view_make(size : Int) -> FinanceriskcoherentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_view_len(s : FinanceriskcoherentView) -> Int { s.size }

pub fn finance_risk_coherent_view_get(s : FinanceriskcoherentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_view_set(s : FinanceriskcoherentView, i : Int, v : Double) -> FinanceriskcoherentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_view_sum(s : FinanceriskcoherentView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_view_mean(s : FinanceriskcoherentView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_view_scale(s : FinanceriskcoherentView, f : Double) -> FinanceriskcoherentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_view_add(a : FinanceriskcoherentView, b : FinanceriskcoherentView) -> FinanceriskcoherentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_view_copy(s : FinanceriskcoherentView) -> FinanceriskcoherentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_view_fill(s : FinanceriskcoherentView, v : Double) -> FinanceriskcoherentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_view_min(s : FinanceriskcoherentView) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_view_max(s : FinanceriskcoherentView) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_view_to_string(s : FinanceriskcoherentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_range_make(size : Int) -> FinanceriskcoherentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_range_len(s : FinanceriskcoherentRange) -> Int { s.size }

pub fn finance_risk_coherent_range_get(s : FinanceriskcoherentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_range_set(s : FinanceriskcoherentRange, i : Int, v : Double) -> FinanceriskcoherentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_range_sum(s : FinanceriskcoherentRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_range_mean(s : FinanceriskcoherentRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_range_scale(s : FinanceriskcoherentRange, f : Double) -> FinanceriskcoherentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_range_add(a : FinanceriskcoherentRange, b : FinanceriskcoherentRange) -> FinanceriskcoherentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_range_copy(s : FinanceriskcoherentRange) -> FinanceriskcoherentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_range_fill(s : FinanceriskcoherentRange, v : Double) -> FinanceriskcoherentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_range_min(s : FinanceriskcoherentRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_range_max(s : FinanceriskcoherentRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_range_to_string(s : FinanceriskcoherentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_slice_make(size : Int) -> FinanceriskcoherentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_slice_len(s : FinanceriskcoherentSlice) -> Int { s.size }

pub fn finance_risk_coherent_slice_get(s : FinanceriskcoherentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_slice_set(s : FinanceriskcoherentSlice, i : Int, v : Double) -> FinanceriskcoherentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_slice_sum(s : FinanceriskcoherentSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_coherent_slice_mean(s : FinanceriskcoherentSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_coherent_slice_scale(s : FinanceriskcoherentSlice, f : Double) -> FinanceriskcoherentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_slice_add(a : FinanceriskcoherentSlice, b : FinanceriskcoherentSlice) -> FinanceriskcoherentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_coherent_slice_copy(s : FinanceriskcoherentSlice) -> FinanceriskcoherentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_slice_fill(s : FinanceriskcoherentSlice, v : Double) -> FinanceriskcoherentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_coherent_slice_min(s : FinanceriskcoherentSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_coherent_slice_max(s : FinanceriskcoherentSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_coherent_slice_to_string(s : FinanceriskcoherentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

