///===
/// extcore/finance_portfolio_black

pub(all) struct FinanceportfolioblackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_black_make_point(x : Double, y : Double) -> FinanceportfolioblackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_black_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioblackPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfolioblackPoint::x(self : FinanceportfolioblackPoint) -> Double { self.x }

pub fn FinanceportfolioblackPoint::y(self : FinanceportfolioblackPoint) -> Double { self.y }

pub fn FinanceportfolioblackPoint::z(self : FinanceportfolioblackPoint) -> Double { self.z }

pub fn FinanceportfolioblackPoint::label(self : FinanceportfolioblackPoint) -> Int { self.label }

pub fn FinanceportfolioblackPoint::dist(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfolioblackPoint::add(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfolioblackPoint::sub(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfolioblackPoint::scale(self : FinanceportfolioblackPoint, s : Double) -> FinanceportfolioblackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfolioblackPoint::dot(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfolioblackPoint::cross(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfolioblackPoint::norm(self : FinanceportfolioblackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfolioblackPoint::normalize(self : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioblackPoint::negate(self : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfolioblackPoint::mid(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint) -> FinanceportfolioblackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfolioblackPoint::lerp(self : FinanceportfolioblackPoint, other : FinanceportfolioblackPoint, t : Double) -> FinanceportfolioblackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfolioblackPoint::to_string(self : FinanceportfolioblackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfolioblackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_black_make_series(vals : Array[Double], name : String) -> FinanceportfolioblackSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfolioblackSeries::len(self : FinanceportfolioblackSeries) -> Int { self.vals.length() }

pub fn FinanceportfolioblackSeries::sum(self : FinanceportfolioblackSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfolioblackSeries::mean(self : FinanceportfolioblackSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfolioblackSeries::min(self : FinanceportfolioblackSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfolioblackSeries::max(self : FinanceportfolioblackSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfolioblackSeries::range(self : FinanceportfolioblackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfolioblackSeries::variance(self : FinanceportfolioblackSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfolioblackSeries::std(self : FinanceportfolioblackSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfolioblackSeries::median(self : FinanceportfolioblackSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfolioblackSeries::scale(self : FinanceportfolioblackSeries, f : Double) -> FinanceportfolioblackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfolioblackSeries::add(self : FinanceportfolioblackSeries, other : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfolioblackSeries::sub(self : FinanceportfolioblackSeries, other : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfolioblackSeries::normalize(self : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfolioblackSeries::cumsum(self : FinanceportfolioblackSeries) -> FinanceportfolioblackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfolioblackSeries::to_string(self : FinanceportfolioblackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioblackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_black_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioblackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_black_matrix_identity(n : Int) -> FinanceportfolioblackMatrix {
  let m = finance_portfolio_black_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfolioblackMatrix::get(self : FinanceportfolioblackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfolioblackMatrix::transpose(self : FinanceportfolioblackMatrix) -> FinanceportfolioblackMatrix {
  let result = finance_portfolio_black_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfolioblackMatrix::add(self : FinanceportfolioblackMatrix, other : FinanceportfolioblackMatrix) -> FinanceportfolioblackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_black_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfolioblackMatrix::scale(self : FinanceportfolioblackMatrix, s : Double) -> FinanceportfolioblackMatrix {
  let result = finance_portfolio_black_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfolioblackMatrix::multiply(self : FinanceportfolioblackMatrix, other : FinanceportfolioblackMatrix) -> FinanceportfolioblackMatrix {
  if self.cols != other.rows { return finance_portfolio_black_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_black_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfolioblackMatrix::trace(self : FinanceportfolioblackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfolioblackMatrix::det(self : FinanceportfolioblackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfolioblackMatrix::norm(self : FinanceportfolioblackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfolioblackMatrix::to_string(self : FinanceportfolioblackMatrix) -> String {
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

pub(all) struct FinanceportfolioblackVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_black_make_vector(comps : Array[Double]) -> FinanceportfolioblackVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_black_vector_zero(dim : Int) -> FinanceportfolioblackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfolioblackVector::add(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> FinanceportfolioblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioblackVector::sub(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> FinanceportfolioblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioblackVector::scale(self : FinanceportfolioblackVector, s : Double) -> FinanceportfolioblackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfolioblackVector::dot(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfolioblackVector::norm(self : FinanceportfolioblackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfolioblackVector::normalize(self : FinanceportfolioblackVector) -> FinanceportfolioblackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioblackVector::dist(self : FinanceportfolioblackVector, other : FinanceportfolioblackVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfolioblackVector::to_string(self : FinanceportfolioblackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_black_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_black_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_black_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_black_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_black_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_black_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_black_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_black_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_black_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_black_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_black_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_black_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_black_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_black_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_black_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_black_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_black_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_black_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_black_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_black_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_black_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_black_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_black_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_black_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_black_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_black_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_black_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_black_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_black_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfolioblackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_frame_make(size : Int) -> FinanceportfolioblackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_frame_len(s : FinanceportfolioblackFrame) -> Int { s.size }

pub fn finance_portfolio_black_frame_get(s : FinanceportfolioblackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_frame_set(s : FinanceportfolioblackFrame, i : Int, v : Double) -> FinanceportfolioblackFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_frame_sum(s : FinanceportfolioblackFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_frame_mean(s : FinanceportfolioblackFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_frame_scale(s : FinanceportfolioblackFrame, f : Double) -> FinanceportfolioblackFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_frame_add(a : FinanceportfolioblackFrame, b : FinanceportfolioblackFrame) -> FinanceportfolioblackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_frame_copy(s : FinanceportfolioblackFrame) -> FinanceportfolioblackFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_frame_fill(s : FinanceportfolioblackFrame, v : Double) -> FinanceportfolioblackFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_frame_min(s : FinanceportfolioblackFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_frame_max(s : FinanceportfolioblackFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_frame_to_string(s : FinanceportfolioblackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_table_make(size : Int) -> FinanceportfolioblackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_table_len(s : FinanceportfolioblackTable) -> Int { s.size }

pub fn finance_portfolio_black_table_get(s : FinanceportfolioblackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_table_set(s : FinanceportfolioblackTable, i : Int, v : Double) -> FinanceportfolioblackTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_table_sum(s : FinanceportfolioblackTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_table_mean(s : FinanceportfolioblackTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_table_scale(s : FinanceportfolioblackTable, f : Double) -> FinanceportfolioblackTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_table_add(a : FinanceportfolioblackTable, b : FinanceportfolioblackTable) -> FinanceportfolioblackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_table_copy(s : FinanceportfolioblackTable) -> FinanceportfolioblackTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_table_fill(s : FinanceportfolioblackTable, v : Double) -> FinanceportfolioblackTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_table_min(s : FinanceportfolioblackTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_table_max(s : FinanceportfolioblackTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_table_to_string(s : FinanceportfolioblackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_graphn_make(size : Int) -> FinanceportfolioblackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_graphn_len(s : FinanceportfolioblackGraphN) -> Int { s.size }

pub fn finance_portfolio_black_graphn_get(s : FinanceportfolioblackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_graphn_set(s : FinanceportfolioblackGraphN, i : Int, v : Double) -> FinanceportfolioblackGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_graphn_sum(s : FinanceportfolioblackGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_graphn_mean(s : FinanceportfolioblackGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_graphn_scale(s : FinanceportfolioblackGraphN, f : Double) -> FinanceportfolioblackGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_graphn_add(a : FinanceportfolioblackGraphN, b : FinanceportfolioblackGraphN) -> FinanceportfolioblackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_graphn_copy(s : FinanceportfolioblackGraphN) -> FinanceportfolioblackGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_graphn_fill(s : FinanceportfolioblackGraphN, v : Double) -> FinanceportfolioblackGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_graphn_min(s : FinanceportfolioblackGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_graphn_max(s : FinanceportfolioblackGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_graphn_to_string(s : FinanceportfolioblackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_node_make(size : Int) -> FinanceportfolioblackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_node_len(s : FinanceportfolioblackNode) -> Int { s.size }

pub fn finance_portfolio_black_node_get(s : FinanceportfolioblackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_node_set(s : FinanceportfolioblackNode, i : Int, v : Double) -> FinanceportfolioblackNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_node_sum(s : FinanceportfolioblackNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_node_mean(s : FinanceportfolioblackNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_node_scale(s : FinanceportfolioblackNode, f : Double) -> FinanceportfolioblackNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_node_add(a : FinanceportfolioblackNode, b : FinanceportfolioblackNode) -> FinanceportfolioblackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_node_copy(s : FinanceportfolioblackNode) -> FinanceportfolioblackNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_node_fill(s : FinanceportfolioblackNode, v : Double) -> FinanceportfolioblackNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_node_min(s : FinanceportfolioblackNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_node_max(s : FinanceportfolioblackNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_node_to_string(s : FinanceportfolioblackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_edge_make(size : Int) -> FinanceportfolioblackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_edge_len(s : FinanceportfolioblackEdge) -> Int { s.size }

pub fn finance_portfolio_black_edge_get(s : FinanceportfolioblackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_edge_set(s : FinanceportfolioblackEdge, i : Int, v : Double) -> FinanceportfolioblackEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_edge_sum(s : FinanceportfolioblackEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_edge_mean(s : FinanceportfolioblackEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_edge_scale(s : FinanceportfolioblackEdge, f : Double) -> FinanceportfolioblackEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_edge_add(a : FinanceportfolioblackEdge, b : FinanceportfolioblackEdge) -> FinanceportfolioblackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_edge_copy(s : FinanceportfolioblackEdge) -> FinanceportfolioblackEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_edge_fill(s : FinanceportfolioblackEdge, v : Double) -> FinanceportfolioblackEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_edge_min(s : FinanceportfolioblackEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_edge_max(s : FinanceportfolioblackEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_edge_to_string(s : FinanceportfolioblackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_path_make(size : Int) -> FinanceportfolioblackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_path_len(s : FinanceportfolioblackPath) -> Int { s.size }

pub fn finance_portfolio_black_path_get(s : FinanceportfolioblackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_path_set(s : FinanceportfolioblackPath, i : Int, v : Double) -> FinanceportfolioblackPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_path_sum(s : FinanceportfolioblackPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_path_mean(s : FinanceportfolioblackPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_path_scale(s : FinanceportfolioblackPath, f : Double) -> FinanceportfolioblackPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_path_add(a : FinanceportfolioblackPath, b : FinanceportfolioblackPath) -> FinanceportfolioblackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_path_copy(s : FinanceportfolioblackPath) -> FinanceportfolioblackPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_path_fill(s : FinanceportfolioblackPath, v : Double) -> FinanceportfolioblackPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_path_min(s : FinanceportfolioblackPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_path_max(s : FinanceportfolioblackPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_path_to_string(s : FinanceportfolioblackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_cluster_make(size : Int) -> FinanceportfolioblackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_cluster_len(s : FinanceportfolioblackCluster) -> Int { s.size }

pub fn finance_portfolio_black_cluster_get(s : FinanceportfolioblackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_cluster_set(s : FinanceportfolioblackCluster, i : Int, v : Double) -> FinanceportfolioblackCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cluster_sum(s : FinanceportfolioblackCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_cluster_mean(s : FinanceportfolioblackCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_cluster_scale(s : FinanceportfolioblackCluster, f : Double) -> FinanceportfolioblackCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cluster_add(a : FinanceportfolioblackCluster, b : FinanceportfolioblackCluster) -> FinanceportfolioblackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_cluster_copy(s : FinanceportfolioblackCluster) -> FinanceportfolioblackCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cluster_fill(s : FinanceportfolioblackCluster, v : Double) -> FinanceportfolioblackCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cluster_min(s : FinanceportfolioblackCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_cluster_max(s : FinanceportfolioblackCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_cluster_to_string(s : FinanceportfolioblackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_model_make(size : Int) -> FinanceportfolioblackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_model_len(s : FinanceportfolioblackModel) -> Int { s.size }

pub fn finance_portfolio_black_model_get(s : FinanceportfolioblackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_model_set(s : FinanceportfolioblackModel, i : Int, v : Double) -> FinanceportfolioblackModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_model_sum(s : FinanceportfolioblackModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_model_mean(s : FinanceportfolioblackModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_model_scale(s : FinanceportfolioblackModel, f : Double) -> FinanceportfolioblackModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_model_add(a : FinanceportfolioblackModel, b : FinanceportfolioblackModel) -> FinanceportfolioblackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_model_copy(s : FinanceportfolioblackModel) -> FinanceportfolioblackModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_model_fill(s : FinanceportfolioblackModel, v : Double) -> FinanceportfolioblackModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_model_min(s : FinanceportfolioblackModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_model_max(s : FinanceportfolioblackModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_model_to_string(s : FinanceportfolioblackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_layer_make(size : Int) -> FinanceportfolioblackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_layer_len(s : FinanceportfolioblackLayer) -> Int { s.size }

pub fn finance_portfolio_black_layer_get(s : FinanceportfolioblackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_layer_set(s : FinanceportfolioblackLayer, i : Int, v : Double) -> FinanceportfolioblackLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_layer_sum(s : FinanceportfolioblackLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_layer_mean(s : FinanceportfolioblackLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_layer_scale(s : FinanceportfolioblackLayer, f : Double) -> FinanceportfolioblackLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_layer_add(a : FinanceportfolioblackLayer, b : FinanceportfolioblackLayer) -> FinanceportfolioblackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_layer_copy(s : FinanceportfolioblackLayer) -> FinanceportfolioblackLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_layer_fill(s : FinanceportfolioblackLayer, v : Double) -> FinanceportfolioblackLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_layer_min(s : FinanceportfolioblackLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_layer_max(s : FinanceportfolioblackLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_layer_to_string(s : FinanceportfolioblackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_buffer_make(size : Int) -> FinanceportfolioblackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_buffer_len(s : FinanceportfolioblackBuffer) -> Int { s.size }

pub fn finance_portfolio_black_buffer_get(s : FinanceportfolioblackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_buffer_set(s : FinanceportfolioblackBuffer, i : Int, v : Double) -> FinanceportfolioblackBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_buffer_sum(s : FinanceportfolioblackBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_buffer_mean(s : FinanceportfolioblackBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_buffer_scale(s : FinanceportfolioblackBuffer, f : Double) -> FinanceportfolioblackBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_buffer_add(a : FinanceportfolioblackBuffer, b : FinanceportfolioblackBuffer) -> FinanceportfolioblackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_buffer_copy(s : FinanceportfolioblackBuffer) -> FinanceportfolioblackBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_buffer_fill(s : FinanceportfolioblackBuffer, v : Double) -> FinanceportfolioblackBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_buffer_min(s : FinanceportfolioblackBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_buffer_max(s : FinanceportfolioblackBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_buffer_to_string(s : FinanceportfolioblackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_cursor_make(size : Int) -> FinanceportfolioblackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_cursor_len(s : FinanceportfolioblackCursor) -> Int { s.size }

pub fn finance_portfolio_black_cursor_get(s : FinanceportfolioblackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_cursor_set(s : FinanceportfolioblackCursor, i : Int, v : Double) -> FinanceportfolioblackCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cursor_sum(s : FinanceportfolioblackCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_cursor_mean(s : FinanceportfolioblackCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_cursor_scale(s : FinanceportfolioblackCursor, f : Double) -> FinanceportfolioblackCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cursor_add(a : FinanceportfolioblackCursor, b : FinanceportfolioblackCursor) -> FinanceportfolioblackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_cursor_copy(s : FinanceportfolioblackCursor) -> FinanceportfolioblackCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cursor_fill(s : FinanceportfolioblackCursor, v : Double) -> FinanceportfolioblackCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_cursor_min(s : FinanceportfolioblackCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_cursor_max(s : FinanceportfolioblackCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_cursor_to_string(s : FinanceportfolioblackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_view_make(size : Int) -> FinanceportfolioblackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_view_len(s : FinanceportfolioblackView) -> Int { s.size }

pub fn finance_portfolio_black_view_get(s : FinanceportfolioblackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_view_set(s : FinanceportfolioblackView, i : Int, v : Double) -> FinanceportfolioblackView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_view_sum(s : FinanceportfolioblackView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_view_mean(s : FinanceportfolioblackView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_view_scale(s : FinanceportfolioblackView, f : Double) -> FinanceportfolioblackView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_view_add(a : FinanceportfolioblackView, b : FinanceportfolioblackView) -> FinanceportfolioblackView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_view_copy(s : FinanceportfolioblackView) -> FinanceportfolioblackView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_view_fill(s : FinanceportfolioblackView, v : Double) -> FinanceportfolioblackView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_view_min(s : FinanceportfolioblackView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_view_max(s : FinanceportfolioblackView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_view_to_string(s : FinanceportfolioblackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_range_make(size : Int) -> FinanceportfolioblackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_range_len(s : FinanceportfolioblackRange) -> Int { s.size }

pub fn finance_portfolio_black_range_get(s : FinanceportfolioblackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_range_set(s : FinanceportfolioblackRange, i : Int, v : Double) -> FinanceportfolioblackRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_range_sum(s : FinanceportfolioblackRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_range_mean(s : FinanceportfolioblackRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_range_scale(s : FinanceportfolioblackRange, f : Double) -> FinanceportfolioblackRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_range_add(a : FinanceportfolioblackRange, b : FinanceportfolioblackRange) -> FinanceportfolioblackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_range_copy(s : FinanceportfolioblackRange) -> FinanceportfolioblackRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_range_fill(s : FinanceportfolioblackRange, v : Double) -> FinanceportfolioblackRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_range_min(s : FinanceportfolioblackRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_range_max(s : FinanceportfolioblackRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_range_to_string(s : FinanceportfolioblackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_slice_make(size : Int) -> FinanceportfolioblackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_slice_len(s : FinanceportfolioblackSlice) -> Int { s.size }

pub fn finance_portfolio_black_slice_get(s : FinanceportfolioblackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_slice_set(s : FinanceportfolioblackSlice, i : Int, v : Double) -> FinanceportfolioblackSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_slice_sum(s : FinanceportfolioblackSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_slice_mean(s : FinanceportfolioblackSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_slice_scale(s : FinanceportfolioblackSlice, f : Double) -> FinanceportfolioblackSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_slice_add(a : FinanceportfolioblackSlice, b : FinanceportfolioblackSlice) -> FinanceportfolioblackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_slice_copy(s : FinanceportfolioblackSlice) -> FinanceportfolioblackSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_slice_fill(s : FinanceportfolioblackSlice, v : Double) -> FinanceportfolioblackSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_slice_min(s : FinanceportfolioblackSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_slice_max(s : FinanceportfolioblackSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_slice_to_string(s : FinanceportfolioblackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

