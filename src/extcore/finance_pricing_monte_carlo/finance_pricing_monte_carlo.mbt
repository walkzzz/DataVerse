///===
/// extcore/finance_pricing_monte_carlo

pub(all) struct FinancepricingmontecarloPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_monte_carlo_make_point(x : Double, y : Double) -> FinancepricingmontecarloPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_monte_carlo_make_point3(x : Double, y : Double, z : Double) -> FinancepricingmontecarloPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingmontecarloPoint::x(self : FinancepricingmontecarloPoint) -> Double { self.x }

pub fn FinancepricingmontecarloPoint::y(self : FinancepricingmontecarloPoint) -> Double { self.y }

pub fn FinancepricingmontecarloPoint::z(self : FinancepricingmontecarloPoint) -> Double { self.z }

pub fn FinancepricingmontecarloPoint::label(self : FinancepricingmontecarloPoint) -> Int { self.label }

pub fn FinancepricingmontecarloPoint::dist(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingmontecarloPoint::add(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingmontecarloPoint::sub(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingmontecarloPoint::scale(self : FinancepricingmontecarloPoint, s : Double) -> FinancepricingmontecarloPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingmontecarloPoint::dot(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingmontecarloPoint::cross(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingmontecarloPoint::norm(self : FinancepricingmontecarloPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingmontecarloPoint::normalize(self : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingmontecarloPoint::negate(self : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingmontecarloPoint::mid(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint) -> FinancepricingmontecarloPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingmontecarloPoint::lerp(self : FinancepricingmontecarloPoint, other : FinancepricingmontecarloPoint, t : Double) -> FinancepricingmontecarloPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingmontecarloPoint::to_string(self : FinancepricingmontecarloPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_monte_carlo_make_series(vals : Array[Double], name : String) -> FinancepricingmontecarloSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingmontecarloSeries::len(self : FinancepricingmontecarloSeries) -> Int { self.vals.length() }

pub fn FinancepricingmontecarloSeries::sum(self : FinancepricingmontecarloSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingmontecarloSeries::mean(self : FinancepricingmontecarloSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingmontecarloSeries::min(self : FinancepricingmontecarloSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingmontecarloSeries::max(self : FinancepricingmontecarloSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingmontecarloSeries::range(self : FinancepricingmontecarloSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingmontecarloSeries::variance(self : FinancepricingmontecarloSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingmontecarloSeries::std(self : FinancepricingmontecarloSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingmontecarloSeries::median(self : FinancepricingmontecarloSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingmontecarloSeries::scale(self : FinancepricingmontecarloSeries, f : Double) -> FinancepricingmontecarloSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingmontecarloSeries::add(self : FinancepricingmontecarloSeries, other : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingmontecarloSeries::sub(self : FinancepricingmontecarloSeries, other : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingmontecarloSeries::normalize(self : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingmontecarloSeries::cumsum(self : FinancepricingmontecarloSeries) -> FinancepricingmontecarloSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingmontecarloSeries::to_string(self : FinancepricingmontecarloSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingmontecarloMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_monte_carlo_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingmontecarloMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_monte_carlo_matrix_identity(n : Int) -> FinancepricingmontecarloMatrix {
  let m = finance_pricing_monte_carlo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingmontecarloMatrix::get(self : FinancepricingmontecarloMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingmontecarloMatrix::transpose(self : FinancepricingmontecarloMatrix) -> FinancepricingmontecarloMatrix {
  let result = finance_pricing_monte_carlo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingmontecarloMatrix::add(self : FinancepricingmontecarloMatrix, other : FinancepricingmontecarloMatrix) -> FinancepricingmontecarloMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_monte_carlo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingmontecarloMatrix::scale(self : FinancepricingmontecarloMatrix, s : Double) -> FinancepricingmontecarloMatrix {
  let result = finance_pricing_monte_carlo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingmontecarloMatrix::multiply(self : FinancepricingmontecarloMatrix, other : FinancepricingmontecarloMatrix) -> FinancepricingmontecarloMatrix {
  if self.cols != other.rows { return finance_pricing_monte_carlo_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_monte_carlo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingmontecarloMatrix::trace(self : FinancepricingmontecarloMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingmontecarloMatrix::det(self : FinancepricingmontecarloMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingmontecarloMatrix::norm(self : FinancepricingmontecarloMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingmontecarloMatrix::to_string(self : FinancepricingmontecarloMatrix) -> String {
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

pub(all) struct FinancepricingmontecarloVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_monte_carlo_make_vector(comps : Array[Double]) -> FinancepricingmontecarloVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_monte_carlo_vector_zero(dim : Int) -> FinancepricingmontecarloVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingmontecarloVector::add(self : FinancepricingmontecarloVector, other : FinancepricingmontecarloVector) -> FinancepricingmontecarloVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingmontecarloVector::sub(self : FinancepricingmontecarloVector, other : FinancepricingmontecarloVector) -> FinancepricingmontecarloVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingmontecarloVector::scale(self : FinancepricingmontecarloVector, s : Double) -> FinancepricingmontecarloVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingmontecarloVector::dot(self : FinancepricingmontecarloVector, other : FinancepricingmontecarloVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingmontecarloVector::norm(self : FinancepricingmontecarloVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingmontecarloVector::normalize(self : FinancepricingmontecarloVector) -> FinancepricingmontecarloVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingmontecarloVector::dist(self : FinancepricingmontecarloVector, other : FinancepricingmontecarloVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingmontecarloVector::to_string(self : FinancepricingmontecarloVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_monte_carlo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_monte_carlo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_monte_carlo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_monte_carlo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_monte_carlo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_monte_carlo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_monte_carlo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_monte_carlo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_monte_carlo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_monte_carlo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_monte_carlo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_monte_carlo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_monte_carlo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_monte_carlo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_monte_carlo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_monte_carlo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_monte_carlo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_monte_carlo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_monte_carlo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_monte_carlo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_monte_carlo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_monte_carlo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_monte_carlo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_monte_carlo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_monte_carlo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_monte_carlo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_monte_carlo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_monte_carlo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_monte_carlo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingmontecarloFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_frame_make(size : Int) -> FinancepricingmontecarloFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_frame_len(s : FinancepricingmontecarloFrame) -> Int { s.size }

pub fn finance_pricing_monte_carlo_frame_get(s : FinancepricingmontecarloFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_frame_set(s : FinancepricingmontecarloFrame, i : Int, v : Double) -> FinancepricingmontecarloFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_frame_sum(s : FinancepricingmontecarloFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_frame_mean(s : FinancepricingmontecarloFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_frame_scale(s : FinancepricingmontecarloFrame, f : Double) -> FinancepricingmontecarloFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_frame_add(a : FinancepricingmontecarloFrame, b : FinancepricingmontecarloFrame) -> FinancepricingmontecarloFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_frame_copy(s : FinancepricingmontecarloFrame) -> FinancepricingmontecarloFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_frame_fill(s : FinancepricingmontecarloFrame, v : Double) -> FinancepricingmontecarloFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_frame_min(s : FinancepricingmontecarloFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_frame_max(s : FinancepricingmontecarloFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_frame_to_string(s : FinancepricingmontecarloFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_table_make(size : Int) -> FinancepricingmontecarloTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_table_len(s : FinancepricingmontecarloTable) -> Int { s.size }

pub fn finance_pricing_monte_carlo_table_get(s : FinancepricingmontecarloTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_table_set(s : FinancepricingmontecarloTable, i : Int, v : Double) -> FinancepricingmontecarloTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_table_sum(s : FinancepricingmontecarloTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_table_mean(s : FinancepricingmontecarloTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_table_scale(s : FinancepricingmontecarloTable, f : Double) -> FinancepricingmontecarloTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_table_add(a : FinancepricingmontecarloTable, b : FinancepricingmontecarloTable) -> FinancepricingmontecarloTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_table_copy(s : FinancepricingmontecarloTable) -> FinancepricingmontecarloTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_table_fill(s : FinancepricingmontecarloTable, v : Double) -> FinancepricingmontecarloTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_table_min(s : FinancepricingmontecarloTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_table_max(s : FinancepricingmontecarloTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_table_to_string(s : FinancepricingmontecarloTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_graphn_make(size : Int) -> FinancepricingmontecarloGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_graphn_len(s : FinancepricingmontecarloGraphN) -> Int { s.size }

pub fn finance_pricing_monte_carlo_graphn_get(s : FinancepricingmontecarloGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_graphn_set(s : FinancepricingmontecarloGraphN, i : Int, v : Double) -> FinancepricingmontecarloGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_graphn_sum(s : FinancepricingmontecarloGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_graphn_mean(s : FinancepricingmontecarloGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_graphn_scale(s : FinancepricingmontecarloGraphN, f : Double) -> FinancepricingmontecarloGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_graphn_add(a : FinancepricingmontecarloGraphN, b : FinancepricingmontecarloGraphN) -> FinancepricingmontecarloGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_graphn_copy(s : FinancepricingmontecarloGraphN) -> FinancepricingmontecarloGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_graphn_fill(s : FinancepricingmontecarloGraphN, v : Double) -> FinancepricingmontecarloGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_graphn_min(s : FinancepricingmontecarloGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_graphn_max(s : FinancepricingmontecarloGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_graphn_to_string(s : FinancepricingmontecarloGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_node_make(size : Int) -> FinancepricingmontecarloNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_node_len(s : FinancepricingmontecarloNode) -> Int { s.size }

pub fn finance_pricing_monte_carlo_node_get(s : FinancepricingmontecarloNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_node_set(s : FinancepricingmontecarloNode, i : Int, v : Double) -> FinancepricingmontecarloNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_node_sum(s : FinancepricingmontecarloNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_node_mean(s : FinancepricingmontecarloNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_node_scale(s : FinancepricingmontecarloNode, f : Double) -> FinancepricingmontecarloNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_node_add(a : FinancepricingmontecarloNode, b : FinancepricingmontecarloNode) -> FinancepricingmontecarloNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_node_copy(s : FinancepricingmontecarloNode) -> FinancepricingmontecarloNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_node_fill(s : FinancepricingmontecarloNode, v : Double) -> FinancepricingmontecarloNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_node_min(s : FinancepricingmontecarloNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_node_max(s : FinancepricingmontecarloNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_node_to_string(s : FinancepricingmontecarloNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_edge_make(size : Int) -> FinancepricingmontecarloEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_edge_len(s : FinancepricingmontecarloEdge) -> Int { s.size }

pub fn finance_pricing_monte_carlo_edge_get(s : FinancepricingmontecarloEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_edge_set(s : FinancepricingmontecarloEdge, i : Int, v : Double) -> FinancepricingmontecarloEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_edge_sum(s : FinancepricingmontecarloEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_edge_mean(s : FinancepricingmontecarloEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_edge_scale(s : FinancepricingmontecarloEdge, f : Double) -> FinancepricingmontecarloEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_edge_add(a : FinancepricingmontecarloEdge, b : FinancepricingmontecarloEdge) -> FinancepricingmontecarloEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_edge_copy(s : FinancepricingmontecarloEdge) -> FinancepricingmontecarloEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_edge_fill(s : FinancepricingmontecarloEdge, v : Double) -> FinancepricingmontecarloEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_edge_min(s : FinancepricingmontecarloEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_edge_max(s : FinancepricingmontecarloEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_edge_to_string(s : FinancepricingmontecarloEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_path_make(size : Int) -> FinancepricingmontecarloPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_path_len(s : FinancepricingmontecarloPath) -> Int { s.size }

pub fn finance_pricing_monte_carlo_path_get(s : FinancepricingmontecarloPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_path_set(s : FinancepricingmontecarloPath, i : Int, v : Double) -> FinancepricingmontecarloPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_path_sum(s : FinancepricingmontecarloPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_path_mean(s : FinancepricingmontecarloPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_path_scale(s : FinancepricingmontecarloPath, f : Double) -> FinancepricingmontecarloPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_path_add(a : FinancepricingmontecarloPath, b : FinancepricingmontecarloPath) -> FinancepricingmontecarloPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_path_copy(s : FinancepricingmontecarloPath) -> FinancepricingmontecarloPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_path_fill(s : FinancepricingmontecarloPath, v : Double) -> FinancepricingmontecarloPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_path_min(s : FinancepricingmontecarloPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_path_max(s : FinancepricingmontecarloPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_path_to_string(s : FinancepricingmontecarloPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_cluster_make(size : Int) -> FinancepricingmontecarloCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_cluster_len(s : FinancepricingmontecarloCluster) -> Int { s.size }

pub fn finance_pricing_monte_carlo_cluster_get(s : FinancepricingmontecarloCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_cluster_set(s : FinancepricingmontecarloCluster, i : Int, v : Double) -> FinancepricingmontecarloCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cluster_sum(s : FinancepricingmontecarloCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_cluster_mean(s : FinancepricingmontecarloCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_cluster_scale(s : FinancepricingmontecarloCluster, f : Double) -> FinancepricingmontecarloCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cluster_add(a : FinancepricingmontecarloCluster, b : FinancepricingmontecarloCluster) -> FinancepricingmontecarloCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_cluster_copy(s : FinancepricingmontecarloCluster) -> FinancepricingmontecarloCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cluster_fill(s : FinancepricingmontecarloCluster, v : Double) -> FinancepricingmontecarloCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cluster_min(s : FinancepricingmontecarloCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_cluster_max(s : FinancepricingmontecarloCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_cluster_to_string(s : FinancepricingmontecarloCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_model_make(size : Int) -> FinancepricingmontecarloModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_model_len(s : FinancepricingmontecarloModel) -> Int { s.size }

pub fn finance_pricing_monte_carlo_model_get(s : FinancepricingmontecarloModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_model_set(s : FinancepricingmontecarloModel, i : Int, v : Double) -> FinancepricingmontecarloModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_model_sum(s : FinancepricingmontecarloModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_model_mean(s : FinancepricingmontecarloModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_model_scale(s : FinancepricingmontecarloModel, f : Double) -> FinancepricingmontecarloModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_model_add(a : FinancepricingmontecarloModel, b : FinancepricingmontecarloModel) -> FinancepricingmontecarloModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_model_copy(s : FinancepricingmontecarloModel) -> FinancepricingmontecarloModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_model_fill(s : FinancepricingmontecarloModel, v : Double) -> FinancepricingmontecarloModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_model_min(s : FinancepricingmontecarloModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_model_max(s : FinancepricingmontecarloModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_model_to_string(s : FinancepricingmontecarloModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_layer_make(size : Int) -> FinancepricingmontecarloLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_layer_len(s : FinancepricingmontecarloLayer) -> Int { s.size }

pub fn finance_pricing_monte_carlo_layer_get(s : FinancepricingmontecarloLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_layer_set(s : FinancepricingmontecarloLayer, i : Int, v : Double) -> FinancepricingmontecarloLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_layer_sum(s : FinancepricingmontecarloLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_layer_mean(s : FinancepricingmontecarloLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_layer_scale(s : FinancepricingmontecarloLayer, f : Double) -> FinancepricingmontecarloLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_layer_add(a : FinancepricingmontecarloLayer, b : FinancepricingmontecarloLayer) -> FinancepricingmontecarloLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_layer_copy(s : FinancepricingmontecarloLayer) -> FinancepricingmontecarloLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_layer_fill(s : FinancepricingmontecarloLayer, v : Double) -> FinancepricingmontecarloLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_layer_min(s : FinancepricingmontecarloLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_layer_max(s : FinancepricingmontecarloLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_layer_to_string(s : FinancepricingmontecarloLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_buffer_make(size : Int) -> FinancepricingmontecarloBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_buffer_len(s : FinancepricingmontecarloBuffer) -> Int { s.size }

pub fn finance_pricing_monte_carlo_buffer_get(s : FinancepricingmontecarloBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_buffer_set(s : FinancepricingmontecarloBuffer, i : Int, v : Double) -> FinancepricingmontecarloBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_buffer_sum(s : FinancepricingmontecarloBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_buffer_mean(s : FinancepricingmontecarloBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_buffer_scale(s : FinancepricingmontecarloBuffer, f : Double) -> FinancepricingmontecarloBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_buffer_add(a : FinancepricingmontecarloBuffer, b : FinancepricingmontecarloBuffer) -> FinancepricingmontecarloBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_buffer_copy(s : FinancepricingmontecarloBuffer) -> FinancepricingmontecarloBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_buffer_fill(s : FinancepricingmontecarloBuffer, v : Double) -> FinancepricingmontecarloBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_buffer_min(s : FinancepricingmontecarloBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_buffer_max(s : FinancepricingmontecarloBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_buffer_to_string(s : FinancepricingmontecarloBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_cursor_make(size : Int) -> FinancepricingmontecarloCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_cursor_len(s : FinancepricingmontecarloCursor) -> Int { s.size }

pub fn finance_pricing_monte_carlo_cursor_get(s : FinancepricingmontecarloCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_cursor_set(s : FinancepricingmontecarloCursor, i : Int, v : Double) -> FinancepricingmontecarloCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cursor_sum(s : FinancepricingmontecarloCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_cursor_mean(s : FinancepricingmontecarloCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_cursor_scale(s : FinancepricingmontecarloCursor, f : Double) -> FinancepricingmontecarloCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cursor_add(a : FinancepricingmontecarloCursor, b : FinancepricingmontecarloCursor) -> FinancepricingmontecarloCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_cursor_copy(s : FinancepricingmontecarloCursor) -> FinancepricingmontecarloCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cursor_fill(s : FinancepricingmontecarloCursor, v : Double) -> FinancepricingmontecarloCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_cursor_min(s : FinancepricingmontecarloCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_cursor_max(s : FinancepricingmontecarloCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_cursor_to_string(s : FinancepricingmontecarloCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_view_make(size : Int) -> FinancepricingmontecarloView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_view_len(s : FinancepricingmontecarloView) -> Int { s.size }

pub fn finance_pricing_monte_carlo_view_get(s : FinancepricingmontecarloView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_view_set(s : FinancepricingmontecarloView, i : Int, v : Double) -> FinancepricingmontecarloView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_view_sum(s : FinancepricingmontecarloView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_view_mean(s : FinancepricingmontecarloView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_view_scale(s : FinancepricingmontecarloView, f : Double) -> FinancepricingmontecarloView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_view_add(a : FinancepricingmontecarloView, b : FinancepricingmontecarloView) -> FinancepricingmontecarloView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_view_copy(s : FinancepricingmontecarloView) -> FinancepricingmontecarloView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_view_fill(s : FinancepricingmontecarloView, v : Double) -> FinancepricingmontecarloView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_view_min(s : FinancepricingmontecarloView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_view_max(s : FinancepricingmontecarloView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_view_to_string(s : FinancepricingmontecarloView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_range_make(size : Int) -> FinancepricingmontecarloRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_range_len(s : FinancepricingmontecarloRange) -> Int { s.size }

pub fn finance_pricing_monte_carlo_range_get(s : FinancepricingmontecarloRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_range_set(s : FinancepricingmontecarloRange, i : Int, v : Double) -> FinancepricingmontecarloRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_range_sum(s : FinancepricingmontecarloRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_range_mean(s : FinancepricingmontecarloRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_range_scale(s : FinancepricingmontecarloRange, f : Double) -> FinancepricingmontecarloRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_range_add(a : FinancepricingmontecarloRange, b : FinancepricingmontecarloRange) -> FinancepricingmontecarloRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_range_copy(s : FinancepricingmontecarloRange) -> FinancepricingmontecarloRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_range_fill(s : FinancepricingmontecarloRange, v : Double) -> FinancepricingmontecarloRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_range_min(s : FinancepricingmontecarloRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_range_max(s : FinancepricingmontecarloRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_range_to_string(s : FinancepricingmontecarloRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_slice_make(size : Int) -> FinancepricingmontecarloSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_monte_carlo_slice_len(s : FinancepricingmontecarloSlice) -> Int { s.size }

pub fn finance_pricing_monte_carlo_slice_get(s : FinancepricingmontecarloSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_monte_carlo_slice_set(s : FinancepricingmontecarloSlice, i : Int, v : Double) -> FinancepricingmontecarloSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_slice_sum(s : FinancepricingmontecarloSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_monte_carlo_slice_mean(s : FinancepricingmontecarloSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_monte_carlo_slice_scale(s : FinancepricingmontecarloSlice, f : Double) -> FinancepricingmontecarloSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_slice_add(a : FinancepricingmontecarloSlice, b : FinancepricingmontecarloSlice) -> FinancepricingmontecarloSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_monte_carlo_slice_copy(s : FinancepricingmontecarloSlice) -> FinancepricingmontecarloSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_slice_fill(s : FinancepricingmontecarloSlice, v : Double) -> FinancepricingmontecarloSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_monte_carlo_slice_min(s : FinancepricingmontecarloSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_monte_carlo_slice_max(s : FinancepricingmontecarloSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_monte_carlo_slice_to_string(s : FinancepricingmontecarloSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

