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

pub fn FinanceriskcoherentFrame::len(self : FinanceriskcoherentFrame) -> Int { self.size }

pub fn FinanceriskcoherentFrame::get(self : FinanceriskcoherentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentFrame::set(self : FinanceriskcoherentFrame, i : Int, v : Double) -> FinanceriskcoherentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentFrame::sum(self : FinanceriskcoherentFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentFrame::mean(self : FinanceriskcoherentFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentFrame::scale(self : FinanceriskcoherentFrame, f : Double) -> FinanceriskcoherentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentFrame::add(self : FinanceriskcoherentFrame, other : FinanceriskcoherentFrame) -> FinanceriskcoherentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentFrame::copy(self : FinanceriskcoherentFrame) -> FinanceriskcoherentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentFrame::fill(self : FinanceriskcoherentFrame, v : Double) -> FinanceriskcoherentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentFrame::min(self : FinanceriskcoherentFrame) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentFrame::max(self : FinanceriskcoherentFrame) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentFrame::to_string(self : FinanceriskcoherentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_table_make(size : Int) -> FinanceriskcoherentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentTable::len(self : FinanceriskcoherentTable) -> Int { self.size }

pub fn FinanceriskcoherentTable::get(self : FinanceriskcoherentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentTable::set(self : FinanceriskcoherentTable, i : Int, v : Double) -> FinanceriskcoherentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentTable::sum(self : FinanceriskcoherentTable) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentTable::mean(self : FinanceriskcoherentTable) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentTable::scale(self : FinanceriskcoherentTable, f : Double) -> FinanceriskcoherentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentTable::add(self : FinanceriskcoherentTable, other : FinanceriskcoherentTable) -> FinanceriskcoherentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentTable::copy(self : FinanceriskcoherentTable) -> FinanceriskcoherentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentTable::fill(self : FinanceriskcoherentTable, v : Double) -> FinanceriskcoherentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentTable::min(self : FinanceriskcoherentTable) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentTable::max(self : FinanceriskcoherentTable) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentTable::to_string(self : FinanceriskcoherentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_graphn_make(size : Int) -> FinanceriskcoherentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentGraphN::len(self : FinanceriskcoherentGraphN) -> Int { self.size }

pub fn FinanceriskcoherentGraphN::get(self : FinanceriskcoherentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentGraphN::set(self : FinanceriskcoherentGraphN, i : Int, v : Double) -> FinanceriskcoherentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentGraphN::sum(self : FinanceriskcoherentGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentGraphN::mean(self : FinanceriskcoherentGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentGraphN::scale(self : FinanceriskcoherentGraphN, f : Double) -> FinanceriskcoherentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentGraphN::add(self : FinanceriskcoherentGraphN, other : FinanceriskcoherentGraphN) -> FinanceriskcoherentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentGraphN::copy(self : FinanceriskcoherentGraphN) -> FinanceriskcoherentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentGraphN::fill(self : FinanceriskcoherentGraphN, v : Double) -> FinanceriskcoherentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentGraphN::min(self : FinanceriskcoherentGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentGraphN::max(self : FinanceriskcoherentGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentGraphN::to_string(self : FinanceriskcoherentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_node_make(size : Int) -> FinanceriskcoherentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentNode::len(self : FinanceriskcoherentNode) -> Int { self.size }

pub fn FinanceriskcoherentNode::get(self : FinanceriskcoherentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentNode::set(self : FinanceriskcoherentNode, i : Int, v : Double) -> FinanceriskcoherentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentNode::sum(self : FinanceriskcoherentNode) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentNode::mean(self : FinanceriskcoherentNode) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentNode::scale(self : FinanceriskcoherentNode, f : Double) -> FinanceriskcoherentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentNode::add(self : FinanceriskcoherentNode, other : FinanceriskcoherentNode) -> FinanceriskcoherentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentNode::copy(self : FinanceriskcoherentNode) -> FinanceriskcoherentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentNode::fill(self : FinanceriskcoherentNode, v : Double) -> FinanceriskcoherentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentNode::min(self : FinanceriskcoherentNode) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentNode::max(self : FinanceriskcoherentNode) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentNode::to_string(self : FinanceriskcoherentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_edge_make(size : Int) -> FinanceriskcoherentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentEdge::len(self : FinanceriskcoherentEdge) -> Int { self.size }

pub fn FinanceriskcoherentEdge::get(self : FinanceriskcoherentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentEdge::set(self : FinanceriskcoherentEdge, i : Int, v : Double) -> FinanceriskcoherentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentEdge::sum(self : FinanceriskcoherentEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentEdge::mean(self : FinanceriskcoherentEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentEdge::scale(self : FinanceriskcoherentEdge, f : Double) -> FinanceriskcoherentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentEdge::add(self : FinanceriskcoherentEdge, other : FinanceriskcoherentEdge) -> FinanceriskcoherentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentEdge::copy(self : FinanceriskcoherentEdge) -> FinanceriskcoherentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentEdge::fill(self : FinanceriskcoherentEdge, v : Double) -> FinanceriskcoherentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentEdge::min(self : FinanceriskcoherentEdge) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentEdge::max(self : FinanceriskcoherentEdge) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentEdge::to_string(self : FinanceriskcoherentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_path_make(size : Int) -> FinanceriskcoherentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentPath::len(self : FinanceriskcoherentPath) -> Int { self.size }

pub fn FinanceriskcoherentPath::get(self : FinanceriskcoherentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentPath::set(self : FinanceriskcoherentPath, i : Int, v : Double) -> FinanceriskcoherentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentPath::sum(self : FinanceriskcoherentPath) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentPath::mean(self : FinanceriskcoherentPath) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentPath::scale(self : FinanceriskcoherentPath, f : Double) -> FinanceriskcoherentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentPath::add(self : FinanceriskcoherentPath, other : FinanceriskcoherentPath) -> FinanceriskcoherentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentPath::copy(self : FinanceriskcoherentPath) -> FinanceriskcoherentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentPath::fill(self : FinanceriskcoherentPath, v : Double) -> FinanceriskcoherentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentPath::min(self : FinanceriskcoherentPath) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentPath::max(self : FinanceriskcoherentPath) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentPath::to_string(self : FinanceriskcoherentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_cluster_make(size : Int) -> FinanceriskcoherentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentCluster::len(self : FinanceriskcoherentCluster) -> Int { self.size }

pub fn FinanceriskcoherentCluster::get(self : FinanceriskcoherentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentCluster::set(self : FinanceriskcoherentCluster, i : Int, v : Double) -> FinanceriskcoherentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCluster::sum(self : FinanceriskcoherentCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentCluster::mean(self : FinanceriskcoherentCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentCluster::scale(self : FinanceriskcoherentCluster, f : Double) -> FinanceriskcoherentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCluster::add(self : FinanceriskcoherentCluster, other : FinanceriskcoherentCluster) -> FinanceriskcoherentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentCluster::copy(self : FinanceriskcoherentCluster) -> FinanceriskcoherentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCluster::fill(self : FinanceriskcoherentCluster, v : Double) -> FinanceriskcoherentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCluster::min(self : FinanceriskcoherentCluster) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentCluster::max(self : FinanceriskcoherentCluster) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentCluster::to_string(self : FinanceriskcoherentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_model_make(size : Int) -> FinanceriskcoherentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentModel::len(self : FinanceriskcoherentModel) -> Int { self.size }

pub fn FinanceriskcoherentModel::get(self : FinanceriskcoherentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentModel::set(self : FinanceriskcoherentModel, i : Int, v : Double) -> FinanceriskcoherentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentModel::sum(self : FinanceriskcoherentModel) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentModel::mean(self : FinanceriskcoherentModel) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentModel::scale(self : FinanceriskcoherentModel, f : Double) -> FinanceriskcoherentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentModel::add(self : FinanceriskcoherentModel, other : FinanceriskcoherentModel) -> FinanceriskcoherentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentModel::copy(self : FinanceriskcoherentModel) -> FinanceriskcoherentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentModel::fill(self : FinanceriskcoherentModel, v : Double) -> FinanceriskcoherentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentModel::min(self : FinanceriskcoherentModel) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentModel::max(self : FinanceriskcoherentModel) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentModel::to_string(self : FinanceriskcoherentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_layer_make(size : Int) -> FinanceriskcoherentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentLayer::len(self : FinanceriskcoherentLayer) -> Int { self.size }

pub fn FinanceriskcoherentLayer::get(self : FinanceriskcoherentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentLayer::set(self : FinanceriskcoherentLayer, i : Int, v : Double) -> FinanceriskcoherentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentLayer::sum(self : FinanceriskcoherentLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentLayer::mean(self : FinanceriskcoherentLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentLayer::scale(self : FinanceriskcoherentLayer, f : Double) -> FinanceriskcoherentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentLayer::add(self : FinanceriskcoherentLayer, other : FinanceriskcoherentLayer) -> FinanceriskcoherentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentLayer::copy(self : FinanceriskcoherentLayer) -> FinanceriskcoherentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentLayer::fill(self : FinanceriskcoherentLayer, v : Double) -> FinanceriskcoherentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentLayer::min(self : FinanceriskcoherentLayer) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentLayer::max(self : FinanceriskcoherentLayer) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentLayer::to_string(self : FinanceriskcoherentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_buffer_make(size : Int) -> FinanceriskcoherentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentBuffer::len(self : FinanceriskcoherentBuffer) -> Int { self.size }

pub fn FinanceriskcoherentBuffer::get(self : FinanceriskcoherentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentBuffer::set(self : FinanceriskcoherentBuffer, i : Int, v : Double) -> FinanceriskcoherentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentBuffer::sum(self : FinanceriskcoherentBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentBuffer::mean(self : FinanceriskcoherentBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentBuffer::scale(self : FinanceriskcoherentBuffer, f : Double) -> FinanceriskcoherentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentBuffer::add(self : FinanceriskcoherentBuffer, other : FinanceriskcoherentBuffer) -> FinanceriskcoherentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentBuffer::copy(self : FinanceriskcoherentBuffer) -> FinanceriskcoherentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentBuffer::fill(self : FinanceriskcoherentBuffer, v : Double) -> FinanceriskcoherentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentBuffer::min(self : FinanceriskcoherentBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentBuffer::max(self : FinanceriskcoherentBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentBuffer::to_string(self : FinanceriskcoherentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_cursor_make(size : Int) -> FinanceriskcoherentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentCursor::len(self : FinanceriskcoherentCursor) -> Int { self.size }

pub fn FinanceriskcoherentCursor::get(self : FinanceriskcoherentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentCursor::set(self : FinanceriskcoherentCursor, i : Int, v : Double) -> FinanceriskcoherentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCursor::sum(self : FinanceriskcoherentCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentCursor::mean(self : FinanceriskcoherentCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentCursor::scale(self : FinanceriskcoherentCursor, f : Double) -> FinanceriskcoherentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCursor::add(self : FinanceriskcoherentCursor, other : FinanceriskcoherentCursor) -> FinanceriskcoherentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentCursor::copy(self : FinanceriskcoherentCursor) -> FinanceriskcoherentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCursor::fill(self : FinanceriskcoherentCursor, v : Double) -> FinanceriskcoherentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentCursor::min(self : FinanceriskcoherentCursor) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentCursor::max(self : FinanceriskcoherentCursor) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentCursor::to_string(self : FinanceriskcoherentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_view_make(size : Int) -> FinanceriskcoherentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentView::len(self : FinanceriskcoherentView) -> Int { self.size }

pub fn FinanceriskcoherentView::get(self : FinanceriskcoherentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentView::set(self : FinanceriskcoherentView, i : Int, v : Double) -> FinanceriskcoherentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentView::sum(self : FinanceriskcoherentView) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentView::mean(self : FinanceriskcoherentView) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentView::scale(self : FinanceriskcoherentView, f : Double) -> FinanceriskcoherentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentView::add(self : FinanceriskcoherentView, other : FinanceriskcoherentView) -> FinanceriskcoherentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentView::copy(self : FinanceriskcoherentView) -> FinanceriskcoherentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentView::fill(self : FinanceriskcoherentView, v : Double) -> FinanceriskcoherentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentView::min(self : FinanceriskcoherentView) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentView::max(self : FinanceriskcoherentView) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentView::to_string(self : FinanceriskcoherentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_range_make(size : Int) -> FinanceriskcoherentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentRange::len(self : FinanceriskcoherentRange) -> Int { self.size }

pub fn FinanceriskcoherentRange::get(self : FinanceriskcoherentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentRange::set(self : FinanceriskcoherentRange, i : Int, v : Double) -> FinanceriskcoherentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentRange::sum(self : FinanceriskcoherentRange) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentRange::mean(self : FinanceriskcoherentRange) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentRange::scale(self : FinanceriskcoherentRange, f : Double) -> FinanceriskcoherentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentRange::add(self : FinanceriskcoherentRange, other : FinanceriskcoherentRange) -> FinanceriskcoherentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentRange::copy(self : FinanceriskcoherentRange) -> FinanceriskcoherentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentRange::fill(self : FinanceriskcoherentRange, v : Double) -> FinanceriskcoherentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentRange::min(self : FinanceriskcoherentRange) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentRange::max(self : FinanceriskcoherentRange) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentRange::to_string(self : FinanceriskcoherentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_slice_make(size : Int) -> FinanceriskcoherentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskcoherentSlice::len(self : FinanceriskcoherentSlice) -> Int { self.size }

pub fn FinanceriskcoherentSlice::get(self : FinanceriskcoherentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskcoherentSlice::set(self : FinanceriskcoherentSlice, i : Int, v : Double) -> FinanceriskcoherentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentSlice::sum(self : FinanceriskcoherentSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceriskcoherentSlice::mean(self : FinanceriskcoherentSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceriskcoherentSlice::scale(self : FinanceriskcoherentSlice, f : Double) -> FinanceriskcoherentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentSlice::add(self : FinanceriskcoherentSlice, other : FinanceriskcoherentSlice) -> FinanceriskcoherentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskcoherentSlice::copy(self : FinanceriskcoherentSlice) -> FinanceriskcoherentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentSlice::fill(self : FinanceriskcoherentSlice, v : Double) -> FinanceriskcoherentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskcoherentSlice::min(self : FinanceriskcoherentSlice) -> Double { @_common.min(self.data) }

pub fn FinanceriskcoherentSlice::max(self : FinanceriskcoherentSlice) -> Double { @_common.max(self.data) }

pub fn FinanceriskcoherentSlice::to_string(self : FinanceriskcoherentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

