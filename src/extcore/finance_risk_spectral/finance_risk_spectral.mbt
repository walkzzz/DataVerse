///===
/// extcore/finance_risk_spectral

pub(all) struct FinanceriskspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_spectral_make_point(x : Double, y : Double) -> FinanceriskspectralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_spectral_make_point3(x : Double, y : Double, z : Double) -> FinanceriskspectralPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskspectralPoint::x(self : FinanceriskspectralPoint) -> Double { self.x }

pub fn FinanceriskspectralPoint::y(self : FinanceriskspectralPoint) -> Double { self.y }

pub fn FinanceriskspectralPoint::z(self : FinanceriskspectralPoint) -> Double { self.z }

pub fn FinanceriskspectralPoint::label(self : FinanceriskspectralPoint) -> Int { self.label }

pub fn FinanceriskspectralPoint::dist(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskspectralPoint::add(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskspectralPoint::sub(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskspectralPoint::scale(self : FinanceriskspectralPoint, s : Double) -> FinanceriskspectralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskspectralPoint::dot(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskspectralPoint::cross(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskspectralPoint::norm(self : FinanceriskspectralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskspectralPoint::normalize(self : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskspectralPoint::negate(self : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskspectralPoint::mid(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskspectralPoint::lerp(self : FinanceriskspectralPoint, other : FinanceriskspectralPoint, t : Double) -> FinanceriskspectralPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskspectralPoint::to_string(self : FinanceriskspectralPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_spectral_make_series(vals : Array[Double], name : String) -> FinanceriskspectralSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskspectralSeries::len(self : FinanceriskspectralSeries) -> Int { self.vals.length() }

pub fn FinanceriskspectralSeries::sum(self : FinanceriskspectralSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskspectralSeries::mean(self : FinanceriskspectralSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskspectralSeries::min(self : FinanceriskspectralSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskspectralSeries::max(self : FinanceriskspectralSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskspectralSeries::range(self : FinanceriskspectralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskspectralSeries::variance(self : FinanceriskspectralSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskspectralSeries::std(self : FinanceriskspectralSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskspectralSeries::median(self : FinanceriskspectralSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskspectralSeries::scale(self : FinanceriskspectralSeries, f : Double) -> FinanceriskspectralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskspectralSeries::add(self : FinanceriskspectralSeries, other : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskspectralSeries::sub(self : FinanceriskspectralSeries, other : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskspectralSeries::normalize(self : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskspectralSeries::cumsum(self : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskspectralSeries::to_string(self : FinanceriskspectralSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskspectralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_spectral_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskspectralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_spectral_matrix_identity(n : Int) -> FinanceriskspectralMatrix {
  let m = finance_risk_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskspectralMatrix::get(self : FinanceriskspectralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskspectralMatrix::transpose(self : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskspectralMatrix::add(self : FinanceriskspectralMatrix, other : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskspectralMatrix::scale(self : FinanceriskspectralMatrix, s : Double) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskspectralMatrix::multiply(self : FinanceriskspectralMatrix, other : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  if self.cols != other.rows { return finance_risk_spectral_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_spectral_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskspectralMatrix::trace(self : FinanceriskspectralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskspectralMatrix::det(self : FinanceriskspectralMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskspectralMatrix::norm(self : FinanceriskspectralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskspectralMatrix::to_string(self : FinanceriskspectralMatrix) -> String {
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

pub(all) struct FinanceriskspectralVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_spectral_make_vector(comps : Array[Double]) -> FinanceriskspectralVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_spectral_vector_zero(dim : Int) -> FinanceriskspectralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskspectralVector::add(self : FinanceriskspectralVector, other : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskspectralVector::sub(self : FinanceriskspectralVector, other : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskspectralVector::scale(self : FinanceriskspectralVector, s : Double) -> FinanceriskspectralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskspectralVector::dot(self : FinanceriskspectralVector, other : FinanceriskspectralVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskspectralVector::norm(self : FinanceriskspectralVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskspectralVector::normalize(self : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskspectralVector::dist(self : FinanceriskspectralVector, other : FinanceriskspectralVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskspectralVector::to_string(self : FinanceriskspectralVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_spectral_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_spectral_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_spectral_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_spectral_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_spectral_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_spectral_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_spectral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_spectral_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_spectral_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_spectral_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_spectral_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_spectral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_spectral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_spectral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_spectral_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_spectral_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_spectral_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_spectral_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_spectral_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_spectral_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_spectral_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_spectral_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_spectral_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_spectral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_spectral_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_spectral_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_spectral_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_spectral_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_spectral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskspectralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_frame_make(size : Int) -> FinanceriskspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_frame_len(s : FinanceriskspectralFrame) -> Int { s.size }

pub fn finance_risk_spectral_frame_get(s : FinanceriskspectralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_frame_set(s : FinanceriskspectralFrame, i : Int, v : Double) -> FinanceriskspectralFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_frame_sum(s : FinanceriskspectralFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_frame_mean(s : FinanceriskspectralFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_frame_scale(s : FinanceriskspectralFrame, f : Double) -> FinanceriskspectralFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_frame_add(a : FinanceriskspectralFrame, b : FinanceriskspectralFrame) -> FinanceriskspectralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_frame_copy(s : FinanceriskspectralFrame) -> FinanceriskspectralFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_frame_fill(s : FinanceriskspectralFrame, v : Double) -> FinanceriskspectralFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_frame_min(s : FinanceriskspectralFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_frame_max(s : FinanceriskspectralFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_frame_to_string(s : FinanceriskspectralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_table_make(size : Int) -> FinanceriskspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_table_len(s : FinanceriskspectralTable) -> Int { s.size }

pub fn finance_risk_spectral_table_get(s : FinanceriskspectralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_table_set(s : FinanceriskspectralTable, i : Int, v : Double) -> FinanceriskspectralTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_table_sum(s : FinanceriskspectralTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_table_mean(s : FinanceriskspectralTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_table_scale(s : FinanceriskspectralTable, f : Double) -> FinanceriskspectralTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_table_add(a : FinanceriskspectralTable, b : FinanceriskspectralTable) -> FinanceriskspectralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_table_copy(s : FinanceriskspectralTable) -> FinanceriskspectralTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_table_fill(s : FinanceriskspectralTable, v : Double) -> FinanceriskspectralTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_table_min(s : FinanceriskspectralTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_table_max(s : FinanceriskspectralTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_table_to_string(s : FinanceriskspectralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_graphn_make(size : Int) -> FinanceriskspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_graphn_len(s : FinanceriskspectralGraphN) -> Int { s.size }

pub fn finance_risk_spectral_graphn_get(s : FinanceriskspectralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_graphn_set(s : FinanceriskspectralGraphN, i : Int, v : Double) -> FinanceriskspectralGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_graphn_sum(s : FinanceriskspectralGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_graphn_mean(s : FinanceriskspectralGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_graphn_scale(s : FinanceriskspectralGraphN, f : Double) -> FinanceriskspectralGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_graphn_add(a : FinanceriskspectralGraphN, b : FinanceriskspectralGraphN) -> FinanceriskspectralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_graphn_copy(s : FinanceriskspectralGraphN) -> FinanceriskspectralGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_graphn_fill(s : FinanceriskspectralGraphN, v : Double) -> FinanceriskspectralGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_graphn_min(s : FinanceriskspectralGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_graphn_max(s : FinanceriskspectralGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_graphn_to_string(s : FinanceriskspectralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_node_make(size : Int) -> FinanceriskspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_node_len(s : FinanceriskspectralNode) -> Int { s.size }

pub fn finance_risk_spectral_node_get(s : FinanceriskspectralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_node_set(s : FinanceriskspectralNode, i : Int, v : Double) -> FinanceriskspectralNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_node_sum(s : FinanceriskspectralNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_node_mean(s : FinanceriskspectralNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_node_scale(s : FinanceriskspectralNode, f : Double) -> FinanceriskspectralNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_node_add(a : FinanceriskspectralNode, b : FinanceriskspectralNode) -> FinanceriskspectralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_node_copy(s : FinanceriskspectralNode) -> FinanceriskspectralNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_node_fill(s : FinanceriskspectralNode, v : Double) -> FinanceriskspectralNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_node_min(s : FinanceriskspectralNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_node_max(s : FinanceriskspectralNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_node_to_string(s : FinanceriskspectralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_edge_make(size : Int) -> FinanceriskspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_edge_len(s : FinanceriskspectralEdge) -> Int { s.size }

pub fn finance_risk_spectral_edge_get(s : FinanceriskspectralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_edge_set(s : FinanceriskspectralEdge, i : Int, v : Double) -> FinanceriskspectralEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_edge_sum(s : FinanceriskspectralEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_edge_mean(s : FinanceriskspectralEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_edge_scale(s : FinanceriskspectralEdge, f : Double) -> FinanceriskspectralEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_edge_add(a : FinanceriskspectralEdge, b : FinanceriskspectralEdge) -> FinanceriskspectralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_edge_copy(s : FinanceriskspectralEdge) -> FinanceriskspectralEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_edge_fill(s : FinanceriskspectralEdge, v : Double) -> FinanceriskspectralEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_edge_min(s : FinanceriskspectralEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_edge_max(s : FinanceriskspectralEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_edge_to_string(s : FinanceriskspectralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_path_make(size : Int) -> FinanceriskspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_path_len(s : FinanceriskspectralPath) -> Int { s.size }

pub fn finance_risk_spectral_path_get(s : FinanceriskspectralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_path_set(s : FinanceriskspectralPath, i : Int, v : Double) -> FinanceriskspectralPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_path_sum(s : FinanceriskspectralPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_path_mean(s : FinanceriskspectralPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_path_scale(s : FinanceriskspectralPath, f : Double) -> FinanceriskspectralPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_path_add(a : FinanceriskspectralPath, b : FinanceriskspectralPath) -> FinanceriskspectralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_path_copy(s : FinanceriskspectralPath) -> FinanceriskspectralPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_path_fill(s : FinanceriskspectralPath, v : Double) -> FinanceriskspectralPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_path_min(s : FinanceriskspectralPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_path_max(s : FinanceriskspectralPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_path_to_string(s : FinanceriskspectralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_cluster_make(size : Int) -> FinanceriskspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_cluster_len(s : FinanceriskspectralCluster) -> Int { s.size }

pub fn finance_risk_spectral_cluster_get(s : FinanceriskspectralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_cluster_set(s : FinanceriskspectralCluster, i : Int, v : Double) -> FinanceriskspectralCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cluster_sum(s : FinanceriskspectralCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_cluster_mean(s : FinanceriskspectralCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_cluster_scale(s : FinanceriskspectralCluster, f : Double) -> FinanceriskspectralCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cluster_add(a : FinanceriskspectralCluster, b : FinanceriskspectralCluster) -> FinanceriskspectralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_cluster_copy(s : FinanceriskspectralCluster) -> FinanceriskspectralCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cluster_fill(s : FinanceriskspectralCluster, v : Double) -> FinanceriskspectralCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cluster_min(s : FinanceriskspectralCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_cluster_max(s : FinanceriskspectralCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_cluster_to_string(s : FinanceriskspectralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_model_make(size : Int) -> FinanceriskspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_model_len(s : FinanceriskspectralModel) -> Int { s.size }

pub fn finance_risk_spectral_model_get(s : FinanceriskspectralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_model_set(s : FinanceriskspectralModel, i : Int, v : Double) -> FinanceriskspectralModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_model_sum(s : FinanceriskspectralModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_model_mean(s : FinanceriskspectralModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_model_scale(s : FinanceriskspectralModel, f : Double) -> FinanceriskspectralModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_model_add(a : FinanceriskspectralModel, b : FinanceriskspectralModel) -> FinanceriskspectralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_model_copy(s : FinanceriskspectralModel) -> FinanceriskspectralModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_model_fill(s : FinanceriskspectralModel, v : Double) -> FinanceriskspectralModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_model_min(s : FinanceriskspectralModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_model_max(s : FinanceriskspectralModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_model_to_string(s : FinanceriskspectralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_layer_make(size : Int) -> FinanceriskspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_layer_len(s : FinanceriskspectralLayer) -> Int { s.size }

pub fn finance_risk_spectral_layer_get(s : FinanceriskspectralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_layer_set(s : FinanceriskspectralLayer, i : Int, v : Double) -> FinanceriskspectralLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_layer_sum(s : FinanceriskspectralLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_layer_mean(s : FinanceriskspectralLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_layer_scale(s : FinanceriskspectralLayer, f : Double) -> FinanceriskspectralLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_layer_add(a : FinanceriskspectralLayer, b : FinanceriskspectralLayer) -> FinanceriskspectralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_layer_copy(s : FinanceriskspectralLayer) -> FinanceriskspectralLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_layer_fill(s : FinanceriskspectralLayer, v : Double) -> FinanceriskspectralLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_layer_min(s : FinanceriskspectralLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_layer_max(s : FinanceriskspectralLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_layer_to_string(s : FinanceriskspectralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_buffer_make(size : Int) -> FinanceriskspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_buffer_len(s : FinanceriskspectralBuffer) -> Int { s.size }

pub fn finance_risk_spectral_buffer_get(s : FinanceriskspectralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_buffer_set(s : FinanceriskspectralBuffer, i : Int, v : Double) -> FinanceriskspectralBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_buffer_sum(s : FinanceriskspectralBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_buffer_mean(s : FinanceriskspectralBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_buffer_scale(s : FinanceriskspectralBuffer, f : Double) -> FinanceriskspectralBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_buffer_add(a : FinanceriskspectralBuffer, b : FinanceriskspectralBuffer) -> FinanceriskspectralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_buffer_copy(s : FinanceriskspectralBuffer) -> FinanceriskspectralBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_buffer_fill(s : FinanceriskspectralBuffer, v : Double) -> FinanceriskspectralBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_buffer_min(s : FinanceriskspectralBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_buffer_max(s : FinanceriskspectralBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_buffer_to_string(s : FinanceriskspectralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_cursor_make(size : Int) -> FinanceriskspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_cursor_len(s : FinanceriskspectralCursor) -> Int { s.size }

pub fn finance_risk_spectral_cursor_get(s : FinanceriskspectralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_cursor_set(s : FinanceriskspectralCursor, i : Int, v : Double) -> FinanceriskspectralCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cursor_sum(s : FinanceriskspectralCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_cursor_mean(s : FinanceriskspectralCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_cursor_scale(s : FinanceriskspectralCursor, f : Double) -> FinanceriskspectralCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cursor_add(a : FinanceriskspectralCursor, b : FinanceriskspectralCursor) -> FinanceriskspectralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_cursor_copy(s : FinanceriskspectralCursor) -> FinanceriskspectralCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cursor_fill(s : FinanceriskspectralCursor, v : Double) -> FinanceriskspectralCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_cursor_min(s : FinanceriskspectralCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_cursor_max(s : FinanceriskspectralCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_cursor_to_string(s : FinanceriskspectralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_view_make(size : Int) -> FinanceriskspectralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_view_len(s : FinanceriskspectralView) -> Int { s.size }

pub fn finance_risk_spectral_view_get(s : FinanceriskspectralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_view_set(s : FinanceriskspectralView, i : Int, v : Double) -> FinanceriskspectralView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_view_sum(s : FinanceriskspectralView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_view_mean(s : FinanceriskspectralView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_view_scale(s : FinanceriskspectralView, f : Double) -> FinanceriskspectralView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_view_add(a : FinanceriskspectralView, b : FinanceriskspectralView) -> FinanceriskspectralView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_view_copy(s : FinanceriskspectralView) -> FinanceriskspectralView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_view_fill(s : FinanceriskspectralView, v : Double) -> FinanceriskspectralView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_view_min(s : FinanceriskspectralView) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_view_max(s : FinanceriskspectralView) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_view_to_string(s : FinanceriskspectralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_range_make(size : Int) -> FinanceriskspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_range_len(s : FinanceriskspectralRange) -> Int { s.size }

pub fn finance_risk_spectral_range_get(s : FinanceriskspectralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_range_set(s : FinanceriskspectralRange, i : Int, v : Double) -> FinanceriskspectralRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_range_sum(s : FinanceriskspectralRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_range_mean(s : FinanceriskspectralRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_range_scale(s : FinanceriskspectralRange, f : Double) -> FinanceriskspectralRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_range_add(a : FinanceriskspectralRange, b : FinanceriskspectralRange) -> FinanceriskspectralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_range_copy(s : FinanceriskspectralRange) -> FinanceriskspectralRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_range_fill(s : FinanceriskspectralRange, v : Double) -> FinanceriskspectralRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_range_min(s : FinanceriskspectralRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_range_max(s : FinanceriskspectralRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_range_to_string(s : FinanceriskspectralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_slice_make(size : Int) -> FinanceriskspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_slice_len(s : FinanceriskspectralSlice) -> Int { s.size }

pub fn finance_risk_spectral_slice_get(s : FinanceriskspectralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_slice_set(s : FinanceriskspectralSlice, i : Int, v : Double) -> FinanceriskspectralSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_slice_sum(s : FinanceriskspectralSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_spectral_slice_mean(s : FinanceriskspectralSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_spectral_slice_scale(s : FinanceriskspectralSlice, f : Double) -> FinanceriskspectralSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_slice_add(a : FinanceriskspectralSlice, b : FinanceriskspectralSlice) -> FinanceriskspectralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_spectral_slice_copy(s : FinanceriskspectralSlice) -> FinanceriskspectralSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_slice_fill(s : FinanceriskspectralSlice, v : Double) -> FinanceriskspectralSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_spectral_slice_min(s : FinanceriskspectralSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_spectral_slice_max(s : FinanceriskspectralSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_spectral_slice_to_string(s : FinanceriskspectralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

