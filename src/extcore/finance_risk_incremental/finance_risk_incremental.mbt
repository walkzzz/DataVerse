///===
/// extcore/finance_risk_incremental

pub(all) struct FinanceriskincrementalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_incremental_make_point(x : Double, y : Double) -> FinanceriskincrementalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_incremental_make_point3(x : Double, y : Double, z : Double) -> FinanceriskincrementalPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceriskincrementalPoint::x(self : FinanceriskincrementalPoint) -> Double { self.x }

pub fn FinanceriskincrementalPoint::y(self : FinanceriskincrementalPoint) -> Double { self.y }

pub fn FinanceriskincrementalPoint::z(self : FinanceriskincrementalPoint) -> Double { self.z }

pub fn FinanceriskincrementalPoint::label(self : FinanceriskincrementalPoint) -> Int { self.label }

pub fn FinanceriskincrementalPoint::dist(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceriskincrementalPoint::add(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceriskincrementalPoint::sub(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceriskincrementalPoint::scale(self : FinanceriskincrementalPoint, s : Double) -> FinanceriskincrementalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceriskincrementalPoint::dot(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceriskincrementalPoint::cross(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceriskincrementalPoint::norm(self : FinanceriskincrementalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceriskincrementalPoint::normalize(self : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskincrementalPoint::negate(self : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceriskincrementalPoint::mid(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint) -> FinanceriskincrementalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceriskincrementalPoint::lerp(self : FinanceriskincrementalPoint, other : FinanceriskincrementalPoint, t : Double) -> FinanceriskincrementalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceriskincrementalPoint::to_string(self : FinanceriskincrementalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceriskincrementalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_incremental_make_series(vals : Array[Double], name : String) -> FinanceriskincrementalSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceriskincrementalSeries::len(self : FinanceriskincrementalSeries) -> Int { self.vals.length() }

pub fn FinanceriskincrementalSeries::sum(self : FinanceriskincrementalSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceriskincrementalSeries::mean(self : FinanceriskincrementalSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceriskincrementalSeries::min(self : FinanceriskincrementalSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceriskincrementalSeries::max(self : FinanceriskincrementalSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceriskincrementalSeries::range(self : FinanceriskincrementalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceriskincrementalSeries::variance(self : FinanceriskincrementalSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceriskincrementalSeries::std(self : FinanceriskincrementalSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceriskincrementalSeries::median(self : FinanceriskincrementalSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceriskincrementalSeries::scale(self : FinanceriskincrementalSeries, f : Double) -> FinanceriskincrementalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceriskincrementalSeries::add(self : FinanceriskincrementalSeries, other : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceriskincrementalSeries::sub(self : FinanceriskincrementalSeries, other : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceriskincrementalSeries::normalize(self : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceriskincrementalSeries::cumsum(self : FinanceriskincrementalSeries) -> FinanceriskincrementalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceriskincrementalSeries::to_string(self : FinanceriskincrementalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskincrementalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_incremental_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskincrementalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_incremental_matrix_identity(n : Int) -> FinanceriskincrementalMatrix {
  let m = finance_risk_incremental_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceriskincrementalMatrix::get(self : FinanceriskincrementalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceriskincrementalMatrix::transpose(self : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  let result = finance_risk_incremental_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceriskincrementalMatrix::add(self : FinanceriskincrementalMatrix, other : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_risk_incremental_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceriskincrementalMatrix::scale(self : FinanceriskincrementalMatrix, s : Double) -> FinanceriskincrementalMatrix {
  let result = finance_risk_incremental_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceriskincrementalMatrix::multiply(self : FinanceriskincrementalMatrix, other : FinanceriskincrementalMatrix) -> FinanceriskincrementalMatrix {
  if self.cols != other.rows { return finance_risk_incremental_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_risk_incremental_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceriskincrementalMatrix::trace(self : FinanceriskincrementalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceriskincrementalMatrix::det(self : FinanceriskincrementalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceriskincrementalMatrix::norm(self : FinanceriskincrementalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceriskincrementalMatrix::to_string(self : FinanceriskincrementalMatrix) -> String {
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

pub(all) struct FinanceriskincrementalVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_incremental_make_vector(comps : Array[Double]) -> FinanceriskincrementalVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_incremental_vector_zero(dim : Int) -> FinanceriskincrementalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceriskincrementalVector::add(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskincrementalVector::sub(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceriskincrementalVector::scale(self : FinanceriskincrementalVector, s : Double) -> FinanceriskincrementalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceriskincrementalVector::dot(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceriskincrementalVector::norm(self : FinanceriskincrementalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceriskincrementalVector::normalize(self : FinanceriskincrementalVector) -> FinanceriskincrementalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceriskincrementalVector::dist(self : FinanceriskincrementalVector, other : FinanceriskincrementalVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceriskincrementalVector::to_string(self : FinanceriskincrementalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_incremental_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_incremental_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_incremental_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_incremental_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_incremental_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_incremental_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_incremental_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_incremental_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_incremental_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_incremental_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_incremental_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_incremental_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_incremental_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_incremental_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_incremental_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_incremental_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_incremental_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_incremental_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_incremental_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_incremental_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_incremental_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_incremental_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_incremental_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_incremental_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_incremental_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_incremental_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_incremental_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_incremental_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_incremental_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskincrementalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_frame_make(size : Int) -> FinanceriskincrementalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_frame_len(s : FinanceriskincrementalFrame) -> Int { s.size }

pub fn finance_risk_incremental_frame_get(s : FinanceriskincrementalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_frame_set(s : FinanceriskincrementalFrame, i : Int, v : Double) -> FinanceriskincrementalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_frame_sum(s : FinanceriskincrementalFrame) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_frame_mean(s : FinanceriskincrementalFrame) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_frame_scale(s : FinanceriskincrementalFrame, f : Double) -> FinanceriskincrementalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_frame_add(a : FinanceriskincrementalFrame, b : FinanceriskincrementalFrame) -> FinanceriskincrementalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_frame_copy(s : FinanceriskincrementalFrame) -> FinanceriskincrementalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_frame_fill(s : FinanceriskincrementalFrame, v : Double) -> FinanceriskincrementalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_frame_min(s : FinanceriskincrementalFrame) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_frame_max(s : FinanceriskincrementalFrame) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_frame_to_string(s : FinanceriskincrementalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_table_make(size : Int) -> FinanceriskincrementalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_table_len(s : FinanceriskincrementalTable) -> Int { s.size }

pub fn finance_risk_incremental_table_get(s : FinanceriskincrementalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_table_set(s : FinanceriskincrementalTable, i : Int, v : Double) -> FinanceriskincrementalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_table_sum(s : FinanceriskincrementalTable) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_table_mean(s : FinanceriskincrementalTable) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_table_scale(s : FinanceriskincrementalTable, f : Double) -> FinanceriskincrementalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_table_add(a : FinanceriskincrementalTable, b : FinanceriskincrementalTable) -> FinanceriskincrementalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_table_copy(s : FinanceriskincrementalTable) -> FinanceriskincrementalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_table_fill(s : FinanceriskincrementalTable, v : Double) -> FinanceriskincrementalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_table_min(s : FinanceriskincrementalTable) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_table_max(s : FinanceriskincrementalTable) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_table_to_string(s : FinanceriskincrementalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_graphn_make(size : Int) -> FinanceriskincrementalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_graphn_len(s : FinanceriskincrementalGraphN) -> Int { s.size }

pub fn finance_risk_incremental_graphn_get(s : FinanceriskincrementalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_graphn_set(s : FinanceriskincrementalGraphN, i : Int, v : Double) -> FinanceriskincrementalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_graphn_sum(s : FinanceriskincrementalGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_graphn_mean(s : FinanceriskincrementalGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_graphn_scale(s : FinanceriskincrementalGraphN, f : Double) -> FinanceriskincrementalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_graphn_add(a : FinanceriskincrementalGraphN, b : FinanceriskincrementalGraphN) -> FinanceriskincrementalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_graphn_copy(s : FinanceriskincrementalGraphN) -> FinanceriskincrementalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_graphn_fill(s : FinanceriskincrementalGraphN, v : Double) -> FinanceriskincrementalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_graphn_min(s : FinanceriskincrementalGraphN) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_graphn_max(s : FinanceriskincrementalGraphN) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_graphn_to_string(s : FinanceriskincrementalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_node_make(size : Int) -> FinanceriskincrementalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_node_len(s : FinanceriskincrementalNode) -> Int { s.size }

pub fn finance_risk_incremental_node_get(s : FinanceriskincrementalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_node_set(s : FinanceriskincrementalNode, i : Int, v : Double) -> FinanceriskincrementalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_node_sum(s : FinanceriskincrementalNode) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_node_mean(s : FinanceriskincrementalNode) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_node_scale(s : FinanceriskincrementalNode, f : Double) -> FinanceriskincrementalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_node_add(a : FinanceriskincrementalNode, b : FinanceriskincrementalNode) -> FinanceriskincrementalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_node_copy(s : FinanceriskincrementalNode) -> FinanceriskincrementalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_node_fill(s : FinanceriskincrementalNode, v : Double) -> FinanceriskincrementalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_node_min(s : FinanceriskincrementalNode) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_node_max(s : FinanceriskincrementalNode) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_node_to_string(s : FinanceriskincrementalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_edge_make(size : Int) -> FinanceriskincrementalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_edge_len(s : FinanceriskincrementalEdge) -> Int { s.size }

pub fn finance_risk_incremental_edge_get(s : FinanceriskincrementalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_edge_set(s : FinanceriskincrementalEdge, i : Int, v : Double) -> FinanceriskincrementalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_edge_sum(s : FinanceriskincrementalEdge) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_edge_mean(s : FinanceriskincrementalEdge) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_edge_scale(s : FinanceriskincrementalEdge, f : Double) -> FinanceriskincrementalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_edge_add(a : FinanceriskincrementalEdge, b : FinanceriskincrementalEdge) -> FinanceriskincrementalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_edge_copy(s : FinanceriskincrementalEdge) -> FinanceriskincrementalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_edge_fill(s : FinanceriskincrementalEdge, v : Double) -> FinanceriskincrementalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_edge_min(s : FinanceriskincrementalEdge) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_edge_max(s : FinanceriskincrementalEdge) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_edge_to_string(s : FinanceriskincrementalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_path_make(size : Int) -> FinanceriskincrementalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_path_len(s : FinanceriskincrementalPath) -> Int { s.size }

pub fn finance_risk_incremental_path_get(s : FinanceriskincrementalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_path_set(s : FinanceriskincrementalPath, i : Int, v : Double) -> FinanceriskincrementalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_path_sum(s : FinanceriskincrementalPath) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_path_mean(s : FinanceriskincrementalPath) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_path_scale(s : FinanceriskincrementalPath, f : Double) -> FinanceriskincrementalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_path_add(a : FinanceriskincrementalPath, b : FinanceriskincrementalPath) -> FinanceriskincrementalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_path_copy(s : FinanceriskincrementalPath) -> FinanceriskincrementalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_path_fill(s : FinanceriskincrementalPath, v : Double) -> FinanceriskincrementalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_path_min(s : FinanceriskincrementalPath) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_path_max(s : FinanceriskincrementalPath) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_path_to_string(s : FinanceriskincrementalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_cluster_make(size : Int) -> FinanceriskincrementalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_cluster_len(s : FinanceriskincrementalCluster) -> Int { s.size }

pub fn finance_risk_incremental_cluster_get(s : FinanceriskincrementalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_cluster_set(s : FinanceriskincrementalCluster, i : Int, v : Double) -> FinanceriskincrementalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cluster_sum(s : FinanceriskincrementalCluster) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_cluster_mean(s : FinanceriskincrementalCluster) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_cluster_scale(s : FinanceriskincrementalCluster, f : Double) -> FinanceriskincrementalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cluster_add(a : FinanceriskincrementalCluster, b : FinanceriskincrementalCluster) -> FinanceriskincrementalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_cluster_copy(s : FinanceriskincrementalCluster) -> FinanceriskincrementalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cluster_fill(s : FinanceriskincrementalCluster, v : Double) -> FinanceriskincrementalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cluster_min(s : FinanceriskincrementalCluster) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_cluster_max(s : FinanceriskincrementalCluster) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_cluster_to_string(s : FinanceriskincrementalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_model_make(size : Int) -> FinanceriskincrementalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_model_len(s : FinanceriskincrementalModel) -> Int { s.size }

pub fn finance_risk_incremental_model_get(s : FinanceriskincrementalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_model_set(s : FinanceriskincrementalModel, i : Int, v : Double) -> FinanceriskincrementalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_model_sum(s : FinanceriskincrementalModel) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_model_mean(s : FinanceriskincrementalModel) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_model_scale(s : FinanceriskincrementalModel, f : Double) -> FinanceriskincrementalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_model_add(a : FinanceriskincrementalModel, b : FinanceriskincrementalModel) -> FinanceriskincrementalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_model_copy(s : FinanceriskincrementalModel) -> FinanceriskincrementalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_model_fill(s : FinanceriskincrementalModel, v : Double) -> FinanceriskincrementalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_model_min(s : FinanceriskincrementalModel) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_model_max(s : FinanceriskincrementalModel) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_model_to_string(s : FinanceriskincrementalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_layer_make(size : Int) -> FinanceriskincrementalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_layer_len(s : FinanceriskincrementalLayer) -> Int { s.size }

pub fn finance_risk_incremental_layer_get(s : FinanceriskincrementalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_layer_set(s : FinanceriskincrementalLayer, i : Int, v : Double) -> FinanceriskincrementalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_layer_sum(s : FinanceriskincrementalLayer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_layer_mean(s : FinanceriskincrementalLayer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_layer_scale(s : FinanceriskincrementalLayer, f : Double) -> FinanceriskincrementalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_layer_add(a : FinanceriskincrementalLayer, b : FinanceriskincrementalLayer) -> FinanceriskincrementalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_layer_copy(s : FinanceriskincrementalLayer) -> FinanceriskincrementalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_layer_fill(s : FinanceriskincrementalLayer, v : Double) -> FinanceriskincrementalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_layer_min(s : FinanceriskincrementalLayer) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_layer_max(s : FinanceriskincrementalLayer) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_layer_to_string(s : FinanceriskincrementalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_buffer_make(size : Int) -> FinanceriskincrementalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_buffer_len(s : FinanceriskincrementalBuffer) -> Int { s.size }

pub fn finance_risk_incremental_buffer_get(s : FinanceriskincrementalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_buffer_set(s : FinanceriskincrementalBuffer, i : Int, v : Double) -> FinanceriskincrementalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_buffer_sum(s : FinanceriskincrementalBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_buffer_mean(s : FinanceriskincrementalBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_buffer_scale(s : FinanceriskincrementalBuffer, f : Double) -> FinanceriskincrementalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_buffer_add(a : FinanceriskincrementalBuffer, b : FinanceriskincrementalBuffer) -> FinanceriskincrementalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_buffer_copy(s : FinanceriskincrementalBuffer) -> FinanceriskincrementalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_buffer_fill(s : FinanceriskincrementalBuffer, v : Double) -> FinanceriskincrementalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_buffer_min(s : FinanceriskincrementalBuffer) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_buffer_max(s : FinanceriskincrementalBuffer) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_buffer_to_string(s : FinanceriskincrementalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_cursor_make(size : Int) -> FinanceriskincrementalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_cursor_len(s : FinanceriskincrementalCursor) -> Int { s.size }

pub fn finance_risk_incremental_cursor_get(s : FinanceriskincrementalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_cursor_set(s : FinanceriskincrementalCursor, i : Int, v : Double) -> FinanceriskincrementalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cursor_sum(s : FinanceriskincrementalCursor) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_cursor_mean(s : FinanceriskincrementalCursor) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_cursor_scale(s : FinanceriskincrementalCursor, f : Double) -> FinanceriskincrementalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cursor_add(a : FinanceriskincrementalCursor, b : FinanceriskincrementalCursor) -> FinanceriskincrementalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_cursor_copy(s : FinanceriskincrementalCursor) -> FinanceriskincrementalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cursor_fill(s : FinanceriskincrementalCursor, v : Double) -> FinanceriskincrementalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_cursor_min(s : FinanceriskincrementalCursor) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_cursor_max(s : FinanceriskincrementalCursor) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_cursor_to_string(s : FinanceriskincrementalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_view_make(size : Int) -> FinanceriskincrementalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_view_len(s : FinanceriskincrementalView) -> Int { s.size }

pub fn finance_risk_incremental_view_get(s : FinanceriskincrementalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_view_set(s : FinanceriskincrementalView, i : Int, v : Double) -> FinanceriskincrementalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_view_sum(s : FinanceriskincrementalView) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_view_mean(s : FinanceriskincrementalView) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_view_scale(s : FinanceriskincrementalView, f : Double) -> FinanceriskincrementalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_view_add(a : FinanceriskincrementalView, b : FinanceriskincrementalView) -> FinanceriskincrementalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_view_copy(s : FinanceriskincrementalView) -> FinanceriskincrementalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_view_fill(s : FinanceriskincrementalView, v : Double) -> FinanceriskincrementalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_view_min(s : FinanceriskincrementalView) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_view_max(s : FinanceriskincrementalView) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_view_to_string(s : FinanceriskincrementalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_range_make(size : Int) -> FinanceriskincrementalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_range_len(s : FinanceriskincrementalRange) -> Int { s.size }

pub fn finance_risk_incremental_range_get(s : FinanceriskincrementalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_range_set(s : FinanceriskincrementalRange, i : Int, v : Double) -> FinanceriskincrementalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_range_sum(s : FinanceriskincrementalRange) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_range_mean(s : FinanceriskincrementalRange) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_range_scale(s : FinanceriskincrementalRange, f : Double) -> FinanceriskincrementalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_range_add(a : FinanceriskincrementalRange, b : FinanceriskincrementalRange) -> FinanceriskincrementalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_range_copy(s : FinanceriskincrementalRange) -> FinanceriskincrementalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_range_fill(s : FinanceriskincrementalRange, v : Double) -> FinanceriskincrementalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_range_min(s : FinanceriskincrementalRange) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_range_max(s : FinanceriskincrementalRange) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_range_to_string(s : FinanceriskincrementalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskincrementalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_incremental_slice_make(size : Int) -> FinanceriskincrementalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_incremental_slice_len(s : FinanceriskincrementalSlice) -> Int { s.size }

pub fn finance_risk_incremental_slice_get(s : FinanceriskincrementalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_incremental_slice_set(s : FinanceriskincrementalSlice, i : Int, v : Double) -> FinanceriskincrementalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_slice_sum(s : FinanceriskincrementalSlice) -> Double { @_common.sum(s.data) }

pub fn finance_risk_incremental_slice_mean(s : FinanceriskincrementalSlice) -> Double { @_common.mean(s.data) }

pub fn finance_risk_incremental_slice_scale(s : FinanceriskincrementalSlice, f : Double) -> FinanceriskincrementalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_slice_add(a : FinanceriskincrementalSlice, b : FinanceriskincrementalSlice) -> FinanceriskincrementalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_risk_incremental_slice_copy(s : FinanceriskincrementalSlice) -> FinanceriskincrementalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_slice_fill(s : FinanceriskincrementalSlice, v : Double) -> FinanceriskincrementalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_risk_incremental_slice_min(s : FinanceriskincrementalSlice) -> Double { @_common.min(s.data) }

pub fn finance_risk_incremental_slice_max(s : FinanceriskincrementalSlice) -> Double { @_common.max(s.data) }

pub fn finance_risk_incremental_slice_to_string(s : FinanceriskincrementalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

