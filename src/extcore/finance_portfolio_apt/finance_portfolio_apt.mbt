///===
/// extcore/finance_portfolio_apt

pub(all) struct FinanceportfolioaptPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_apt_make_point(x : Double, y : Double) -> FinanceportfolioaptPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_apt_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioaptPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfolioaptPoint::x(self : FinanceportfolioaptPoint) -> Double { self.x }

pub fn FinanceportfolioaptPoint::y(self : FinanceportfolioaptPoint) -> Double { self.y }

pub fn FinanceportfolioaptPoint::z(self : FinanceportfolioaptPoint) -> Double { self.z }

pub fn FinanceportfolioaptPoint::label(self : FinanceportfolioaptPoint) -> Int { self.label }

pub fn FinanceportfolioaptPoint::dist(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfolioaptPoint::add(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfolioaptPoint::sub(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfolioaptPoint::scale(self : FinanceportfolioaptPoint, s : Double) -> FinanceportfolioaptPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfolioaptPoint::dot(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfolioaptPoint::cross(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfolioaptPoint::norm(self : FinanceportfolioaptPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfolioaptPoint::normalize(self : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioaptPoint::negate(self : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfolioaptPoint::mid(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint) -> FinanceportfolioaptPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfolioaptPoint::lerp(self : FinanceportfolioaptPoint, other : FinanceportfolioaptPoint, t : Double) -> FinanceportfolioaptPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfolioaptPoint::to_string(self : FinanceportfolioaptPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfolioaptSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_apt_make_series(vals : Array[Double], name : String) -> FinanceportfolioaptSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfolioaptSeries::len(self : FinanceportfolioaptSeries) -> Int { self.vals.length() }

pub fn FinanceportfolioaptSeries::sum(self : FinanceportfolioaptSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfolioaptSeries::mean(self : FinanceportfolioaptSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfolioaptSeries::min(self : FinanceportfolioaptSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfolioaptSeries::max(self : FinanceportfolioaptSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfolioaptSeries::range(self : FinanceportfolioaptSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfolioaptSeries::variance(self : FinanceportfolioaptSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfolioaptSeries::std(self : FinanceportfolioaptSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfolioaptSeries::median(self : FinanceportfolioaptSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfolioaptSeries::scale(self : FinanceportfolioaptSeries, f : Double) -> FinanceportfolioaptSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfolioaptSeries::add(self : FinanceportfolioaptSeries, other : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfolioaptSeries::sub(self : FinanceportfolioaptSeries, other : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfolioaptSeries::normalize(self : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfolioaptSeries::cumsum(self : FinanceportfolioaptSeries) -> FinanceportfolioaptSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfolioaptSeries::to_string(self : FinanceportfolioaptSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioaptMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_apt_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioaptMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_apt_matrix_identity(n : Int) -> FinanceportfolioaptMatrix {
  let m = finance_portfolio_apt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfolioaptMatrix::get(self : FinanceportfolioaptMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfolioaptMatrix::transpose(self : FinanceportfolioaptMatrix) -> FinanceportfolioaptMatrix {
  let result = finance_portfolio_apt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfolioaptMatrix::add(self : FinanceportfolioaptMatrix, other : FinanceportfolioaptMatrix) -> FinanceportfolioaptMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_apt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfolioaptMatrix::scale(self : FinanceportfolioaptMatrix, s : Double) -> FinanceportfolioaptMatrix {
  let result = finance_portfolio_apt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfolioaptMatrix::multiply(self : FinanceportfolioaptMatrix, other : FinanceportfolioaptMatrix) -> FinanceportfolioaptMatrix {
  if self.cols != other.rows { return finance_portfolio_apt_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_apt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfolioaptMatrix::trace(self : FinanceportfolioaptMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfolioaptMatrix::det(self : FinanceportfolioaptMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfolioaptMatrix::norm(self : FinanceportfolioaptMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfolioaptMatrix::to_string(self : FinanceportfolioaptMatrix) -> String {
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

pub(all) struct FinanceportfolioaptVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_apt_make_vector(comps : Array[Double]) -> FinanceportfolioaptVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_apt_vector_zero(dim : Int) -> FinanceportfolioaptVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfolioaptVector::add(self : FinanceportfolioaptVector, other : FinanceportfolioaptVector) -> FinanceportfolioaptVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioaptVector::sub(self : FinanceportfolioaptVector, other : FinanceportfolioaptVector) -> FinanceportfolioaptVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioaptVector::scale(self : FinanceportfolioaptVector, s : Double) -> FinanceportfolioaptVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfolioaptVector::dot(self : FinanceportfolioaptVector, other : FinanceportfolioaptVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfolioaptVector::norm(self : FinanceportfolioaptVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfolioaptVector::normalize(self : FinanceportfolioaptVector) -> FinanceportfolioaptVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioaptVector::dist(self : FinanceportfolioaptVector, other : FinanceportfolioaptVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfolioaptVector::to_string(self : FinanceportfolioaptVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_apt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_apt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_apt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_apt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_apt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_apt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_apt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_apt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_apt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_apt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_apt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_apt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_apt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_apt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_apt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_apt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_apt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_apt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_apt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_apt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_apt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_apt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_apt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_apt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_apt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_apt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_apt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_apt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_apt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfolioaptFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_frame_make(size : Int) -> FinanceportfolioaptFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_frame_len(s : FinanceportfolioaptFrame) -> Int { s.size }

pub fn finance_portfolio_apt_frame_get(s : FinanceportfolioaptFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_frame_set(s : FinanceportfolioaptFrame, i : Int, v : Double) -> FinanceportfolioaptFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_frame_sum(s : FinanceportfolioaptFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_frame_mean(s : FinanceportfolioaptFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_frame_scale(s : FinanceportfolioaptFrame, f : Double) -> FinanceportfolioaptFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_frame_add(a : FinanceportfolioaptFrame, b : FinanceportfolioaptFrame) -> FinanceportfolioaptFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_frame_copy(s : FinanceportfolioaptFrame) -> FinanceportfolioaptFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_frame_fill(s : FinanceportfolioaptFrame, v : Double) -> FinanceportfolioaptFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_frame_min(s : FinanceportfolioaptFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_frame_max(s : FinanceportfolioaptFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_frame_to_string(s : FinanceportfolioaptFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_table_make(size : Int) -> FinanceportfolioaptTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_table_len(s : FinanceportfolioaptTable) -> Int { s.size }

pub fn finance_portfolio_apt_table_get(s : FinanceportfolioaptTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_table_set(s : FinanceportfolioaptTable, i : Int, v : Double) -> FinanceportfolioaptTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_table_sum(s : FinanceportfolioaptTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_table_mean(s : FinanceportfolioaptTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_table_scale(s : FinanceportfolioaptTable, f : Double) -> FinanceportfolioaptTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_table_add(a : FinanceportfolioaptTable, b : FinanceportfolioaptTable) -> FinanceportfolioaptTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_table_copy(s : FinanceportfolioaptTable) -> FinanceportfolioaptTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_table_fill(s : FinanceportfolioaptTable, v : Double) -> FinanceportfolioaptTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_table_min(s : FinanceportfolioaptTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_table_max(s : FinanceportfolioaptTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_table_to_string(s : FinanceportfolioaptTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_graphn_make(size : Int) -> FinanceportfolioaptGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_graphn_len(s : FinanceportfolioaptGraphN) -> Int { s.size }

pub fn finance_portfolio_apt_graphn_get(s : FinanceportfolioaptGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_graphn_set(s : FinanceportfolioaptGraphN, i : Int, v : Double) -> FinanceportfolioaptGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_graphn_sum(s : FinanceportfolioaptGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_graphn_mean(s : FinanceportfolioaptGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_graphn_scale(s : FinanceportfolioaptGraphN, f : Double) -> FinanceportfolioaptGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_graphn_add(a : FinanceportfolioaptGraphN, b : FinanceportfolioaptGraphN) -> FinanceportfolioaptGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_graphn_copy(s : FinanceportfolioaptGraphN) -> FinanceportfolioaptGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_graphn_fill(s : FinanceportfolioaptGraphN, v : Double) -> FinanceportfolioaptGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_graphn_min(s : FinanceportfolioaptGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_graphn_max(s : FinanceportfolioaptGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_graphn_to_string(s : FinanceportfolioaptGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_node_make(size : Int) -> FinanceportfolioaptNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_node_len(s : FinanceportfolioaptNode) -> Int { s.size }

pub fn finance_portfolio_apt_node_get(s : FinanceportfolioaptNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_node_set(s : FinanceportfolioaptNode, i : Int, v : Double) -> FinanceportfolioaptNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_node_sum(s : FinanceportfolioaptNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_node_mean(s : FinanceportfolioaptNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_node_scale(s : FinanceportfolioaptNode, f : Double) -> FinanceportfolioaptNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_node_add(a : FinanceportfolioaptNode, b : FinanceportfolioaptNode) -> FinanceportfolioaptNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_node_copy(s : FinanceportfolioaptNode) -> FinanceportfolioaptNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_node_fill(s : FinanceportfolioaptNode, v : Double) -> FinanceportfolioaptNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_node_min(s : FinanceportfolioaptNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_node_max(s : FinanceportfolioaptNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_node_to_string(s : FinanceportfolioaptNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_edge_make(size : Int) -> FinanceportfolioaptEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_edge_len(s : FinanceportfolioaptEdge) -> Int { s.size }

pub fn finance_portfolio_apt_edge_get(s : FinanceportfolioaptEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_edge_set(s : FinanceportfolioaptEdge, i : Int, v : Double) -> FinanceportfolioaptEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_edge_sum(s : FinanceportfolioaptEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_edge_mean(s : FinanceportfolioaptEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_edge_scale(s : FinanceportfolioaptEdge, f : Double) -> FinanceportfolioaptEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_edge_add(a : FinanceportfolioaptEdge, b : FinanceportfolioaptEdge) -> FinanceportfolioaptEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_edge_copy(s : FinanceportfolioaptEdge) -> FinanceportfolioaptEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_edge_fill(s : FinanceportfolioaptEdge, v : Double) -> FinanceportfolioaptEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_edge_min(s : FinanceportfolioaptEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_edge_max(s : FinanceportfolioaptEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_edge_to_string(s : FinanceportfolioaptEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_path_make(size : Int) -> FinanceportfolioaptPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_path_len(s : FinanceportfolioaptPath) -> Int { s.size }

pub fn finance_portfolio_apt_path_get(s : FinanceportfolioaptPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_path_set(s : FinanceportfolioaptPath, i : Int, v : Double) -> FinanceportfolioaptPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_path_sum(s : FinanceportfolioaptPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_path_mean(s : FinanceportfolioaptPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_path_scale(s : FinanceportfolioaptPath, f : Double) -> FinanceportfolioaptPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_path_add(a : FinanceportfolioaptPath, b : FinanceportfolioaptPath) -> FinanceportfolioaptPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_path_copy(s : FinanceportfolioaptPath) -> FinanceportfolioaptPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_path_fill(s : FinanceportfolioaptPath, v : Double) -> FinanceportfolioaptPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_path_min(s : FinanceportfolioaptPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_path_max(s : FinanceportfolioaptPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_path_to_string(s : FinanceportfolioaptPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_cluster_make(size : Int) -> FinanceportfolioaptCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_cluster_len(s : FinanceportfolioaptCluster) -> Int { s.size }

pub fn finance_portfolio_apt_cluster_get(s : FinanceportfolioaptCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_cluster_set(s : FinanceportfolioaptCluster, i : Int, v : Double) -> FinanceportfolioaptCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cluster_sum(s : FinanceportfolioaptCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_cluster_mean(s : FinanceportfolioaptCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_cluster_scale(s : FinanceportfolioaptCluster, f : Double) -> FinanceportfolioaptCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cluster_add(a : FinanceportfolioaptCluster, b : FinanceportfolioaptCluster) -> FinanceportfolioaptCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_cluster_copy(s : FinanceportfolioaptCluster) -> FinanceportfolioaptCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cluster_fill(s : FinanceportfolioaptCluster, v : Double) -> FinanceportfolioaptCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cluster_min(s : FinanceportfolioaptCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_cluster_max(s : FinanceportfolioaptCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_cluster_to_string(s : FinanceportfolioaptCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_model_make(size : Int) -> FinanceportfolioaptModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_model_len(s : FinanceportfolioaptModel) -> Int { s.size }

pub fn finance_portfolio_apt_model_get(s : FinanceportfolioaptModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_model_set(s : FinanceportfolioaptModel, i : Int, v : Double) -> FinanceportfolioaptModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_model_sum(s : FinanceportfolioaptModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_model_mean(s : FinanceportfolioaptModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_model_scale(s : FinanceportfolioaptModel, f : Double) -> FinanceportfolioaptModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_model_add(a : FinanceportfolioaptModel, b : FinanceportfolioaptModel) -> FinanceportfolioaptModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_model_copy(s : FinanceportfolioaptModel) -> FinanceportfolioaptModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_model_fill(s : FinanceportfolioaptModel, v : Double) -> FinanceportfolioaptModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_model_min(s : FinanceportfolioaptModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_model_max(s : FinanceportfolioaptModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_model_to_string(s : FinanceportfolioaptModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_layer_make(size : Int) -> FinanceportfolioaptLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_layer_len(s : FinanceportfolioaptLayer) -> Int { s.size }

pub fn finance_portfolio_apt_layer_get(s : FinanceportfolioaptLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_layer_set(s : FinanceportfolioaptLayer, i : Int, v : Double) -> FinanceportfolioaptLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_layer_sum(s : FinanceportfolioaptLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_layer_mean(s : FinanceportfolioaptLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_layer_scale(s : FinanceportfolioaptLayer, f : Double) -> FinanceportfolioaptLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_layer_add(a : FinanceportfolioaptLayer, b : FinanceportfolioaptLayer) -> FinanceportfolioaptLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_layer_copy(s : FinanceportfolioaptLayer) -> FinanceportfolioaptLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_layer_fill(s : FinanceportfolioaptLayer, v : Double) -> FinanceportfolioaptLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_layer_min(s : FinanceportfolioaptLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_layer_max(s : FinanceportfolioaptLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_layer_to_string(s : FinanceportfolioaptLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_buffer_make(size : Int) -> FinanceportfolioaptBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_buffer_len(s : FinanceportfolioaptBuffer) -> Int { s.size }

pub fn finance_portfolio_apt_buffer_get(s : FinanceportfolioaptBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_buffer_set(s : FinanceportfolioaptBuffer, i : Int, v : Double) -> FinanceportfolioaptBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_buffer_sum(s : FinanceportfolioaptBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_buffer_mean(s : FinanceportfolioaptBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_buffer_scale(s : FinanceportfolioaptBuffer, f : Double) -> FinanceportfolioaptBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_buffer_add(a : FinanceportfolioaptBuffer, b : FinanceportfolioaptBuffer) -> FinanceportfolioaptBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_buffer_copy(s : FinanceportfolioaptBuffer) -> FinanceportfolioaptBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_buffer_fill(s : FinanceportfolioaptBuffer, v : Double) -> FinanceportfolioaptBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_buffer_min(s : FinanceportfolioaptBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_buffer_max(s : FinanceportfolioaptBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_buffer_to_string(s : FinanceportfolioaptBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_cursor_make(size : Int) -> FinanceportfolioaptCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_cursor_len(s : FinanceportfolioaptCursor) -> Int { s.size }

pub fn finance_portfolio_apt_cursor_get(s : FinanceportfolioaptCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_cursor_set(s : FinanceportfolioaptCursor, i : Int, v : Double) -> FinanceportfolioaptCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cursor_sum(s : FinanceportfolioaptCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_cursor_mean(s : FinanceportfolioaptCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_cursor_scale(s : FinanceportfolioaptCursor, f : Double) -> FinanceportfolioaptCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cursor_add(a : FinanceportfolioaptCursor, b : FinanceportfolioaptCursor) -> FinanceportfolioaptCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_cursor_copy(s : FinanceportfolioaptCursor) -> FinanceportfolioaptCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cursor_fill(s : FinanceportfolioaptCursor, v : Double) -> FinanceportfolioaptCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_cursor_min(s : FinanceportfolioaptCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_cursor_max(s : FinanceportfolioaptCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_cursor_to_string(s : FinanceportfolioaptCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_view_make(size : Int) -> FinanceportfolioaptView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_view_len(s : FinanceportfolioaptView) -> Int { s.size }

pub fn finance_portfolio_apt_view_get(s : FinanceportfolioaptView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_view_set(s : FinanceportfolioaptView, i : Int, v : Double) -> FinanceportfolioaptView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_view_sum(s : FinanceportfolioaptView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_view_mean(s : FinanceportfolioaptView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_view_scale(s : FinanceportfolioaptView, f : Double) -> FinanceportfolioaptView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_view_add(a : FinanceportfolioaptView, b : FinanceportfolioaptView) -> FinanceportfolioaptView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_view_copy(s : FinanceportfolioaptView) -> FinanceportfolioaptView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_view_fill(s : FinanceportfolioaptView, v : Double) -> FinanceportfolioaptView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_view_min(s : FinanceportfolioaptView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_view_max(s : FinanceportfolioaptView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_view_to_string(s : FinanceportfolioaptView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_range_make(size : Int) -> FinanceportfolioaptRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_range_len(s : FinanceportfolioaptRange) -> Int { s.size }

pub fn finance_portfolio_apt_range_get(s : FinanceportfolioaptRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_range_set(s : FinanceportfolioaptRange, i : Int, v : Double) -> FinanceportfolioaptRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_range_sum(s : FinanceportfolioaptRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_range_mean(s : FinanceportfolioaptRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_range_scale(s : FinanceportfolioaptRange, f : Double) -> FinanceportfolioaptRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_range_add(a : FinanceportfolioaptRange, b : FinanceportfolioaptRange) -> FinanceportfolioaptRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_range_copy(s : FinanceportfolioaptRange) -> FinanceportfolioaptRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_range_fill(s : FinanceportfolioaptRange, v : Double) -> FinanceportfolioaptRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_range_min(s : FinanceportfolioaptRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_range_max(s : FinanceportfolioaptRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_range_to_string(s : FinanceportfolioaptRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioaptSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_apt_slice_make(size : Int) -> FinanceportfolioaptSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_apt_slice_len(s : FinanceportfolioaptSlice) -> Int { s.size }

pub fn finance_portfolio_apt_slice_get(s : FinanceportfolioaptSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_apt_slice_set(s : FinanceportfolioaptSlice, i : Int, v : Double) -> FinanceportfolioaptSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_slice_sum(s : FinanceportfolioaptSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_apt_slice_mean(s : FinanceportfolioaptSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_apt_slice_scale(s : FinanceportfolioaptSlice, f : Double) -> FinanceportfolioaptSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_slice_add(a : FinanceportfolioaptSlice, b : FinanceportfolioaptSlice) -> FinanceportfolioaptSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_apt_slice_copy(s : FinanceportfolioaptSlice) -> FinanceportfolioaptSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_slice_fill(s : FinanceportfolioaptSlice, v : Double) -> FinanceportfolioaptSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_apt_slice_min(s : FinanceportfolioaptSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_apt_slice_max(s : FinanceportfolioaptSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_apt_slice_to_string(s : FinanceportfolioaptSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

