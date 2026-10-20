///===
/// extcore/finance_time_regime

pub(all) struct FinancetimeregimePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_regime_make_point(x : Double, y : Double) -> FinancetimeregimePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_regime_make_point3(x : Double, y : Double, z : Double) -> FinancetimeregimePoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimeregimePoint::x(self : FinancetimeregimePoint) -> Double { self.x }

pub fn FinancetimeregimePoint::y(self : FinancetimeregimePoint) -> Double { self.y }

pub fn FinancetimeregimePoint::z(self : FinancetimeregimePoint) -> Double { self.z }

pub fn FinancetimeregimePoint::label(self : FinancetimeregimePoint) -> Int { self.label }

pub fn FinancetimeregimePoint::dist(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimeregimePoint::add(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimeregimePoint::sub(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimeregimePoint::scale(self : FinancetimeregimePoint, s : Double) -> FinancetimeregimePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimeregimePoint::dot(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimeregimePoint::cross(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimeregimePoint::norm(self : FinancetimeregimePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimeregimePoint::normalize(self : FinancetimeregimePoint) -> FinancetimeregimePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeregimePoint::negate(self : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimeregimePoint::mid(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimeregimePoint::lerp(self : FinancetimeregimePoint, other : FinancetimeregimePoint, t : Double) -> FinancetimeregimePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimeregimePoint::to_string(self : FinancetimeregimePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimeregimeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_regime_make_series(vals : Array[Double], name : String) -> FinancetimeregimeSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimeregimeSeries::len(self : FinancetimeregimeSeries) -> Int { self.vals.length() }

pub fn FinancetimeregimeSeries::sum(self : FinancetimeregimeSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimeregimeSeries::mean(self : FinancetimeregimeSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimeregimeSeries::min(self : FinancetimeregimeSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimeregimeSeries::max(self : FinancetimeregimeSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimeregimeSeries::range(self : FinancetimeregimeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimeregimeSeries::variance(self : FinancetimeregimeSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimeregimeSeries::std(self : FinancetimeregimeSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimeregimeSeries::median(self : FinancetimeregimeSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimeregimeSeries::scale(self : FinancetimeregimeSeries, f : Double) -> FinancetimeregimeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimeregimeSeries::add(self : FinancetimeregimeSeries, other : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimeregimeSeries::sub(self : FinancetimeregimeSeries, other : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimeregimeSeries::normalize(self : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimeregimeSeries::cumsum(self : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimeregimeSeries::to_string(self : FinancetimeregimeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeregimeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_regime_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeregimeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_regime_matrix_identity(n : Int) -> FinancetimeregimeMatrix {
  let m = finance_time_regime_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimeregimeMatrix::get(self : FinancetimeregimeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimeregimeMatrix::transpose(self : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  let result = finance_time_regime_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimeregimeMatrix::add(self : FinancetimeregimeMatrix, other : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_regime_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimeregimeMatrix::scale(self : FinancetimeregimeMatrix, s : Double) -> FinancetimeregimeMatrix {
  let result = finance_time_regime_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimeregimeMatrix::multiply(self : FinancetimeregimeMatrix, other : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  if self.cols != other.rows { return finance_time_regime_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_regime_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimeregimeMatrix::trace(self : FinancetimeregimeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimeregimeMatrix::det(self : FinancetimeregimeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimeregimeMatrix::norm(self : FinancetimeregimeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimeregimeMatrix::to_string(self : FinancetimeregimeMatrix) -> String {
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

pub(all) struct FinancetimeregimeVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_regime_make_vector(comps : Array[Double]) -> FinancetimeregimeVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_regime_vector_zero(dim : Int) -> FinancetimeregimeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimeregimeVector::add(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeregimeVector::sub(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeregimeVector::scale(self : FinancetimeregimeVector, s : Double) -> FinancetimeregimeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimeregimeVector::dot(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimeregimeVector::norm(self : FinancetimeregimeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimeregimeVector::normalize(self : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeregimeVector::dist(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimeregimeVector::to_string(self : FinancetimeregimeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_regime_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_regime_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_regime_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_regime_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_regime_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_regime_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_regime_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_regime_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_regime_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_regime_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_regime_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_regime_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_regime_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_regime_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_regime_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_regime_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_regime_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_regime_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_regime_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_regime_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_regime_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_regime_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_regime_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_regime_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_regime_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_regime_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_regime_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_regime_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_regime_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeregimeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_frame_make(size : Int) -> FinancetimeregimeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeFrame::len(self : FinancetimeregimeFrame) -> Int { self.size }

pub fn FinancetimeregimeFrame::get(self : FinancetimeregimeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeFrame::set(self : FinancetimeregimeFrame, i : Int, v : Double) -> FinancetimeregimeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeFrame::sum(self : FinancetimeregimeFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeFrame::mean(self : FinancetimeregimeFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeFrame::scale(self : FinancetimeregimeFrame, f : Double) -> FinancetimeregimeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeFrame::add(self : FinancetimeregimeFrame, other : FinancetimeregimeFrame) -> FinancetimeregimeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeFrame::copy(self : FinancetimeregimeFrame) -> FinancetimeregimeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeFrame::fill(self : FinancetimeregimeFrame, v : Double) -> FinancetimeregimeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeFrame::min(self : FinancetimeregimeFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeFrame::max(self : FinancetimeregimeFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeFrame::to_string(self : FinancetimeregimeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_table_make(size : Int) -> FinancetimeregimeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeTable::len(self : FinancetimeregimeTable) -> Int { self.size }

pub fn FinancetimeregimeTable::get(self : FinancetimeregimeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeTable::set(self : FinancetimeregimeTable, i : Int, v : Double) -> FinancetimeregimeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeTable::sum(self : FinancetimeregimeTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeTable::mean(self : FinancetimeregimeTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeTable::scale(self : FinancetimeregimeTable, f : Double) -> FinancetimeregimeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeTable::add(self : FinancetimeregimeTable, other : FinancetimeregimeTable) -> FinancetimeregimeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeTable::copy(self : FinancetimeregimeTable) -> FinancetimeregimeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeTable::fill(self : FinancetimeregimeTable, v : Double) -> FinancetimeregimeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeTable::min(self : FinancetimeregimeTable) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeTable::max(self : FinancetimeregimeTable) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeTable::to_string(self : FinancetimeregimeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_graphn_make(size : Int) -> FinancetimeregimeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeGraphN::len(self : FinancetimeregimeGraphN) -> Int { self.size }

pub fn FinancetimeregimeGraphN::get(self : FinancetimeregimeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeGraphN::set(self : FinancetimeregimeGraphN, i : Int, v : Double) -> FinancetimeregimeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeGraphN::sum(self : FinancetimeregimeGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeGraphN::mean(self : FinancetimeregimeGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeGraphN::scale(self : FinancetimeregimeGraphN, f : Double) -> FinancetimeregimeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeGraphN::add(self : FinancetimeregimeGraphN, other : FinancetimeregimeGraphN) -> FinancetimeregimeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeGraphN::copy(self : FinancetimeregimeGraphN) -> FinancetimeregimeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeGraphN::fill(self : FinancetimeregimeGraphN, v : Double) -> FinancetimeregimeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeGraphN::min(self : FinancetimeregimeGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeGraphN::max(self : FinancetimeregimeGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeGraphN::to_string(self : FinancetimeregimeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_node_make(size : Int) -> FinancetimeregimeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeNode::len(self : FinancetimeregimeNode) -> Int { self.size }

pub fn FinancetimeregimeNode::get(self : FinancetimeregimeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeNode::set(self : FinancetimeregimeNode, i : Int, v : Double) -> FinancetimeregimeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeNode::sum(self : FinancetimeregimeNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeNode::mean(self : FinancetimeregimeNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeNode::scale(self : FinancetimeregimeNode, f : Double) -> FinancetimeregimeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeNode::add(self : FinancetimeregimeNode, other : FinancetimeregimeNode) -> FinancetimeregimeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeNode::copy(self : FinancetimeregimeNode) -> FinancetimeregimeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeNode::fill(self : FinancetimeregimeNode, v : Double) -> FinancetimeregimeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeNode::min(self : FinancetimeregimeNode) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeNode::max(self : FinancetimeregimeNode) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeNode::to_string(self : FinancetimeregimeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_edge_make(size : Int) -> FinancetimeregimeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeEdge::len(self : FinancetimeregimeEdge) -> Int { self.size }

pub fn FinancetimeregimeEdge::get(self : FinancetimeregimeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeEdge::set(self : FinancetimeregimeEdge, i : Int, v : Double) -> FinancetimeregimeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeEdge::sum(self : FinancetimeregimeEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeEdge::mean(self : FinancetimeregimeEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeEdge::scale(self : FinancetimeregimeEdge, f : Double) -> FinancetimeregimeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeEdge::add(self : FinancetimeregimeEdge, other : FinancetimeregimeEdge) -> FinancetimeregimeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeEdge::copy(self : FinancetimeregimeEdge) -> FinancetimeregimeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeEdge::fill(self : FinancetimeregimeEdge, v : Double) -> FinancetimeregimeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeEdge::min(self : FinancetimeregimeEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeEdge::max(self : FinancetimeregimeEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeEdge::to_string(self : FinancetimeregimeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_path_make(size : Int) -> FinancetimeregimePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimePath::len(self : FinancetimeregimePath) -> Int { self.size }

pub fn FinancetimeregimePath::get(self : FinancetimeregimePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimePath::set(self : FinancetimeregimePath, i : Int, v : Double) -> FinancetimeregimePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimePath::sum(self : FinancetimeregimePath) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimePath::mean(self : FinancetimeregimePath) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimePath::scale(self : FinancetimeregimePath, f : Double) -> FinancetimeregimePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimePath::add(self : FinancetimeregimePath, other : FinancetimeregimePath) -> FinancetimeregimePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimePath::copy(self : FinancetimeregimePath) -> FinancetimeregimePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimePath::fill(self : FinancetimeregimePath, v : Double) -> FinancetimeregimePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimePath::min(self : FinancetimeregimePath) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimePath::max(self : FinancetimeregimePath) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimePath::to_string(self : FinancetimeregimePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_cluster_make(size : Int) -> FinancetimeregimeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeCluster::len(self : FinancetimeregimeCluster) -> Int { self.size }

pub fn FinancetimeregimeCluster::get(self : FinancetimeregimeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeCluster::set(self : FinancetimeregimeCluster, i : Int, v : Double) -> FinancetimeregimeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCluster::sum(self : FinancetimeregimeCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeCluster::mean(self : FinancetimeregimeCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeCluster::scale(self : FinancetimeregimeCluster, f : Double) -> FinancetimeregimeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCluster::add(self : FinancetimeregimeCluster, other : FinancetimeregimeCluster) -> FinancetimeregimeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeCluster::copy(self : FinancetimeregimeCluster) -> FinancetimeregimeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCluster::fill(self : FinancetimeregimeCluster, v : Double) -> FinancetimeregimeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCluster::min(self : FinancetimeregimeCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeCluster::max(self : FinancetimeregimeCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeCluster::to_string(self : FinancetimeregimeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_model_make(size : Int) -> FinancetimeregimeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeModel::len(self : FinancetimeregimeModel) -> Int { self.size }

pub fn FinancetimeregimeModel::get(self : FinancetimeregimeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeModel::set(self : FinancetimeregimeModel, i : Int, v : Double) -> FinancetimeregimeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeModel::sum(self : FinancetimeregimeModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeModel::mean(self : FinancetimeregimeModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeModel::scale(self : FinancetimeregimeModel, f : Double) -> FinancetimeregimeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeModel::add(self : FinancetimeregimeModel, other : FinancetimeregimeModel) -> FinancetimeregimeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeModel::copy(self : FinancetimeregimeModel) -> FinancetimeregimeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeModel::fill(self : FinancetimeregimeModel, v : Double) -> FinancetimeregimeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeModel::min(self : FinancetimeregimeModel) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeModel::max(self : FinancetimeregimeModel) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeModel::to_string(self : FinancetimeregimeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_layer_make(size : Int) -> FinancetimeregimeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeLayer::len(self : FinancetimeregimeLayer) -> Int { self.size }

pub fn FinancetimeregimeLayer::get(self : FinancetimeregimeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeLayer::set(self : FinancetimeregimeLayer, i : Int, v : Double) -> FinancetimeregimeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeLayer::sum(self : FinancetimeregimeLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeLayer::mean(self : FinancetimeregimeLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeLayer::scale(self : FinancetimeregimeLayer, f : Double) -> FinancetimeregimeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeLayer::add(self : FinancetimeregimeLayer, other : FinancetimeregimeLayer) -> FinancetimeregimeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeLayer::copy(self : FinancetimeregimeLayer) -> FinancetimeregimeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeLayer::fill(self : FinancetimeregimeLayer, v : Double) -> FinancetimeregimeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeLayer::min(self : FinancetimeregimeLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeLayer::max(self : FinancetimeregimeLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeLayer::to_string(self : FinancetimeregimeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_buffer_make(size : Int) -> FinancetimeregimeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeBuffer::len(self : FinancetimeregimeBuffer) -> Int { self.size }

pub fn FinancetimeregimeBuffer::get(self : FinancetimeregimeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeBuffer::set(self : FinancetimeregimeBuffer, i : Int, v : Double) -> FinancetimeregimeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeBuffer::sum(self : FinancetimeregimeBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeBuffer::mean(self : FinancetimeregimeBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeBuffer::scale(self : FinancetimeregimeBuffer, f : Double) -> FinancetimeregimeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeBuffer::add(self : FinancetimeregimeBuffer, other : FinancetimeregimeBuffer) -> FinancetimeregimeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeBuffer::copy(self : FinancetimeregimeBuffer) -> FinancetimeregimeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeBuffer::fill(self : FinancetimeregimeBuffer, v : Double) -> FinancetimeregimeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeBuffer::min(self : FinancetimeregimeBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeBuffer::max(self : FinancetimeregimeBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeBuffer::to_string(self : FinancetimeregimeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_cursor_make(size : Int) -> FinancetimeregimeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeCursor::len(self : FinancetimeregimeCursor) -> Int { self.size }

pub fn FinancetimeregimeCursor::get(self : FinancetimeregimeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeCursor::set(self : FinancetimeregimeCursor, i : Int, v : Double) -> FinancetimeregimeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCursor::sum(self : FinancetimeregimeCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeCursor::mean(self : FinancetimeregimeCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeCursor::scale(self : FinancetimeregimeCursor, f : Double) -> FinancetimeregimeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCursor::add(self : FinancetimeregimeCursor, other : FinancetimeregimeCursor) -> FinancetimeregimeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeCursor::copy(self : FinancetimeregimeCursor) -> FinancetimeregimeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCursor::fill(self : FinancetimeregimeCursor, v : Double) -> FinancetimeregimeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeCursor::min(self : FinancetimeregimeCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeCursor::max(self : FinancetimeregimeCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeCursor::to_string(self : FinancetimeregimeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_view_make(size : Int) -> FinancetimeregimeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeView::len(self : FinancetimeregimeView) -> Int { self.size }

pub fn FinancetimeregimeView::get(self : FinancetimeregimeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeView::set(self : FinancetimeregimeView, i : Int, v : Double) -> FinancetimeregimeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeView::sum(self : FinancetimeregimeView) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeView::mean(self : FinancetimeregimeView) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeView::scale(self : FinancetimeregimeView, f : Double) -> FinancetimeregimeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeView::add(self : FinancetimeregimeView, other : FinancetimeregimeView) -> FinancetimeregimeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeView::copy(self : FinancetimeregimeView) -> FinancetimeregimeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeView::fill(self : FinancetimeregimeView, v : Double) -> FinancetimeregimeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeView::min(self : FinancetimeregimeView) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeView::max(self : FinancetimeregimeView) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeView::to_string(self : FinancetimeregimeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_range_make(size : Int) -> FinancetimeregimeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeRange::len(self : FinancetimeregimeRange) -> Int { self.size }

pub fn FinancetimeregimeRange::get(self : FinancetimeregimeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeRange::set(self : FinancetimeregimeRange, i : Int, v : Double) -> FinancetimeregimeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeRange::sum(self : FinancetimeregimeRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeRange::mean(self : FinancetimeregimeRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeRange::scale(self : FinancetimeregimeRange, f : Double) -> FinancetimeregimeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeRange::add(self : FinancetimeregimeRange, other : FinancetimeregimeRange) -> FinancetimeregimeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeRange::copy(self : FinancetimeregimeRange) -> FinancetimeregimeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeRange::fill(self : FinancetimeregimeRange, v : Double) -> FinancetimeregimeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeRange::min(self : FinancetimeregimeRange) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeRange::max(self : FinancetimeregimeRange) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeRange::to_string(self : FinancetimeregimeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_slice_make(size : Int) -> FinancetimeregimeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeregimeSlice::len(self : FinancetimeregimeSlice) -> Int { self.size }

pub fn FinancetimeregimeSlice::get(self : FinancetimeregimeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeregimeSlice::set(self : FinancetimeregimeSlice, i : Int, v : Double) -> FinancetimeregimeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeSlice::sum(self : FinancetimeregimeSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimeregimeSlice::mean(self : FinancetimeregimeSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimeregimeSlice::scale(self : FinancetimeregimeSlice, f : Double) -> FinancetimeregimeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeSlice::add(self : FinancetimeregimeSlice, other : FinancetimeregimeSlice) -> FinancetimeregimeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeregimeSlice::copy(self : FinancetimeregimeSlice) -> FinancetimeregimeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeSlice::fill(self : FinancetimeregimeSlice, v : Double) -> FinancetimeregimeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeregimeSlice::min(self : FinancetimeregimeSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimeregimeSlice::max(self : FinancetimeregimeSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimeregimeSlice::to_string(self : FinancetimeregimeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

