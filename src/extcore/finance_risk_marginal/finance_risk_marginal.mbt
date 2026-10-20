///===
/// extcore/finance_risk_marginal

pub(all) struct FinanceriskmarginalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_marginal_make_point(x : Double, y : Double) -> FinanceriskmarginalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_marginal_make_point3(x : Double, y : Double, z : Double) -> FinanceriskmarginalPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskmarginalPoint::x(self : FinanceriskmarginalPoint) -> Double { self.x }

pub fn FinanceriskmarginalPoint::y(self : FinanceriskmarginalPoint) -> Double { self.y }

pub fn FinanceriskmarginalPoint::z(self : FinanceriskmarginalPoint) -> Double { self.z }

pub fn FinanceriskmarginalPoint::label(self : FinanceriskmarginalPoint) -> Int { self.label }

pub fn FinanceriskmarginalPoint::dist(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskmarginalPoint::add(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskmarginalPoint::sub(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskmarginalPoint::scale(self : FinanceriskmarginalPoint, s : Double) -> FinanceriskmarginalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskmarginalPoint::dot(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskmarginalPoint::cross(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskmarginalPoint::norm(self : FinanceriskmarginalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskmarginalPoint::normalize(self : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskmarginalPoint::negate(self : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskmarginalPoint::mid(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskmarginalPoint::lerp(self : FinanceriskmarginalPoint, other : FinanceriskmarginalPoint, t : Double) -> FinanceriskmarginalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskmarginalPoint::to_string(self : FinanceriskmarginalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskmarginalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_marginal_make_series(vals : Array[Double], name : String) -> FinanceriskmarginalSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskmarginalSeries::len(self : FinanceriskmarginalSeries) -> Int { self.vals.length() }

pub fn FinanceriskmarginalSeries::sum(self : FinanceriskmarginalSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskmarginalSeries::mean(self : FinanceriskmarginalSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskmarginalSeries::min(self : FinanceriskmarginalSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskmarginalSeries::max(self : FinanceriskmarginalSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskmarginalSeries::range(self : FinanceriskmarginalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskmarginalSeries::variance(self : FinanceriskmarginalSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskmarginalSeries::std(self : FinanceriskmarginalSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskmarginalSeries::median(self : FinanceriskmarginalSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskmarginalSeries::scale(self : FinanceriskmarginalSeries, f : Double) -> FinanceriskmarginalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskmarginalSeries::add(self : FinanceriskmarginalSeries, other : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskmarginalSeries::sub(self : FinanceriskmarginalSeries, other : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskmarginalSeries::normalize(self : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskmarginalSeries::cumsum(self : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskmarginalSeries::to_string(self : FinanceriskmarginalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskmarginalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_marginal_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskmarginalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_marginal_matrix_identity(n : Int) -> FinanceriskmarginalMatrix {
  let m = finance_risk_marginal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskmarginalMatrix::get(self : FinanceriskmarginalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskmarginalMatrix::transpose(self : FinanceriskmarginalMatrix) -> FinanceriskmarginalMatrix {
  let result = finance_risk_marginal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskmarginalMatrix::add(self : FinanceriskmarginalMatrix, other : FinanceriskmarginalMatrix) -> FinanceriskmarginalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_marginal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskmarginalMatrix::scale(self : FinanceriskmarginalMatrix, s : Double) -> FinanceriskmarginalMatrix {
  let result = finance_risk_marginal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskmarginalMatrix::multiply(self : FinanceriskmarginalMatrix, other : FinanceriskmarginalMatrix) -> FinanceriskmarginalMatrix {
  if self.cols != other.rows { return finance_risk_marginal_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_marginal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskmarginalMatrix::trace(self : FinanceriskmarginalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskmarginalMatrix::det(self : FinanceriskmarginalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskmarginalMatrix::norm(self : FinanceriskmarginalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskmarginalMatrix::to_string(self : FinanceriskmarginalMatrix) -> String {
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

pub(all) struct FinanceriskmarginalVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_marginal_make_vector(comps : Array[Double]) -> FinanceriskmarginalVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_marginal_vector_zero(dim : Int) -> FinanceriskmarginalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskmarginalVector::add(self : FinanceriskmarginalVector, other : FinanceriskmarginalVector) -> FinanceriskmarginalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskmarginalVector::sub(self : FinanceriskmarginalVector, other : FinanceriskmarginalVector) -> FinanceriskmarginalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskmarginalVector::scale(self : FinanceriskmarginalVector, s : Double) -> FinanceriskmarginalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskmarginalVector::dot(self : FinanceriskmarginalVector, other : FinanceriskmarginalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskmarginalVector::norm(self : FinanceriskmarginalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskmarginalVector::normalize(self : FinanceriskmarginalVector) -> FinanceriskmarginalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskmarginalVector::dist(self : FinanceriskmarginalVector, other : FinanceriskmarginalVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskmarginalVector::to_string(self : FinanceriskmarginalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_marginal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_marginal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_marginal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_marginal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_marginal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_marginal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_marginal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_marginal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_marginal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_marginal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_marginal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_marginal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_marginal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_marginal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_marginal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_marginal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_marginal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_marginal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_marginal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_marginal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_marginal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_marginal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_marginal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_marginal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_marginal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_marginal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_marginal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_marginal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_marginal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskmarginalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_frame_make(size : Int) -> FinanceriskmarginalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_frame_len(s : FinanceriskmarginalFrame) -> Int { s.size }

pub fn finance_risk_marginal_frame_get(s : FinanceriskmarginalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_frame_set(s : FinanceriskmarginalFrame, i : Int, v : Double) -> FinanceriskmarginalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_frame_sum(s : FinanceriskmarginalFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_frame_mean(s : FinanceriskmarginalFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_frame_scale(s : FinanceriskmarginalFrame, f : Double) -> FinanceriskmarginalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_frame_add(a : FinanceriskmarginalFrame, b : FinanceriskmarginalFrame) -> FinanceriskmarginalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_frame_copy(s : FinanceriskmarginalFrame) -> FinanceriskmarginalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_frame_fill(s : FinanceriskmarginalFrame, v : Double) -> FinanceriskmarginalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_frame_min(s : FinanceriskmarginalFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_frame_max(s : FinanceriskmarginalFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_frame_to_string(s : FinanceriskmarginalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_table_make(size : Int) -> FinanceriskmarginalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_table_len(s : FinanceriskmarginalTable) -> Int { s.size }

pub fn finance_risk_marginal_table_get(s : FinanceriskmarginalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_table_set(s : FinanceriskmarginalTable, i : Int, v : Double) -> FinanceriskmarginalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_table_sum(s : FinanceriskmarginalTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_table_mean(s : FinanceriskmarginalTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_table_scale(s : FinanceriskmarginalTable, f : Double) -> FinanceriskmarginalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_table_add(a : FinanceriskmarginalTable, b : FinanceriskmarginalTable) -> FinanceriskmarginalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_table_copy(s : FinanceriskmarginalTable) -> FinanceriskmarginalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_table_fill(s : FinanceriskmarginalTable, v : Double) -> FinanceriskmarginalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_table_min(s : FinanceriskmarginalTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_table_max(s : FinanceriskmarginalTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_table_to_string(s : FinanceriskmarginalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_graphn_make(size : Int) -> FinanceriskmarginalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_graphn_len(s : FinanceriskmarginalGraphN) -> Int { s.size }

pub fn finance_risk_marginal_graphn_get(s : FinanceriskmarginalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_graphn_set(s : FinanceriskmarginalGraphN, i : Int, v : Double) -> FinanceriskmarginalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_graphn_sum(s : FinanceriskmarginalGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_graphn_mean(s : FinanceriskmarginalGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_graphn_scale(s : FinanceriskmarginalGraphN, f : Double) -> FinanceriskmarginalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_graphn_add(a : FinanceriskmarginalGraphN, b : FinanceriskmarginalGraphN) -> FinanceriskmarginalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_graphn_copy(s : FinanceriskmarginalGraphN) -> FinanceriskmarginalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_graphn_fill(s : FinanceriskmarginalGraphN, v : Double) -> FinanceriskmarginalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_graphn_min(s : FinanceriskmarginalGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_graphn_max(s : FinanceriskmarginalGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_graphn_to_string(s : FinanceriskmarginalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_node_make(size : Int) -> FinanceriskmarginalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_node_len(s : FinanceriskmarginalNode) -> Int { s.size }

pub fn finance_risk_marginal_node_get(s : FinanceriskmarginalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_node_set(s : FinanceriskmarginalNode, i : Int, v : Double) -> FinanceriskmarginalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_node_sum(s : FinanceriskmarginalNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_node_mean(s : FinanceriskmarginalNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_node_scale(s : FinanceriskmarginalNode, f : Double) -> FinanceriskmarginalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_node_add(a : FinanceriskmarginalNode, b : FinanceriskmarginalNode) -> FinanceriskmarginalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_node_copy(s : FinanceriskmarginalNode) -> FinanceriskmarginalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_node_fill(s : FinanceriskmarginalNode, v : Double) -> FinanceriskmarginalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_node_min(s : FinanceriskmarginalNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_node_max(s : FinanceriskmarginalNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_node_to_string(s : FinanceriskmarginalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_edge_make(size : Int) -> FinanceriskmarginalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_edge_len(s : FinanceriskmarginalEdge) -> Int { s.size }

pub fn finance_risk_marginal_edge_get(s : FinanceriskmarginalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_edge_set(s : FinanceriskmarginalEdge, i : Int, v : Double) -> FinanceriskmarginalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_edge_sum(s : FinanceriskmarginalEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_edge_mean(s : FinanceriskmarginalEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_edge_scale(s : FinanceriskmarginalEdge, f : Double) -> FinanceriskmarginalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_edge_add(a : FinanceriskmarginalEdge, b : FinanceriskmarginalEdge) -> FinanceriskmarginalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_edge_copy(s : FinanceriskmarginalEdge) -> FinanceriskmarginalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_edge_fill(s : FinanceriskmarginalEdge, v : Double) -> FinanceriskmarginalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_edge_min(s : FinanceriskmarginalEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_edge_max(s : FinanceriskmarginalEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_edge_to_string(s : FinanceriskmarginalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_path_make(size : Int) -> FinanceriskmarginalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_path_len(s : FinanceriskmarginalPath) -> Int { s.size }

pub fn finance_risk_marginal_path_get(s : FinanceriskmarginalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_path_set(s : FinanceriskmarginalPath, i : Int, v : Double) -> FinanceriskmarginalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_path_sum(s : FinanceriskmarginalPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_path_mean(s : FinanceriskmarginalPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_path_scale(s : FinanceriskmarginalPath, f : Double) -> FinanceriskmarginalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_path_add(a : FinanceriskmarginalPath, b : FinanceriskmarginalPath) -> FinanceriskmarginalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_path_copy(s : FinanceriskmarginalPath) -> FinanceriskmarginalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_path_fill(s : FinanceriskmarginalPath, v : Double) -> FinanceriskmarginalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_path_min(s : FinanceriskmarginalPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_path_max(s : FinanceriskmarginalPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_path_to_string(s : FinanceriskmarginalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_cluster_make(size : Int) -> FinanceriskmarginalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_cluster_len(s : FinanceriskmarginalCluster) -> Int { s.size }

pub fn finance_risk_marginal_cluster_get(s : FinanceriskmarginalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_cluster_set(s : FinanceriskmarginalCluster, i : Int, v : Double) -> FinanceriskmarginalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cluster_sum(s : FinanceriskmarginalCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_cluster_mean(s : FinanceriskmarginalCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_cluster_scale(s : FinanceriskmarginalCluster, f : Double) -> FinanceriskmarginalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cluster_add(a : FinanceriskmarginalCluster, b : FinanceriskmarginalCluster) -> FinanceriskmarginalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_cluster_copy(s : FinanceriskmarginalCluster) -> FinanceriskmarginalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cluster_fill(s : FinanceriskmarginalCluster, v : Double) -> FinanceriskmarginalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cluster_min(s : FinanceriskmarginalCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_cluster_max(s : FinanceriskmarginalCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_cluster_to_string(s : FinanceriskmarginalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_model_make(size : Int) -> FinanceriskmarginalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_model_len(s : FinanceriskmarginalModel) -> Int { s.size }

pub fn finance_risk_marginal_model_get(s : FinanceriskmarginalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_model_set(s : FinanceriskmarginalModel, i : Int, v : Double) -> FinanceriskmarginalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_model_sum(s : FinanceriskmarginalModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_model_mean(s : FinanceriskmarginalModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_model_scale(s : FinanceriskmarginalModel, f : Double) -> FinanceriskmarginalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_model_add(a : FinanceriskmarginalModel, b : FinanceriskmarginalModel) -> FinanceriskmarginalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_model_copy(s : FinanceriskmarginalModel) -> FinanceriskmarginalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_model_fill(s : FinanceriskmarginalModel, v : Double) -> FinanceriskmarginalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_model_min(s : FinanceriskmarginalModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_model_max(s : FinanceriskmarginalModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_model_to_string(s : FinanceriskmarginalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_layer_make(size : Int) -> FinanceriskmarginalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_layer_len(s : FinanceriskmarginalLayer) -> Int { s.size }

pub fn finance_risk_marginal_layer_get(s : FinanceriskmarginalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_layer_set(s : FinanceriskmarginalLayer, i : Int, v : Double) -> FinanceriskmarginalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_layer_sum(s : FinanceriskmarginalLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_layer_mean(s : FinanceriskmarginalLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_layer_scale(s : FinanceriskmarginalLayer, f : Double) -> FinanceriskmarginalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_layer_add(a : FinanceriskmarginalLayer, b : FinanceriskmarginalLayer) -> FinanceriskmarginalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_layer_copy(s : FinanceriskmarginalLayer) -> FinanceriskmarginalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_layer_fill(s : FinanceriskmarginalLayer, v : Double) -> FinanceriskmarginalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_layer_min(s : FinanceriskmarginalLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_layer_max(s : FinanceriskmarginalLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_layer_to_string(s : FinanceriskmarginalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_buffer_make(size : Int) -> FinanceriskmarginalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_buffer_len(s : FinanceriskmarginalBuffer) -> Int { s.size }

pub fn finance_risk_marginal_buffer_get(s : FinanceriskmarginalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_buffer_set(s : FinanceriskmarginalBuffer, i : Int, v : Double) -> FinanceriskmarginalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_buffer_sum(s : FinanceriskmarginalBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_buffer_mean(s : FinanceriskmarginalBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_buffer_scale(s : FinanceriskmarginalBuffer, f : Double) -> FinanceriskmarginalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_buffer_add(a : FinanceriskmarginalBuffer, b : FinanceriskmarginalBuffer) -> FinanceriskmarginalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_buffer_copy(s : FinanceriskmarginalBuffer) -> FinanceriskmarginalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_buffer_fill(s : FinanceriskmarginalBuffer, v : Double) -> FinanceriskmarginalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_buffer_min(s : FinanceriskmarginalBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_buffer_max(s : FinanceriskmarginalBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_buffer_to_string(s : FinanceriskmarginalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_cursor_make(size : Int) -> FinanceriskmarginalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_cursor_len(s : FinanceriskmarginalCursor) -> Int { s.size }

pub fn finance_risk_marginal_cursor_get(s : FinanceriskmarginalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_cursor_set(s : FinanceriskmarginalCursor, i : Int, v : Double) -> FinanceriskmarginalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cursor_sum(s : FinanceriskmarginalCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_cursor_mean(s : FinanceriskmarginalCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_cursor_scale(s : FinanceriskmarginalCursor, f : Double) -> FinanceriskmarginalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cursor_add(a : FinanceriskmarginalCursor, b : FinanceriskmarginalCursor) -> FinanceriskmarginalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_cursor_copy(s : FinanceriskmarginalCursor) -> FinanceriskmarginalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cursor_fill(s : FinanceriskmarginalCursor, v : Double) -> FinanceriskmarginalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_cursor_min(s : FinanceriskmarginalCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_cursor_max(s : FinanceriskmarginalCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_cursor_to_string(s : FinanceriskmarginalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_view_make(size : Int) -> FinanceriskmarginalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_view_len(s : FinanceriskmarginalView) -> Int { s.size }

pub fn finance_risk_marginal_view_get(s : FinanceriskmarginalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_view_set(s : FinanceriskmarginalView, i : Int, v : Double) -> FinanceriskmarginalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_view_sum(s : FinanceriskmarginalView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_view_mean(s : FinanceriskmarginalView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_view_scale(s : FinanceriskmarginalView, f : Double) -> FinanceriskmarginalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_view_add(a : FinanceriskmarginalView, b : FinanceriskmarginalView) -> FinanceriskmarginalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_view_copy(s : FinanceriskmarginalView) -> FinanceriskmarginalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_view_fill(s : FinanceriskmarginalView, v : Double) -> FinanceriskmarginalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_view_min(s : FinanceriskmarginalView) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_view_max(s : FinanceriskmarginalView) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_view_to_string(s : FinanceriskmarginalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_range_make(size : Int) -> FinanceriskmarginalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_range_len(s : FinanceriskmarginalRange) -> Int { s.size }

pub fn finance_risk_marginal_range_get(s : FinanceriskmarginalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_range_set(s : FinanceriskmarginalRange, i : Int, v : Double) -> FinanceriskmarginalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_range_sum(s : FinanceriskmarginalRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_range_mean(s : FinanceriskmarginalRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_range_scale(s : FinanceriskmarginalRange, f : Double) -> FinanceriskmarginalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_range_add(a : FinanceriskmarginalRange, b : FinanceriskmarginalRange) -> FinanceriskmarginalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_range_copy(s : FinanceriskmarginalRange) -> FinanceriskmarginalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_range_fill(s : FinanceriskmarginalRange, v : Double) -> FinanceriskmarginalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_range_min(s : FinanceriskmarginalRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_range_max(s : FinanceriskmarginalRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_range_to_string(s : FinanceriskmarginalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_slice_make(size : Int) -> FinanceriskmarginalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_slice_len(s : FinanceriskmarginalSlice) -> Int { s.size }

pub fn finance_risk_marginal_slice_get(s : FinanceriskmarginalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_slice_set(s : FinanceriskmarginalSlice, i : Int, v : Double) -> FinanceriskmarginalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_slice_sum(s : FinanceriskmarginalSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_marginal_slice_mean(s : FinanceriskmarginalSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_marginal_slice_scale(s : FinanceriskmarginalSlice, f : Double) -> FinanceriskmarginalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_slice_add(a : FinanceriskmarginalSlice, b : FinanceriskmarginalSlice) -> FinanceriskmarginalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_marginal_slice_copy(s : FinanceriskmarginalSlice) -> FinanceriskmarginalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_slice_fill(s : FinanceriskmarginalSlice, v : Double) -> FinanceriskmarginalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_marginal_slice_min(s : FinanceriskmarginalSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_marginal_slice_max(s : FinanceriskmarginalSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_marginal_slice_to_string(s : FinanceriskmarginalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

