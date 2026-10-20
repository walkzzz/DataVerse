///===
/// extcore/finance_risk_stress

pub(all) struct FinanceriskstressPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_stress_make_point(x : Double, y : Double) -> FinanceriskstressPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_stress_make_point3(x : Double, y : Double, z : Double) -> FinanceriskstressPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskstressPoint::x(self : FinanceriskstressPoint) -> Double { self.x }

pub fn FinanceriskstressPoint::y(self : FinanceriskstressPoint) -> Double { self.y }

pub fn FinanceriskstressPoint::z(self : FinanceriskstressPoint) -> Double { self.z }

pub fn FinanceriskstressPoint::label(self : FinanceriskstressPoint) -> Int { self.label }

pub fn FinanceriskstressPoint::dist(self : FinanceriskstressPoint, other : FinanceriskstressPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskstressPoint::add(self : FinanceriskstressPoint, other : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskstressPoint::sub(self : FinanceriskstressPoint, other : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskstressPoint::scale(self : FinanceriskstressPoint, s : Double) -> FinanceriskstressPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskstressPoint::dot(self : FinanceriskstressPoint, other : FinanceriskstressPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskstressPoint::cross(self : FinanceriskstressPoint, other : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskstressPoint::norm(self : FinanceriskstressPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskstressPoint::normalize(self : FinanceriskstressPoint) -> FinanceriskstressPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskstressPoint::negate(self : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskstressPoint::mid(self : FinanceriskstressPoint, other : FinanceriskstressPoint) -> FinanceriskstressPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskstressPoint::lerp(self : FinanceriskstressPoint, other : FinanceriskstressPoint, t : Double) -> FinanceriskstressPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskstressPoint::to_string(self : FinanceriskstressPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskstressSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_stress_make_series(vals : Array[Double], name : String) -> FinanceriskstressSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskstressSeries::len(self : FinanceriskstressSeries) -> Int { self.vals.length() }

pub fn FinanceriskstressSeries::sum(self : FinanceriskstressSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskstressSeries::mean(self : FinanceriskstressSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskstressSeries::min(self : FinanceriskstressSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskstressSeries::max(self : FinanceriskstressSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskstressSeries::range(self : FinanceriskstressSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskstressSeries::variance(self : FinanceriskstressSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskstressSeries::std(self : FinanceriskstressSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskstressSeries::median(self : FinanceriskstressSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskstressSeries::scale(self : FinanceriskstressSeries, f : Double) -> FinanceriskstressSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskstressSeries::add(self : FinanceriskstressSeries, other : FinanceriskstressSeries) -> FinanceriskstressSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskstressSeries::sub(self : FinanceriskstressSeries, other : FinanceriskstressSeries) -> FinanceriskstressSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskstressSeries::normalize(self : FinanceriskstressSeries) -> FinanceriskstressSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskstressSeries::cumsum(self : FinanceriskstressSeries) -> FinanceriskstressSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskstressSeries::to_string(self : FinanceriskstressSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskstressMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_stress_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskstressMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_stress_matrix_identity(n : Int) -> FinanceriskstressMatrix {
  let m = finance_risk_stress_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskstressMatrix::get(self : FinanceriskstressMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskstressMatrix::transpose(self : FinanceriskstressMatrix) -> FinanceriskstressMatrix {
  let result = finance_risk_stress_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskstressMatrix::add(self : FinanceriskstressMatrix, other : FinanceriskstressMatrix) -> FinanceriskstressMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_stress_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskstressMatrix::scale(self : FinanceriskstressMatrix, s : Double) -> FinanceriskstressMatrix {
  let result = finance_risk_stress_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskstressMatrix::multiply(self : FinanceriskstressMatrix, other : FinanceriskstressMatrix) -> FinanceriskstressMatrix {
  if self.cols != other.rows { return finance_risk_stress_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_stress_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskstressMatrix::trace(self : FinanceriskstressMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskstressMatrix::det(self : FinanceriskstressMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskstressMatrix::norm(self : FinanceriskstressMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskstressMatrix::to_string(self : FinanceriskstressMatrix) -> String {
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

pub(all) struct FinanceriskstressVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_stress_make_vector(comps : Array[Double]) -> FinanceriskstressVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_stress_vector_zero(dim : Int) -> FinanceriskstressVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskstressVector::add(self : FinanceriskstressVector, other : FinanceriskstressVector) -> FinanceriskstressVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskstressVector::sub(self : FinanceriskstressVector, other : FinanceriskstressVector) -> FinanceriskstressVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskstressVector::scale(self : FinanceriskstressVector, s : Double) -> FinanceriskstressVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskstressVector::dot(self : FinanceriskstressVector, other : FinanceriskstressVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskstressVector::norm(self : FinanceriskstressVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskstressVector::normalize(self : FinanceriskstressVector) -> FinanceriskstressVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskstressVector::dist(self : FinanceriskstressVector, other : FinanceriskstressVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskstressVector::to_string(self : FinanceriskstressVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_stress_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_stress_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_stress_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_stress_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_stress_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_stress_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_stress_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_stress_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_stress_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_stress_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_stress_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_stress_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_stress_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_stress_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_stress_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_stress_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_stress_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_stress_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_stress_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_stress_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_stress_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_stress_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_stress_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_stress_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_stress_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_stress_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_stress_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_stress_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_stress_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskstressFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_frame_make(size : Int) -> FinanceriskstressFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressFrame::len(self : FinanceriskstressFrame) -> Int { self.size }

pub fn FinanceriskstressFrame::get(self : FinanceriskstressFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressFrame::set(self : FinanceriskstressFrame, i : Int, v : Double) -> FinanceriskstressFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressFrame::sum(self : FinanceriskstressFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressFrame::mean(self : FinanceriskstressFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressFrame::scale(self : FinanceriskstressFrame, f : Double) -> FinanceriskstressFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressFrame::add(self : FinanceriskstressFrame, other : FinanceriskstressFrame) -> FinanceriskstressFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressFrame::copy(self : FinanceriskstressFrame) -> FinanceriskstressFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressFrame::fill(self : FinanceriskstressFrame, v : Double) -> FinanceriskstressFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressFrame::min(self : FinanceriskstressFrame) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressFrame::max(self : FinanceriskstressFrame) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressFrame::to_string(self : FinanceriskstressFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_table_make(size : Int) -> FinanceriskstressTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressTable::len(self : FinanceriskstressTable) -> Int { self.size }

pub fn FinanceriskstressTable::get(self : FinanceriskstressTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressTable::set(self : FinanceriskstressTable, i : Int, v : Double) -> FinanceriskstressTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressTable::sum(self : FinanceriskstressTable) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressTable::mean(self : FinanceriskstressTable) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressTable::scale(self : FinanceriskstressTable, f : Double) -> FinanceriskstressTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressTable::add(self : FinanceriskstressTable, other : FinanceriskstressTable) -> FinanceriskstressTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressTable::copy(self : FinanceriskstressTable) -> FinanceriskstressTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressTable::fill(self : FinanceriskstressTable, v : Double) -> FinanceriskstressTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressTable::min(self : FinanceriskstressTable) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressTable::max(self : FinanceriskstressTable) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressTable::to_string(self : FinanceriskstressTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_graphn_make(size : Int) -> FinanceriskstressGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressGraphN::len(self : FinanceriskstressGraphN) -> Int { self.size }

pub fn FinanceriskstressGraphN::get(self : FinanceriskstressGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressGraphN::set(self : FinanceriskstressGraphN, i : Int, v : Double) -> FinanceriskstressGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressGraphN::sum(self : FinanceriskstressGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressGraphN::mean(self : FinanceriskstressGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressGraphN::scale(self : FinanceriskstressGraphN, f : Double) -> FinanceriskstressGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressGraphN::add(self : FinanceriskstressGraphN, other : FinanceriskstressGraphN) -> FinanceriskstressGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressGraphN::copy(self : FinanceriskstressGraphN) -> FinanceriskstressGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressGraphN::fill(self : FinanceriskstressGraphN, v : Double) -> FinanceriskstressGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressGraphN::min(self : FinanceriskstressGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressGraphN::max(self : FinanceriskstressGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressGraphN::to_string(self : FinanceriskstressGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_node_make(size : Int) -> FinanceriskstressNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressNode::len(self : FinanceriskstressNode) -> Int { self.size }

pub fn FinanceriskstressNode::get(self : FinanceriskstressNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressNode::set(self : FinanceriskstressNode, i : Int, v : Double) -> FinanceriskstressNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressNode::sum(self : FinanceriskstressNode) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressNode::mean(self : FinanceriskstressNode) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressNode::scale(self : FinanceriskstressNode, f : Double) -> FinanceriskstressNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressNode::add(self : FinanceriskstressNode, other : FinanceriskstressNode) -> FinanceriskstressNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressNode::copy(self : FinanceriskstressNode) -> FinanceriskstressNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressNode::fill(self : FinanceriskstressNode, v : Double) -> FinanceriskstressNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressNode::min(self : FinanceriskstressNode) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressNode::max(self : FinanceriskstressNode) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressNode::to_string(self : FinanceriskstressNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_edge_make(size : Int) -> FinanceriskstressEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressEdge::len(self : FinanceriskstressEdge) -> Int { self.size }

pub fn FinanceriskstressEdge::get(self : FinanceriskstressEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressEdge::set(self : FinanceriskstressEdge, i : Int, v : Double) -> FinanceriskstressEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressEdge::sum(self : FinanceriskstressEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressEdge::mean(self : FinanceriskstressEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressEdge::scale(self : FinanceriskstressEdge, f : Double) -> FinanceriskstressEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressEdge::add(self : FinanceriskstressEdge, other : FinanceriskstressEdge) -> FinanceriskstressEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressEdge::copy(self : FinanceriskstressEdge) -> FinanceriskstressEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressEdge::fill(self : FinanceriskstressEdge, v : Double) -> FinanceriskstressEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressEdge::min(self : FinanceriskstressEdge) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressEdge::max(self : FinanceriskstressEdge) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressEdge::to_string(self : FinanceriskstressEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_path_make(size : Int) -> FinanceriskstressPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressPath::len(self : FinanceriskstressPath) -> Int { self.size }

pub fn FinanceriskstressPath::get(self : FinanceriskstressPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressPath::set(self : FinanceriskstressPath, i : Int, v : Double) -> FinanceriskstressPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressPath::sum(self : FinanceriskstressPath) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressPath::mean(self : FinanceriskstressPath) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressPath::scale(self : FinanceriskstressPath, f : Double) -> FinanceriskstressPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressPath::add(self : FinanceriskstressPath, other : FinanceriskstressPath) -> FinanceriskstressPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressPath::copy(self : FinanceriskstressPath) -> FinanceriskstressPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressPath::fill(self : FinanceriskstressPath, v : Double) -> FinanceriskstressPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressPath::min(self : FinanceriskstressPath) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressPath::max(self : FinanceriskstressPath) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressPath::to_string(self : FinanceriskstressPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_cluster_make(size : Int) -> FinanceriskstressCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressCluster::len(self : FinanceriskstressCluster) -> Int { self.size }

pub fn FinanceriskstressCluster::get(self : FinanceriskstressCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressCluster::set(self : FinanceriskstressCluster, i : Int, v : Double) -> FinanceriskstressCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCluster::sum(self : FinanceriskstressCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressCluster::mean(self : FinanceriskstressCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressCluster::scale(self : FinanceriskstressCluster, f : Double) -> FinanceriskstressCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCluster::add(self : FinanceriskstressCluster, other : FinanceriskstressCluster) -> FinanceriskstressCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressCluster::copy(self : FinanceriskstressCluster) -> FinanceriskstressCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCluster::fill(self : FinanceriskstressCluster, v : Double) -> FinanceriskstressCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCluster::min(self : FinanceriskstressCluster) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressCluster::max(self : FinanceriskstressCluster) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressCluster::to_string(self : FinanceriskstressCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_model_make(size : Int) -> FinanceriskstressModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressModel::len(self : FinanceriskstressModel) -> Int { self.size }

pub fn FinanceriskstressModel::get(self : FinanceriskstressModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressModel::set(self : FinanceriskstressModel, i : Int, v : Double) -> FinanceriskstressModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressModel::sum(self : FinanceriskstressModel) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressModel::mean(self : FinanceriskstressModel) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressModel::scale(self : FinanceriskstressModel, f : Double) -> FinanceriskstressModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressModel::add(self : FinanceriskstressModel, other : FinanceriskstressModel) -> FinanceriskstressModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressModel::copy(self : FinanceriskstressModel) -> FinanceriskstressModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressModel::fill(self : FinanceriskstressModel, v : Double) -> FinanceriskstressModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressModel::min(self : FinanceriskstressModel) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressModel::max(self : FinanceriskstressModel) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressModel::to_string(self : FinanceriskstressModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_layer_make(size : Int) -> FinanceriskstressLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressLayer::len(self : FinanceriskstressLayer) -> Int { self.size }

pub fn FinanceriskstressLayer::get(self : FinanceriskstressLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressLayer::set(self : FinanceriskstressLayer, i : Int, v : Double) -> FinanceriskstressLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressLayer::sum(self : FinanceriskstressLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressLayer::mean(self : FinanceriskstressLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressLayer::scale(self : FinanceriskstressLayer, f : Double) -> FinanceriskstressLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressLayer::add(self : FinanceriskstressLayer, other : FinanceriskstressLayer) -> FinanceriskstressLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressLayer::copy(self : FinanceriskstressLayer) -> FinanceriskstressLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressLayer::fill(self : FinanceriskstressLayer, v : Double) -> FinanceriskstressLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressLayer::min(self : FinanceriskstressLayer) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressLayer::max(self : FinanceriskstressLayer) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressLayer::to_string(self : FinanceriskstressLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_buffer_make(size : Int) -> FinanceriskstressBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressBuffer::len(self : FinanceriskstressBuffer) -> Int { self.size }

pub fn FinanceriskstressBuffer::get(self : FinanceriskstressBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressBuffer::set(self : FinanceriskstressBuffer, i : Int, v : Double) -> FinanceriskstressBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressBuffer::sum(self : FinanceriskstressBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressBuffer::mean(self : FinanceriskstressBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressBuffer::scale(self : FinanceriskstressBuffer, f : Double) -> FinanceriskstressBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressBuffer::add(self : FinanceriskstressBuffer, other : FinanceriskstressBuffer) -> FinanceriskstressBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressBuffer::copy(self : FinanceriskstressBuffer) -> FinanceriskstressBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressBuffer::fill(self : FinanceriskstressBuffer, v : Double) -> FinanceriskstressBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressBuffer::min(self : FinanceriskstressBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressBuffer::max(self : FinanceriskstressBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressBuffer::to_string(self : FinanceriskstressBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_cursor_make(size : Int) -> FinanceriskstressCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressCursor::len(self : FinanceriskstressCursor) -> Int { self.size }

pub fn FinanceriskstressCursor::get(self : FinanceriskstressCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressCursor::set(self : FinanceriskstressCursor, i : Int, v : Double) -> FinanceriskstressCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCursor::sum(self : FinanceriskstressCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressCursor::mean(self : FinanceriskstressCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressCursor::scale(self : FinanceriskstressCursor, f : Double) -> FinanceriskstressCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCursor::add(self : FinanceriskstressCursor, other : FinanceriskstressCursor) -> FinanceriskstressCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressCursor::copy(self : FinanceriskstressCursor) -> FinanceriskstressCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCursor::fill(self : FinanceriskstressCursor, v : Double) -> FinanceriskstressCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressCursor::min(self : FinanceriskstressCursor) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressCursor::max(self : FinanceriskstressCursor) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressCursor::to_string(self : FinanceriskstressCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_view_make(size : Int) -> FinanceriskstressView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressView::len(self : FinanceriskstressView) -> Int { self.size }

pub fn FinanceriskstressView::get(self : FinanceriskstressView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressView::set(self : FinanceriskstressView, i : Int, v : Double) -> FinanceriskstressView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressView::sum(self : FinanceriskstressView) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressView::mean(self : FinanceriskstressView) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressView::scale(self : FinanceriskstressView, f : Double) -> FinanceriskstressView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressView::add(self : FinanceriskstressView, other : FinanceriskstressView) -> FinanceriskstressView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressView::copy(self : FinanceriskstressView) -> FinanceriskstressView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressView::fill(self : FinanceriskstressView, v : Double) -> FinanceriskstressView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressView::min(self : FinanceriskstressView) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressView::max(self : FinanceriskstressView) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressView::to_string(self : FinanceriskstressView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_range_make(size : Int) -> FinanceriskstressRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressRange::len(self : FinanceriskstressRange) -> Int { self.size }

pub fn FinanceriskstressRange::get(self : FinanceriskstressRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressRange::set(self : FinanceriskstressRange, i : Int, v : Double) -> FinanceriskstressRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressRange::sum(self : FinanceriskstressRange) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressRange::mean(self : FinanceriskstressRange) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressRange::scale(self : FinanceriskstressRange, f : Double) -> FinanceriskstressRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressRange::add(self : FinanceriskstressRange, other : FinanceriskstressRange) -> FinanceriskstressRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressRange::copy(self : FinanceriskstressRange) -> FinanceriskstressRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressRange::fill(self : FinanceriskstressRange, v : Double) -> FinanceriskstressRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressRange::min(self : FinanceriskstressRange) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressRange::max(self : FinanceriskstressRange) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressRange::to_string(self : FinanceriskstressRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_slice_make(size : Int) -> FinanceriskstressSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceriskstressSlice::len(self : FinanceriskstressSlice) -> Int { self.size }

pub fn FinanceriskstressSlice::get(self : FinanceriskstressSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceriskstressSlice::set(self : FinanceriskstressSlice, i : Int, v : Double) -> FinanceriskstressSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceriskstressSlice::sum(self : FinanceriskstressSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceriskstressSlice::mean(self : FinanceriskstressSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceriskstressSlice::scale(self : FinanceriskstressSlice, f : Double) -> FinanceriskstressSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressSlice::add(self : FinanceriskstressSlice, other : FinanceriskstressSlice) -> FinanceriskstressSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceriskstressSlice::copy(self : FinanceriskstressSlice) -> FinanceriskstressSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressSlice::fill(self : FinanceriskstressSlice, v : Double) -> FinanceriskstressSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceriskstressSlice::min(self : FinanceriskstressSlice) -> Double { @_common.min(self.data) }

pub fn FinanceriskstressSlice::max(self : FinanceriskstressSlice) -> Double { @_common.max(self.data) }

pub fn FinanceriskstressSlice::to_string(self : FinanceriskstressSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

