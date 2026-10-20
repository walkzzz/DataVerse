///===
/// extcore/finance_pricing_american

pub(all) struct FinancepricingamericanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_american_make_point(x : Double, y : Double) -> FinancepricingamericanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_american_make_point3(x : Double, y : Double, z : Double) -> FinancepricingamericanPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingamericanPoint::x(self : FinancepricingamericanPoint) -> Double { self.x }

pub fn FinancepricingamericanPoint::y(self : FinancepricingamericanPoint) -> Double { self.y }

pub fn FinancepricingamericanPoint::z(self : FinancepricingamericanPoint) -> Double { self.z }

pub fn FinancepricingamericanPoint::label(self : FinancepricingamericanPoint) -> Int { self.label }

pub fn FinancepricingamericanPoint::dist(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingamericanPoint::add(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingamericanPoint::sub(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingamericanPoint::scale(self : FinancepricingamericanPoint, s : Double) -> FinancepricingamericanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingamericanPoint::dot(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingamericanPoint::cross(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingamericanPoint::norm(self : FinancepricingamericanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingamericanPoint::normalize(self : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingamericanPoint::negate(self : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingamericanPoint::mid(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingamericanPoint::lerp(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint, t : Double) -> FinancepricingamericanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingamericanPoint::to_string(self : FinancepricingamericanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingamericanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_american_make_series(vals : Array[Double], name : String) -> FinancepricingamericanSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingamericanSeries::len(self : FinancepricingamericanSeries) -> Int { self.vals.length() }

pub fn FinancepricingamericanSeries::sum(self : FinancepricingamericanSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingamericanSeries::mean(self : FinancepricingamericanSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingamericanSeries::min(self : FinancepricingamericanSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingamericanSeries::max(self : FinancepricingamericanSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingamericanSeries::range(self : FinancepricingamericanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingamericanSeries::variance(self : FinancepricingamericanSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingamericanSeries::std(self : FinancepricingamericanSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingamericanSeries::median(self : FinancepricingamericanSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingamericanSeries::scale(self : FinancepricingamericanSeries, f : Double) -> FinancepricingamericanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingamericanSeries::add(self : FinancepricingamericanSeries, other : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingamericanSeries::sub(self : FinancepricingamericanSeries, other : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingamericanSeries::normalize(self : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingamericanSeries::cumsum(self : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingamericanSeries::to_string(self : FinancepricingamericanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingamericanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_american_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingamericanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_american_matrix_identity(n : Int) -> FinancepricingamericanMatrix {
  let m = finance_pricing_american_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingamericanMatrix::get(self : FinancepricingamericanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingamericanMatrix::transpose(self : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingamericanMatrix::add(self : FinancepricingamericanMatrix, other : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_american_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingamericanMatrix::scale(self : FinancepricingamericanMatrix, s : Double) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingamericanMatrix::multiply(self : FinancepricingamericanMatrix, other : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if self.cols != other.rows { return finance_pricing_american_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_american_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingamericanMatrix::trace(self : FinancepricingamericanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingamericanMatrix::det(self : FinancepricingamericanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingamericanMatrix::norm(self : FinancepricingamericanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingamericanMatrix::to_string(self : FinancepricingamericanMatrix) -> String {
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

pub(all) struct FinancepricingamericanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_american_make_vector(comps : Array[Double]) -> FinancepricingamericanVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_american_vector_zero(dim : Int) -> FinancepricingamericanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingamericanVector::add(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingamericanVector::sub(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingamericanVector::scale(self : FinancepricingamericanVector, s : Double) -> FinancepricingamericanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingamericanVector::dot(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingamericanVector::norm(self : FinancepricingamericanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingamericanVector::normalize(self : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingamericanVector::dist(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingamericanVector::to_string(self : FinancepricingamericanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_american_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_american_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_american_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_american_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_american_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_american_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_american_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_american_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_american_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_american_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_american_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_american_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_american_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_american_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_american_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_american_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_american_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_american_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_american_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_american_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_american_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_american_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_american_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_american_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_american_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_american_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_american_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_american_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_american_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingamericanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_frame_make(size : Int) -> FinancepricingamericanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanFrame::len(self : FinancepricingamericanFrame) -> Int { self.size }

pub fn FinancepricingamericanFrame::get(self : FinancepricingamericanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanFrame::set(self : FinancepricingamericanFrame, i : Int, v : Double) -> FinancepricingamericanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanFrame::sum(self : FinancepricingamericanFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanFrame::mean(self : FinancepricingamericanFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanFrame::scale(self : FinancepricingamericanFrame, f : Double) -> FinancepricingamericanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanFrame::add(self : FinancepricingamericanFrame, other : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanFrame::copy(self : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanFrame::fill(self : FinancepricingamericanFrame, v : Double) -> FinancepricingamericanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanFrame::min(self : FinancepricingamericanFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanFrame::max(self : FinancepricingamericanFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanFrame::to_string(self : FinancepricingamericanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_table_make(size : Int) -> FinancepricingamericanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanTable::len(self : FinancepricingamericanTable) -> Int { self.size }

pub fn FinancepricingamericanTable::get(self : FinancepricingamericanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanTable::set(self : FinancepricingamericanTable, i : Int, v : Double) -> FinancepricingamericanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanTable::sum(self : FinancepricingamericanTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanTable::mean(self : FinancepricingamericanTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanTable::scale(self : FinancepricingamericanTable, f : Double) -> FinancepricingamericanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanTable::add(self : FinancepricingamericanTable, other : FinancepricingamericanTable) -> FinancepricingamericanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanTable::copy(self : FinancepricingamericanTable) -> FinancepricingamericanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanTable::fill(self : FinancepricingamericanTable, v : Double) -> FinancepricingamericanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanTable::min(self : FinancepricingamericanTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanTable::max(self : FinancepricingamericanTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanTable::to_string(self : FinancepricingamericanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_graphn_make(size : Int) -> FinancepricingamericanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanGraphN::len(self : FinancepricingamericanGraphN) -> Int { self.size }

pub fn FinancepricingamericanGraphN::get(self : FinancepricingamericanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanGraphN::set(self : FinancepricingamericanGraphN, i : Int, v : Double) -> FinancepricingamericanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanGraphN::sum(self : FinancepricingamericanGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanGraphN::mean(self : FinancepricingamericanGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanGraphN::scale(self : FinancepricingamericanGraphN, f : Double) -> FinancepricingamericanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanGraphN::add(self : FinancepricingamericanGraphN, other : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanGraphN::copy(self : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanGraphN::fill(self : FinancepricingamericanGraphN, v : Double) -> FinancepricingamericanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanGraphN::min(self : FinancepricingamericanGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanGraphN::max(self : FinancepricingamericanGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanGraphN::to_string(self : FinancepricingamericanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_node_make(size : Int) -> FinancepricingamericanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanNode::len(self : FinancepricingamericanNode) -> Int { self.size }

pub fn FinancepricingamericanNode::get(self : FinancepricingamericanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanNode::set(self : FinancepricingamericanNode, i : Int, v : Double) -> FinancepricingamericanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanNode::sum(self : FinancepricingamericanNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanNode::mean(self : FinancepricingamericanNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanNode::scale(self : FinancepricingamericanNode, f : Double) -> FinancepricingamericanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanNode::add(self : FinancepricingamericanNode, other : FinancepricingamericanNode) -> FinancepricingamericanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanNode::copy(self : FinancepricingamericanNode) -> FinancepricingamericanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanNode::fill(self : FinancepricingamericanNode, v : Double) -> FinancepricingamericanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanNode::min(self : FinancepricingamericanNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanNode::max(self : FinancepricingamericanNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanNode::to_string(self : FinancepricingamericanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_edge_make(size : Int) -> FinancepricingamericanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanEdge::len(self : FinancepricingamericanEdge) -> Int { self.size }

pub fn FinancepricingamericanEdge::get(self : FinancepricingamericanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanEdge::set(self : FinancepricingamericanEdge, i : Int, v : Double) -> FinancepricingamericanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanEdge::sum(self : FinancepricingamericanEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanEdge::mean(self : FinancepricingamericanEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanEdge::scale(self : FinancepricingamericanEdge, f : Double) -> FinancepricingamericanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanEdge::add(self : FinancepricingamericanEdge, other : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanEdge::copy(self : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanEdge::fill(self : FinancepricingamericanEdge, v : Double) -> FinancepricingamericanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanEdge::min(self : FinancepricingamericanEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanEdge::max(self : FinancepricingamericanEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanEdge::to_string(self : FinancepricingamericanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_path_make(size : Int) -> FinancepricingamericanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanPath::len(self : FinancepricingamericanPath) -> Int { self.size }

pub fn FinancepricingamericanPath::get(self : FinancepricingamericanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanPath::set(self : FinancepricingamericanPath, i : Int, v : Double) -> FinancepricingamericanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanPath::sum(self : FinancepricingamericanPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanPath::mean(self : FinancepricingamericanPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanPath::scale(self : FinancepricingamericanPath, f : Double) -> FinancepricingamericanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanPath::add(self : FinancepricingamericanPath, other : FinancepricingamericanPath) -> FinancepricingamericanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanPath::copy(self : FinancepricingamericanPath) -> FinancepricingamericanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanPath::fill(self : FinancepricingamericanPath, v : Double) -> FinancepricingamericanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanPath::min(self : FinancepricingamericanPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanPath::max(self : FinancepricingamericanPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanPath::to_string(self : FinancepricingamericanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cluster_make(size : Int) -> FinancepricingamericanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanCluster::len(self : FinancepricingamericanCluster) -> Int { self.size }

pub fn FinancepricingamericanCluster::get(self : FinancepricingamericanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanCluster::set(self : FinancepricingamericanCluster, i : Int, v : Double) -> FinancepricingamericanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCluster::sum(self : FinancepricingamericanCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanCluster::mean(self : FinancepricingamericanCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanCluster::scale(self : FinancepricingamericanCluster, f : Double) -> FinancepricingamericanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCluster::add(self : FinancepricingamericanCluster, other : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanCluster::copy(self : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCluster::fill(self : FinancepricingamericanCluster, v : Double) -> FinancepricingamericanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCluster::min(self : FinancepricingamericanCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanCluster::max(self : FinancepricingamericanCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanCluster::to_string(self : FinancepricingamericanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_model_make(size : Int) -> FinancepricingamericanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanModel::len(self : FinancepricingamericanModel) -> Int { self.size }

pub fn FinancepricingamericanModel::get(self : FinancepricingamericanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanModel::set(self : FinancepricingamericanModel, i : Int, v : Double) -> FinancepricingamericanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanModel::sum(self : FinancepricingamericanModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanModel::mean(self : FinancepricingamericanModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanModel::scale(self : FinancepricingamericanModel, f : Double) -> FinancepricingamericanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanModel::add(self : FinancepricingamericanModel, other : FinancepricingamericanModel) -> FinancepricingamericanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanModel::copy(self : FinancepricingamericanModel) -> FinancepricingamericanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanModel::fill(self : FinancepricingamericanModel, v : Double) -> FinancepricingamericanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanModel::min(self : FinancepricingamericanModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanModel::max(self : FinancepricingamericanModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanModel::to_string(self : FinancepricingamericanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_layer_make(size : Int) -> FinancepricingamericanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanLayer::len(self : FinancepricingamericanLayer) -> Int { self.size }

pub fn FinancepricingamericanLayer::get(self : FinancepricingamericanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanLayer::set(self : FinancepricingamericanLayer, i : Int, v : Double) -> FinancepricingamericanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanLayer::sum(self : FinancepricingamericanLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanLayer::mean(self : FinancepricingamericanLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanLayer::scale(self : FinancepricingamericanLayer, f : Double) -> FinancepricingamericanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanLayer::add(self : FinancepricingamericanLayer, other : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanLayer::copy(self : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanLayer::fill(self : FinancepricingamericanLayer, v : Double) -> FinancepricingamericanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanLayer::min(self : FinancepricingamericanLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanLayer::max(self : FinancepricingamericanLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanLayer::to_string(self : FinancepricingamericanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_buffer_make(size : Int) -> FinancepricingamericanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanBuffer::len(self : FinancepricingamericanBuffer) -> Int { self.size }

pub fn FinancepricingamericanBuffer::get(self : FinancepricingamericanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanBuffer::set(self : FinancepricingamericanBuffer, i : Int, v : Double) -> FinancepricingamericanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanBuffer::sum(self : FinancepricingamericanBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanBuffer::mean(self : FinancepricingamericanBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanBuffer::scale(self : FinancepricingamericanBuffer, f : Double) -> FinancepricingamericanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanBuffer::add(self : FinancepricingamericanBuffer, other : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanBuffer::copy(self : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanBuffer::fill(self : FinancepricingamericanBuffer, v : Double) -> FinancepricingamericanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanBuffer::min(self : FinancepricingamericanBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanBuffer::max(self : FinancepricingamericanBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanBuffer::to_string(self : FinancepricingamericanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cursor_make(size : Int) -> FinancepricingamericanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanCursor::len(self : FinancepricingamericanCursor) -> Int { self.size }

pub fn FinancepricingamericanCursor::get(self : FinancepricingamericanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanCursor::set(self : FinancepricingamericanCursor, i : Int, v : Double) -> FinancepricingamericanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCursor::sum(self : FinancepricingamericanCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanCursor::mean(self : FinancepricingamericanCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanCursor::scale(self : FinancepricingamericanCursor, f : Double) -> FinancepricingamericanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCursor::add(self : FinancepricingamericanCursor, other : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanCursor::copy(self : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCursor::fill(self : FinancepricingamericanCursor, v : Double) -> FinancepricingamericanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanCursor::min(self : FinancepricingamericanCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanCursor::max(self : FinancepricingamericanCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanCursor::to_string(self : FinancepricingamericanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_view_make(size : Int) -> FinancepricingamericanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanView::len(self : FinancepricingamericanView) -> Int { self.size }

pub fn FinancepricingamericanView::get(self : FinancepricingamericanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanView::set(self : FinancepricingamericanView, i : Int, v : Double) -> FinancepricingamericanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanView::sum(self : FinancepricingamericanView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanView::mean(self : FinancepricingamericanView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanView::scale(self : FinancepricingamericanView, f : Double) -> FinancepricingamericanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanView::add(self : FinancepricingamericanView, other : FinancepricingamericanView) -> FinancepricingamericanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanView::copy(self : FinancepricingamericanView) -> FinancepricingamericanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanView::fill(self : FinancepricingamericanView, v : Double) -> FinancepricingamericanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanView::min(self : FinancepricingamericanView) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanView::max(self : FinancepricingamericanView) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanView::to_string(self : FinancepricingamericanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_range_make(size : Int) -> FinancepricingamericanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanRange::len(self : FinancepricingamericanRange) -> Int { self.size }

pub fn FinancepricingamericanRange::get(self : FinancepricingamericanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanRange::set(self : FinancepricingamericanRange, i : Int, v : Double) -> FinancepricingamericanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanRange::sum(self : FinancepricingamericanRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanRange::mean(self : FinancepricingamericanRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanRange::scale(self : FinancepricingamericanRange, f : Double) -> FinancepricingamericanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanRange::add(self : FinancepricingamericanRange, other : FinancepricingamericanRange) -> FinancepricingamericanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanRange::copy(self : FinancepricingamericanRange) -> FinancepricingamericanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanRange::fill(self : FinancepricingamericanRange, v : Double) -> FinancepricingamericanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanRange::min(self : FinancepricingamericanRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanRange::max(self : FinancepricingamericanRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanRange::to_string(self : FinancepricingamericanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_slice_make(size : Int) -> FinancepricingamericanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingamericanSlice::len(self : FinancepricingamericanSlice) -> Int { self.size }

pub fn FinancepricingamericanSlice::get(self : FinancepricingamericanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingamericanSlice::set(self : FinancepricingamericanSlice, i : Int, v : Double) -> FinancepricingamericanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanSlice::sum(self : FinancepricingamericanSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingamericanSlice::mean(self : FinancepricingamericanSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingamericanSlice::scale(self : FinancepricingamericanSlice, f : Double) -> FinancepricingamericanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanSlice::add(self : FinancepricingamericanSlice, other : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingamericanSlice::copy(self : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanSlice::fill(self : FinancepricingamericanSlice, v : Double) -> FinancepricingamericanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingamericanSlice::min(self : FinancepricingamericanSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingamericanSlice::max(self : FinancepricingamericanSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingamericanSlice::to_string(self : FinancepricingamericanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

