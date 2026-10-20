///===
/// extcore/finance_pricing_binomial

pub(all) struct FinancepricingbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_binomial_make_point(x : Double, y : Double) -> FinancepricingbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_binomial_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingbinomialPoint::x(self : FinancepricingbinomialPoint) -> Double { self.x }

pub fn FinancepricingbinomialPoint::y(self : FinancepricingbinomialPoint) -> Double { self.y }

pub fn FinancepricingbinomialPoint::z(self : FinancepricingbinomialPoint) -> Double { self.z }

pub fn FinancepricingbinomialPoint::label(self : FinancepricingbinomialPoint) -> Int { self.label }

pub fn FinancepricingbinomialPoint::dist(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingbinomialPoint::add(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingbinomialPoint::sub(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingbinomialPoint::scale(self : FinancepricingbinomialPoint, s : Double) -> FinancepricingbinomialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingbinomialPoint::dot(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingbinomialPoint::cross(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingbinomialPoint::norm(self : FinancepricingbinomialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingbinomialPoint::normalize(self : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbinomialPoint::negate(self : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingbinomialPoint::mid(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingbinomialPoint::lerp(self : FinancepricingbinomialPoint, other : FinancepricingbinomialPoint, t : Double) -> FinancepricingbinomialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingbinomialPoint::to_string(self : FinancepricingbinomialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_binomial_make_series(vals : Array[Double], name : String) -> FinancepricingbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingbinomialSeries::len(self : FinancepricingbinomialSeries) -> Int { self.vals.length() }

pub fn FinancepricingbinomialSeries::sum(self : FinancepricingbinomialSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingbinomialSeries::mean(self : FinancepricingbinomialSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingbinomialSeries::min(self : FinancepricingbinomialSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingbinomialSeries::max(self : FinancepricingbinomialSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingbinomialSeries::range(self : FinancepricingbinomialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingbinomialSeries::variance(self : FinancepricingbinomialSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingbinomialSeries::std(self : FinancepricingbinomialSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingbinomialSeries::median(self : FinancepricingbinomialSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingbinomialSeries::scale(self : FinancepricingbinomialSeries, f : Double) -> FinancepricingbinomialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingbinomialSeries::add(self : FinancepricingbinomialSeries, other : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingbinomialSeries::sub(self : FinancepricingbinomialSeries, other : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingbinomialSeries::normalize(self : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingbinomialSeries::cumsum(self : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingbinomialSeries::to_string(self : FinancepricingbinomialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_binomial_matrix_identity(n : Int) -> FinancepricingbinomialMatrix {
  let m = finance_pricing_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingbinomialMatrix::get(self : FinancepricingbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingbinomialMatrix::transpose(self : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  let result = finance_pricing_binomial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingbinomialMatrix::add(self : FinancepricingbinomialMatrix, other : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingbinomialMatrix::scale(self : FinancepricingbinomialMatrix, s : Double) -> FinancepricingbinomialMatrix {
  let result = finance_pricing_binomial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingbinomialMatrix::multiply(self : FinancepricingbinomialMatrix, other : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  if self.cols != other.rows { return finance_pricing_binomial_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_binomial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingbinomialMatrix::trace(self : FinancepricingbinomialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingbinomialMatrix::det(self : FinancepricingbinomialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingbinomialMatrix::norm(self : FinancepricingbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingbinomialMatrix::to_string(self : FinancepricingbinomialMatrix) -> String {
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

pub(all) struct FinancepricingbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_binomial_make_vector(comps : Array[Double]) -> FinancepricingbinomialVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_binomial_vector_zero(dim : Int) -> FinancepricingbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingbinomialVector::add(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbinomialVector::sub(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbinomialVector::scale(self : FinancepricingbinomialVector, s : Double) -> FinancepricingbinomialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingbinomialVector::dot(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingbinomialVector::norm(self : FinancepricingbinomialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingbinomialVector::normalize(self : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbinomialVector::dist(self : FinancepricingbinomialVector, other : FinancepricingbinomialVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingbinomialVector::to_string(self : FinancepricingbinomialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_binomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_binomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_binomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_binomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_binomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_binomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_binomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_binomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_binomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_binomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_binomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_binomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_binomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_binomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_binomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_binomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_binomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_binomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_binomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_frame_make(size : Int) -> FinancepricingbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_frame_len(s : FinancepricingbinomialFrame) -> Int { s.size }

pub fn finance_pricing_binomial_frame_get(s : FinancepricingbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_frame_set(s : FinancepricingbinomialFrame, i : Int, v : Double) -> FinancepricingbinomialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_frame_sum(s : FinancepricingbinomialFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_frame_mean(s : FinancepricingbinomialFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_frame_scale(s : FinancepricingbinomialFrame, f : Double) -> FinancepricingbinomialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_frame_add(a : FinancepricingbinomialFrame, b : FinancepricingbinomialFrame) -> FinancepricingbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_frame_copy(s : FinancepricingbinomialFrame) -> FinancepricingbinomialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_frame_fill(s : FinancepricingbinomialFrame, v : Double) -> FinancepricingbinomialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_frame_min(s : FinancepricingbinomialFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_frame_max(s : FinancepricingbinomialFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_frame_to_string(s : FinancepricingbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_table_make(size : Int) -> FinancepricingbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_table_len(s : FinancepricingbinomialTable) -> Int { s.size }

pub fn finance_pricing_binomial_table_get(s : FinancepricingbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_table_set(s : FinancepricingbinomialTable, i : Int, v : Double) -> FinancepricingbinomialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_table_sum(s : FinancepricingbinomialTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_table_mean(s : FinancepricingbinomialTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_table_scale(s : FinancepricingbinomialTable, f : Double) -> FinancepricingbinomialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_table_add(a : FinancepricingbinomialTable, b : FinancepricingbinomialTable) -> FinancepricingbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_table_copy(s : FinancepricingbinomialTable) -> FinancepricingbinomialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_table_fill(s : FinancepricingbinomialTable, v : Double) -> FinancepricingbinomialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_table_min(s : FinancepricingbinomialTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_table_max(s : FinancepricingbinomialTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_table_to_string(s : FinancepricingbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_graphn_make(size : Int) -> FinancepricingbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_graphn_len(s : FinancepricingbinomialGraphN) -> Int { s.size }

pub fn finance_pricing_binomial_graphn_get(s : FinancepricingbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_graphn_set(s : FinancepricingbinomialGraphN, i : Int, v : Double) -> FinancepricingbinomialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_graphn_sum(s : FinancepricingbinomialGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_graphn_mean(s : FinancepricingbinomialGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_graphn_scale(s : FinancepricingbinomialGraphN, f : Double) -> FinancepricingbinomialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_graphn_add(a : FinancepricingbinomialGraphN, b : FinancepricingbinomialGraphN) -> FinancepricingbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_graphn_copy(s : FinancepricingbinomialGraphN) -> FinancepricingbinomialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_graphn_fill(s : FinancepricingbinomialGraphN, v : Double) -> FinancepricingbinomialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_graphn_min(s : FinancepricingbinomialGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_graphn_max(s : FinancepricingbinomialGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_graphn_to_string(s : FinancepricingbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_node_make(size : Int) -> FinancepricingbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_node_len(s : FinancepricingbinomialNode) -> Int { s.size }

pub fn finance_pricing_binomial_node_get(s : FinancepricingbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_node_set(s : FinancepricingbinomialNode, i : Int, v : Double) -> FinancepricingbinomialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_node_sum(s : FinancepricingbinomialNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_node_mean(s : FinancepricingbinomialNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_node_scale(s : FinancepricingbinomialNode, f : Double) -> FinancepricingbinomialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_node_add(a : FinancepricingbinomialNode, b : FinancepricingbinomialNode) -> FinancepricingbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_node_copy(s : FinancepricingbinomialNode) -> FinancepricingbinomialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_node_fill(s : FinancepricingbinomialNode, v : Double) -> FinancepricingbinomialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_node_min(s : FinancepricingbinomialNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_node_max(s : FinancepricingbinomialNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_node_to_string(s : FinancepricingbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_edge_make(size : Int) -> FinancepricingbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_edge_len(s : FinancepricingbinomialEdge) -> Int { s.size }

pub fn finance_pricing_binomial_edge_get(s : FinancepricingbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_edge_set(s : FinancepricingbinomialEdge, i : Int, v : Double) -> FinancepricingbinomialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_edge_sum(s : FinancepricingbinomialEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_edge_mean(s : FinancepricingbinomialEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_edge_scale(s : FinancepricingbinomialEdge, f : Double) -> FinancepricingbinomialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_edge_add(a : FinancepricingbinomialEdge, b : FinancepricingbinomialEdge) -> FinancepricingbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_edge_copy(s : FinancepricingbinomialEdge) -> FinancepricingbinomialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_edge_fill(s : FinancepricingbinomialEdge, v : Double) -> FinancepricingbinomialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_edge_min(s : FinancepricingbinomialEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_edge_max(s : FinancepricingbinomialEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_edge_to_string(s : FinancepricingbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_path_make(size : Int) -> FinancepricingbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_path_len(s : FinancepricingbinomialPath) -> Int { s.size }

pub fn finance_pricing_binomial_path_get(s : FinancepricingbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_path_set(s : FinancepricingbinomialPath, i : Int, v : Double) -> FinancepricingbinomialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_path_sum(s : FinancepricingbinomialPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_path_mean(s : FinancepricingbinomialPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_path_scale(s : FinancepricingbinomialPath, f : Double) -> FinancepricingbinomialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_path_add(a : FinancepricingbinomialPath, b : FinancepricingbinomialPath) -> FinancepricingbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_path_copy(s : FinancepricingbinomialPath) -> FinancepricingbinomialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_path_fill(s : FinancepricingbinomialPath, v : Double) -> FinancepricingbinomialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_path_min(s : FinancepricingbinomialPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_path_max(s : FinancepricingbinomialPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_path_to_string(s : FinancepricingbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_cluster_make(size : Int) -> FinancepricingbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_cluster_len(s : FinancepricingbinomialCluster) -> Int { s.size }

pub fn finance_pricing_binomial_cluster_get(s : FinancepricingbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_cluster_set(s : FinancepricingbinomialCluster, i : Int, v : Double) -> FinancepricingbinomialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cluster_sum(s : FinancepricingbinomialCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_cluster_mean(s : FinancepricingbinomialCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_cluster_scale(s : FinancepricingbinomialCluster, f : Double) -> FinancepricingbinomialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cluster_add(a : FinancepricingbinomialCluster, b : FinancepricingbinomialCluster) -> FinancepricingbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_cluster_copy(s : FinancepricingbinomialCluster) -> FinancepricingbinomialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cluster_fill(s : FinancepricingbinomialCluster, v : Double) -> FinancepricingbinomialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cluster_min(s : FinancepricingbinomialCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_cluster_max(s : FinancepricingbinomialCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_cluster_to_string(s : FinancepricingbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_model_make(size : Int) -> FinancepricingbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_model_len(s : FinancepricingbinomialModel) -> Int { s.size }

pub fn finance_pricing_binomial_model_get(s : FinancepricingbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_model_set(s : FinancepricingbinomialModel, i : Int, v : Double) -> FinancepricingbinomialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_model_sum(s : FinancepricingbinomialModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_model_mean(s : FinancepricingbinomialModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_model_scale(s : FinancepricingbinomialModel, f : Double) -> FinancepricingbinomialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_model_add(a : FinancepricingbinomialModel, b : FinancepricingbinomialModel) -> FinancepricingbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_model_copy(s : FinancepricingbinomialModel) -> FinancepricingbinomialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_model_fill(s : FinancepricingbinomialModel, v : Double) -> FinancepricingbinomialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_model_min(s : FinancepricingbinomialModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_model_max(s : FinancepricingbinomialModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_model_to_string(s : FinancepricingbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_layer_make(size : Int) -> FinancepricingbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_layer_len(s : FinancepricingbinomialLayer) -> Int { s.size }

pub fn finance_pricing_binomial_layer_get(s : FinancepricingbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_layer_set(s : FinancepricingbinomialLayer, i : Int, v : Double) -> FinancepricingbinomialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_layer_sum(s : FinancepricingbinomialLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_layer_mean(s : FinancepricingbinomialLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_layer_scale(s : FinancepricingbinomialLayer, f : Double) -> FinancepricingbinomialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_layer_add(a : FinancepricingbinomialLayer, b : FinancepricingbinomialLayer) -> FinancepricingbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_layer_copy(s : FinancepricingbinomialLayer) -> FinancepricingbinomialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_layer_fill(s : FinancepricingbinomialLayer, v : Double) -> FinancepricingbinomialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_layer_min(s : FinancepricingbinomialLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_layer_max(s : FinancepricingbinomialLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_layer_to_string(s : FinancepricingbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_buffer_make(size : Int) -> FinancepricingbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_buffer_len(s : FinancepricingbinomialBuffer) -> Int { s.size }

pub fn finance_pricing_binomial_buffer_get(s : FinancepricingbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_buffer_set(s : FinancepricingbinomialBuffer, i : Int, v : Double) -> FinancepricingbinomialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_buffer_sum(s : FinancepricingbinomialBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_buffer_mean(s : FinancepricingbinomialBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_buffer_scale(s : FinancepricingbinomialBuffer, f : Double) -> FinancepricingbinomialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_buffer_add(a : FinancepricingbinomialBuffer, b : FinancepricingbinomialBuffer) -> FinancepricingbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_buffer_copy(s : FinancepricingbinomialBuffer) -> FinancepricingbinomialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_buffer_fill(s : FinancepricingbinomialBuffer, v : Double) -> FinancepricingbinomialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_buffer_min(s : FinancepricingbinomialBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_buffer_max(s : FinancepricingbinomialBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_buffer_to_string(s : FinancepricingbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_cursor_make(size : Int) -> FinancepricingbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_cursor_len(s : FinancepricingbinomialCursor) -> Int { s.size }

pub fn finance_pricing_binomial_cursor_get(s : FinancepricingbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_cursor_set(s : FinancepricingbinomialCursor, i : Int, v : Double) -> FinancepricingbinomialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cursor_sum(s : FinancepricingbinomialCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_cursor_mean(s : FinancepricingbinomialCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_cursor_scale(s : FinancepricingbinomialCursor, f : Double) -> FinancepricingbinomialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cursor_add(a : FinancepricingbinomialCursor, b : FinancepricingbinomialCursor) -> FinancepricingbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_cursor_copy(s : FinancepricingbinomialCursor) -> FinancepricingbinomialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cursor_fill(s : FinancepricingbinomialCursor, v : Double) -> FinancepricingbinomialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_cursor_min(s : FinancepricingbinomialCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_cursor_max(s : FinancepricingbinomialCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_cursor_to_string(s : FinancepricingbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_view_make(size : Int) -> FinancepricingbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_view_len(s : FinancepricingbinomialView) -> Int { s.size }

pub fn finance_pricing_binomial_view_get(s : FinancepricingbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_view_set(s : FinancepricingbinomialView, i : Int, v : Double) -> FinancepricingbinomialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_view_sum(s : FinancepricingbinomialView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_view_mean(s : FinancepricingbinomialView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_view_scale(s : FinancepricingbinomialView, f : Double) -> FinancepricingbinomialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_view_add(a : FinancepricingbinomialView, b : FinancepricingbinomialView) -> FinancepricingbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_view_copy(s : FinancepricingbinomialView) -> FinancepricingbinomialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_view_fill(s : FinancepricingbinomialView, v : Double) -> FinancepricingbinomialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_view_min(s : FinancepricingbinomialView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_view_max(s : FinancepricingbinomialView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_view_to_string(s : FinancepricingbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_range_make(size : Int) -> FinancepricingbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_range_len(s : FinancepricingbinomialRange) -> Int { s.size }

pub fn finance_pricing_binomial_range_get(s : FinancepricingbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_range_set(s : FinancepricingbinomialRange, i : Int, v : Double) -> FinancepricingbinomialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_range_sum(s : FinancepricingbinomialRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_range_mean(s : FinancepricingbinomialRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_range_scale(s : FinancepricingbinomialRange, f : Double) -> FinancepricingbinomialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_range_add(a : FinancepricingbinomialRange, b : FinancepricingbinomialRange) -> FinancepricingbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_range_copy(s : FinancepricingbinomialRange) -> FinancepricingbinomialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_range_fill(s : FinancepricingbinomialRange, v : Double) -> FinancepricingbinomialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_range_min(s : FinancepricingbinomialRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_range_max(s : FinancepricingbinomialRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_range_to_string(s : FinancepricingbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_slice_make(size : Int) -> FinancepricingbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_slice_len(s : FinancepricingbinomialSlice) -> Int { s.size }

pub fn finance_pricing_binomial_slice_get(s : FinancepricingbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_slice_set(s : FinancepricingbinomialSlice, i : Int, v : Double) -> FinancepricingbinomialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_slice_sum(s : FinancepricingbinomialSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_binomial_slice_mean(s : FinancepricingbinomialSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_binomial_slice_scale(s : FinancepricingbinomialSlice, f : Double) -> FinancepricingbinomialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_slice_add(a : FinancepricingbinomialSlice, b : FinancepricingbinomialSlice) -> FinancepricingbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_binomial_slice_copy(s : FinancepricingbinomialSlice) -> FinancepricingbinomialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_slice_fill(s : FinancepricingbinomialSlice, v : Double) -> FinancepricingbinomialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_binomial_slice_min(s : FinancepricingbinomialSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_binomial_slice_max(s : FinancepricingbinomialSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_binomial_slice_to_string(s : FinancepricingbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

