///===
/// extcore/finance_pricing_black_scholes

pub(all) struct FinancepricingblackscholesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_black_scholes_make_point(x : Double, y : Double) -> FinancepricingblackscholesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_black_scholes_make_point3(x : Double, y : Double, z : Double) -> FinancepricingblackscholesPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingblackscholesPoint::x(self : FinancepricingblackscholesPoint) -> Double { self.x }

pub fn FinancepricingblackscholesPoint::y(self : FinancepricingblackscholesPoint) -> Double { self.y }

pub fn FinancepricingblackscholesPoint::z(self : FinancepricingblackscholesPoint) -> Double { self.z }

pub fn FinancepricingblackscholesPoint::label(self : FinancepricingblackscholesPoint) -> Int { self.label }

pub fn FinancepricingblackscholesPoint::dist(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingblackscholesPoint::add(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingblackscholesPoint::sub(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingblackscholesPoint::scale(self : FinancepricingblackscholesPoint, s : Double) -> FinancepricingblackscholesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingblackscholesPoint::dot(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingblackscholesPoint::cross(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingblackscholesPoint::norm(self : FinancepricingblackscholesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingblackscholesPoint::normalize(self : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingblackscholesPoint::negate(self : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingblackscholesPoint::mid(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint) -> FinancepricingblackscholesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingblackscholesPoint::lerp(self : FinancepricingblackscholesPoint, other : FinancepricingblackscholesPoint, t : Double) -> FinancepricingblackscholesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingblackscholesPoint::to_string(self : FinancepricingblackscholesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_black_scholes_make_series(vals : Array[Double], name : String) -> FinancepricingblackscholesSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingblackscholesSeries::len(self : FinancepricingblackscholesSeries) -> Int { self.vals.length() }

pub fn FinancepricingblackscholesSeries::sum(self : FinancepricingblackscholesSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingblackscholesSeries::mean(self : FinancepricingblackscholesSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingblackscholesSeries::min(self : FinancepricingblackscholesSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingblackscholesSeries::max(self : FinancepricingblackscholesSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingblackscholesSeries::range(self : FinancepricingblackscholesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingblackscholesSeries::variance(self : FinancepricingblackscholesSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingblackscholesSeries::std(self : FinancepricingblackscholesSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingblackscholesSeries::median(self : FinancepricingblackscholesSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingblackscholesSeries::scale(self : FinancepricingblackscholesSeries, f : Double) -> FinancepricingblackscholesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::add(self : FinancepricingblackscholesSeries, other : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::sub(self : FinancepricingblackscholesSeries, other : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::normalize(self : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingblackscholesSeries::cumsum(self : FinancepricingblackscholesSeries) -> FinancepricingblackscholesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingblackscholesSeries::to_string(self : FinancepricingblackscholesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingblackscholesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_black_scholes_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingblackscholesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_black_scholes_matrix_identity(n : Int) -> FinancepricingblackscholesMatrix {
  let m = finance_pricing_black_scholes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingblackscholesMatrix::get(self : FinancepricingblackscholesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingblackscholesMatrix::transpose(self : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  let result = finance_pricing_black_scholes_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingblackscholesMatrix::add(self : FinancepricingblackscholesMatrix, other : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_black_scholes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingblackscholesMatrix::scale(self : FinancepricingblackscholesMatrix, s : Double) -> FinancepricingblackscholesMatrix {
  let result = finance_pricing_black_scholes_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingblackscholesMatrix::multiply(self : FinancepricingblackscholesMatrix, other : FinancepricingblackscholesMatrix) -> FinancepricingblackscholesMatrix {
  if self.cols != other.rows { return finance_pricing_black_scholes_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_black_scholes_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingblackscholesMatrix::trace(self : FinancepricingblackscholesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingblackscholesMatrix::det(self : FinancepricingblackscholesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingblackscholesMatrix::norm(self : FinancepricingblackscholesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingblackscholesMatrix::to_string(self : FinancepricingblackscholesMatrix) -> String {
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

pub(all) struct FinancepricingblackscholesVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_black_scholes_make_vector(comps : Array[Double]) -> FinancepricingblackscholesVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_black_scholes_vector_zero(dim : Int) -> FinancepricingblackscholesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingblackscholesVector::add(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingblackscholesVector::sub(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingblackscholesVector::scale(self : FinancepricingblackscholesVector, s : Double) -> FinancepricingblackscholesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingblackscholesVector::dot(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingblackscholesVector::norm(self : FinancepricingblackscholesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingblackscholesVector::normalize(self : FinancepricingblackscholesVector) -> FinancepricingblackscholesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingblackscholesVector::dist(self : FinancepricingblackscholesVector, other : FinancepricingblackscholesVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingblackscholesVector::to_string(self : FinancepricingblackscholesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_black_scholes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_black_scholes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_black_scholes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_black_scholes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_black_scholes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_black_scholes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_black_scholes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_black_scholes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_black_scholes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_black_scholes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_black_scholes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_black_scholes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_black_scholes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_black_scholes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_black_scholes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_black_scholes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_black_scholes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_black_scholes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_black_scholes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_black_scholes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_black_scholes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_black_scholes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_black_scholes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_black_scholes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_black_scholes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_black_scholes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_black_scholes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_black_scholes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_black_scholes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingblackscholesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_frame_make(size : Int) -> FinancepricingblackscholesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_frame_len(s : FinancepricingblackscholesFrame) -> Int { s.size }

pub fn finance_pricing_black_scholes_frame_get(s : FinancepricingblackscholesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_frame_set(s : FinancepricingblackscholesFrame, i : Int, v : Double) -> FinancepricingblackscholesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_frame_sum(s : FinancepricingblackscholesFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_frame_mean(s : FinancepricingblackscholesFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_frame_scale(s : FinancepricingblackscholesFrame, f : Double) -> FinancepricingblackscholesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_frame_add(a : FinancepricingblackscholesFrame, b : FinancepricingblackscholesFrame) -> FinancepricingblackscholesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_frame_copy(s : FinancepricingblackscholesFrame) -> FinancepricingblackscholesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_frame_fill(s : FinancepricingblackscholesFrame, v : Double) -> FinancepricingblackscholesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_frame_min(s : FinancepricingblackscholesFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_frame_max(s : FinancepricingblackscholesFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_frame_to_string(s : FinancepricingblackscholesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_table_make(size : Int) -> FinancepricingblackscholesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_table_len(s : FinancepricingblackscholesTable) -> Int { s.size }

pub fn finance_pricing_black_scholes_table_get(s : FinancepricingblackscholesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_table_set(s : FinancepricingblackscholesTable, i : Int, v : Double) -> FinancepricingblackscholesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_table_sum(s : FinancepricingblackscholesTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_table_mean(s : FinancepricingblackscholesTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_table_scale(s : FinancepricingblackscholesTable, f : Double) -> FinancepricingblackscholesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_table_add(a : FinancepricingblackscholesTable, b : FinancepricingblackscholesTable) -> FinancepricingblackscholesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_table_copy(s : FinancepricingblackscholesTable) -> FinancepricingblackscholesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_table_fill(s : FinancepricingblackscholesTable, v : Double) -> FinancepricingblackscholesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_table_min(s : FinancepricingblackscholesTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_table_max(s : FinancepricingblackscholesTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_table_to_string(s : FinancepricingblackscholesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_graphn_make(size : Int) -> FinancepricingblackscholesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_graphn_len(s : FinancepricingblackscholesGraphN) -> Int { s.size }

pub fn finance_pricing_black_scholes_graphn_get(s : FinancepricingblackscholesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_graphn_set(s : FinancepricingblackscholesGraphN, i : Int, v : Double) -> FinancepricingblackscholesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_graphn_sum(s : FinancepricingblackscholesGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_graphn_mean(s : FinancepricingblackscholesGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_graphn_scale(s : FinancepricingblackscholesGraphN, f : Double) -> FinancepricingblackscholesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_graphn_add(a : FinancepricingblackscholesGraphN, b : FinancepricingblackscholesGraphN) -> FinancepricingblackscholesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_graphn_copy(s : FinancepricingblackscholesGraphN) -> FinancepricingblackscholesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_graphn_fill(s : FinancepricingblackscholesGraphN, v : Double) -> FinancepricingblackscholesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_graphn_min(s : FinancepricingblackscholesGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_graphn_max(s : FinancepricingblackscholesGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_graphn_to_string(s : FinancepricingblackscholesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_node_make(size : Int) -> FinancepricingblackscholesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_node_len(s : FinancepricingblackscholesNode) -> Int { s.size }

pub fn finance_pricing_black_scholes_node_get(s : FinancepricingblackscholesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_node_set(s : FinancepricingblackscholesNode, i : Int, v : Double) -> FinancepricingblackscholesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_node_sum(s : FinancepricingblackscholesNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_node_mean(s : FinancepricingblackscholesNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_node_scale(s : FinancepricingblackscholesNode, f : Double) -> FinancepricingblackscholesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_node_add(a : FinancepricingblackscholesNode, b : FinancepricingblackscholesNode) -> FinancepricingblackscholesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_node_copy(s : FinancepricingblackscholesNode) -> FinancepricingblackscholesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_node_fill(s : FinancepricingblackscholesNode, v : Double) -> FinancepricingblackscholesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_node_min(s : FinancepricingblackscholesNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_node_max(s : FinancepricingblackscholesNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_node_to_string(s : FinancepricingblackscholesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_edge_make(size : Int) -> FinancepricingblackscholesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_edge_len(s : FinancepricingblackscholesEdge) -> Int { s.size }

pub fn finance_pricing_black_scholes_edge_get(s : FinancepricingblackscholesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_edge_set(s : FinancepricingblackscholesEdge, i : Int, v : Double) -> FinancepricingblackscholesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_edge_sum(s : FinancepricingblackscholesEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_edge_mean(s : FinancepricingblackscholesEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_edge_scale(s : FinancepricingblackscholesEdge, f : Double) -> FinancepricingblackscholesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_edge_add(a : FinancepricingblackscholesEdge, b : FinancepricingblackscholesEdge) -> FinancepricingblackscholesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_edge_copy(s : FinancepricingblackscholesEdge) -> FinancepricingblackscholesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_edge_fill(s : FinancepricingblackscholesEdge, v : Double) -> FinancepricingblackscholesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_edge_min(s : FinancepricingblackscholesEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_edge_max(s : FinancepricingblackscholesEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_edge_to_string(s : FinancepricingblackscholesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_path_make(size : Int) -> FinancepricingblackscholesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_path_len(s : FinancepricingblackscholesPath) -> Int { s.size }

pub fn finance_pricing_black_scholes_path_get(s : FinancepricingblackscholesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_path_set(s : FinancepricingblackscholesPath, i : Int, v : Double) -> FinancepricingblackscholesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_path_sum(s : FinancepricingblackscholesPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_path_mean(s : FinancepricingblackscholesPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_path_scale(s : FinancepricingblackscholesPath, f : Double) -> FinancepricingblackscholesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_path_add(a : FinancepricingblackscholesPath, b : FinancepricingblackscholesPath) -> FinancepricingblackscholesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_path_copy(s : FinancepricingblackscholesPath) -> FinancepricingblackscholesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_path_fill(s : FinancepricingblackscholesPath, v : Double) -> FinancepricingblackscholesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_path_min(s : FinancepricingblackscholesPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_path_max(s : FinancepricingblackscholesPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_path_to_string(s : FinancepricingblackscholesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_cluster_make(size : Int) -> FinancepricingblackscholesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_cluster_len(s : FinancepricingblackscholesCluster) -> Int { s.size }

pub fn finance_pricing_black_scholes_cluster_get(s : FinancepricingblackscholesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_cluster_set(s : FinancepricingblackscholesCluster, i : Int, v : Double) -> FinancepricingblackscholesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cluster_sum(s : FinancepricingblackscholesCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_cluster_mean(s : FinancepricingblackscholesCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_cluster_scale(s : FinancepricingblackscholesCluster, f : Double) -> FinancepricingblackscholesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cluster_add(a : FinancepricingblackscholesCluster, b : FinancepricingblackscholesCluster) -> FinancepricingblackscholesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_cluster_copy(s : FinancepricingblackscholesCluster) -> FinancepricingblackscholesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cluster_fill(s : FinancepricingblackscholesCluster, v : Double) -> FinancepricingblackscholesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cluster_min(s : FinancepricingblackscholesCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_cluster_max(s : FinancepricingblackscholesCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_cluster_to_string(s : FinancepricingblackscholesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_model_make(size : Int) -> FinancepricingblackscholesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_model_len(s : FinancepricingblackscholesModel) -> Int { s.size }

pub fn finance_pricing_black_scholes_model_get(s : FinancepricingblackscholesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_model_set(s : FinancepricingblackscholesModel, i : Int, v : Double) -> FinancepricingblackscholesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_model_sum(s : FinancepricingblackscholesModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_model_mean(s : FinancepricingblackscholesModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_model_scale(s : FinancepricingblackscholesModel, f : Double) -> FinancepricingblackscholesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_model_add(a : FinancepricingblackscholesModel, b : FinancepricingblackscholesModel) -> FinancepricingblackscholesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_model_copy(s : FinancepricingblackscholesModel) -> FinancepricingblackscholesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_model_fill(s : FinancepricingblackscholesModel, v : Double) -> FinancepricingblackscholesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_model_min(s : FinancepricingblackscholesModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_model_max(s : FinancepricingblackscholesModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_model_to_string(s : FinancepricingblackscholesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_layer_make(size : Int) -> FinancepricingblackscholesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_layer_len(s : FinancepricingblackscholesLayer) -> Int { s.size }

pub fn finance_pricing_black_scholes_layer_get(s : FinancepricingblackscholesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_layer_set(s : FinancepricingblackscholesLayer, i : Int, v : Double) -> FinancepricingblackscholesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_layer_sum(s : FinancepricingblackscholesLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_layer_mean(s : FinancepricingblackscholesLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_layer_scale(s : FinancepricingblackscholesLayer, f : Double) -> FinancepricingblackscholesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_layer_add(a : FinancepricingblackscholesLayer, b : FinancepricingblackscholesLayer) -> FinancepricingblackscholesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_layer_copy(s : FinancepricingblackscholesLayer) -> FinancepricingblackscholesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_layer_fill(s : FinancepricingblackscholesLayer, v : Double) -> FinancepricingblackscholesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_layer_min(s : FinancepricingblackscholesLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_layer_max(s : FinancepricingblackscholesLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_layer_to_string(s : FinancepricingblackscholesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_buffer_make(size : Int) -> FinancepricingblackscholesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_buffer_len(s : FinancepricingblackscholesBuffer) -> Int { s.size }

pub fn finance_pricing_black_scholes_buffer_get(s : FinancepricingblackscholesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_buffer_set(s : FinancepricingblackscholesBuffer, i : Int, v : Double) -> FinancepricingblackscholesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_buffer_sum(s : FinancepricingblackscholesBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_buffer_mean(s : FinancepricingblackscholesBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_buffer_scale(s : FinancepricingblackscholesBuffer, f : Double) -> FinancepricingblackscholesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_buffer_add(a : FinancepricingblackscholesBuffer, b : FinancepricingblackscholesBuffer) -> FinancepricingblackscholesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_buffer_copy(s : FinancepricingblackscholesBuffer) -> FinancepricingblackscholesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_buffer_fill(s : FinancepricingblackscholesBuffer, v : Double) -> FinancepricingblackscholesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_buffer_min(s : FinancepricingblackscholesBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_buffer_max(s : FinancepricingblackscholesBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_buffer_to_string(s : FinancepricingblackscholesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_cursor_make(size : Int) -> FinancepricingblackscholesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_cursor_len(s : FinancepricingblackscholesCursor) -> Int { s.size }

pub fn finance_pricing_black_scholes_cursor_get(s : FinancepricingblackscholesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_cursor_set(s : FinancepricingblackscholesCursor, i : Int, v : Double) -> FinancepricingblackscholesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cursor_sum(s : FinancepricingblackscholesCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_cursor_mean(s : FinancepricingblackscholesCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_cursor_scale(s : FinancepricingblackscholesCursor, f : Double) -> FinancepricingblackscholesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cursor_add(a : FinancepricingblackscholesCursor, b : FinancepricingblackscholesCursor) -> FinancepricingblackscholesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_cursor_copy(s : FinancepricingblackscholesCursor) -> FinancepricingblackscholesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cursor_fill(s : FinancepricingblackscholesCursor, v : Double) -> FinancepricingblackscholesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_cursor_min(s : FinancepricingblackscholesCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_cursor_max(s : FinancepricingblackscholesCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_cursor_to_string(s : FinancepricingblackscholesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_view_make(size : Int) -> FinancepricingblackscholesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_view_len(s : FinancepricingblackscholesView) -> Int { s.size }

pub fn finance_pricing_black_scholes_view_get(s : FinancepricingblackscholesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_view_set(s : FinancepricingblackscholesView, i : Int, v : Double) -> FinancepricingblackscholesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_view_sum(s : FinancepricingblackscholesView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_view_mean(s : FinancepricingblackscholesView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_view_scale(s : FinancepricingblackscholesView, f : Double) -> FinancepricingblackscholesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_view_add(a : FinancepricingblackscholesView, b : FinancepricingblackscholesView) -> FinancepricingblackscholesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_view_copy(s : FinancepricingblackscholesView) -> FinancepricingblackscholesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_view_fill(s : FinancepricingblackscholesView, v : Double) -> FinancepricingblackscholesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_view_min(s : FinancepricingblackscholesView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_view_max(s : FinancepricingblackscholesView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_view_to_string(s : FinancepricingblackscholesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_range_make(size : Int) -> FinancepricingblackscholesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_range_len(s : FinancepricingblackscholesRange) -> Int { s.size }

pub fn finance_pricing_black_scholes_range_get(s : FinancepricingblackscholesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_range_set(s : FinancepricingblackscholesRange, i : Int, v : Double) -> FinancepricingblackscholesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_range_sum(s : FinancepricingblackscholesRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_range_mean(s : FinancepricingblackscholesRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_range_scale(s : FinancepricingblackscholesRange, f : Double) -> FinancepricingblackscholesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_range_add(a : FinancepricingblackscholesRange, b : FinancepricingblackscholesRange) -> FinancepricingblackscholesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_range_copy(s : FinancepricingblackscholesRange) -> FinancepricingblackscholesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_range_fill(s : FinancepricingblackscholesRange, v : Double) -> FinancepricingblackscholesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_range_min(s : FinancepricingblackscholesRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_range_max(s : FinancepricingblackscholesRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_range_to_string(s : FinancepricingblackscholesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingblackscholesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_black_scholes_slice_make(size : Int) -> FinancepricingblackscholesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_black_scholes_slice_len(s : FinancepricingblackscholesSlice) -> Int { s.size }

pub fn finance_pricing_black_scholes_slice_get(s : FinancepricingblackscholesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_black_scholes_slice_set(s : FinancepricingblackscholesSlice, i : Int, v : Double) -> FinancepricingblackscholesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_slice_sum(s : FinancepricingblackscholesSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_black_scholes_slice_mean(s : FinancepricingblackscholesSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_black_scholes_slice_scale(s : FinancepricingblackscholesSlice, f : Double) -> FinancepricingblackscholesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_slice_add(a : FinancepricingblackscholesSlice, b : FinancepricingblackscholesSlice) -> FinancepricingblackscholesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_black_scholes_slice_copy(s : FinancepricingblackscholesSlice) -> FinancepricingblackscholesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_slice_fill(s : FinancepricingblackscholesSlice, v : Double) -> FinancepricingblackscholesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_black_scholes_slice_min(s : FinancepricingblackscholesSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_black_scholes_slice_max(s : FinancepricingblackscholesSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_black_scholes_slice_to_string(s : FinancepricingblackscholesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

