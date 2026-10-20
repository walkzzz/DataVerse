///===
/// extcore/finance_portfolio_capm

pub(all) struct FinanceportfoliocapmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_capm_make_point(x : Double, y : Double) -> FinanceportfoliocapmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_capm_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliocapmPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliocapmPoint::x(self : FinanceportfoliocapmPoint) -> Double { self.x }

pub fn FinanceportfoliocapmPoint::y(self : FinanceportfoliocapmPoint) -> Double { self.y }

pub fn FinanceportfoliocapmPoint::z(self : FinanceportfoliocapmPoint) -> Double { self.z }

pub fn FinanceportfoliocapmPoint::label(self : FinanceportfoliocapmPoint) -> Int { self.label }

pub fn FinanceportfoliocapmPoint::dist(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliocapmPoint::add(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliocapmPoint::sub(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliocapmPoint::scale(self : FinanceportfoliocapmPoint, s : Double) -> FinanceportfoliocapmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliocapmPoint::dot(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliocapmPoint::cross(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliocapmPoint::norm(self : FinanceportfoliocapmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliocapmPoint::normalize(self : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliocapmPoint::negate(self : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliocapmPoint::mid(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint) -> FinanceportfoliocapmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliocapmPoint::lerp(self : FinanceportfoliocapmPoint, other : FinanceportfoliocapmPoint, t : Double) -> FinanceportfoliocapmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliocapmPoint::to_string(self : FinanceportfoliocapmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_capm_make_series(vals : Array[Double], name : String) -> FinanceportfoliocapmSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliocapmSeries::len(self : FinanceportfoliocapmSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliocapmSeries::sum(self : FinanceportfoliocapmSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliocapmSeries::mean(self : FinanceportfoliocapmSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliocapmSeries::min(self : FinanceportfoliocapmSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliocapmSeries::max(self : FinanceportfoliocapmSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliocapmSeries::range(self : FinanceportfoliocapmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliocapmSeries::variance(self : FinanceportfoliocapmSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliocapmSeries::std(self : FinanceportfoliocapmSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliocapmSeries::median(self : FinanceportfoliocapmSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliocapmSeries::scale(self : FinanceportfoliocapmSeries, f : Double) -> FinanceportfoliocapmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::add(self : FinanceportfoliocapmSeries, other : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::sub(self : FinanceportfoliocapmSeries, other : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::normalize(self : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliocapmSeries::cumsum(self : FinanceportfoliocapmSeries) -> FinanceportfoliocapmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliocapmSeries::to_string(self : FinanceportfoliocapmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliocapmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_capm_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliocapmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_capm_matrix_identity(n : Int) -> FinanceportfoliocapmMatrix {
  let m = finance_portfolio_capm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliocapmMatrix::get(self : FinanceportfoliocapmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliocapmMatrix::transpose(self : FinanceportfoliocapmMatrix) -> FinanceportfoliocapmMatrix {
  let result = finance_portfolio_capm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliocapmMatrix::add(self : FinanceportfoliocapmMatrix, other : FinanceportfoliocapmMatrix) -> FinanceportfoliocapmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_capm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliocapmMatrix::scale(self : FinanceportfoliocapmMatrix, s : Double) -> FinanceportfoliocapmMatrix {
  let result = finance_portfolio_capm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliocapmMatrix::multiply(self : FinanceportfoliocapmMatrix, other : FinanceportfoliocapmMatrix) -> FinanceportfoliocapmMatrix {
  if self.cols != other.rows { return finance_portfolio_capm_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_capm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfoliocapmMatrix::trace(self : FinanceportfoliocapmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliocapmMatrix::det(self : FinanceportfoliocapmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliocapmMatrix::norm(self : FinanceportfoliocapmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliocapmMatrix::to_string(self : FinanceportfoliocapmMatrix) -> String {
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

pub(all) struct FinanceportfoliocapmVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_capm_make_vector(comps : Array[Double]) -> FinanceportfoliocapmVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_capm_vector_zero(dim : Int) -> FinanceportfoliocapmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliocapmVector::add(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> FinanceportfoliocapmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliocapmVector::sub(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> FinanceportfoliocapmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliocapmVector::scale(self : FinanceportfoliocapmVector, s : Double) -> FinanceportfoliocapmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliocapmVector::dot(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliocapmVector::norm(self : FinanceportfoliocapmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliocapmVector::normalize(self : FinanceportfoliocapmVector) -> FinanceportfoliocapmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliocapmVector::dist(self : FinanceportfoliocapmVector, other : FinanceportfoliocapmVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliocapmVector::to_string(self : FinanceportfoliocapmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_capm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_capm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_capm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_capm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_capm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_capm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_capm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_capm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_capm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_capm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_capm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_capm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_capm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_capm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_capm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_capm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_capm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_capm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_capm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_capm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_capm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_capm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_capm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_capm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_capm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_capm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_capm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_capm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_capm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliocapmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_frame_make(size : Int) -> FinanceportfoliocapmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_frame_len(s : FinanceportfoliocapmFrame) -> Int { s.size }

pub fn finance_portfolio_capm_frame_get(s : FinanceportfoliocapmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_frame_set(s : FinanceportfoliocapmFrame, i : Int, v : Double) -> FinanceportfoliocapmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_frame_sum(s : FinanceportfoliocapmFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_frame_mean(s : FinanceportfoliocapmFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_frame_scale(s : FinanceportfoliocapmFrame, f : Double) -> FinanceportfoliocapmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_frame_add(a : FinanceportfoliocapmFrame, b : FinanceportfoliocapmFrame) -> FinanceportfoliocapmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_frame_copy(s : FinanceportfoliocapmFrame) -> FinanceportfoliocapmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_frame_fill(s : FinanceportfoliocapmFrame, v : Double) -> FinanceportfoliocapmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_frame_min(s : FinanceportfoliocapmFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_frame_max(s : FinanceportfoliocapmFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_frame_to_string(s : FinanceportfoliocapmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_table_make(size : Int) -> FinanceportfoliocapmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_table_len(s : FinanceportfoliocapmTable) -> Int { s.size }

pub fn finance_portfolio_capm_table_get(s : FinanceportfoliocapmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_table_set(s : FinanceportfoliocapmTable, i : Int, v : Double) -> FinanceportfoliocapmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_table_sum(s : FinanceportfoliocapmTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_table_mean(s : FinanceportfoliocapmTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_table_scale(s : FinanceportfoliocapmTable, f : Double) -> FinanceportfoliocapmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_table_add(a : FinanceportfoliocapmTable, b : FinanceportfoliocapmTable) -> FinanceportfoliocapmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_table_copy(s : FinanceportfoliocapmTable) -> FinanceportfoliocapmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_table_fill(s : FinanceportfoliocapmTable, v : Double) -> FinanceportfoliocapmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_table_min(s : FinanceportfoliocapmTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_table_max(s : FinanceportfoliocapmTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_table_to_string(s : FinanceportfoliocapmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_graphn_make(size : Int) -> FinanceportfoliocapmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_graphn_len(s : FinanceportfoliocapmGraphN) -> Int { s.size }

pub fn finance_portfolio_capm_graphn_get(s : FinanceportfoliocapmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_graphn_set(s : FinanceportfoliocapmGraphN, i : Int, v : Double) -> FinanceportfoliocapmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_graphn_sum(s : FinanceportfoliocapmGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_graphn_mean(s : FinanceportfoliocapmGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_graphn_scale(s : FinanceportfoliocapmGraphN, f : Double) -> FinanceportfoliocapmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_graphn_add(a : FinanceportfoliocapmGraphN, b : FinanceportfoliocapmGraphN) -> FinanceportfoliocapmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_graphn_copy(s : FinanceportfoliocapmGraphN) -> FinanceportfoliocapmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_graphn_fill(s : FinanceportfoliocapmGraphN, v : Double) -> FinanceportfoliocapmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_graphn_min(s : FinanceportfoliocapmGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_graphn_max(s : FinanceportfoliocapmGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_graphn_to_string(s : FinanceportfoliocapmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_node_make(size : Int) -> FinanceportfoliocapmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_node_len(s : FinanceportfoliocapmNode) -> Int { s.size }

pub fn finance_portfolio_capm_node_get(s : FinanceportfoliocapmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_node_set(s : FinanceportfoliocapmNode, i : Int, v : Double) -> FinanceportfoliocapmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_node_sum(s : FinanceportfoliocapmNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_node_mean(s : FinanceportfoliocapmNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_node_scale(s : FinanceportfoliocapmNode, f : Double) -> FinanceportfoliocapmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_node_add(a : FinanceportfoliocapmNode, b : FinanceportfoliocapmNode) -> FinanceportfoliocapmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_node_copy(s : FinanceportfoliocapmNode) -> FinanceportfoliocapmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_node_fill(s : FinanceportfoliocapmNode, v : Double) -> FinanceportfoliocapmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_node_min(s : FinanceportfoliocapmNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_node_max(s : FinanceportfoliocapmNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_node_to_string(s : FinanceportfoliocapmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_edge_make(size : Int) -> FinanceportfoliocapmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_edge_len(s : FinanceportfoliocapmEdge) -> Int { s.size }

pub fn finance_portfolio_capm_edge_get(s : FinanceportfoliocapmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_edge_set(s : FinanceportfoliocapmEdge, i : Int, v : Double) -> FinanceportfoliocapmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_edge_sum(s : FinanceportfoliocapmEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_edge_mean(s : FinanceportfoliocapmEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_edge_scale(s : FinanceportfoliocapmEdge, f : Double) -> FinanceportfoliocapmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_edge_add(a : FinanceportfoliocapmEdge, b : FinanceportfoliocapmEdge) -> FinanceportfoliocapmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_edge_copy(s : FinanceportfoliocapmEdge) -> FinanceportfoliocapmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_edge_fill(s : FinanceportfoliocapmEdge, v : Double) -> FinanceportfoliocapmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_edge_min(s : FinanceportfoliocapmEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_edge_max(s : FinanceportfoliocapmEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_edge_to_string(s : FinanceportfoliocapmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_path_make(size : Int) -> FinanceportfoliocapmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_path_len(s : FinanceportfoliocapmPath) -> Int { s.size }

pub fn finance_portfolio_capm_path_get(s : FinanceportfoliocapmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_path_set(s : FinanceportfoliocapmPath, i : Int, v : Double) -> FinanceportfoliocapmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_path_sum(s : FinanceportfoliocapmPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_path_mean(s : FinanceportfoliocapmPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_path_scale(s : FinanceportfoliocapmPath, f : Double) -> FinanceportfoliocapmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_path_add(a : FinanceportfoliocapmPath, b : FinanceportfoliocapmPath) -> FinanceportfoliocapmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_path_copy(s : FinanceportfoliocapmPath) -> FinanceportfoliocapmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_path_fill(s : FinanceportfoliocapmPath, v : Double) -> FinanceportfoliocapmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_path_min(s : FinanceportfoliocapmPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_path_max(s : FinanceportfoliocapmPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_path_to_string(s : FinanceportfoliocapmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_cluster_make(size : Int) -> FinanceportfoliocapmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_cluster_len(s : FinanceportfoliocapmCluster) -> Int { s.size }

pub fn finance_portfolio_capm_cluster_get(s : FinanceportfoliocapmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_cluster_set(s : FinanceportfoliocapmCluster, i : Int, v : Double) -> FinanceportfoliocapmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cluster_sum(s : FinanceportfoliocapmCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_cluster_mean(s : FinanceportfoliocapmCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_cluster_scale(s : FinanceportfoliocapmCluster, f : Double) -> FinanceportfoliocapmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cluster_add(a : FinanceportfoliocapmCluster, b : FinanceportfoliocapmCluster) -> FinanceportfoliocapmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_cluster_copy(s : FinanceportfoliocapmCluster) -> FinanceportfoliocapmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cluster_fill(s : FinanceportfoliocapmCluster, v : Double) -> FinanceportfoliocapmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cluster_min(s : FinanceportfoliocapmCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_cluster_max(s : FinanceportfoliocapmCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_cluster_to_string(s : FinanceportfoliocapmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_model_make(size : Int) -> FinanceportfoliocapmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_model_len(s : FinanceportfoliocapmModel) -> Int { s.size }

pub fn finance_portfolio_capm_model_get(s : FinanceportfoliocapmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_model_set(s : FinanceportfoliocapmModel, i : Int, v : Double) -> FinanceportfoliocapmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_model_sum(s : FinanceportfoliocapmModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_model_mean(s : FinanceportfoliocapmModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_model_scale(s : FinanceportfoliocapmModel, f : Double) -> FinanceportfoliocapmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_model_add(a : FinanceportfoliocapmModel, b : FinanceportfoliocapmModel) -> FinanceportfoliocapmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_model_copy(s : FinanceportfoliocapmModel) -> FinanceportfoliocapmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_model_fill(s : FinanceportfoliocapmModel, v : Double) -> FinanceportfoliocapmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_model_min(s : FinanceportfoliocapmModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_model_max(s : FinanceportfoliocapmModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_model_to_string(s : FinanceportfoliocapmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_layer_make(size : Int) -> FinanceportfoliocapmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_layer_len(s : FinanceportfoliocapmLayer) -> Int { s.size }

pub fn finance_portfolio_capm_layer_get(s : FinanceportfoliocapmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_layer_set(s : FinanceportfoliocapmLayer, i : Int, v : Double) -> FinanceportfoliocapmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_layer_sum(s : FinanceportfoliocapmLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_layer_mean(s : FinanceportfoliocapmLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_layer_scale(s : FinanceportfoliocapmLayer, f : Double) -> FinanceportfoliocapmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_layer_add(a : FinanceportfoliocapmLayer, b : FinanceportfoliocapmLayer) -> FinanceportfoliocapmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_layer_copy(s : FinanceportfoliocapmLayer) -> FinanceportfoliocapmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_layer_fill(s : FinanceportfoliocapmLayer, v : Double) -> FinanceportfoliocapmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_layer_min(s : FinanceportfoliocapmLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_layer_max(s : FinanceportfoliocapmLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_layer_to_string(s : FinanceportfoliocapmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_buffer_make(size : Int) -> FinanceportfoliocapmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_buffer_len(s : FinanceportfoliocapmBuffer) -> Int { s.size }

pub fn finance_portfolio_capm_buffer_get(s : FinanceportfoliocapmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_buffer_set(s : FinanceportfoliocapmBuffer, i : Int, v : Double) -> FinanceportfoliocapmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_buffer_sum(s : FinanceportfoliocapmBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_buffer_mean(s : FinanceportfoliocapmBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_buffer_scale(s : FinanceportfoliocapmBuffer, f : Double) -> FinanceportfoliocapmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_buffer_add(a : FinanceportfoliocapmBuffer, b : FinanceportfoliocapmBuffer) -> FinanceportfoliocapmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_buffer_copy(s : FinanceportfoliocapmBuffer) -> FinanceportfoliocapmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_buffer_fill(s : FinanceportfoliocapmBuffer, v : Double) -> FinanceportfoliocapmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_buffer_min(s : FinanceportfoliocapmBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_buffer_max(s : FinanceportfoliocapmBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_buffer_to_string(s : FinanceportfoliocapmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_cursor_make(size : Int) -> FinanceportfoliocapmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_cursor_len(s : FinanceportfoliocapmCursor) -> Int { s.size }

pub fn finance_portfolio_capm_cursor_get(s : FinanceportfoliocapmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_cursor_set(s : FinanceportfoliocapmCursor, i : Int, v : Double) -> FinanceportfoliocapmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cursor_sum(s : FinanceportfoliocapmCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_cursor_mean(s : FinanceportfoliocapmCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_cursor_scale(s : FinanceportfoliocapmCursor, f : Double) -> FinanceportfoliocapmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cursor_add(a : FinanceportfoliocapmCursor, b : FinanceportfoliocapmCursor) -> FinanceportfoliocapmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_cursor_copy(s : FinanceportfoliocapmCursor) -> FinanceportfoliocapmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cursor_fill(s : FinanceportfoliocapmCursor, v : Double) -> FinanceportfoliocapmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_cursor_min(s : FinanceportfoliocapmCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_cursor_max(s : FinanceportfoliocapmCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_cursor_to_string(s : FinanceportfoliocapmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_view_make(size : Int) -> FinanceportfoliocapmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_view_len(s : FinanceportfoliocapmView) -> Int { s.size }

pub fn finance_portfolio_capm_view_get(s : FinanceportfoliocapmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_view_set(s : FinanceportfoliocapmView, i : Int, v : Double) -> FinanceportfoliocapmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_view_sum(s : FinanceportfoliocapmView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_view_mean(s : FinanceportfoliocapmView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_view_scale(s : FinanceportfoliocapmView, f : Double) -> FinanceportfoliocapmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_view_add(a : FinanceportfoliocapmView, b : FinanceportfoliocapmView) -> FinanceportfoliocapmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_view_copy(s : FinanceportfoliocapmView) -> FinanceportfoliocapmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_view_fill(s : FinanceportfoliocapmView, v : Double) -> FinanceportfoliocapmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_view_min(s : FinanceportfoliocapmView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_view_max(s : FinanceportfoliocapmView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_view_to_string(s : FinanceportfoliocapmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_range_make(size : Int) -> FinanceportfoliocapmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_range_len(s : FinanceportfoliocapmRange) -> Int { s.size }

pub fn finance_portfolio_capm_range_get(s : FinanceportfoliocapmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_range_set(s : FinanceportfoliocapmRange, i : Int, v : Double) -> FinanceportfoliocapmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_range_sum(s : FinanceportfoliocapmRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_range_mean(s : FinanceportfoliocapmRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_range_scale(s : FinanceportfoliocapmRange, f : Double) -> FinanceportfoliocapmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_range_add(a : FinanceportfoliocapmRange, b : FinanceportfoliocapmRange) -> FinanceportfoliocapmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_range_copy(s : FinanceportfoliocapmRange) -> FinanceportfoliocapmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_range_fill(s : FinanceportfoliocapmRange, v : Double) -> FinanceportfoliocapmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_range_min(s : FinanceportfoliocapmRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_range_max(s : FinanceportfoliocapmRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_range_to_string(s : FinanceportfoliocapmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliocapmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_capm_slice_make(size : Int) -> FinanceportfoliocapmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_capm_slice_len(s : FinanceportfoliocapmSlice) -> Int { s.size }

pub fn finance_portfolio_capm_slice_get(s : FinanceportfoliocapmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_capm_slice_set(s : FinanceportfoliocapmSlice, i : Int, v : Double) -> FinanceportfoliocapmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_slice_sum(s : FinanceportfoliocapmSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_capm_slice_mean(s : FinanceportfoliocapmSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_capm_slice_scale(s : FinanceportfoliocapmSlice, f : Double) -> FinanceportfoliocapmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_slice_add(a : FinanceportfoliocapmSlice, b : FinanceportfoliocapmSlice) -> FinanceportfoliocapmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_capm_slice_copy(s : FinanceportfoliocapmSlice) -> FinanceportfoliocapmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_slice_fill(s : FinanceportfoliocapmSlice, v : Double) -> FinanceportfoliocapmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_capm_slice_min(s : FinanceportfoliocapmSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_capm_slice_max(s : FinanceportfoliocapmSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_capm_slice_to_string(s : FinanceportfoliocapmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

