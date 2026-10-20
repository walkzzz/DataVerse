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

pub fn FinancepricingmontecarloFrame::len(self : FinancepricingmontecarloFrame) -> Int { self.size }

pub fn FinancepricingmontecarloFrame::get(self : FinancepricingmontecarloFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloFrame::set(self : FinancepricingmontecarloFrame, i : Int, v : Double) -> FinancepricingmontecarloFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloFrame::sum(self : FinancepricingmontecarloFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloFrame::mean(self : FinancepricingmontecarloFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloFrame::scale(self : FinancepricingmontecarloFrame, f : Double) -> FinancepricingmontecarloFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloFrame::add(self : FinancepricingmontecarloFrame, other : FinancepricingmontecarloFrame) -> FinancepricingmontecarloFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloFrame::copy(self : FinancepricingmontecarloFrame) -> FinancepricingmontecarloFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloFrame::fill(self : FinancepricingmontecarloFrame, v : Double) -> FinancepricingmontecarloFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloFrame::min(self : FinancepricingmontecarloFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloFrame::max(self : FinancepricingmontecarloFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloFrame::to_string(self : FinancepricingmontecarloFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_table_make(size : Int) -> FinancepricingmontecarloTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloTable::len(self : FinancepricingmontecarloTable) -> Int { self.size }

pub fn FinancepricingmontecarloTable::get(self : FinancepricingmontecarloTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloTable::set(self : FinancepricingmontecarloTable, i : Int, v : Double) -> FinancepricingmontecarloTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloTable::sum(self : FinancepricingmontecarloTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloTable::mean(self : FinancepricingmontecarloTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloTable::scale(self : FinancepricingmontecarloTable, f : Double) -> FinancepricingmontecarloTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloTable::add(self : FinancepricingmontecarloTable, other : FinancepricingmontecarloTable) -> FinancepricingmontecarloTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloTable::copy(self : FinancepricingmontecarloTable) -> FinancepricingmontecarloTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloTable::fill(self : FinancepricingmontecarloTable, v : Double) -> FinancepricingmontecarloTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloTable::min(self : FinancepricingmontecarloTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloTable::max(self : FinancepricingmontecarloTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloTable::to_string(self : FinancepricingmontecarloTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_graphn_make(size : Int) -> FinancepricingmontecarloGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloGraphN::len(self : FinancepricingmontecarloGraphN) -> Int { self.size }

pub fn FinancepricingmontecarloGraphN::get(self : FinancepricingmontecarloGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloGraphN::set(self : FinancepricingmontecarloGraphN, i : Int, v : Double) -> FinancepricingmontecarloGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloGraphN::sum(self : FinancepricingmontecarloGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloGraphN::mean(self : FinancepricingmontecarloGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloGraphN::scale(self : FinancepricingmontecarloGraphN, f : Double) -> FinancepricingmontecarloGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloGraphN::add(self : FinancepricingmontecarloGraphN, other : FinancepricingmontecarloGraphN) -> FinancepricingmontecarloGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloGraphN::copy(self : FinancepricingmontecarloGraphN) -> FinancepricingmontecarloGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloGraphN::fill(self : FinancepricingmontecarloGraphN, v : Double) -> FinancepricingmontecarloGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloGraphN::min(self : FinancepricingmontecarloGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloGraphN::max(self : FinancepricingmontecarloGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloGraphN::to_string(self : FinancepricingmontecarloGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_node_make(size : Int) -> FinancepricingmontecarloNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloNode::len(self : FinancepricingmontecarloNode) -> Int { self.size }

pub fn FinancepricingmontecarloNode::get(self : FinancepricingmontecarloNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloNode::set(self : FinancepricingmontecarloNode, i : Int, v : Double) -> FinancepricingmontecarloNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloNode::sum(self : FinancepricingmontecarloNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloNode::mean(self : FinancepricingmontecarloNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloNode::scale(self : FinancepricingmontecarloNode, f : Double) -> FinancepricingmontecarloNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloNode::add(self : FinancepricingmontecarloNode, other : FinancepricingmontecarloNode) -> FinancepricingmontecarloNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloNode::copy(self : FinancepricingmontecarloNode) -> FinancepricingmontecarloNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloNode::fill(self : FinancepricingmontecarloNode, v : Double) -> FinancepricingmontecarloNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloNode::min(self : FinancepricingmontecarloNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloNode::max(self : FinancepricingmontecarloNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloNode::to_string(self : FinancepricingmontecarloNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_edge_make(size : Int) -> FinancepricingmontecarloEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloEdge::len(self : FinancepricingmontecarloEdge) -> Int { self.size }

pub fn FinancepricingmontecarloEdge::get(self : FinancepricingmontecarloEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloEdge::set(self : FinancepricingmontecarloEdge, i : Int, v : Double) -> FinancepricingmontecarloEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloEdge::sum(self : FinancepricingmontecarloEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloEdge::mean(self : FinancepricingmontecarloEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloEdge::scale(self : FinancepricingmontecarloEdge, f : Double) -> FinancepricingmontecarloEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloEdge::add(self : FinancepricingmontecarloEdge, other : FinancepricingmontecarloEdge) -> FinancepricingmontecarloEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloEdge::copy(self : FinancepricingmontecarloEdge) -> FinancepricingmontecarloEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloEdge::fill(self : FinancepricingmontecarloEdge, v : Double) -> FinancepricingmontecarloEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloEdge::min(self : FinancepricingmontecarloEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloEdge::max(self : FinancepricingmontecarloEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloEdge::to_string(self : FinancepricingmontecarloEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_path_make(size : Int) -> FinancepricingmontecarloPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloPath::len(self : FinancepricingmontecarloPath) -> Int { self.size }

pub fn FinancepricingmontecarloPath::get(self : FinancepricingmontecarloPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloPath::set(self : FinancepricingmontecarloPath, i : Int, v : Double) -> FinancepricingmontecarloPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloPath::sum(self : FinancepricingmontecarloPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloPath::mean(self : FinancepricingmontecarloPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloPath::scale(self : FinancepricingmontecarloPath, f : Double) -> FinancepricingmontecarloPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloPath::add(self : FinancepricingmontecarloPath, other : FinancepricingmontecarloPath) -> FinancepricingmontecarloPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloPath::copy(self : FinancepricingmontecarloPath) -> FinancepricingmontecarloPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloPath::fill(self : FinancepricingmontecarloPath, v : Double) -> FinancepricingmontecarloPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloPath::min(self : FinancepricingmontecarloPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloPath::max(self : FinancepricingmontecarloPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloPath::to_string(self : FinancepricingmontecarloPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_cluster_make(size : Int) -> FinancepricingmontecarloCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloCluster::len(self : FinancepricingmontecarloCluster) -> Int { self.size }

pub fn FinancepricingmontecarloCluster::get(self : FinancepricingmontecarloCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloCluster::set(self : FinancepricingmontecarloCluster, i : Int, v : Double) -> FinancepricingmontecarloCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCluster::sum(self : FinancepricingmontecarloCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloCluster::mean(self : FinancepricingmontecarloCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloCluster::scale(self : FinancepricingmontecarloCluster, f : Double) -> FinancepricingmontecarloCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCluster::add(self : FinancepricingmontecarloCluster, other : FinancepricingmontecarloCluster) -> FinancepricingmontecarloCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloCluster::copy(self : FinancepricingmontecarloCluster) -> FinancepricingmontecarloCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCluster::fill(self : FinancepricingmontecarloCluster, v : Double) -> FinancepricingmontecarloCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCluster::min(self : FinancepricingmontecarloCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloCluster::max(self : FinancepricingmontecarloCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloCluster::to_string(self : FinancepricingmontecarloCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_model_make(size : Int) -> FinancepricingmontecarloModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloModel::len(self : FinancepricingmontecarloModel) -> Int { self.size }

pub fn FinancepricingmontecarloModel::get(self : FinancepricingmontecarloModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloModel::set(self : FinancepricingmontecarloModel, i : Int, v : Double) -> FinancepricingmontecarloModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloModel::sum(self : FinancepricingmontecarloModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloModel::mean(self : FinancepricingmontecarloModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloModel::scale(self : FinancepricingmontecarloModel, f : Double) -> FinancepricingmontecarloModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloModel::add(self : FinancepricingmontecarloModel, other : FinancepricingmontecarloModel) -> FinancepricingmontecarloModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloModel::copy(self : FinancepricingmontecarloModel) -> FinancepricingmontecarloModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloModel::fill(self : FinancepricingmontecarloModel, v : Double) -> FinancepricingmontecarloModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloModel::min(self : FinancepricingmontecarloModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloModel::max(self : FinancepricingmontecarloModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloModel::to_string(self : FinancepricingmontecarloModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_layer_make(size : Int) -> FinancepricingmontecarloLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloLayer::len(self : FinancepricingmontecarloLayer) -> Int { self.size }

pub fn FinancepricingmontecarloLayer::get(self : FinancepricingmontecarloLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloLayer::set(self : FinancepricingmontecarloLayer, i : Int, v : Double) -> FinancepricingmontecarloLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloLayer::sum(self : FinancepricingmontecarloLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloLayer::mean(self : FinancepricingmontecarloLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloLayer::scale(self : FinancepricingmontecarloLayer, f : Double) -> FinancepricingmontecarloLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloLayer::add(self : FinancepricingmontecarloLayer, other : FinancepricingmontecarloLayer) -> FinancepricingmontecarloLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloLayer::copy(self : FinancepricingmontecarloLayer) -> FinancepricingmontecarloLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloLayer::fill(self : FinancepricingmontecarloLayer, v : Double) -> FinancepricingmontecarloLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloLayer::min(self : FinancepricingmontecarloLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloLayer::max(self : FinancepricingmontecarloLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloLayer::to_string(self : FinancepricingmontecarloLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_buffer_make(size : Int) -> FinancepricingmontecarloBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloBuffer::len(self : FinancepricingmontecarloBuffer) -> Int { self.size }

pub fn FinancepricingmontecarloBuffer::get(self : FinancepricingmontecarloBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloBuffer::set(self : FinancepricingmontecarloBuffer, i : Int, v : Double) -> FinancepricingmontecarloBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloBuffer::sum(self : FinancepricingmontecarloBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloBuffer::mean(self : FinancepricingmontecarloBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloBuffer::scale(self : FinancepricingmontecarloBuffer, f : Double) -> FinancepricingmontecarloBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloBuffer::add(self : FinancepricingmontecarloBuffer, other : FinancepricingmontecarloBuffer) -> FinancepricingmontecarloBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloBuffer::copy(self : FinancepricingmontecarloBuffer) -> FinancepricingmontecarloBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloBuffer::fill(self : FinancepricingmontecarloBuffer, v : Double) -> FinancepricingmontecarloBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloBuffer::min(self : FinancepricingmontecarloBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloBuffer::max(self : FinancepricingmontecarloBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloBuffer::to_string(self : FinancepricingmontecarloBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_cursor_make(size : Int) -> FinancepricingmontecarloCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloCursor::len(self : FinancepricingmontecarloCursor) -> Int { self.size }

pub fn FinancepricingmontecarloCursor::get(self : FinancepricingmontecarloCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloCursor::set(self : FinancepricingmontecarloCursor, i : Int, v : Double) -> FinancepricingmontecarloCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCursor::sum(self : FinancepricingmontecarloCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloCursor::mean(self : FinancepricingmontecarloCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloCursor::scale(self : FinancepricingmontecarloCursor, f : Double) -> FinancepricingmontecarloCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCursor::add(self : FinancepricingmontecarloCursor, other : FinancepricingmontecarloCursor) -> FinancepricingmontecarloCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloCursor::copy(self : FinancepricingmontecarloCursor) -> FinancepricingmontecarloCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCursor::fill(self : FinancepricingmontecarloCursor, v : Double) -> FinancepricingmontecarloCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloCursor::min(self : FinancepricingmontecarloCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloCursor::max(self : FinancepricingmontecarloCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloCursor::to_string(self : FinancepricingmontecarloCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_view_make(size : Int) -> FinancepricingmontecarloView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloView::len(self : FinancepricingmontecarloView) -> Int { self.size }

pub fn FinancepricingmontecarloView::get(self : FinancepricingmontecarloView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloView::set(self : FinancepricingmontecarloView, i : Int, v : Double) -> FinancepricingmontecarloView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloView::sum(self : FinancepricingmontecarloView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloView::mean(self : FinancepricingmontecarloView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloView::scale(self : FinancepricingmontecarloView, f : Double) -> FinancepricingmontecarloView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloView::add(self : FinancepricingmontecarloView, other : FinancepricingmontecarloView) -> FinancepricingmontecarloView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloView::copy(self : FinancepricingmontecarloView) -> FinancepricingmontecarloView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloView::fill(self : FinancepricingmontecarloView, v : Double) -> FinancepricingmontecarloView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloView::min(self : FinancepricingmontecarloView) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloView::max(self : FinancepricingmontecarloView) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloView::to_string(self : FinancepricingmontecarloView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_range_make(size : Int) -> FinancepricingmontecarloRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloRange::len(self : FinancepricingmontecarloRange) -> Int { self.size }

pub fn FinancepricingmontecarloRange::get(self : FinancepricingmontecarloRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloRange::set(self : FinancepricingmontecarloRange, i : Int, v : Double) -> FinancepricingmontecarloRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloRange::sum(self : FinancepricingmontecarloRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloRange::mean(self : FinancepricingmontecarloRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloRange::scale(self : FinancepricingmontecarloRange, f : Double) -> FinancepricingmontecarloRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloRange::add(self : FinancepricingmontecarloRange, other : FinancepricingmontecarloRange) -> FinancepricingmontecarloRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloRange::copy(self : FinancepricingmontecarloRange) -> FinancepricingmontecarloRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloRange::fill(self : FinancepricingmontecarloRange, v : Double) -> FinancepricingmontecarloRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloRange::min(self : FinancepricingmontecarloRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloRange::max(self : FinancepricingmontecarloRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloRange::to_string(self : FinancepricingmontecarloRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingmontecarloSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_monte_carlo_slice_make(size : Int) -> FinancepricingmontecarloSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingmontecarloSlice::len(self : FinancepricingmontecarloSlice) -> Int { self.size }

pub fn FinancepricingmontecarloSlice::get(self : FinancepricingmontecarloSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingmontecarloSlice::set(self : FinancepricingmontecarloSlice, i : Int, v : Double) -> FinancepricingmontecarloSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloSlice::sum(self : FinancepricingmontecarloSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingmontecarloSlice::mean(self : FinancepricingmontecarloSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingmontecarloSlice::scale(self : FinancepricingmontecarloSlice, f : Double) -> FinancepricingmontecarloSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloSlice::add(self : FinancepricingmontecarloSlice, other : FinancepricingmontecarloSlice) -> FinancepricingmontecarloSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingmontecarloSlice::copy(self : FinancepricingmontecarloSlice) -> FinancepricingmontecarloSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloSlice::fill(self : FinancepricingmontecarloSlice, v : Double) -> FinancepricingmontecarloSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingmontecarloSlice::min(self : FinancepricingmontecarloSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingmontecarloSlice::max(self : FinancepricingmontecarloSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingmontecarloSlice::to_string(self : FinancepricingmontecarloSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

