///===
/// extcore/finance_pricing_lookback

pub(all) struct FinancepricinglookbackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_lookback_make_point(x : Double, y : Double) -> FinancepricinglookbackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_lookback_make_point3(x : Double, y : Double, z : Double) -> FinancepricinglookbackPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricinglookbackPoint::x(self : FinancepricinglookbackPoint) -> Double { self.x }

pub fn FinancepricinglookbackPoint::y(self : FinancepricinglookbackPoint) -> Double { self.y }

pub fn FinancepricinglookbackPoint::z(self : FinancepricinglookbackPoint) -> Double { self.z }

pub fn FinancepricinglookbackPoint::label(self : FinancepricinglookbackPoint) -> Int { self.label }

pub fn FinancepricinglookbackPoint::dist(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricinglookbackPoint::add(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricinglookbackPoint::sub(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricinglookbackPoint::scale(self : FinancepricinglookbackPoint, s : Double) -> FinancepricinglookbackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricinglookbackPoint::dot(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricinglookbackPoint::cross(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricinglookbackPoint::norm(self : FinancepricinglookbackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricinglookbackPoint::normalize(self : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricinglookbackPoint::negate(self : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricinglookbackPoint::mid(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricinglookbackPoint::lerp(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint, t : Double) -> FinancepricinglookbackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricinglookbackPoint::to_string(self : FinancepricinglookbackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricinglookbackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_lookback_make_series(vals : Array[Double], name : String) -> FinancepricinglookbackSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricinglookbackSeries::len(self : FinancepricinglookbackSeries) -> Int { self.vals.length() }

pub fn FinancepricinglookbackSeries::sum(self : FinancepricinglookbackSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricinglookbackSeries::mean(self : FinancepricinglookbackSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricinglookbackSeries::min(self : FinancepricinglookbackSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricinglookbackSeries::max(self : FinancepricinglookbackSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricinglookbackSeries::range(self : FinancepricinglookbackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricinglookbackSeries::variance(self : FinancepricinglookbackSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricinglookbackSeries::std(self : FinancepricinglookbackSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricinglookbackSeries::median(self : FinancepricinglookbackSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricinglookbackSeries::scale(self : FinancepricinglookbackSeries, f : Double) -> FinancepricinglookbackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricinglookbackSeries::add(self : FinancepricinglookbackSeries, other : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricinglookbackSeries::sub(self : FinancepricinglookbackSeries, other : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricinglookbackSeries::normalize(self : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricinglookbackSeries::cumsum(self : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricinglookbackSeries::to_string(self : FinancepricinglookbackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricinglookbackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_lookback_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricinglookbackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_lookback_matrix_identity(n : Int) -> FinancepricinglookbackMatrix {
  let m = finance_pricing_lookback_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricinglookbackMatrix::get(self : FinancepricinglookbackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricinglookbackMatrix::transpose(self : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  let result = finance_pricing_lookback_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricinglookbackMatrix::add(self : FinancepricinglookbackMatrix, other : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_lookback_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricinglookbackMatrix::scale(self : FinancepricinglookbackMatrix, s : Double) -> FinancepricinglookbackMatrix {
  let result = finance_pricing_lookback_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricinglookbackMatrix::multiply(self : FinancepricinglookbackMatrix, other : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  if self.cols != other.rows { return finance_pricing_lookback_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_lookback_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricinglookbackMatrix::trace(self : FinancepricinglookbackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricinglookbackMatrix::det(self : FinancepricinglookbackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricinglookbackMatrix::norm(self : FinancepricinglookbackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricinglookbackMatrix::to_string(self : FinancepricinglookbackMatrix) -> String {
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

pub(all) struct FinancepricinglookbackVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_lookback_make_vector(comps : Array[Double]) -> FinancepricinglookbackVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_lookback_vector_zero(dim : Int) -> FinancepricinglookbackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricinglookbackVector::add(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricinglookbackVector::sub(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricinglookbackVector::scale(self : FinancepricinglookbackVector, s : Double) -> FinancepricinglookbackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricinglookbackVector::dot(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricinglookbackVector::norm(self : FinancepricinglookbackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricinglookbackVector::normalize(self : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricinglookbackVector::dist(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricinglookbackVector::to_string(self : FinancepricinglookbackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_lookback_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_lookback_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_lookback_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_lookback_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_lookback_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_lookback_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_lookback_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_lookback_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_lookback_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_lookback_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_lookback_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_lookback_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_lookback_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_lookback_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_lookback_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_lookback_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_lookback_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_lookback_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_lookback_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_lookback_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_lookback_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_lookback_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_lookback_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_lookback_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_lookback_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_lookback_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_lookback_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_lookback_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_lookback_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricinglookbackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_frame_make(size : Int) -> FinancepricinglookbackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackFrame::len(self : FinancepricinglookbackFrame) -> Int { self.size }

pub fn FinancepricinglookbackFrame::get(self : FinancepricinglookbackFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackFrame::set(self : FinancepricinglookbackFrame, i : Int, v : Double) -> FinancepricinglookbackFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackFrame::sum(self : FinancepricinglookbackFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackFrame::mean(self : FinancepricinglookbackFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackFrame::scale(self : FinancepricinglookbackFrame, f : Double) -> FinancepricinglookbackFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackFrame::add(self : FinancepricinglookbackFrame, other : FinancepricinglookbackFrame) -> FinancepricinglookbackFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackFrame::copy(self : FinancepricinglookbackFrame) -> FinancepricinglookbackFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackFrame::fill(self : FinancepricinglookbackFrame, v : Double) -> FinancepricinglookbackFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackFrame::min(self : FinancepricinglookbackFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackFrame::max(self : FinancepricinglookbackFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackFrame::to_string(self : FinancepricinglookbackFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_table_make(size : Int) -> FinancepricinglookbackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackTable::len(self : FinancepricinglookbackTable) -> Int { self.size }

pub fn FinancepricinglookbackTable::get(self : FinancepricinglookbackTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackTable::set(self : FinancepricinglookbackTable, i : Int, v : Double) -> FinancepricinglookbackTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackTable::sum(self : FinancepricinglookbackTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackTable::mean(self : FinancepricinglookbackTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackTable::scale(self : FinancepricinglookbackTable, f : Double) -> FinancepricinglookbackTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackTable::add(self : FinancepricinglookbackTable, other : FinancepricinglookbackTable) -> FinancepricinglookbackTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackTable::copy(self : FinancepricinglookbackTable) -> FinancepricinglookbackTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackTable::fill(self : FinancepricinglookbackTable, v : Double) -> FinancepricinglookbackTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackTable::min(self : FinancepricinglookbackTable) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackTable::max(self : FinancepricinglookbackTable) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackTable::to_string(self : FinancepricinglookbackTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_graphn_make(size : Int) -> FinancepricinglookbackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackGraphN::len(self : FinancepricinglookbackGraphN) -> Int { self.size }

pub fn FinancepricinglookbackGraphN::get(self : FinancepricinglookbackGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackGraphN::set(self : FinancepricinglookbackGraphN, i : Int, v : Double) -> FinancepricinglookbackGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackGraphN::sum(self : FinancepricinglookbackGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackGraphN::mean(self : FinancepricinglookbackGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackGraphN::scale(self : FinancepricinglookbackGraphN, f : Double) -> FinancepricinglookbackGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackGraphN::add(self : FinancepricinglookbackGraphN, other : FinancepricinglookbackGraphN) -> FinancepricinglookbackGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackGraphN::copy(self : FinancepricinglookbackGraphN) -> FinancepricinglookbackGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackGraphN::fill(self : FinancepricinglookbackGraphN, v : Double) -> FinancepricinglookbackGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackGraphN::min(self : FinancepricinglookbackGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackGraphN::max(self : FinancepricinglookbackGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackGraphN::to_string(self : FinancepricinglookbackGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_node_make(size : Int) -> FinancepricinglookbackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackNode::len(self : FinancepricinglookbackNode) -> Int { self.size }

pub fn FinancepricinglookbackNode::get(self : FinancepricinglookbackNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackNode::set(self : FinancepricinglookbackNode, i : Int, v : Double) -> FinancepricinglookbackNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackNode::sum(self : FinancepricinglookbackNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackNode::mean(self : FinancepricinglookbackNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackNode::scale(self : FinancepricinglookbackNode, f : Double) -> FinancepricinglookbackNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackNode::add(self : FinancepricinglookbackNode, other : FinancepricinglookbackNode) -> FinancepricinglookbackNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackNode::copy(self : FinancepricinglookbackNode) -> FinancepricinglookbackNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackNode::fill(self : FinancepricinglookbackNode, v : Double) -> FinancepricinglookbackNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackNode::min(self : FinancepricinglookbackNode) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackNode::max(self : FinancepricinglookbackNode) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackNode::to_string(self : FinancepricinglookbackNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_edge_make(size : Int) -> FinancepricinglookbackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackEdge::len(self : FinancepricinglookbackEdge) -> Int { self.size }

pub fn FinancepricinglookbackEdge::get(self : FinancepricinglookbackEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackEdge::set(self : FinancepricinglookbackEdge, i : Int, v : Double) -> FinancepricinglookbackEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackEdge::sum(self : FinancepricinglookbackEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackEdge::mean(self : FinancepricinglookbackEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackEdge::scale(self : FinancepricinglookbackEdge, f : Double) -> FinancepricinglookbackEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackEdge::add(self : FinancepricinglookbackEdge, other : FinancepricinglookbackEdge) -> FinancepricinglookbackEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackEdge::copy(self : FinancepricinglookbackEdge) -> FinancepricinglookbackEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackEdge::fill(self : FinancepricinglookbackEdge, v : Double) -> FinancepricinglookbackEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackEdge::min(self : FinancepricinglookbackEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackEdge::max(self : FinancepricinglookbackEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackEdge::to_string(self : FinancepricinglookbackEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_path_make(size : Int) -> FinancepricinglookbackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackPath::len(self : FinancepricinglookbackPath) -> Int { self.size }

pub fn FinancepricinglookbackPath::get(self : FinancepricinglookbackPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackPath::set(self : FinancepricinglookbackPath, i : Int, v : Double) -> FinancepricinglookbackPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackPath::sum(self : FinancepricinglookbackPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackPath::mean(self : FinancepricinglookbackPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackPath::scale(self : FinancepricinglookbackPath, f : Double) -> FinancepricinglookbackPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackPath::add(self : FinancepricinglookbackPath, other : FinancepricinglookbackPath) -> FinancepricinglookbackPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackPath::copy(self : FinancepricinglookbackPath) -> FinancepricinglookbackPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackPath::fill(self : FinancepricinglookbackPath, v : Double) -> FinancepricinglookbackPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackPath::min(self : FinancepricinglookbackPath) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackPath::max(self : FinancepricinglookbackPath) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackPath::to_string(self : FinancepricinglookbackPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_cluster_make(size : Int) -> FinancepricinglookbackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackCluster::len(self : FinancepricinglookbackCluster) -> Int { self.size }

pub fn FinancepricinglookbackCluster::get(self : FinancepricinglookbackCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackCluster::set(self : FinancepricinglookbackCluster, i : Int, v : Double) -> FinancepricinglookbackCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCluster::sum(self : FinancepricinglookbackCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackCluster::mean(self : FinancepricinglookbackCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackCluster::scale(self : FinancepricinglookbackCluster, f : Double) -> FinancepricinglookbackCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCluster::add(self : FinancepricinglookbackCluster, other : FinancepricinglookbackCluster) -> FinancepricinglookbackCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackCluster::copy(self : FinancepricinglookbackCluster) -> FinancepricinglookbackCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCluster::fill(self : FinancepricinglookbackCluster, v : Double) -> FinancepricinglookbackCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCluster::min(self : FinancepricinglookbackCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackCluster::max(self : FinancepricinglookbackCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackCluster::to_string(self : FinancepricinglookbackCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_model_make(size : Int) -> FinancepricinglookbackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackModel::len(self : FinancepricinglookbackModel) -> Int { self.size }

pub fn FinancepricinglookbackModel::get(self : FinancepricinglookbackModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackModel::set(self : FinancepricinglookbackModel, i : Int, v : Double) -> FinancepricinglookbackModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackModel::sum(self : FinancepricinglookbackModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackModel::mean(self : FinancepricinglookbackModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackModel::scale(self : FinancepricinglookbackModel, f : Double) -> FinancepricinglookbackModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackModel::add(self : FinancepricinglookbackModel, other : FinancepricinglookbackModel) -> FinancepricinglookbackModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackModel::copy(self : FinancepricinglookbackModel) -> FinancepricinglookbackModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackModel::fill(self : FinancepricinglookbackModel, v : Double) -> FinancepricinglookbackModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackModel::min(self : FinancepricinglookbackModel) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackModel::max(self : FinancepricinglookbackModel) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackModel::to_string(self : FinancepricinglookbackModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_layer_make(size : Int) -> FinancepricinglookbackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackLayer::len(self : FinancepricinglookbackLayer) -> Int { self.size }

pub fn FinancepricinglookbackLayer::get(self : FinancepricinglookbackLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackLayer::set(self : FinancepricinglookbackLayer, i : Int, v : Double) -> FinancepricinglookbackLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackLayer::sum(self : FinancepricinglookbackLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackLayer::mean(self : FinancepricinglookbackLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackLayer::scale(self : FinancepricinglookbackLayer, f : Double) -> FinancepricinglookbackLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackLayer::add(self : FinancepricinglookbackLayer, other : FinancepricinglookbackLayer) -> FinancepricinglookbackLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackLayer::copy(self : FinancepricinglookbackLayer) -> FinancepricinglookbackLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackLayer::fill(self : FinancepricinglookbackLayer, v : Double) -> FinancepricinglookbackLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackLayer::min(self : FinancepricinglookbackLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackLayer::max(self : FinancepricinglookbackLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackLayer::to_string(self : FinancepricinglookbackLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_buffer_make(size : Int) -> FinancepricinglookbackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackBuffer::len(self : FinancepricinglookbackBuffer) -> Int { self.size }

pub fn FinancepricinglookbackBuffer::get(self : FinancepricinglookbackBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackBuffer::set(self : FinancepricinglookbackBuffer, i : Int, v : Double) -> FinancepricinglookbackBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackBuffer::sum(self : FinancepricinglookbackBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackBuffer::mean(self : FinancepricinglookbackBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackBuffer::scale(self : FinancepricinglookbackBuffer, f : Double) -> FinancepricinglookbackBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackBuffer::add(self : FinancepricinglookbackBuffer, other : FinancepricinglookbackBuffer) -> FinancepricinglookbackBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackBuffer::copy(self : FinancepricinglookbackBuffer) -> FinancepricinglookbackBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackBuffer::fill(self : FinancepricinglookbackBuffer, v : Double) -> FinancepricinglookbackBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackBuffer::min(self : FinancepricinglookbackBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackBuffer::max(self : FinancepricinglookbackBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackBuffer::to_string(self : FinancepricinglookbackBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_cursor_make(size : Int) -> FinancepricinglookbackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackCursor::len(self : FinancepricinglookbackCursor) -> Int { self.size }

pub fn FinancepricinglookbackCursor::get(self : FinancepricinglookbackCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackCursor::set(self : FinancepricinglookbackCursor, i : Int, v : Double) -> FinancepricinglookbackCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCursor::sum(self : FinancepricinglookbackCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackCursor::mean(self : FinancepricinglookbackCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackCursor::scale(self : FinancepricinglookbackCursor, f : Double) -> FinancepricinglookbackCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCursor::add(self : FinancepricinglookbackCursor, other : FinancepricinglookbackCursor) -> FinancepricinglookbackCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackCursor::copy(self : FinancepricinglookbackCursor) -> FinancepricinglookbackCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCursor::fill(self : FinancepricinglookbackCursor, v : Double) -> FinancepricinglookbackCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackCursor::min(self : FinancepricinglookbackCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackCursor::max(self : FinancepricinglookbackCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackCursor::to_string(self : FinancepricinglookbackCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_view_make(size : Int) -> FinancepricinglookbackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackView::len(self : FinancepricinglookbackView) -> Int { self.size }

pub fn FinancepricinglookbackView::get(self : FinancepricinglookbackView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackView::set(self : FinancepricinglookbackView, i : Int, v : Double) -> FinancepricinglookbackView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackView::sum(self : FinancepricinglookbackView) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackView::mean(self : FinancepricinglookbackView) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackView::scale(self : FinancepricinglookbackView, f : Double) -> FinancepricinglookbackView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackView::add(self : FinancepricinglookbackView, other : FinancepricinglookbackView) -> FinancepricinglookbackView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackView::copy(self : FinancepricinglookbackView) -> FinancepricinglookbackView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackView::fill(self : FinancepricinglookbackView, v : Double) -> FinancepricinglookbackView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackView::min(self : FinancepricinglookbackView) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackView::max(self : FinancepricinglookbackView) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackView::to_string(self : FinancepricinglookbackView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_range_make(size : Int) -> FinancepricinglookbackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackRange::len(self : FinancepricinglookbackRange) -> Int { self.size }

pub fn FinancepricinglookbackRange::get(self : FinancepricinglookbackRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackRange::set(self : FinancepricinglookbackRange, i : Int, v : Double) -> FinancepricinglookbackRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackRange::sum(self : FinancepricinglookbackRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackRange::mean(self : FinancepricinglookbackRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackRange::scale(self : FinancepricinglookbackRange, f : Double) -> FinancepricinglookbackRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackRange::add(self : FinancepricinglookbackRange, other : FinancepricinglookbackRange) -> FinancepricinglookbackRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackRange::copy(self : FinancepricinglookbackRange) -> FinancepricinglookbackRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackRange::fill(self : FinancepricinglookbackRange, v : Double) -> FinancepricinglookbackRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackRange::min(self : FinancepricinglookbackRange) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackRange::max(self : FinancepricinglookbackRange) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackRange::to_string(self : FinancepricinglookbackRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_slice_make(size : Int) -> FinancepricinglookbackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricinglookbackSlice::len(self : FinancepricinglookbackSlice) -> Int { self.size }

pub fn FinancepricinglookbackSlice::get(self : FinancepricinglookbackSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricinglookbackSlice::set(self : FinancepricinglookbackSlice, i : Int, v : Double) -> FinancepricinglookbackSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackSlice::sum(self : FinancepricinglookbackSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricinglookbackSlice::mean(self : FinancepricinglookbackSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricinglookbackSlice::scale(self : FinancepricinglookbackSlice, f : Double) -> FinancepricinglookbackSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackSlice::add(self : FinancepricinglookbackSlice, other : FinancepricinglookbackSlice) -> FinancepricinglookbackSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricinglookbackSlice::copy(self : FinancepricinglookbackSlice) -> FinancepricinglookbackSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackSlice::fill(self : FinancepricinglookbackSlice, v : Double) -> FinancepricinglookbackSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricinglookbackSlice::min(self : FinancepricinglookbackSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricinglookbackSlice::max(self : FinancepricinglookbackSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricinglookbackSlice::to_string(self : FinancepricinglookbackSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

