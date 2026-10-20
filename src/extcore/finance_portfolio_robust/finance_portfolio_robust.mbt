///===
/// extcore/finance_portfolio_robust

pub(all) struct FinanceportfoliorobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_robust_make_point(x : Double, y : Double) -> FinanceportfoliorobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_robust_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliorobustPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliorobustPoint::x(self : FinanceportfoliorobustPoint) -> Double { self.x }

pub fn FinanceportfoliorobustPoint::y(self : FinanceportfoliorobustPoint) -> Double { self.y }

pub fn FinanceportfoliorobustPoint::z(self : FinanceportfoliorobustPoint) -> Double { self.z }

pub fn FinanceportfoliorobustPoint::label(self : FinanceportfoliorobustPoint) -> Int { self.label }

pub fn FinanceportfoliorobustPoint::dist(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliorobustPoint::add(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliorobustPoint::sub(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliorobustPoint::scale(self : FinanceportfoliorobustPoint, s : Double) -> FinanceportfoliorobustPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliorobustPoint::dot(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliorobustPoint::cross(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliorobustPoint::norm(self : FinanceportfoliorobustPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliorobustPoint::normalize(self : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliorobustPoint::negate(self : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliorobustPoint::mid(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint) -> FinanceportfoliorobustPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliorobustPoint::lerp(self : FinanceportfoliorobustPoint, other : FinanceportfoliorobustPoint, t : Double) -> FinanceportfoliorobustPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliorobustPoint::to_string(self : FinanceportfoliorobustPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_robust_make_series(vals : Array[Double], name : String) -> FinanceportfoliorobustSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliorobustSeries::len(self : FinanceportfoliorobustSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliorobustSeries::sum(self : FinanceportfoliorobustSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliorobustSeries::mean(self : FinanceportfoliorobustSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliorobustSeries::min(self : FinanceportfoliorobustSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliorobustSeries::max(self : FinanceportfoliorobustSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliorobustSeries::range(self : FinanceportfoliorobustSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliorobustSeries::variance(self : FinanceportfoliorobustSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliorobustSeries::std(self : FinanceportfoliorobustSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliorobustSeries::median(self : FinanceportfoliorobustSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliorobustSeries::scale(self : FinanceportfoliorobustSeries, f : Double) -> FinanceportfoliorobustSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliorobustSeries::add(self : FinanceportfoliorobustSeries, other : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliorobustSeries::sub(self : FinanceportfoliorobustSeries, other : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliorobustSeries::normalize(self : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliorobustSeries::cumsum(self : FinanceportfoliorobustSeries) -> FinanceportfoliorobustSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliorobustSeries::to_string(self : FinanceportfoliorobustSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliorobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_robust_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliorobustMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_robust_matrix_identity(n : Int) -> FinanceportfoliorobustMatrix {
  let m = finance_portfolio_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliorobustMatrix::get(self : FinanceportfoliorobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliorobustMatrix::transpose(self : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  let result = finance_portfolio_robust_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliorobustMatrix::add(self : FinanceportfoliorobustMatrix, other : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_robust_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliorobustMatrix::scale(self : FinanceportfoliorobustMatrix, s : Double) -> FinanceportfoliorobustMatrix {
  let result = finance_portfolio_robust_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliorobustMatrix::multiply(self : FinanceportfoliorobustMatrix, other : FinanceportfoliorobustMatrix) -> FinanceportfoliorobustMatrix {
  if self.cols != other.rows { return finance_portfolio_robust_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_robust_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfoliorobustMatrix::trace(self : FinanceportfoliorobustMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliorobustMatrix::det(self : FinanceportfoliorobustMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliorobustMatrix::norm(self : FinanceportfoliorobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliorobustMatrix::to_string(self : FinanceportfoliorobustMatrix) -> String {
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

pub(all) struct FinanceportfoliorobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_robust_make_vector(comps : Array[Double]) -> FinanceportfoliorobustVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_robust_vector_zero(dim : Int) -> FinanceportfoliorobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliorobustVector::add(self : FinanceportfoliorobustVector, other : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliorobustVector::sub(self : FinanceportfoliorobustVector, other : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliorobustVector::scale(self : FinanceportfoliorobustVector, s : Double) -> FinanceportfoliorobustVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliorobustVector::dot(self : FinanceportfoliorobustVector, other : FinanceportfoliorobustVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliorobustVector::norm(self : FinanceportfoliorobustVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliorobustVector::normalize(self : FinanceportfoliorobustVector) -> FinanceportfoliorobustVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliorobustVector::dist(self : FinanceportfoliorobustVector, other : FinanceportfoliorobustVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliorobustVector::to_string(self : FinanceportfoliorobustVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_robust_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_robust_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_robust_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_robust_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_robust_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_robust_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_robust_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_robust_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_robust_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_robust_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_robust_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_robust_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_robust_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_robust_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_robust_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_robust_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_robust_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_robust_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_robust_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_robust_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_robust_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_robust_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_robust_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_robust_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_robust_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_robust_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_robust_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_robust_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_robust_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliorobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_frame_make(size : Int) -> FinanceportfoliorobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_frame_len(s : FinanceportfoliorobustFrame) -> Int { s.size }

pub fn finance_portfolio_robust_frame_get(s : FinanceportfoliorobustFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_frame_set(s : FinanceportfoliorobustFrame, i : Int, v : Double) -> FinanceportfoliorobustFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_sum(s : FinanceportfoliorobustFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_frame_mean(s : FinanceportfoliorobustFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_frame_scale(s : FinanceportfoliorobustFrame, f : Double) -> FinanceportfoliorobustFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_add(a : FinanceportfoliorobustFrame, b : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_frame_copy(s : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_fill(s : FinanceportfoliorobustFrame, v : Double) -> FinanceportfoliorobustFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_frame_min(s : FinanceportfoliorobustFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_frame_max(s : FinanceportfoliorobustFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_frame_to_string(s : FinanceportfoliorobustFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_table_make(size : Int) -> FinanceportfoliorobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_table_len(s : FinanceportfoliorobustTable) -> Int { s.size }

pub fn finance_portfolio_robust_table_get(s : FinanceportfoliorobustTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_table_set(s : FinanceportfoliorobustTable, i : Int, v : Double) -> FinanceportfoliorobustTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_sum(s : FinanceportfoliorobustTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_table_mean(s : FinanceportfoliorobustTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_table_scale(s : FinanceportfoliorobustTable, f : Double) -> FinanceportfoliorobustTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_add(a : FinanceportfoliorobustTable, b : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_table_copy(s : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_fill(s : FinanceportfoliorobustTable, v : Double) -> FinanceportfoliorobustTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_table_min(s : FinanceportfoliorobustTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_table_max(s : FinanceportfoliorobustTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_table_to_string(s : FinanceportfoliorobustTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_graphn_make(size : Int) -> FinanceportfoliorobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_graphn_len(s : FinanceportfoliorobustGraphN) -> Int { s.size }

pub fn finance_portfolio_robust_graphn_get(s : FinanceportfoliorobustGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_graphn_set(s : FinanceportfoliorobustGraphN, i : Int, v : Double) -> FinanceportfoliorobustGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_sum(s : FinanceportfoliorobustGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_graphn_mean(s : FinanceportfoliorobustGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_graphn_scale(s : FinanceportfoliorobustGraphN, f : Double) -> FinanceportfoliorobustGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_add(a : FinanceportfoliorobustGraphN, b : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_graphn_copy(s : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_fill(s : FinanceportfoliorobustGraphN, v : Double) -> FinanceportfoliorobustGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_graphn_min(s : FinanceportfoliorobustGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_graphn_max(s : FinanceportfoliorobustGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_graphn_to_string(s : FinanceportfoliorobustGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_node_make(size : Int) -> FinanceportfoliorobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_node_len(s : FinanceportfoliorobustNode) -> Int { s.size }

pub fn finance_portfolio_robust_node_get(s : FinanceportfoliorobustNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_node_set(s : FinanceportfoliorobustNode, i : Int, v : Double) -> FinanceportfoliorobustNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_sum(s : FinanceportfoliorobustNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_node_mean(s : FinanceportfoliorobustNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_node_scale(s : FinanceportfoliorobustNode, f : Double) -> FinanceportfoliorobustNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_add(a : FinanceportfoliorobustNode, b : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_node_copy(s : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_fill(s : FinanceportfoliorobustNode, v : Double) -> FinanceportfoliorobustNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_node_min(s : FinanceportfoliorobustNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_node_max(s : FinanceportfoliorobustNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_node_to_string(s : FinanceportfoliorobustNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_edge_make(size : Int) -> FinanceportfoliorobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_edge_len(s : FinanceportfoliorobustEdge) -> Int { s.size }

pub fn finance_portfolio_robust_edge_get(s : FinanceportfoliorobustEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_edge_set(s : FinanceportfoliorobustEdge, i : Int, v : Double) -> FinanceportfoliorobustEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_sum(s : FinanceportfoliorobustEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_edge_mean(s : FinanceportfoliorobustEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_edge_scale(s : FinanceportfoliorobustEdge, f : Double) -> FinanceportfoliorobustEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_add(a : FinanceportfoliorobustEdge, b : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_edge_copy(s : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_fill(s : FinanceportfoliorobustEdge, v : Double) -> FinanceportfoliorobustEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_edge_min(s : FinanceportfoliorobustEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_edge_max(s : FinanceportfoliorobustEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_edge_to_string(s : FinanceportfoliorobustEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_path_make(size : Int) -> FinanceportfoliorobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_path_len(s : FinanceportfoliorobustPath) -> Int { s.size }

pub fn finance_portfolio_robust_path_get(s : FinanceportfoliorobustPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_path_set(s : FinanceportfoliorobustPath, i : Int, v : Double) -> FinanceportfoliorobustPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_sum(s : FinanceportfoliorobustPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_path_mean(s : FinanceportfoliorobustPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_path_scale(s : FinanceportfoliorobustPath, f : Double) -> FinanceportfoliorobustPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_add(a : FinanceportfoliorobustPath, b : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_path_copy(s : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_fill(s : FinanceportfoliorobustPath, v : Double) -> FinanceportfoliorobustPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_path_min(s : FinanceportfoliorobustPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_path_max(s : FinanceportfoliorobustPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_path_to_string(s : FinanceportfoliorobustPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cluster_make(size : Int) -> FinanceportfoliorobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_cluster_len(s : FinanceportfoliorobustCluster) -> Int { s.size }

pub fn finance_portfolio_robust_cluster_get(s : FinanceportfoliorobustCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_cluster_set(s : FinanceportfoliorobustCluster, i : Int, v : Double) -> FinanceportfoliorobustCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_sum(s : FinanceportfoliorobustCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_cluster_mean(s : FinanceportfoliorobustCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_cluster_scale(s : FinanceportfoliorobustCluster, f : Double) -> FinanceportfoliorobustCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_add(a : FinanceportfoliorobustCluster, b : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_cluster_copy(s : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_fill(s : FinanceportfoliorobustCluster, v : Double) -> FinanceportfoliorobustCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cluster_min(s : FinanceportfoliorobustCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_cluster_max(s : FinanceportfoliorobustCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_cluster_to_string(s : FinanceportfoliorobustCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_model_make(size : Int) -> FinanceportfoliorobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_model_len(s : FinanceportfoliorobustModel) -> Int { s.size }

pub fn finance_portfolio_robust_model_get(s : FinanceportfoliorobustModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_model_set(s : FinanceportfoliorobustModel, i : Int, v : Double) -> FinanceportfoliorobustModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_sum(s : FinanceportfoliorobustModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_model_mean(s : FinanceportfoliorobustModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_model_scale(s : FinanceportfoliorobustModel, f : Double) -> FinanceportfoliorobustModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_add(a : FinanceportfoliorobustModel, b : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_model_copy(s : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_fill(s : FinanceportfoliorobustModel, v : Double) -> FinanceportfoliorobustModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_model_min(s : FinanceportfoliorobustModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_model_max(s : FinanceportfoliorobustModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_model_to_string(s : FinanceportfoliorobustModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_layer_make(size : Int) -> FinanceportfoliorobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_layer_len(s : FinanceportfoliorobustLayer) -> Int { s.size }

pub fn finance_portfolio_robust_layer_get(s : FinanceportfoliorobustLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_layer_set(s : FinanceportfoliorobustLayer, i : Int, v : Double) -> FinanceportfoliorobustLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_sum(s : FinanceportfoliorobustLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_layer_mean(s : FinanceportfoliorobustLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_layer_scale(s : FinanceportfoliorobustLayer, f : Double) -> FinanceportfoliorobustLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_add(a : FinanceportfoliorobustLayer, b : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_layer_copy(s : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_fill(s : FinanceportfoliorobustLayer, v : Double) -> FinanceportfoliorobustLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_layer_min(s : FinanceportfoliorobustLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_layer_max(s : FinanceportfoliorobustLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_layer_to_string(s : FinanceportfoliorobustLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_buffer_make(size : Int) -> FinanceportfoliorobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_buffer_len(s : FinanceportfoliorobustBuffer) -> Int { s.size }

pub fn finance_portfolio_robust_buffer_get(s : FinanceportfoliorobustBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_buffer_set(s : FinanceportfoliorobustBuffer, i : Int, v : Double) -> FinanceportfoliorobustBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_sum(s : FinanceportfoliorobustBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_buffer_mean(s : FinanceportfoliorobustBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_buffer_scale(s : FinanceportfoliorobustBuffer, f : Double) -> FinanceportfoliorobustBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_add(a : FinanceportfoliorobustBuffer, b : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_buffer_copy(s : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_fill(s : FinanceportfoliorobustBuffer, v : Double) -> FinanceportfoliorobustBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_buffer_min(s : FinanceportfoliorobustBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_buffer_max(s : FinanceportfoliorobustBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_buffer_to_string(s : FinanceportfoliorobustBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cursor_make(size : Int) -> FinanceportfoliorobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_cursor_len(s : FinanceportfoliorobustCursor) -> Int { s.size }

pub fn finance_portfolio_robust_cursor_get(s : FinanceportfoliorobustCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_cursor_set(s : FinanceportfoliorobustCursor, i : Int, v : Double) -> FinanceportfoliorobustCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_sum(s : FinanceportfoliorobustCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_cursor_mean(s : FinanceportfoliorobustCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_cursor_scale(s : FinanceportfoliorobustCursor, f : Double) -> FinanceportfoliorobustCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_add(a : FinanceportfoliorobustCursor, b : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_cursor_copy(s : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_fill(s : FinanceportfoliorobustCursor, v : Double) -> FinanceportfoliorobustCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_cursor_min(s : FinanceportfoliorobustCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_cursor_max(s : FinanceportfoliorobustCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_cursor_to_string(s : FinanceportfoliorobustCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_view_make(size : Int) -> FinanceportfoliorobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_view_len(s : FinanceportfoliorobustView) -> Int { s.size }

pub fn finance_portfolio_robust_view_get(s : FinanceportfoliorobustView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_view_set(s : FinanceportfoliorobustView, i : Int, v : Double) -> FinanceportfoliorobustView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_sum(s : FinanceportfoliorobustView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_view_mean(s : FinanceportfoliorobustView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_view_scale(s : FinanceportfoliorobustView, f : Double) -> FinanceportfoliorobustView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_add(a : FinanceportfoliorobustView, b : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_view_copy(s : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_fill(s : FinanceportfoliorobustView, v : Double) -> FinanceportfoliorobustView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_view_min(s : FinanceportfoliorobustView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_view_max(s : FinanceportfoliorobustView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_view_to_string(s : FinanceportfoliorobustView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_range_make(size : Int) -> FinanceportfoliorobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_range_len(s : FinanceportfoliorobustRange) -> Int { s.size }

pub fn finance_portfolio_robust_range_get(s : FinanceportfoliorobustRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_range_set(s : FinanceportfoliorobustRange, i : Int, v : Double) -> FinanceportfoliorobustRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_sum(s : FinanceportfoliorobustRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_range_mean(s : FinanceportfoliorobustRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_range_scale(s : FinanceportfoliorobustRange, f : Double) -> FinanceportfoliorobustRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_add(a : FinanceportfoliorobustRange, b : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_range_copy(s : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_fill(s : FinanceportfoliorobustRange, v : Double) -> FinanceportfoliorobustRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_range_min(s : FinanceportfoliorobustRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_range_max(s : FinanceportfoliorobustRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_range_to_string(s : FinanceportfoliorobustRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_slice_make(size : Int) -> FinanceportfoliorobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_robust_slice_len(s : FinanceportfoliorobustSlice) -> Int { s.size }

pub fn finance_portfolio_robust_slice_get(s : FinanceportfoliorobustSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_robust_slice_set(s : FinanceportfoliorobustSlice, i : Int, v : Double) -> FinanceportfoliorobustSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_sum(s : FinanceportfoliorobustSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_robust_slice_mean(s : FinanceportfoliorobustSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_robust_slice_scale(s : FinanceportfoliorobustSlice, f : Double) -> FinanceportfoliorobustSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_add(a : FinanceportfoliorobustSlice, b : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_robust_slice_copy(s : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_fill(s : FinanceportfoliorobustSlice, v : Double) -> FinanceportfoliorobustSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_robust_slice_min(s : FinanceportfoliorobustSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_robust_slice_max(s : FinanceportfoliorobustSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_robust_slice_to_string(s : FinanceportfoliorobustSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

