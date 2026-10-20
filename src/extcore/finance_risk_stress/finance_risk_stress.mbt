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

pub fn finance_risk_stress_frame_len(s : FinanceriskstressFrame) -> Int { s.size }

pub fn finance_risk_stress_frame_get(s : FinanceriskstressFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_frame_set(s : FinanceriskstressFrame, i : Int, v : Double) -> FinanceriskstressFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_frame_sum(s : FinanceriskstressFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_frame_mean(s : FinanceriskstressFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_frame_scale(s : FinanceriskstressFrame, f : Double) -> FinanceriskstressFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_frame_add(a : FinanceriskstressFrame, b : FinanceriskstressFrame) -> FinanceriskstressFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_frame_copy(s : FinanceriskstressFrame) -> FinanceriskstressFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_frame_fill(s : FinanceriskstressFrame, v : Double) -> FinanceriskstressFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_frame_min(s : FinanceriskstressFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_frame_max(s : FinanceriskstressFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_frame_to_string(s : FinanceriskstressFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_table_make(size : Int) -> FinanceriskstressTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_table_len(s : FinanceriskstressTable) -> Int { s.size }

pub fn finance_risk_stress_table_get(s : FinanceriskstressTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_table_set(s : FinanceriskstressTable, i : Int, v : Double) -> FinanceriskstressTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_table_sum(s : FinanceriskstressTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_table_mean(s : FinanceriskstressTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_table_scale(s : FinanceriskstressTable, f : Double) -> FinanceriskstressTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_table_add(a : FinanceriskstressTable, b : FinanceriskstressTable) -> FinanceriskstressTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_table_copy(s : FinanceriskstressTable) -> FinanceriskstressTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_table_fill(s : FinanceriskstressTable, v : Double) -> FinanceriskstressTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_table_min(s : FinanceriskstressTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_table_max(s : FinanceriskstressTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_table_to_string(s : FinanceriskstressTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_graphn_make(size : Int) -> FinanceriskstressGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_graphn_len(s : FinanceriskstressGraphN) -> Int { s.size }

pub fn finance_risk_stress_graphn_get(s : FinanceriskstressGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_graphn_set(s : FinanceriskstressGraphN, i : Int, v : Double) -> FinanceriskstressGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_graphn_sum(s : FinanceriskstressGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_graphn_mean(s : FinanceriskstressGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_graphn_scale(s : FinanceriskstressGraphN, f : Double) -> FinanceriskstressGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_graphn_add(a : FinanceriskstressGraphN, b : FinanceriskstressGraphN) -> FinanceriskstressGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_graphn_copy(s : FinanceriskstressGraphN) -> FinanceriskstressGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_graphn_fill(s : FinanceriskstressGraphN, v : Double) -> FinanceriskstressGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_graphn_min(s : FinanceriskstressGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_graphn_max(s : FinanceriskstressGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_graphn_to_string(s : FinanceriskstressGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_node_make(size : Int) -> FinanceriskstressNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_node_len(s : FinanceriskstressNode) -> Int { s.size }

pub fn finance_risk_stress_node_get(s : FinanceriskstressNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_node_set(s : FinanceriskstressNode, i : Int, v : Double) -> FinanceriskstressNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_node_sum(s : FinanceriskstressNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_node_mean(s : FinanceriskstressNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_node_scale(s : FinanceriskstressNode, f : Double) -> FinanceriskstressNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_node_add(a : FinanceriskstressNode, b : FinanceriskstressNode) -> FinanceriskstressNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_node_copy(s : FinanceriskstressNode) -> FinanceriskstressNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_node_fill(s : FinanceriskstressNode, v : Double) -> FinanceriskstressNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_node_min(s : FinanceriskstressNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_node_max(s : FinanceriskstressNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_node_to_string(s : FinanceriskstressNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_edge_make(size : Int) -> FinanceriskstressEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_edge_len(s : FinanceriskstressEdge) -> Int { s.size }

pub fn finance_risk_stress_edge_get(s : FinanceriskstressEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_edge_set(s : FinanceriskstressEdge, i : Int, v : Double) -> FinanceriskstressEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_edge_sum(s : FinanceriskstressEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_edge_mean(s : FinanceriskstressEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_edge_scale(s : FinanceriskstressEdge, f : Double) -> FinanceriskstressEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_edge_add(a : FinanceriskstressEdge, b : FinanceriskstressEdge) -> FinanceriskstressEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_edge_copy(s : FinanceriskstressEdge) -> FinanceriskstressEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_edge_fill(s : FinanceriskstressEdge, v : Double) -> FinanceriskstressEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_edge_min(s : FinanceriskstressEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_edge_max(s : FinanceriskstressEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_edge_to_string(s : FinanceriskstressEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_path_make(size : Int) -> FinanceriskstressPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_path_len(s : FinanceriskstressPath) -> Int { s.size }

pub fn finance_risk_stress_path_get(s : FinanceriskstressPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_path_set(s : FinanceriskstressPath, i : Int, v : Double) -> FinanceriskstressPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_path_sum(s : FinanceriskstressPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_path_mean(s : FinanceriskstressPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_path_scale(s : FinanceriskstressPath, f : Double) -> FinanceriskstressPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_path_add(a : FinanceriskstressPath, b : FinanceriskstressPath) -> FinanceriskstressPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_path_copy(s : FinanceriskstressPath) -> FinanceriskstressPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_path_fill(s : FinanceriskstressPath, v : Double) -> FinanceriskstressPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_path_min(s : FinanceriskstressPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_path_max(s : FinanceriskstressPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_path_to_string(s : FinanceriskstressPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_cluster_make(size : Int) -> FinanceriskstressCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_cluster_len(s : FinanceriskstressCluster) -> Int { s.size }

pub fn finance_risk_stress_cluster_get(s : FinanceriskstressCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_cluster_set(s : FinanceriskstressCluster, i : Int, v : Double) -> FinanceriskstressCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cluster_sum(s : FinanceriskstressCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_cluster_mean(s : FinanceriskstressCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_cluster_scale(s : FinanceriskstressCluster, f : Double) -> FinanceriskstressCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cluster_add(a : FinanceriskstressCluster, b : FinanceriskstressCluster) -> FinanceriskstressCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_cluster_copy(s : FinanceriskstressCluster) -> FinanceriskstressCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cluster_fill(s : FinanceriskstressCluster, v : Double) -> FinanceriskstressCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cluster_min(s : FinanceriskstressCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_cluster_max(s : FinanceriskstressCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_cluster_to_string(s : FinanceriskstressCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_model_make(size : Int) -> FinanceriskstressModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_model_len(s : FinanceriskstressModel) -> Int { s.size }

pub fn finance_risk_stress_model_get(s : FinanceriskstressModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_model_set(s : FinanceriskstressModel, i : Int, v : Double) -> FinanceriskstressModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_model_sum(s : FinanceriskstressModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_model_mean(s : FinanceriskstressModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_model_scale(s : FinanceriskstressModel, f : Double) -> FinanceriskstressModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_model_add(a : FinanceriskstressModel, b : FinanceriskstressModel) -> FinanceriskstressModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_model_copy(s : FinanceriskstressModel) -> FinanceriskstressModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_model_fill(s : FinanceriskstressModel, v : Double) -> FinanceriskstressModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_model_min(s : FinanceriskstressModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_model_max(s : FinanceriskstressModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_model_to_string(s : FinanceriskstressModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_layer_make(size : Int) -> FinanceriskstressLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_layer_len(s : FinanceriskstressLayer) -> Int { s.size }

pub fn finance_risk_stress_layer_get(s : FinanceriskstressLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_layer_set(s : FinanceriskstressLayer, i : Int, v : Double) -> FinanceriskstressLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_layer_sum(s : FinanceriskstressLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_layer_mean(s : FinanceriskstressLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_layer_scale(s : FinanceriskstressLayer, f : Double) -> FinanceriskstressLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_layer_add(a : FinanceriskstressLayer, b : FinanceriskstressLayer) -> FinanceriskstressLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_layer_copy(s : FinanceriskstressLayer) -> FinanceriskstressLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_layer_fill(s : FinanceriskstressLayer, v : Double) -> FinanceriskstressLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_layer_min(s : FinanceriskstressLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_layer_max(s : FinanceriskstressLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_layer_to_string(s : FinanceriskstressLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_buffer_make(size : Int) -> FinanceriskstressBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_buffer_len(s : FinanceriskstressBuffer) -> Int { s.size }

pub fn finance_risk_stress_buffer_get(s : FinanceriskstressBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_buffer_set(s : FinanceriskstressBuffer, i : Int, v : Double) -> FinanceriskstressBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_buffer_sum(s : FinanceriskstressBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_buffer_mean(s : FinanceriskstressBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_buffer_scale(s : FinanceriskstressBuffer, f : Double) -> FinanceriskstressBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_buffer_add(a : FinanceriskstressBuffer, b : FinanceriskstressBuffer) -> FinanceriskstressBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_buffer_copy(s : FinanceriskstressBuffer) -> FinanceriskstressBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_buffer_fill(s : FinanceriskstressBuffer, v : Double) -> FinanceriskstressBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_buffer_min(s : FinanceriskstressBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_buffer_max(s : FinanceriskstressBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_buffer_to_string(s : FinanceriskstressBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_cursor_make(size : Int) -> FinanceriskstressCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_cursor_len(s : FinanceriskstressCursor) -> Int { s.size }

pub fn finance_risk_stress_cursor_get(s : FinanceriskstressCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_cursor_set(s : FinanceriskstressCursor, i : Int, v : Double) -> FinanceriskstressCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cursor_sum(s : FinanceriskstressCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_cursor_mean(s : FinanceriskstressCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_cursor_scale(s : FinanceriskstressCursor, f : Double) -> FinanceriskstressCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cursor_add(a : FinanceriskstressCursor, b : FinanceriskstressCursor) -> FinanceriskstressCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_cursor_copy(s : FinanceriskstressCursor) -> FinanceriskstressCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cursor_fill(s : FinanceriskstressCursor, v : Double) -> FinanceriskstressCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_cursor_min(s : FinanceriskstressCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_cursor_max(s : FinanceriskstressCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_cursor_to_string(s : FinanceriskstressCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_view_make(size : Int) -> FinanceriskstressView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_view_len(s : FinanceriskstressView) -> Int { s.size }

pub fn finance_risk_stress_view_get(s : FinanceriskstressView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_view_set(s : FinanceriskstressView, i : Int, v : Double) -> FinanceriskstressView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_view_sum(s : FinanceriskstressView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_view_mean(s : FinanceriskstressView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_view_scale(s : FinanceriskstressView, f : Double) -> FinanceriskstressView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_view_add(a : FinanceriskstressView, b : FinanceriskstressView) -> FinanceriskstressView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_view_copy(s : FinanceriskstressView) -> FinanceriskstressView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_view_fill(s : FinanceriskstressView, v : Double) -> FinanceriskstressView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_view_min(s : FinanceriskstressView) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_view_max(s : FinanceriskstressView) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_view_to_string(s : FinanceriskstressView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_range_make(size : Int) -> FinanceriskstressRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_range_len(s : FinanceriskstressRange) -> Int { s.size }

pub fn finance_risk_stress_range_get(s : FinanceriskstressRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_range_set(s : FinanceriskstressRange, i : Int, v : Double) -> FinanceriskstressRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_range_sum(s : FinanceriskstressRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_range_mean(s : FinanceriskstressRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_range_scale(s : FinanceriskstressRange, f : Double) -> FinanceriskstressRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_range_add(a : FinanceriskstressRange, b : FinanceriskstressRange) -> FinanceriskstressRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_range_copy(s : FinanceriskstressRange) -> FinanceriskstressRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_range_fill(s : FinanceriskstressRange, v : Double) -> FinanceriskstressRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_range_min(s : FinanceriskstressRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_range_max(s : FinanceriskstressRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_range_to_string(s : FinanceriskstressRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskstressSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_stress_slice_make(size : Int) -> FinanceriskstressSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_stress_slice_len(s : FinanceriskstressSlice) -> Int { s.size }

pub fn finance_risk_stress_slice_get(s : FinanceriskstressSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_stress_slice_set(s : FinanceriskstressSlice, i : Int, v : Double) -> FinanceriskstressSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_slice_sum(s : FinanceriskstressSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_stress_slice_mean(s : FinanceriskstressSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_stress_slice_scale(s : FinanceriskstressSlice, f : Double) -> FinanceriskstressSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_slice_add(a : FinanceriskstressSlice, b : FinanceriskstressSlice) -> FinanceriskstressSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_stress_slice_copy(s : FinanceriskstressSlice) -> FinanceriskstressSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_slice_fill(s : FinanceriskstressSlice, v : Double) -> FinanceriskstressSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_stress_slice_min(s : FinanceriskstressSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_stress_slice_max(s : FinanceriskstressSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_stress_slice_to_string(s : FinanceriskstressSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

