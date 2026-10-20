///===
/// extcore/finance_portfolio_factor

pub(all) struct FinanceportfoliofactorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_factor_make_point(x : Double, y : Double) -> FinanceportfoliofactorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_factor_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliofactorPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliofactorPoint::x(self : FinanceportfoliofactorPoint) -> Double { self.x }

pub fn FinanceportfoliofactorPoint::y(self : FinanceportfoliofactorPoint) -> Double { self.y }

pub fn FinanceportfoliofactorPoint::z(self : FinanceportfoliofactorPoint) -> Double { self.z }

pub fn FinanceportfoliofactorPoint::label(self : FinanceportfoliofactorPoint) -> Int { self.label }

pub fn FinanceportfoliofactorPoint::dist(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliofactorPoint::add(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliofactorPoint::sub(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliofactorPoint::scale(self : FinanceportfoliofactorPoint, s : Double) -> FinanceportfoliofactorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliofactorPoint::dot(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliofactorPoint::cross(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliofactorPoint::norm(self : FinanceportfoliofactorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliofactorPoint::normalize(self : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliofactorPoint::negate(self : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliofactorPoint::mid(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint) -> FinanceportfoliofactorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliofactorPoint::lerp(self : FinanceportfoliofactorPoint, other : FinanceportfoliofactorPoint, t : Double) -> FinanceportfoliofactorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliofactorPoint::to_string(self : FinanceportfoliofactorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_factor_make_series(vals : Array[Double], name : String) -> FinanceportfoliofactorSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliofactorSeries::len(self : FinanceportfoliofactorSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliofactorSeries::sum(self : FinanceportfoliofactorSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliofactorSeries::mean(self : FinanceportfoliofactorSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliofactorSeries::min(self : FinanceportfoliofactorSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliofactorSeries::max(self : FinanceportfoliofactorSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliofactorSeries::range(self : FinanceportfoliofactorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliofactorSeries::variance(self : FinanceportfoliofactorSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliofactorSeries::std(self : FinanceportfoliofactorSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliofactorSeries::median(self : FinanceportfoliofactorSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliofactorSeries::scale(self : FinanceportfoliofactorSeries, f : Double) -> FinanceportfoliofactorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliofactorSeries::add(self : FinanceportfoliofactorSeries, other : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliofactorSeries::sub(self : FinanceportfoliofactorSeries, other : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliofactorSeries::normalize(self : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliofactorSeries::cumsum(self : FinanceportfoliofactorSeries) -> FinanceportfoliofactorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliofactorSeries::to_string(self : FinanceportfoliofactorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliofactorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_factor_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliofactorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_factor_matrix_identity(n : Int) -> FinanceportfoliofactorMatrix {
  let m = finance_portfolio_factor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliofactorMatrix::get(self : FinanceportfoliofactorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliofactorMatrix::transpose(self : FinanceportfoliofactorMatrix) -> FinanceportfoliofactorMatrix {
  let result = finance_portfolio_factor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliofactorMatrix::add(self : FinanceportfoliofactorMatrix, other : FinanceportfoliofactorMatrix) -> FinanceportfoliofactorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliofactorMatrix::scale(self : FinanceportfoliofactorMatrix, s : Double) -> FinanceportfoliofactorMatrix {
  let result = finance_portfolio_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliofactorMatrix::multiply(self : FinanceportfoliofactorMatrix, other : FinanceportfoliofactorMatrix) -> FinanceportfoliofactorMatrix {
  if self.cols != other.rows { return finance_portfolio_factor_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_factor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfoliofactorMatrix::trace(self : FinanceportfoliofactorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliofactorMatrix::det(self : FinanceportfoliofactorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliofactorMatrix::norm(self : FinanceportfoliofactorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliofactorMatrix::to_string(self : FinanceportfoliofactorMatrix) -> String {
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

pub(all) struct FinanceportfoliofactorVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_factor_make_vector(comps : Array[Double]) -> FinanceportfoliofactorVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_factor_vector_zero(dim : Int) -> FinanceportfoliofactorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliofactorVector::add(self : FinanceportfoliofactorVector, other : FinanceportfoliofactorVector) -> FinanceportfoliofactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliofactorVector::sub(self : FinanceportfoliofactorVector, other : FinanceportfoliofactorVector) -> FinanceportfoliofactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliofactorVector::scale(self : FinanceportfoliofactorVector, s : Double) -> FinanceportfoliofactorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliofactorVector::dot(self : FinanceportfoliofactorVector, other : FinanceportfoliofactorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliofactorVector::norm(self : FinanceportfoliofactorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliofactorVector::normalize(self : FinanceportfoliofactorVector) -> FinanceportfoliofactorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliofactorVector::dist(self : FinanceportfoliofactorVector, other : FinanceportfoliofactorVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliofactorVector::to_string(self : FinanceportfoliofactorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_factor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_factor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_factor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_factor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_factor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_factor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_factor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_factor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_factor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_factor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_factor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_factor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_factor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_factor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_factor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_factor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_factor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_factor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_factor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_factor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_factor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_factor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_factor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_factor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_factor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_factor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_factor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_factor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_factor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliofactorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_frame_make(size : Int) -> FinanceportfoliofactorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_frame_len(s : FinanceportfoliofactorFrame) -> Int { s.size }

pub fn finance_portfolio_factor_frame_get(s : FinanceportfoliofactorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_frame_set(s : FinanceportfoliofactorFrame, i : Int, v : Double) -> FinanceportfoliofactorFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_frame_sum(s : FinanceportfoliofactorFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_frame_mean(s : FinanceportfoliofactorFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_frame_scale(s : FinanceportfoliofactorFrame, f : Double) -> FinanceportfoliofactorFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_frame_add(a : FinanceportfoliofactorFrame, b : FinanceportfoliofactorFrame) -> FinanceportfoliofactorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_frame_copy(s : FinanceportfoliofactorFrame) -> FinanceportfoliofactorFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_frame_fill(s : FinanceportfoliofactorFrame, v : Double) -> FinanceportfoliofactorFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_frame_min(s : FinanceportfoliofactorFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_frame_max(s : FinanceportfoliofactorFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_frame_to_string(s : FinanceportfoliofactorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_table_make(size : Int) -> FinanceportfoliofactorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_table_len(s : FinanceportfoliofactorTable) -> Int { s.size }

pub fn finance_portfolio_factor_table_get(s : FinanceportfoliofactorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_table_set(s : FinanceportfoliofactorTable, i : Int, v : Double) -> FinanceportfoliofactorTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_table_sum(s : FinanceportfoliofactorTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_table_mean(s : FinanceportfoliofactorTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_table_scale(s : FinanceportfoliofactorTable, f : Double) -> FinanceportfoliofactorTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_table_add(a : FinanceportfoliofactorTable, b : FinanceportfoliofactorTable) -> FinanceportfoliofactorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_table_copy(s : FinanceportfoliofactorTable) -> FinanceportfoliofactorTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_table_fill(s : FinanceportfoliofactorTable, v : Double) -> FinanceportfoliofactorTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_table_min(s : FinanceportfoliofactorTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_table_max(s : FinanceportfoliofactorTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_table_to_string(s : FinanceportfoliofactorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_graphn_make(size : Int) -> FinanceportfoliofactorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_graphn_len(s : FinanceportfoliofactorGraphN) -> Int { s.size }

pub fn finance_portfolio_factor_graphn_get(s : FinanceportfoliofactorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_graphn_set(s : FinanceportfoliofactorGraphN, i : Int, v : Double) -> FinanceportfoliofactorGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_graphn_sum(s : FinanceportfoliofactorGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_graphn_mean(s : FinanceportfoliofactorGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_graphn_scale(s : FinanceportfoliofactorGraphN, f : Double) -> FinanceportfoliofactorGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_graphn_add(a : FinanceportfoliofactorGraphN, b : FinanceportfoliofactorGraphN) -> FinanceportfoliofactorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_graphn_copy(s : FinanceportfoliofactorGraphN) -> FinanceportfoliofactorGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_graphn_fill(s : FinanceportfoliofactorGraphN, v : Double) -> FinanceportfoliofactorGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_graphn_min(s : FinanceportfoliofactorGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_graphn_max(s : FinanceportfoliofactorGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_graphn_to_string(s : FinanceportfoliofactorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_node_make(size : Int) -> FinanceportfoliofactorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_node_len(s : FinanceportfoliofactorNode) -> Int { s.size }

pub fn finance_portfolio_factor_node_get(s : FinanceportfoliofactorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_node_set(s : FinanceportfoliofactorNode, i : Int, v : Double) -> FinanceportfoliofactorNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_node_sum(s : FinanceportfoliofactorNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_node_mean(s : FinanceportfoliofactorNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_node_scale(s : FinanceportfoliofactorNode, f : Double) -> FinanceportfoliofactorNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_node_add(a : FinanceportfoliofactorNode, b : FinanceportfoliofactorNode) -> FinanceportfoliofactorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_node_copy(s : FinanceportfoliofactorNode) -> FinanceportfoliofactorNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_node_fill(s : FinanceportfoliofactorNode, v : Double) -> FinanceportfoliofactorNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_node_min(s : FinanceportfoliofactorNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_node_max(s : FinanceportfoliofactorNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_node_to_string(s : FinanceportfoliofactorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_edge_make(size : Int) -> FinanceportfoliofactorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_edge_len(s : FinanceportfoliofactorEdge) -> Int { s.size }

pub fn finance_portfolio_factor_edge_get(s : FinanceportfoliofactorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_edge_set(s : FinanceportfoliofactorEdge, i : Int, v : Double) -> FinanceportfoliofactorEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_edge_sum(s : FinanceportfoliofactorEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_edge_mean(s : FinanceportfoliofactorEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_edge_scale(s : FinanceportfoliofactorEdge, f : Double) -> FinanceportfoliofactorEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_edge_add(a : FinanceportfoliofactorEdge, b : FinanceportfoliofactorEdge) -> FinanceportfoliofactorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_edge_copy(s : FinanceportfoliofactorEdge) -> FinanceportfoliofactorEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_edge_fill(s : FinanceportfoliofactorEdge, v : Double) -> FinanceportfoliofactorEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_edge_min(s : FinanceportfoliofactorEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_edge_max(s : FinanceportfoliofactorEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_edge_to_string(s : FinanceportfoliofactorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_path_make(size : Int) -> FinanceportfoliofactorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_path_len(s : FinanceportfoliofactorPath) -> Int { s.size }

pub fn finance_portfolio_factor_path_get(s : FinanceportfoliofactorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_path_set(s : FinanceportfoliofactorPath, i : Int, v : Double) -> FinanceportfoliofactorPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_path_sum(s : FinanceportfoliofactorPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_path_mean(s : FinanceportfoliofactorPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_path_scale(s : FinanceportfoliofactorPath, f : Double) -> FinanceportfoliofactorPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_path_add(a : FinanceportfoliofactorPath, b : FinanceportfoliofactorPath) -> FinanceportfoliofactorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_path_copy(s : FinanceportfoliofactorPath) -> FinanceportfoliofactorPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_path_fill(s : FinanceportfoliofactorPath, v : Double) -> FinanceportfoliofactorPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_path_min(s : FinanceportfoliofactorPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_path_max(s : FinanceportfoliofactorPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_path_to_string(s : FinanceportfoliofactorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_cluster_make(size : Int) -> FinanceportfoliofactorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_cluster_len(s : FinanceportfoliofactorCluster) -> Int { s.size }

pub fn finance_portfolio_factor_cluster_get(s : FinanceportfoliofactorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_cluster_set(s : FinanceportfoliofactorCluster, i : Int, v : Double) -> FinanceportfoliofactorCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cluster_sum(s : FinanceportfoliofactorCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_cluster_mean(s : FinanceportfoliofactorCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_cluster_scale(s : FinanceportfoliofactorCluster, f : Double) -> FinanceportfoliofactorCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cluster_add(a : FinanceportfoliofactorCluster, b : FinanceportfoliofactorCluster) -> FinanceportfoliofactorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_cluster_copy(s : FinanceportfoliofactorCluster) -> FinanceportfoliofactorCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cluster_fill(s : FinanceportfoliofactorCluster, v : Double) -> FinanceportfoliofactorCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cluster_min(s : FinanceportfoliofactorCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_cluster_max(s : FinanceportfoliofactorCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_cluster_to_string(s : FinanceportfoliofactorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_model_make(size : Int) -> FinanceportfoliofactorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_model_len(s : FinanceportfoliofactorModel) -> Int { s.size }

pub fn finance_portfolio_factor_model_get(s : FinanceportfoliofactorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_model_set(s : FinanceportfoliofactorModel, i : Int, v : Double) -> FinanceportfoliofactorModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_model_sum(s : FinanceportfoliofactorModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_model_mean(s : FinanceportfoliofactorModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_model_scale(s : FinanceportfoliofactorModel, f : Double) -> FinanceportfoliofactorModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_model_add(a : FinanceportfoliofactorModel, b : FinanceportfoliofactorModel) -> FinanceportfoliofactorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_model_copy(s : FinanceportfoliofactorModel) -> FinanceportfoliofactorModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_model_fill(s : FinanceportfoliofactorModel, v : Double) -> FinanceportfoliofactorModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_model_min(s : FinanceportfoliofactorModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_model_max(s : FinanceportfoliofactorModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_model_to_string(s : FinanceportfoliofactorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_layer_make(size : Int) -> FinanceportfoliofactorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_layer_len(s : FinanceportfoliofactorLayer) -> Int { s.size }

pub fn finance_portfolio_factor_layer_get(s : FinanceportfoliofactorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_layer_set(s : FinanceportfoliofactorLayer, i : Int, v : Double) -> FinanceportfoliofactorLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_layer_sum(s : FinanceportfoliofactorLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_layer_mean(s : FinanceportfoliofactorLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_layer_scale(s : FinanceportfoliofactorLayer, f : Double) -> FinanceportfoliofactorLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_layer_add(a : FinanceportfoliofactorLayer, b : FinanceportfoliofactorLayer) -> FinanceportfoliofactorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_layer_copy(s : FinanceportfoliofactorLayer) -> FinanceportfoliofactorLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_layer_fill(s : FinanceportfoliofactorLayer, v : Double) -> FinanceportfoliofactorLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_layer_min(s : FinanceportfoliofactorLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_layer_max(s : FinanceportfoliofactorLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_layer_to_string(s : FinanceportfoliofactorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_buffer_make(size : Int) -> FinanceportfoliofactorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_buffer_len(s : FinanceportfoliofactorBuffer) -> Int { s.size }

pub fn finance_portfolio_factor_buffer_get(s : FinanceportfoliofactorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_buffer_set(s : FinanceportfoliofactorBuffer, i : Int, v : Double) -> FinanceportfoliofactorBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_buffer_sum(s : FinanceportfoliofactorBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_buffer_mean(s : FinanceportfoliofactorBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_buffer_scale(s : FinanceportfoliofactorBuffer, f : Double) -> FinanceportfoliofactorBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_buffer_add(a : FinanceportfoliofactorBuffer, b : FinanceportfoliofactorBuffer) -> FinanceportfoliofactorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_buffer_copy(s : FinanceportfoliofactorBuffer) -> FinanceportfoliofactorBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_buffer_fill(s : FinanceportfoliofactorBuffer, v : Double) -> FinanceportfoliofactorBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_buffer_min(s : FinanceportfoliofactorBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_buffer_max(s : FinanceportfoliofactorBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_buffer_to_string(s : FinanceportfoliofactorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_cursor_make(size : Int) -> FinanceportfoliofactorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_cursor_len(s : FinanceportfoliofactorCursor) -> Int { s.size }

pub fn finance_portfolio_factor_cursor_get(s : FinanceportfoliofactorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_cursor_set(s : FinanceportfoliofactorCursor, i : Int, v : Double) -> FinanceportfoliofactorCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cursor_sum(s : FinanceportfoliofactorCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_cursor_mean(s : FinanceportfoliofactorCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_cursor_scale(s : FinanceportfoliofactorCursor, f : Double) -> FinanceportfoliofactorCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cursor_add(a : FinanceportfoliofactorCursor, b : FinanceportfoliofactorCursor) -> FinanceportfoliofactorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_cursor_copy(s : FinanceportfoliofactorCursor) -> FinanceportfoliofactorCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cursor_fill(s : FinanceportfoliofactorCursor, v : Double) -> FinanceportfoliofactorCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_cursor_min(s : FinanceportfoliofactorCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_cursor_max(s : FinanceportfoliofactorCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_cursor_to_string(s : FinanceportfoliofactorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_view_make(size : Int) -> FinanceportfoliofactorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_view_len(s : FinanceportfoliofactorView) -> Int { s.size }

pub fn finance_portfolio_factor_view_get(s : FinanceportfoliofactorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_view_set(s : FinanceportfoliofactorView, i : Int, v : Double) -> FinanceportfoliofactorView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_view_sum(s : FinanceportfoliofactorView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_view_mean(s : FinanceportfoliofactorView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_view_scale(s : FinanceportfoliofactorView, f : Double) -> FinanceportfoliofactorView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_view_add(a : FinanceportfoliofactorView, b : FinanceportfoliofactorView) -> FinanceportfoliofactorView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_view_copy(s : FinanceportfoliofactorView) -> FinanceportfoliofactorView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_view_fill(s : FinanceportfoliofactorView, v : Double) -> FinanceportfoliofactorView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_view_min(s : FinanceportfoliofactorView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_view_max(s : FinanceportfoliofactorView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_view_to_string(s : FinanceportfoliofactorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_range_make(size : Int) -> FinanceportfoliofactorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_range_len(s : FinanceportfoliofactorRange) -> Int { s.size }

pub fn finance_portfolio_factor_range_get(s : FinanceportfoliofactorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_range_set(s : FinanceportfoliofactorRange, i : Int, v : Double) -> FinanceportfoliofactorRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_range_sum(s : FinanceportfoliofactorRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_range_mean(s : FinanceportfoliofactorRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_range_scale(s : FinanceportfoliofactorRange, f : Double) -> FinanceportfoliofactorRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_range_add(a : FinanceportfoliofactorRange, b : FinanceportfoliofactorRange) -> FinanceportfoliofactorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_range_copy(s : FinanceportfoliofactorRange) -> FinanceportfoliofactorRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_range_fill(s : FinanceportfoliofactorRange, v : Double) -> FinanceportfoliofactorRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_range_min(s : FinanceportfoliofactorRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_range_max(s : FinanceportfoliofactorRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_range_to_string(s : FinanceportfoliofactorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliofactorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_factor_slice_make(size : Int) -> FinanceportfoliofactorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_factor_slice_len(s : FinanceportfoliofactorSlice) -> Int { s.size }

pub fn finance_portfolio_factor_slice_get(s : FinanceportfoliofactorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_factor_slice_set(s : FinanceportfoliofactorSlice, i : Int, v : Double) -> FinanceportfoliofactorSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_slice_sum(s : FinanceportfoliofactorSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_factor_slice_mean(s : FinanceportfoliofactorSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_factor_slice_scale(s : FinanceportfoliofactorSlice, f : Double) -> FinanceportfoliofactorSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_slice_add(a : FinanceportfoliofactorSlice, b : FinanceportfoliofactorSlice) -> FinanceportfoliofactorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_factor_slice_copy(s : FinanceportfoliofactorSlice) -> FinanceportfoliofactorSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_slice_fill(s : FinanceportfoliofactorSlice, v : Double) -> FinanceportfoliofactorSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_factor_slice_min(s : FinanceportfoliofactorSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_factor_slice_max(s : FinanceportfoliofactorSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_factor_slice_to_string(s : FinanceportfoliofactorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

