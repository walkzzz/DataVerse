///===
/// extcore/finance_portfolio_black_litterman

pub(all) struct FinanceportfolioblacklittermanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_black_litterman_make_point(x : Double, y : Double) -> FinanceportfolioblacklittermanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_black_litterman_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioblacklittermanPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfolioblacklittermanPoint::x(self : FinanceportfolioblacklittermanPoint) -> Double { self.x }

pub fn FinanceportfolioblacklittermanPoint::y(self : FinanceportfolioblacklittermanPoint) -> Double { self.y }

pub fn FinanceportfolioblacklittermanPoint::z(self : FinanceportfolioblacklittermanPoint) -> Double { self.z }

pub fn FinanceportfolioblacklittermanPoint::label(self : FinanceportfolioblacklittermanPoint) -> Int { self.label }

pub fn FinanceportfolioblacklittermanPoint::dist(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfolioblacklittermanPoint::add(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfolioblacklittermanPoint::sub(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfolioblacklittermanPoint::scale(self : FinanceportfolioblacklittermanPoint, s : Double) -> FinanceportfolioblacklittermanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfolioblacklittermanPoint::dot(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfolioblacklittermanPoint::cross(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfolioblacklittermanPoint::norm(self : FinanceportfolioblacklittermanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfolioblacklittermanPoint::normalize(self : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioblacklittermanPoint::negate(self : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfolioblacklittermanPoint::mid(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint) -> FinanceportfolioblacklittermanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfolioblacklittermanPoint::lerp(self : FinanceportfolioblacklittermanPoint, other : FinanceportfolioblacklittermanPoint, t : Double) -> FinanceportfolioblacklittermanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfolioblacklittermanPoint::to_string(self : FinanceportfolioblacklittermanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_black_litterman_make_series(vals : Array[Double], name : String) -> FinanceportfolioblacklittermanSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfolioblacklittermanSeries::len(self : FinanceportfolioblacklittermanSeries) -> Int { self.vals.length() }

pub fn FinanceportfolioblacklittermanSeries::sum(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::mean(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::min(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::max(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::range(self : FinanceportfolioblacklittermanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfolioblacklittermanSeries::variance(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::std(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::median(self : FinanceportfolioblacklittermanSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfolioblacklittermanSeries::scale(self : FinanceportfolioblacklittermanSeries, f : Double) -> FinanceportfolioblacklittermanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfolioblacklittermanSeries::add(self : FinanceportfolioblacklittermanSeries, other : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfolioblacklittermanSeries::sub(self : FinanceportfolioblacklittermanSeries, other : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfolioblacklittermanSeries::normalize(self : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfolioblacklittermanSeries::cumsum(self : FinanceportfolioblacklittermanSeries) -> FinanceportfolioblacklittermanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfolioblacklittermanSeries::to_string(self : FinanceportfolioblacklittermanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioblacklittermanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_black_litterman_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioblacklittermanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_black_litterman_matrix_identity(n : Int) -> FinanceportfolioblacklittermanMatrix {
  let m = finance_portfolio_black_litterman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfolioblacklittermanMatrix::get(self : FinanceportfolioblacklittermanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfolioblacklittermanMatrix::transpose(self : FinanceportfolioblacklittermanMatrix) -> FinanceportfolioblacklittermanMatrix {
  let result = finance_portfolio_black_litterman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfolioblacklittermanMatrix::add(self : FinanceportfolioblacklittermanMatrix, other : FinanceportfolioblacklittermanMatrix) -> FinanceportfolioblacklittermanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_black_litterman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfolioblacklittermanMatrix::scale(self : FinanceportfolioblacklittermanMatrix, s : Double) -> FinanceportfolioblacklittermanMatrix {
  let result = finance_portfolio_black_litterman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfolioblacklittermanMatrix::multiply(self : FinanceportfolioblacklittermanMatrix, other : FinanceportfolioblacklittermanMatrix) -> FinanceportfolioblacklittermanMatrix {
  if self.cols != other.rows { return finance_portfolio_black_litterman_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_black_litterman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfolioblacklittermanMatrix::trace(self : FinanceportfolioblacklittermanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfolioblacklittermanMatrix::det(self : FinanceportfolioblacklittermanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfolioblacklittermanMatrix::norm(self : FinanceportfolioblacklittermanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfolioblacklittermanMatrix::to_string(self : FinanceportfolioblacklittermanMatrix) -> String {
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

pub(all) struct FinanceportfolioblacklittermanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_black_litterman_make_vector(comps : Array[Double]) -> FinanceportfolioblacklittermanVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_black_litterman_vector_zero(dim : Int) -> FinanceportfolioblacklittermanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfolioblacklittermanVector::add(self : FinanceportfolioblacklittermanVector, other : FinanceportfolioblacklittermanVector) -> FinanceportfolioblacklittermanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioblacklittermanVector::sub(self : FinanceportfolioblacklittermanVector, other : FinanceportfolioblacklittermanVector) -> FinanceportfolioblacklittermanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioblacklittermanVector::scale(self : FinanceportfolioblacklittermanVector, s : Double) -> FinanceportfolioblacklittermanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfolioblacklittermanVector::dot(self : FinanceportfolioblacklittermanVector, other : FinanceportfolioblacklittermanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfolioblacklittermanVector::norm(self : FinanceportfolioblacklittermanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfolioblacklittermanVector::normalize(self : FinanceportfolioblacklittermanVector) -> FinanceportfolioblacklittermanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioblacklittermanVector::dist(self : FinanceportfolioblacklittermanVector, other : FinanceportfolioblacklittermanVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfolioblacklittermanVector::to_string(self : FinanceportfolioblacklittermanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_black_litterman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_black_litterman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_black_litterman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_black_litterman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_black_litterman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_black_litterman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_black_litterman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_black_litterman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_black_litterman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_black_litterman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_black_litterman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_black_litterman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_black_litterman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_black_litterman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_black_litterman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_black_litterman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_black_litterman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_black_litterman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_black_litterman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_black_litterman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_black_litterman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_black_litterman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_black_litterman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_black_litterman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_black_litterman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_black_litterman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_black_litterman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_black_litterman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_black_litterman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfolioblacklittermanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_frame_make(size : Int) -> FinanceportfolioblacklittermanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_frame_len(s : FinanceportfolioblacklittermanFrame) -> Int { s.size }

pub fn finance_portfolio_black_litterman_frame_get(s : FinanceportfolioblacklittermanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_frame_set(s : FinanceportfolioblacklittermanFrame, i : Int, v : Double) -> FinanceportfolioblacklittermanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_sum(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_frame_mean(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_frame_scale(s : FinanceportfolioblacklittermanFrame, f : Double) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_add(a : FinanceportfolioblacklittermanFrame, b : FinanceportfolioblacklittermanFrame) -> FinanceportfolioblacklittermanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_frame_copy(s : FinanceportfolioblacklittermanFrame) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_fill(s : FinanceportfolioblacklittermanFrame, v : Double) -> FinanceportfolioblacklittermanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_frame_min(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_frame_max(s : FinanceportfolioblacklittermanFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_frame_to_string(s : FinanceportfolioblacklittermanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_table_make(size : Int) -> FinanceportfolioblacklittermanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_table_len(s : FinanceportfolioblacklittermanTable) -> Int { s.size }

pub fn finance_portfolio_black_litterman_table_get(s : FinanceportfolioblacklittermanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_table_set(s : FinanceportfolioblacklittermanTable, i : Int, v : Double) -> FinanceportfolioblacklittermanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_sum(s : FinanceportfolioblacklittermanTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_table_mean(s : FinanceportfolioblacklittermanTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_table_scale(s : FinanceportfolioblacklittermanTable, f : Double) -> FinanceportfolioblacklittermanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_add(a : FinanceportfolioblacklittermanTable, b : FinanceportfolioblacklittermanTable) -> FinanceportfolioblacklittermanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_table_copy(s : FinanceportfolioblacklittermanTable) -> FinanceportfolioblacklittermanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_fill(s : FinanceportfolioblacklittermanTable, v : Double) -> FinanceportfolioblacklittermanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_table_min(s : FinanceportfolioblacklittermanTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_table_max(s : FinanceportfolioblacklittermanTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_table_to_string(s : FinanceportfolioblacklittermanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_graphn_make(size : Int) -> FinanceportfolioblacklittermanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_graphn_len(s : FinanceportfolioblacklittermanGraphN) -> Int { s.size }

pub fn finance_portfolio_black_litterman_graphn_get(s : FinanceportfolioblacklittermanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_graphn_set(s : FinanceportfolioblacklittermanGraphN, i : Int, v : Double) -> FinanceportfolioblacklittermanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_sum(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_graphn_mean(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_graphn_scale(s : FinanceportfolioblacklittermanGraphN, f : Double) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_add(a : FinanceportfolioblacklittermanGraphN, b : FinanceportfolioblacklittermanGraphN) -> FinanceportfolioblacklittermanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_graphn_copy(s : FinanceportfolioblacklittermanGraphN) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_fill(s : FinanceportfolioblacklittermanGraphN, v : Double) -> FinanceportfolioblacklittermanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_graphn_min(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_graphn_max(s : FinanceportfolioblacklittermanGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_graphn_to_string(s : FinanceportfolioblacklittermanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_node_make(size : Int) -> FinanceportfolioblacklittermanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_node_len(s : FinanceportfolioblacklittermanNode) -> Int { s.size }

pub fn finance_portfolio_black_litterman_node_get(s : FinanceportfolioblacklittermanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_node_set(s : FinanceportfolioblacklittermanNode, i : Int, v : Double) -> FinanceportfolioblacklittermanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_sum(s : FinanceportfolioblacklittermanNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_node_mean(s : FinanceportfolioblacklittermanNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_node_scale(s : FinanceportfolioblacklittermanNode, f : Double) -> FinanceportfolioblacklittermanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_add(a : FinanceportfolioblacklittermanNode, b : FinanceportfolioblacklittermanNode) -> FinanceportfolioblacklittermanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_node_copy(s : FinanceportfolioblacklittermanNode) -> FinanceportfolioblacklittermanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_fill(s : FinanceportfolioblacklittermanNode, v : Double) -> FinanceportfolioblacklittermanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_node_min(s : FinanceportfolioblacklittermanNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_node_max(s : FinanceportfolioblacklittermanNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_node_to_string(s : FinanceportfolioblacklittermanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_edge_make(size : Int) -> FinanceportfolioblacklittermanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_edge_len(s : FinanceportfolioblacklittermanEdge) -> Int { s.size }

pub fn finance_portfolio_black_litterman_edge_get(s : FinanceportfolioblacklittermanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_edge_set(s : FinanceportfolioblacklittermanEdge, i : Int, v : Double) -> FinanceportfolioblacklittermanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_sum(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_edge_mean(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_edge_scale(s : FinanceportfolioblacklittermanEdge, f : Double) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_add(a : FinanceportfolioblacklittermanEdge, b : FinanceportfolioblacklittermanEdge) -> FinanceportfolioblacklittermanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_edge_copy(s : FinanceportfolioblacklittermanEdge) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_fill(s : FinanceportfolioblacklittermanEdge, v : Double) -> FinanceportfolioblacklittermanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_edge_min(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_edge_max(s : FinanceportfolioblacklittermanEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_edge_to_string(s : FinanceportfolioblacklittermanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_path_make(size : Int) -> FinanceportfolioblacklittermanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_path_len(s : FinanceportfolioblacklittermanPath) -> Int { s.size }

pub fn finance_portfolio_black_litterman_path_get(s : FinanceportfolioblacklittermanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_path_set(s : FinanceportfolioblacklittermanPath, i : Int, v : Double) -> FinanceportfolioblacklittermanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_sum(s : FinanceportfolioblacklittermanPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_path_mean(s : FinanceportfolioblacklittermanPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_path_scale(s : FinanceportfolioblacklittermanPath, f : Double) -> FinanceportfolioblacklittermanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_add(a : FinanceportfolioblacklittermanPath, b : FinanceportfolioblacklittermanPath) -> FinanceportfolioblacklittermanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_path_copy(s : FinanceportfolioblacklittermanPath) -> FinanceportfolioblacklittermanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_fill(s : FinanceportfolioblacklittermanPath, v : Double) -> FinanceportfolioblacklittermanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_path_min(s : FinanceportfolioblacklittermanPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_path_max(s : FinanceportfolioblacklittermanPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_path_to_string(s : FinanceportfolioblacklittermanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_cluster_make(size : Int) -> FinanceportfolioblacklittermanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_cluster_len(s : FinanceportfolioblacklittermanCluster) -> Int { s.size }

pub fn finance_portfolio_black_litterman_cluster_get(s : FinanceportfolioblacklittermanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_cluster_set(s : FinanceportfolioblacklittermanCluster, i : Int, v : Double) -> FinanceportfolioblacklittermanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_sum(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_cluster_mean(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_cluster_scale(s : FinanceportfolioblacklittermanCluster, f : Double) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_add(a : FinanceportfolioblacklittermanCluster, b : FinanceportfolioblacklittermanCluster) -> FinanceportfolioblacklittermanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_cluster_copy(s : FinanceportfolioblacklittermanCluster) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_fill(s : FinanceportfolioblacklittermanCluster, v : Double) -> FinanceportfolioblacklittermanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cluster_min(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_cluster_max(s : FinanceportfolioblacklittermanCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_cluster_to_string(s : FinanceportfolioblacklittermanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_model_make(size : Int) -> FinanceportfolioblacklittermanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_model_len(s : FinanceportfolioblacklittermanModel) -> Int { s.size }

pub fn finance_portfolio_black_litterman_model_get(s : FinanceportfolioblacklittermanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_model_set(s : FinanceportfolioblacklittermanModel, i : Int, v : Double) -> FinanceportfolioblacklittermanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_sum(s : FinanceportfolioblacklittermanModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_model_mean(s : FinanceportfolioblacklittermanModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_model_scale(s : FinanceportfolioblacklittermanModel, f : Double) -> FinanceportfolioblacklittermanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_add(a : FinanceportfolioblacklittermanModel, b : FinanceportfolioblacklittermanModel) -> FinanceportfolioblacklittermanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_model_copy(s : FinanceportfolioblacklittermanModel) -> FinanceportfolioblacklittermanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_fill(s : FinanceportfolioblacklittermanModel, v : Double) -> FinanceportfolioblacklittermanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_model_min(s : FinanceportfolioblacklittermanModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_model_max(s : FinanceportfolioblacklittermanModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_model_to_string(s : FinanceportfolioblacklittermanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_layer_make(size : Int) -> FinanceportfolioblacklittermanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_layer_len(s : FinanceportfolioblacklittermanLayer) -> Int { s.size }

pub fn finance_portfolio_black_litterman_layer_get(s : FinanceportfolioblacklittermanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_layer_set(s : FinanceportfolioblacklittermanLayer, i : Int, v : Double) -> FinanceportfolioblacklittermanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_sum(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_layer_mean(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_layer_scale(s : FinanceportfolioblacklittermanLayer, f : Double) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_add(a : FinanceportfolioblacklittermanLayer, b : FinanceportfolioblacklittermanLayer) -> FinanceportfolioblacklittermanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_layer_copy(s : FinanceportfolioblacklittermanLayer) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_fill(s : FinanceportfolioblacklittermanLayer, v : Double) -> FinanceportfolioblacklittermanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_layer_min(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_layer_max(s : FinanceportfolioblacklittermanLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_layer_to_string(s : FinanceportfolioblacklittermanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_buffer_make(size : Int) -> FinanceportfolioblacklittermanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_buffer_len(s : FinanceportfolioblacklittermanBuffer) -> Int { s.size }

pub fn finance_portfolio_black_litterman_buffer_get(s : FinanceportfolioblacklittermanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_buffer_set(s : FinanceportfolioblacklittermanBuffer, i : Int, v : Double) -> FinanceportfolioblacklittermanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_sum(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_buffer_mean(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_buffer_scale(s : FinanceportfolioblacklittermanBuffer, f : Double) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_add(a : FinanceportfolioblacklittermanBuffer, b : FinanceportfolioblacklittermanBuffer) -> FinanceportfolioblacklittermanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_buffer_copy(s : FinanceportfolioblacklittermanBuffer) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_fill(s : FinanceportfolioblacklittermanBuffer, v : Double) -> FinanceportfolioblacklittermanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_buffer_min(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_buffer_max(s : FinanceportfolioblacklittermanBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_buffer_to_string(s : FinanceportfolioblacklittermanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_cursor_make(size : Int) -> FinanceportfolioblacklittermanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_cursor_len(s : FinanceportfolioblacklittermanCursor) -> Int { s.size }

pub fn finance_portfolio_black_litterman_cursor_get(s : FinanceportfolioblacklittermanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_cursor_set(s : FinanceportfolioblacklittermanCursor, i : Int, v : Double) -> FinanceportfolioblacklittermanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_sum(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_cursor_mean(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_cursor_scale(s : FinanceportfolioblacklittermanCursor, f : Double) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_add(a : FinanceportfolioblacklittermanCursor, b : FinanceportfolioblacklittermanCursor) -> FinanceportfolioblacklittermanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_cursor_copy(s : FinanceportfolioblacklittermanCursor) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_fill(s : FinanceportfolioblacklittermanCursor, v : Double) -> FinanceportfolioblacklittermanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_cursor_min(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_cursor_max(s : FinanceportfolioblacklittermanCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_cursor_to_string(s : FinanceportfolioblacklittermanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_view_make(size : Int) -> FinanceportfolioblacklittermanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_view_len(s : FinanceportfolioblacklittermanView) -> Int { s.size }

pub fn finance_portfolio_black_litterman_view_get(s : FinanceportfolioblacklittermanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_view_set(s : FinanceportfolioblacklittermanView, i : Int, v : Double) -> FinanceportfolioblacklittermanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_sum(s : FinanceportfolioblacklittermanView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_view_mean(s : FinanceportfolioblacklittermanView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_view_scale(s : FinanceportfolioblacklittermanView, f : Double) -> FinanceportfolioblacklittermanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_add(a : FinanceportfolioblacklittermanView, b : FinanceportfolioblacklittermanView) -> FinanceportfolioblacklittermanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_view_copy(s : FinanceportfolioblacklittermanView) -> FinanceportfolioblacklittermanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_fill(s : FinanceportfolioblacklittermanView, v : Double) -> FinanceportfolioblacklittermanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_view_min(s : FinanceportfolioblacklittermanView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_view_max(s : FinanceportfolioblacklittermanView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_view_to_string(s : FinanceportfolioblacklittermanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_range_make(size : Int) -> FinanceportfolioblacklittermanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_range_len(s : FinanceportfolioblacklittermanRange) -> Int { s.size }

pub fn finance_portfolio_black_litterman_range_get(s : FinanceportfolioblacklittermanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_range_set(s : FinanceportfolioblacklittermanRange, i : Int, v : Double) -> FinanceportfolioblacklittermanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_sum(s : FinanceportfolioblacklittermanRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_range_mean(s : FinanceportfolioblacklittermanRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_range_scale(s : FinanceportfolioblacklittermanRange, f : Double) -> FinanceportfolioblacklittermanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_add(a : FinanceportfolioblacklittermanRange, b : FinanceportfolioblacklittermanRange) -> FinanceportfolioblacklittermanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_range_copy(s : FinanceportfolioblacklittermanRange) -> FinanceportfolioblacklittermanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_fill(s : FinanceportfolioblacklittermanRange, v : Double) -> FinanceportfolioblacklittermanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_range_min(s : FinanceportfolioblacklittermanRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_range_max(s : FinanceportfolioblacklittermanRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_range_to_string(s : FinanceportfolioblacklittermanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioblacklittermanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_black_litterman_slice_make(size : Int) -> FinanceportfolioblacklittermanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_black_litterman_slice_len(s : FinanceportfolioblacklittermanSlice) -> Int { s.size }

pub fn finance_portfolio_black_litterman_slice_get(s : FinanceportfolioblacklittermanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_black_litterman_slice_set(s : FinanceportfolioblacklittermanSlice, i : Int, v : Double) -> FinanceportfolioblacklittermanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_sum(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_black_litterman_slice_mean(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_black_litterman_slice_scale(s : FinanceportfolioblacklittermanSlice, f : Double) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_add(a : FinanceportfolioblacklittermanSlice, b : FinanceportfolioblacklittermanSlice) -> FinanceportfolioblacklittermanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_black_litterman_slice_copy(s : FinanceportfolioblacklittermanSlice) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_fill(s : FinanceportfolioblacklittermanSlice, v : Double) -> FinanceportfolioblacklittermanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_black_litterman_slice_min(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_black_litterman_slice_max(s : FinanceportfolioblacklittermanSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_black_litterman_slice_to_string(s : FinanceportfolioblacklittermanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

