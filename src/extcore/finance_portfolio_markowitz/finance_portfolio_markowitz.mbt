///===
/// extcore/finance_portfolio_markowitz

pub(all) struct FinanceportfoliomarkowitzPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_markowitz_make_point(x : Double, y : Double) -> FinanceportfoliomarkowitzPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_markowitz_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliomarkowitzPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliomarkowitzPoint::x(self : FinanceportfoliomarkowitzPoint) -> Double { self.x }

pub fn FinanceportfoliomarkowitzPoint::y(self : FinanceportfoliomarkowitzPoint) -> Double { self.y }

pub fn FinanceportfoliomarkowitzPoint::z(self : FinanceportfoliomarkowitzPoint) -> Double { self.z }

pub fn FinanceportfoliomarkowitzPoint::label(self : FinanceportfoliomarkowitzPoint) -> Int { self.label }

pub fn FinanceportfoliomarkowitzPoint::dist(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliomarkowitzPoint::add(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::sub(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::scale(self : FinanceportfoliomarkowitzPoint, s : Double) -> FinanceportfoliomarkowitzPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::dot(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliomarkowitzPoint::cross(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliomarkowitzPoint::norm(self : FinanceportfoliomarkowitzPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliomarkowitzPoint::normalize(self : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliomarkowitzPoint::negate(self : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::mid(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint) -> FinanceportfoliomarkowitzPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::lerp(self : FinanceportfoliomarkowitzPoint, other : FinanceportfoliomarkowitzPoint, t : Double) -> FinanceportfoliomarkowitzPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliomarkowitzPoint::to_string(self : FinanceportfoliomarkowitzPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_markowitz_make_series(vals : Array[Double], name : String) -> FinanceportfoliomarkowitzSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliomarkowitzSeries::len(self : FinanceportfoliomarkowitzSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliomarkowitzSeries::sum(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::mean(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::min(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::max(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::range(self : FinanceportfoliomarkowitzSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliomarkowitzSeries::variance(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::std(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::median(self : FinanceportfoliomarkowitzSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliomarkowitzSeries::scale(self : FinanceportfoliomarkowitzSeries, f : Double) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::add(self : FinanceportfoliomarkowitzSeries, other : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::sub(self : FinanceportfoliomarkowitzSeries, other : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::normalize(self : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliomarkowitzSeries::cumsum(self : FinanceportfoliomarkowitzSeries) -> FinanceportfoliomarkowitzSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliomarkowitzSeries::to_string(self : FinanceportfoliomarkowitzSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliomarkowitzMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_markowitz_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliomarkowitzMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_markowitz_matrix_identity(n : Int) -> FinanceportfoliomarkowitzMatrix {
  let m = finance_portfolio_markowitz_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliomarkowitzMatrix::get(self : FinanceportfoliomarkowitzMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliomarkowitzMatrix::transpose(self : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  let result = finance_portfolio_markowitz_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::add(self : FinanceportfoliomarkowitzMatrix, other : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_markowitz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::scale(self : FinanceportfoliomarkowitzMatrix, s : Double) -> FinanceportfoliomarkowitzMatrix {
  let result = finance_portfolio_markowitz_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::multiply(self : FinanceportfoliomarkowitzMatrix, other : FinanceportfoliomarkowitzMatrix) -> FinanceportfoliomarkowitzMatrix {
  if self.cols != other.rows { return finance_portfolio_markowitz_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_markowitz_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfoliomarkowitzMatrix::trace(self : FinanceportfoliomarkowitzMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliomarkowitzMatrix::det(self : FinanceportfoliomarkowitzMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliomarkowitzMatrix::norm(self : FinanceportfoliomarkowitzMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliomarkowitzMatrix::to_string(self : FinanceportfoliomarkowitzMatrix) -> String {
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

pub(all) struct FinanceportfoliomarkowitzVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_markowitz_make_vector(comps : Array[Double]) -> FinanceportfoliomarkowitzVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_markowitz_vector_zero(dim : Int) -> FinanceportfoliomarkowitzVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliomarkowitzVector::add(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliomarkowitzVector::sub(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliomarkowitzVector::scale(self : FinanceportfoliomarkowitzVector, s : Double) -> FinanceportfoliomarkowitzVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliomarkowitzVector::dot(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliomarkowitzVector::norm(self : FinanceportfoliomarkowitzVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliomarkowitzVector::normalize(self : FinanceportfoliomarkowitzVector) -> FinanceportfoliomarkowitzVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliomarkowitzVector::dist(self : FinanceportfoliomarkowitzVector, other : FinanceportfoliomarkowitzVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliomarkowitzVector::to_string(self : FinanceportfoliomarkowitzVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_markowitz_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_markowitz_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_markowitz_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_markowitz_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_markowitz_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_markowitz_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_markowitz_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_markowitz_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_markowitz_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_markowitz_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_markowitz_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_markowitz_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_markowitz_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_markowitz_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_markowitz_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_markowitz_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_markowitz_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_markowitz_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_markowitz_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_markowitz_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_markowitz_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_markowitz_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_markowitz_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_markowitz_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_markowitz_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_markowitz_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_markowitz_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_markowitz_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_markowitz_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliomarkowitzFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_frame_make(size : Int) -> FinanceportfoliomarkowitzFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_frame_len(s : FinanceportfoliomarkowitzFrame) -> Int { s.size }

pub fn finance_portfolio_markowitz_frame_get(s : FinanceportfoliomarkowitzFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_frame_set(s : FinanceportfoliomarkowitzFrame, i : Int, v : Double) -> FinanceportfoliomarkowitzFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_frame_sum(s : FinanceportfoliomarkowitzFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_frame_mean(s : FinanceportfoliomarkowitzFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_frame_scale(s : FinanceportfoliomarkowitzFrame, f : Double) -> FinanceportfoliomarkowitzFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_frame_add(a : FinanceportfoliomarkowitzFrame, b : FinanceportfoliomarkowitzFrame) -> FinanceportfoliomarkowitzFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_frame_copy(s : FinanceportfoliomarkowitzFrame) -> FinanceportfoliomarkowitzFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_frame_fill(s : FinanceportfoliomarkowitzFrame, v : Double) -> FinanceportfoliomarkowitzFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_frame_min(s : FinanceportfoliomarkowitzFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_frame_max(s : FinanceportfoliomarkowitzFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_frame_to_string(s : FinanceportfoliomarkowitzFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_table_make(size : Int) -> FinanceportfoliomarkowitzTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_table_len(s : FinanceportfoliomarkowitzTable) -> Int { s.size }

pub fn finance_portfolio_markowitz_table_get(s : FinanceportfoliomarkowitzTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_table_set(s : FinanceportfoliomarkowitzTable, i : Int, v : Double) -> FinanceportfoliomarkowitzTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_table_sum(s : FinanceportfoliomarkowitzTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_table_mean(s : FinanceportfoliomarkowitzTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_table_scale(s : FinanceportfoliomarkowitzTable, f : Double) -> FinanceportfoliomarkowitzTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_table_add(a : FinanceportfoliomarkowitzTable, b : FinanceportfoliomarkowitzTable) -> FinanceportfoliomarkowitzTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_table_copy(s : FinanceportfoliomarkowitzTable) -> FinanceportfoliomarkowitzTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_table_fill(s : FinanceportfoliomarkowitzTable, v : Double) -> FinanceportfoliomarkowitzTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_table_min(s : FinanceportfoliomarkowitzTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_table_max(s : FinanceportfoliomarkowitzTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_table_to_string(s : FinanceportfoliomarkowitzTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_graphn_make(size : Int) -> FinanceportfoliomarkowitzGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_graphn_len(s : FinanceportfoliomarkowitzGraphN) -> Int { s.size }

pub fn finance_portfolio_markowitz_graphn_get(s : FinanceportfoliomarkowitzGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_graphn_set(s : FinanceportfoliomarkowitzGraphN, i : Int, v : Double) -> FinanceportfoliomarkowitzGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_graphn_sum(s : FinanceportfoliomarkowitzGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_graphn_mean(s : FinanceportfoliomarkowitzGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_graphn_scale(s : FinanceportfoliomarkowitzGraphN, f : Double) -> FinanceportfoliomarkowitzGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_graphn_add(a : FinanceportfoliomarkowitzGraphN, b : FinanceportfoliomarkowitzGraphN) -> FinanceportfoliomarkowitzGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_graphn_copy(s : FinanceportfoliomarkowitzGraphN) -> FinanceportfoliomarkowitzGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_graphn_fill(s : FinanceportfoliomarkowitzGraphN, v : Double) -> FinanceportfoliomarkowitzGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_graphn_min(s : FinanceportfoliomarkowitzGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_graphn_max(s : FinanceportfoliomarkowitzGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_graphn_to_string(s : FinanceportfoliomarkowitzGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_node_make(size : Int) -> FinanceportfoliomarkowitzNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_node_len(s : FinanceportfoliomarkowitzNode) -> Int { s.size }

pub fn finance_portfolio_markowitz_node_get(s : FinanceportfoliomarkowitzNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_node_set(s : FinanceportfoliomarkowitzNode, i : Int, v : Double) -> FinanceportfoliomarkowitzNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_node_sum(s : FinanceportfoliomarkowitzNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_node_mean(s : FinanceportfoliomarkowitzNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_node_scale(s : FinanceportfoliomarkowitzNode, f : Double) -> FinanceportfoliomarkowitzNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_node_add(a : FinanceportfoliomarkowitzNode, b : FinanceportfoliomarkowitzNode) -> FinanceportfoliomarkowitzNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_node_copy(s : FinanceportfoliomarkowitzNode) -> FinanceportfoliomarkowitzNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_node_fill(s : FinanceportfoliomarkowitzNode, v : Double) -> FinanceportfoliomarkowitzNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_node_min(s : FinanceportfoliomarkowitzNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_node_max(s : FinanceportfoliomarkowitzNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_node_to_string(s : FinanceportfoliomarkowitzNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_edge_make(size : Int) -> FinanceportfoliomarkowitzEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_edge_len(s : FinanceportfoliomarkowitzEdge) -> Int { s.size }

pub fn finance_portfolio_markowitz_edge_get(s : FinanceportfoliomarkowitzEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_edge_set(s : FinanceportfoliomarkowitzEdge, i : Int, v : Double) -> FinanceportfoliomarkowitzEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_edge_sum(s : FinanceportfoliomarkowitzEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_edge_mean(s : FinanceportfoliomarkowitzEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_edge_scale(s : FinanceportfoliomarkowitzEdge, f : Double) -> FinanceportfoliomarkowitzEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_edge_add(a : FinanceportfoliomarkowitzEdge, b : FinanceportfoliomarkowitzEdge) -> FinanceportfoliomarkowitzEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_edge_copy(s : FinanceportfoliomarkowitzEdge) -> FinanceportfoliomarkowitzEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_edge_fill(s : FinanceportfoliomarkowitzEdge, v : Double) -> FinanceportfoliomarkowitzEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_edge_min(s : FinanceportfoliomarkowitzEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_edge_max(s : FinanceportfoliomarkowitzEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_edge_to_string(s : FinanceportfoliomarkowitzEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_path_make(size : Int) -> FinanceportfoliomarkowitzPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_path_len(s : FinanceportfoliomarkowitzPath) -> Int { s.size }

pub fn finance_portfolio_markowitz_path_get(s : FinanceportfoliomarkowitzPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_path_set(s : FinanceportfoliomarkowitzPath, i : Int, v : Double) -> FinanceportfoliomarkowitzPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_path_sum(s : FinanceportfoliomarkowitzPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_path_mean(s : FinanceportfoliomarkowitzPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_path_scale(s : FinanceportfoliomarkowitzPath, f : Double) -> FinanceportfoliomarkowitzPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_path_add(a : FinanceportfoliomarkowitzPath, b : FinanceportfoliomarkowitzPath) -> FinanceportfoliomarkowitzPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_path_copy(s : FinanceportfoliomarkowitzPath) -> FinanceportfoliomarkowitzPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_path_fill(s : FinanceportfoliomarkowitzPath, v : Double) -> FinanceportfoliomarkowitzPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_path_min(s : FinanceportfoliomarkowitzPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_path_max(s : FinanceportfoliomarkowitzPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_path_to_string(s : FinanceportfoliomarkowitzPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_cluster_make(size : Int) -> FinanceportfoliomarkowitzCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_cluster_len(s : FinanceportfoliomarkowitzCluster) -> Int { s.size }

pub fn finance_portfolio_markowitz_cluster_get(s : FinanceportfoliomarkowitzCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_cluster_set(s : FinanceportfoliomarkowitzCluster, i : Int, v : Double) -> FinanceportfoliomarkowitzCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cluster_sum(s : FinanceportfoliomarkowitzCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_cluster_mean(s : FinanceportfoliomarkowitzCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_cluster_scale(s : FinanceportfoliomarkowitzCluster, f : Double) -> FinanceportfoliomarkowitzCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cluster_add(a : FinanceportfoliomarkowitzCluster, b : FinanceportfoliomarkowitzCluster) -> FinanceportfoliomarkowitzCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_cluster_copy(s : FinanceportfoliomarkowitzCluster) -> FinanceportfoliomarkowitzCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cluster_fill(s : FinanceportfoliomarkowitzCluster, v : Double) -> FinanceportfoliomarkowitzCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cluster_min(s : FinanceportfoliomarkowitzCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_cluster_max(s : FinanceportfoliomarkowitzCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_cluster_to_string(s : FinanceportfoliomarkowitzCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_model_make(size : Int) -> FinanceportfoliomarkowitzModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_model_len(s : FinanceportfoliomarkowitzModel) -> Int { s.size }

pub fn finance_portfolio_markowitz_model_get(s : FinanceportfoliomarkowitzModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_model_set(s : FinanceportfoliomarkowitzModel, i : Int, v : Double) -> FinanceportfoliomarkowitzModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_model_sum(s : FinanceportfoliomarkowitzModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_model_mean(s : FinanceportfoliomarkowitzModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_model_scale(s : FinanceportfoliomarkowitzModel, f : Double) -> FinanceportfoliomarkowitzModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_model_add(a : FinanceportfoliomarkowitzModel, b : FinanceportfoliomarkowitzModel) -> FinanceportfoliomarkowitzModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_model_copy(s : FinanceportfoliomarkowitzModel) -> FinanceportfoliomarkowitzModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_model_fill(s : FinanceportfoliomarkowitzModel, v : Double) -> FinanceportfoliomarkowitzModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_model_min(s : FinanceportfoliomarkowitzModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_model_max(s : FinanceportfoliomarkowitzModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_model_to_string(s : FinanceportfoliomarkowitzModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_layer_make(size : Int) -> FinanceportfoliomarkowitzLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_layer_len(s : FinanceportfoliomarkowitzLayer) -> Int { s.size }

pub fn finance_portfolio_markowitz_layer_get(s : FinanceportfoliomarkowitzLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_layer_set(s : FinanceportfoliomarkowitzLayer, i : Int, v : Double) -> FinanceportfoliomarkowitzLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_layer_sum(s : FinanceportfoliomarkowitzLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_layer_mean(s : FinanceportfoliomarkowitzLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_layer_scale(s : FinanceportfoliomarkowitzLayer, f : Double) -> FinanceportfoliomarkowitzLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_layer_add(a : FinanceportfoliomarkowitzLayer, b : FinanceportfoliomarkowitzLayer) -> FinanceportfoliomarkowitzLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_layer_copy(s : FinanceportfoliomarkowitzLayer) -> FinanceportfoliomarkowitzLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_layer_fill(s : FinanceportfoliomarkowitzLayer, v : Double) -> FinanceportfoliomarkowitzLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_layer_min(s : FinanceportfoliomarkowitzLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_layer_max(s : FinanceportfoliomarkowitzLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_layer_to_string(s : FinanceportfoliomarkowitzLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_buffer_make(size : Int) -> FinanceportfoliomarkowitzBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_buffer_len(s : FinanceportfoliomarkowitzBuffer) -> Int { s.size }

pub fn finance_portfolio_markowitz_buffer_get(s : FinanceportfoliomarkowitzBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_buffer_set(s : FinanceportfoliomarkowitzBuffer, i : Int, v : Double) -> FinanceportfoliomarkowitzBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_buffer_sum(s : FinanceportfoliomarkowitzBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_buffer_mean(s : FinanceportfoliomarkowitzBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_buffer_scale(s : FinanceportfoliomarkowitzBuffer, f : Double) -> FinanceportfoliomarkowitzBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_buffer_add(a : FinanceportfoliomarkowitzBuffer, b : FinanceportfoliomarkowitzBuffer) -> FinanceportfoliomarkowitzBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_buffer_copy(s : FinanceportfoliomarkowitzBuffer) -> FinanceportfoliomarkowitzBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_buffer_fill(s : FinanceportfoliomarkowitzBuffer, v : Double) -> FinanceportfoliomarkowitzBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_buffer_min(s : FinanceportfoliomarkowitzBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_buffer_max(s : FinanceportfoliomarkowitzBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_buffer_to_string(s : FinanceportfoliomarkowitzBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_cursor_make(size : Int) -> FinanceportfoliomarkowitzCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_cursor_len(s : FinanceportfoliomarkowitzCursor) -> Int { s.size }

pub fn finance_portfolio_markowitz_cursor_get(s : FinanceportfoliomarkowitzCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_cursor_set(s : FinanceportfoliomarkowitzCursor, i : Int, v : Double) -> FinanceportfoliomarkowitzCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cursor_sum(s : FinanceportfoliomarkowitzCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_cursor_mean(s : FinanceportfoliomarkowitzCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_cursor_scale(s : FinanceportfoliomarkowitzCursor, f : Double) -> FinanceportfoliomarkowitzCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cursor_add(a : FinanceportfoliomarkowitzCursor, b : FinanceportfoliomarkowitzCursor) -> FinanceportfoliomarkowitzCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_cursor_copy(s : FinanceportfoliomarkowitzCursor) -> FinanceportfoliomarkowitzCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cursor_fill(s : FinanceportfoliomarkowitzCursor, v : Double) -> FinanceportfoliomarkowitzCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_cursor_min(s : FinanceportfoliomarkowitzCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_cursor_max(s : FinanceportfoliomarkowitzCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_cursor_to_string(s : FinanceportfoliomarkowitzCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_view_make(size : Int) -> FinanceportfoliomarkowitzView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_view_len(s : FinanceportfoliomarkowitzView) -> Int { s.size }

pub fn finance_portfolio_markowitz_view_get(s : FinanceportfoliomarkowitzView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_view_set(s : FinanceportfoliomarkowitzView, i : Int, v : Double) -> FinanceportfoliomarkowitzView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_view_sum(s : FinanceportfoliomarkowitzView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_view_mean(s : FinanceportfoliomarkowitzView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_view_scale(s : FinanceportfoliomarkowitzView, f : Double) -> FinanceportfoliomarkowitzView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_view_add(a : FinanceportfoliomarkowitzView, b : FinanceportfoliomarkowitzView) -> FinanceportfoliomarkowitzView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_view_copy(s : FinanceportfoliomarkowitzView) -> FinanceportfoliomarkowitzView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_view_fill(s : FinanceportfoliomarkowitzView, v : Double) -> FinanceportfoliomarkowitzView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_view_min(s : FinanceportfoliomarkowitzView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_view_max(s : FinanceportfoliomarkowitzView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_view_to_string(s : FinanceportfoliomarkowitzView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_range_make(size : Int) -> FinanceportfoliomarkowitzRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_range_len(s : FinanceportfoliomarkowitzRange) -> Int { s.size }

pub fn finance_portfolio_markowitz_range_get(s : FinanceportfoliomarkowitzRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_range_set(s : FinanceportfoliomarkowitzRange, i : Int, v : Double) -> FinanceportfoliomarkowitzRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_range_sum(s : FinanceportfoliomarkowitzRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_range_mean(s : FinanceportfoliomarkowitzRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_range_scale(s : FinanceportfoliomarkowitzRange, f : Double) -> FinanceportfoliomarkowitzRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_range_add(a : FinanceportfoliomarkowitzRange, b : FinanceportfoliomarkowitzRange) -> FinanceportfoliomarkowitzRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_range_copy(s : FinanceportfoliomarkowitzRange) -> FinanceportfoliomarkowitzRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_range_fill(s : FinanceportfoliomarkowitzRange, v : Double) -> FinanceportfoliomarkowitzRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_range_min(s : FinanceportfoliomarkowitzRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_range_max(s : FinanceportfoliomarkowitzRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_range_to_string(s : FinanceportfoliomarkowitzRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliomarkowitzSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_markowitz_slice_make(size : Int) -> FinanceportfoliomarkowitzSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_markowitz_slice_len(s : FinanceportfoliomarkowitzSlice) -> Int { s.size }

pub fn finance_portfolio_markowitz_slice_get(s : FinanceportfoliomarkowitzSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_markowitz_slice_set(s : FinanceportfoliomarkowitzSlice, i : Int, v : Double) -> FinanceportfoliomarkowitzSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_slice_sum(s : FinanceportfoliomarkowitzSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_markowitz_slice_mean(s : FinanceportfoliomarkowitzSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_markowitz_slice_scale(s : FinanceportfoliomarkowitzSlice, f : Double) -> FinanceportfoliomarkowitzSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_slice_add(a : FinanceportfoliomarkowitzSlice, b : FinanceportfoliomarkowitzSlice) -> FinanceportfoliomarkowitzSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_markowitz_slice_copy(s : FinanceportfoliomarkowitzSlice) -> FinanceportfoliomarkowitzSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_slice_fill(s : FinanceportfoliomarkowitzSlice, v : Double) -> FinanceportfoliomarkowitzSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_markowitz_slice_min(s : FinanceportfoliomarkowitzSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_markowitz_slice_max(s : FinanceportfoliomarkowitzSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_markowitz_slice_to_string(s : FinanceportfoliomarkowitzSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

