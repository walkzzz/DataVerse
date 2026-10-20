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

pub fn FinanceportfoliorobustFrame::len(self : FinanceportfoliorobustFrame) -> Int { self.size }

pub fn FinanceportfoliorobustFrame::get(self : FinanceportfoliorobustFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustFrame::set(self : FinanceportfoliorobustFrame, i : Int, v : Double) -> FinanceportfoliorobustFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustFrame::sum(self : FinanceportfoliorobustFrame) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustFrame::mean(self : FinanceportfoliorobustFrame) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustFrame::scale(self : FinanceportfoliorobustFrame, f : Double) -> FinanceportfoliorobustFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustFrame::add(self : FinanceportfoliorobustFrame, other : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustFrame::copy(self : FinanceportfoliorobustFrame) -> FinanceportfoliorobustFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustFrame::fill(self : FinanceportfoliorobustFrame, v : Double) -> FinanceportfoliorobustFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustFrame::min(self : FinanceportfoliorobustFrame) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustFrame::max(self : FinanceportfoliorobustFrame) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustFrame::to_string(self : FinanceportfoliorobustFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_table_make(size : Int) -> FinanceportfoliorobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustTable::len(self : FinanceportfoliorobustTable) -> Int { self.size }

pub fn FinanceportfoliorobustTable::get(self : FinanceportfoliorobustTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustTable::set(self : FinanceportfoliorobustTable, i : Int, v : Double) -> FinanceportfoliorobustTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustTable::sum(self : FinanceportfoliorobustTable) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustTable::mean(self : FinanceportfoliorobustTable) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustTable::scale(self : FinanceportfoliorobustTable, f : Double) -> FinanceportfoliorobustTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustTable::add(self : FinanceportfoliorobustTable, other : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustTable::copy(self : FinanceportfoliorobustTable) -> FinanceportfoliorobustTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustTable::fill(self : FinanceportfoliorobustTable, v : Double) -> FinanceportfoliorobustTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustTable::min(self : FinanceportfoliorobustTable) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustTable::max(self : FinanceportfoliorobustTable) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustTable::to_string(self : FinanceportfoliorobustTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_graphn_make(size : Int) -> FinanceportfoliorobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustGraphN::len(self : FinanceportfoliorobustGraphN) -> Int { self.size }

pub fn FinanceportfoliorobustGraphN::get(self : FinanceportfoliorobustGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustGraphN::set(self : FinanceportfoliorobustGraphN, i : Int, v : Double) -> FinanceportfoliorobustGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustGraphN::sum(self : FinanceportfoliorobustGraphN) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustGraphN::mean(self : FinanceportfoliorobustGraphN) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustGraphN::scale(self : FinanceportfoliorobustGraphN, f : Double) -> FinanceportfoliorobustGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustGraphN::add(self : FinanceportfoliorobustGraphN, other : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustGraphN::copy(self : FinanceportfoliorobustGraphN) -> FinanceportfoliorobustGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustGraphN::fill(self : FinanceportfoliorobustGraphN, v : Double) -> FinanceportfoliorobustGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustGraphN::min(self : FinanceportfoliorobustGraphN) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustGraphN::max(self : FinanceportfoliorobustGraphN) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustGraphN::to_string(self : FinanceportfoliorobustGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_node_make(size : Int) -> FinanceportfoliorobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustNode::len(self : FinanceportfoliorobustNode) -> Int { self.size }

pub fn FinanceportfoliorobustNode::get(self : FinanceportfoliorobustNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustNode::set(self : FinanceportfoliorobustNode, i : Int, v : Double) -> FinanceportfoliorobustNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustNode::sum(self : FinanceportfoliorobustNode) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustNode::mean(self : FinanceportfoliorobustNode) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustNode::scale(self : FinanceportfoliorobustNode, f : Double) -> FinanceportfoliorobustNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustNode::add(self : FinanceportfoliorobustNode, other : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustNode::copy(self : FinanceportfoliorobustNode) -> FinanceportfoliorobustNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustNode::fill(self : FinanceportfoliorobustNode, v : Double) -> FinanceportfoliorobustNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustNode::min(self : FinanceportfoliorobustNode) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustNode::max(self : FinanceportfoliorobustNode) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustNode::to_string(self : FinanceportfoliorobustNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_edge_make(size : Int) -> FinanceportfoliorobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustEdge::len(self : FinanceportfoliorobustEdge) -> Int { self.size }

pub fn FinanceportfoliorobustEdge::get(self : FinanceportfoliorobustEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustEdge::set(self : FinanceportfoliorobustEdge, i : Int, v : Double) -> FinanceportfoliorobustEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustEdge::sum(self : FinanceportfoliorobustEdge) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustEdge::mean(self : FinanceportfoliorobustEdge) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustEdge::scale(self : FinanceportfoliorobustEdge, f : Double) -> FinanceportfoliorobustEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustEdge::add(self : FinanceportfoliorobustEdge, other : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustEdge::copy(self : FinanceportfoliorobustEdge) -> FinanceportfoliorobustEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustEdge::fill(self : FinanceportfoliorobustEdge, v : Double) -> FinanceportfoliorobustEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustEdge::min(self : FinanceportfoliorobustEdge) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustEdge::max(self : FinanceportfoliorobustEdge) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustEdge::to_string(self : FinanceportfoliorobustEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_path_make(size : Int) -> FinanceportfoliorobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustPath::len(self : FinanceportfoliorobustPath) -> Int { self.size }

pub fn FinanceportfoliorobustPath::get(self : FinanceportfoliorobustPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustPath::set(self : FinanceportfoliorobustPath, i : Int, v : Double) -> FinanceportfoliorobustPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustPath::sum(self : FinanceportfoliorobustPath) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustPath::mean(self : FinanceportfoliorobustPath) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustPath::scale(self : FinanceportfoliorobustPath, f : Double) -> FinanceportfoliorobustPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustPath::add(self : FinanceportfoliorobustPath, other : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustPath::copy(self : FinanceportfoliorobustPath) -> FinanceportfoliorobustPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustPath::fill(self : FinanceportfoliorobustPath, v : Double) -> FinanceportfoliorobustPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustPath::min(self : FinanceportfoliorobustPath) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustPath::max(self : FinanceportfoliorobustPath) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustPath::to_string(self : FinanceportfoliorobustPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cluster_make(size : Int) -> FinanceportfoliorobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustCluster::len(self : FinanceportfoliorobustCluster) -> Int { self.size }

pub fn FinanceportfoliorobustCluster::get(self : FinanceportfoliorobustCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustCluster::set(self : FinanceportfoliorobustCluster, i : Int, v : Double) -> FinanceportfoliorobustCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCluster::sum(self : FinanceportfoliorobustCluster) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustCluster::mean(self : FinanceportfoliorobustCluster) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustCluster::scale(self : FinanceportfoliorobustCluster, f : Double) -> FinanceportfoliorobustCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCluster::add(self : FinanceportfoliorobustCluster, other : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustCluster::copy(self : FinanceportfoliorobustCluster) -> FinanceportfoliorobustCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCluster::fill(self : FinanceportfoliorobustCluster, v : Double) -> FinanceportfoliorobustCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCluster::min(self : FinanceportfoliorobustCluster) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustCluster::max(self : FinanceportfoliorobustCluster) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustCluster::to_string(self : FinanceportfoliorobustCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_model_make(size : Int) -> FinanceportfoliorobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustModel::len(self : FinanceportfoliorobustModel) -> Int { self.size }

pub fn FinanceportfoliorobustModel::get(self : FinanceportfoliorobustModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustModel::set(self : FinanceportfoliorobustModel, i : Int, v : Double) -> FinanceportfoliorobustModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustModel::sum(self : FinanceportfoliorobustModel) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustModel::mean(self : FinanceportfoliorobustModel) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustModel::scale(self : FinanceportfoliorobustModel, f : Double) -> FinanceportfoliorobustModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustModel::add(self : FinanceportfoliorobustModel, other : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustModel::copy(self : FinanceportfoliorobustModel) -> FinanceportfoliorobustModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustModel::fill(self : FinanceportfoliorobustModel, v : Double) -> FinanceportfoliorobustModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustModel::min(self : FinanceportfoliorobustModel) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustModel::max(self : FinanceportfoliorobustModel) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustModel::to_string(self : FinanceportfoliorobustModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_layer_make(size : Int) -> FinanceportfoliorobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustLayer::len(self : FinanceportfoliorobustLayer) -> Int { self.size }

pub fn FinanceportfoliorobustLayer::get(self : FinanceportfoliorobustLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustLayer::set(self : FinanceportfoliorobustLayer, i : Int, v : Double) -> FinanceportfoliorobustLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustLayer::sum(self : FinanceportfoliorobustLayer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustLayer::mean(self : FinanceportfoliorobustLayer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustLayer::scale(self : FinanceportfoliorobustLayer, f : Double) -> FinanceportfoliorobustLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustLayer::add(self : FinanceportfoliorobustLayer, other : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustLayer::copy(self : FinanceportfoliorobustLayer) -> FinanceportfoliorobustLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustLayer::fill(self : FinanceportfoliorobustLayer, v : Double) -> FinanceportfoliorobustLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustLayer::min(self : FinanceportfoliorobustLayer) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustLayer::max(self : FinanceportfoliorobustLayer) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustLayer::to_string(self : FinanceportfoliorobustLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_buffer_make(size : Int) -> FinanceportfoliorobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustBuffer::len(self : FinanceportfoliorobustBuffer) -> Int { self.size }

pub fn FinanceportfoliorobustBuffer::get(self : FinanceportfoliorobustBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustBuffer::set(self : FinanceportfoliorobustBuffer, i : Int, v : Double) -> FinanceportfoliorobustBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustBuffer::sum(self : FinanceportfoliorobustBuffer) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustBuffer::mean(self : FinanceportfoliorobustBuffer) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustBuffer::scale(self : FinanceportfoliorobustBuffer, f : Double) -> FinanceportfoliorobustBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustBuffer::add(self : FinanceportfoliorobustBuffer, other : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustBuffer::copy(self : FinanceportfoliorobustBuffer) -> FinanceportfoliorobustBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustBuffer::fill(self : FinanceportfoliorobustBuffer, v : Double) -> FinanceportfoliorobustBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustBuffer::min(self : FinanceportfoliorobustBuffer) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustBuffer::max(self : FinanceportfoliorobustBuffer) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustBuffer::to_string(self : FinanceportfoliorobustBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_cursor_make(size : Int) -> FinanceportfoliorobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustCursor::len(self : FinanceportfoliorobustCursor) -> Int { self.size }

pub fn FinanceportfoliorobustCursor::get(self : FinanceportfoliorobustCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustCursor::set(self : FinanceportfoliorobustCursor, i : Int, v : Double) -> FinanceportfoliorobustCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCursor::sum(self : FinanceportfoliorobustCursor) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustCursor::mean(self : FinanceportfoliorobustCursor) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustCursor::scale(self : FinanceportfoliorobustCursor, f : Double) -> FinanceportfoliorobustCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCursor::add(self : FinanceportfoliorobustCursor, other : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustCursor::copy(self : FinanceportfoliorobustCursor) -> FinanceportfoliorobustCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCursor::fill(self : FinanceportfoliorobustCursor, v : Double) -> FinanceportfoliorobustCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustCursor::min(self : FinanceportfoliorobustCursor) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustCursor::max(self : FinanceportfoliorobustCursor) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustCursor::to_string(self : FinanceportfoliorobustCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_view_make(size : Int) -> FinanceportfoliorobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustView::len(self : FinanceportfoliorobustView) -> Int { self.size }

pub fn FinanceportfoliorobustView::get(self : FinanceportfoliorobustView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustView::set(self : FinanceportfoliorobustView, i : Int, v : Double) -> FinanceportfoliorobustView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustView::sum(self : FinanceportfoliorobustView) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustView::mean(self : FinanceportfoliorobustView) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustView::scale(self : FinanceportfoliorobustView, f : Double) -> FinanceportfoliorobustView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustView::add(self : FinanceportfoliorobustView, other : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustView::copy(self : FinanceportfoliorobustView) -> FinanceportfoliorobustView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustView::fill(self : FinanceportfoliorobustView, v : Double) -> FinanceportfoliorobustView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustView::min(self : FinanceportfoliorobustView) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustView::max(self : FinanceportfoliorobustView) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustView::to_string(self : FinanceportfoliorobustView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_range_make(size : Int) -> FinanceportfoliorobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustRange::len(self : FinanceportfoliorobustRange) -> Int { self.size }

pub fn FinanceportfoliorobustRange::get(self : FinanceportfoliorobustRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustRange::set(self : FinanceportfoliorobustRange, i : Int, v : Double) -> FinanceportfoliorobustRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustRange::sum(self : FinanceportfoliorobustRange) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustRange::mean(self : FinanceportfoliorobustRange) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustRange::scale(self : FinanceportfoliorobustRange, f : Double) -> FinanceportfoliorobustRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustRange::add(self : FinanceportfoliorobustRange, other : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustRange::copy(self : FinanceportfoliorobustRange) -> FinanceportfoliorobustRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustRange::fill(self : FinanceportfoliorobustRange, v : Double) -> FinanceportfoliorobustRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustRange::min(self : FinanceportfoliorobustRange) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustRange::max(self : FinanceportfoliorobustRange) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustRange::to_string(self : FinanceportfoliorobustRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_robust_slice_make(size : Int) -> FinanceportfoliorobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinanceportfoliorobustSlice::len(self : FinanceportfoliorobustSlice) -> Int { self.size }

pub fn FinanceportfoliorobustSlice::get(self : FinanceportfoliorobustSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinanceportfoliorobustSlice::set(self : FinanceportfoliorobustSlice, i : Int, v : Double) -> FinanceportfoliorobustSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustSlice::sum(self : FinanceportfoliorobustSlice) -> Double { @_common.sum(self.data) }

pub fn FinanceportfoliorobustSlice::mean(self : FinanceportfoliorobustSlice) -> Double { @_common.mean(self.data) }

pub fn FinanceportfoliorobustSlice::scale(self : FinanceportfoliorobustSlice, f : Double) -> FinanceportfoliorobustSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustSlice::add(self : FinanceportfoliorobustSlice, other : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinanceportfoliorobustSlice::copy(self : FinanceportfoliorobustSlice) -> FinanceportfoliorobustSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustSlice::fill(self : FinanceportfoliorobustSlice, v : Double) -> FinanceportfoliorobustSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinanceportfoliorobustSlice::min(self : FinanceportfoliorobustSlice) -> Double { @_common.min(self.data) }

pub fn FinanceportfoliorobustSlice::max(self : FinanceportfoliorobustSlice) -> Double { @_common.max(self.data) }

pub fn FinanceportfoliorobustSlice::to_string(self : FinanceportfoliorobustSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

