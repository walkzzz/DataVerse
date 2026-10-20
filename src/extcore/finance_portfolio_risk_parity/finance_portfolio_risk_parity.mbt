///===
/// extcore/finance_portfolio_risk_parity

pub(all) struct FinanceportfolioriskparityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_risk_parity_make_point(x : Double, y : Double) -> FinanceportfolioriskparityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_risk_parity_make_point3(x : Double, y : Double, z : Double) -> FinanceportfolioriskparityPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfolioriskparityPoint::x(self : FinanceportfolioriskparityPoint) -> Double { self.x }

pub fn FinanceportfolioriskparityPoint::y(self : FinanceportfolioriskparityPoint) -> Double { self.y }

pub fn FinanceportfolioriskparityPoint::z(self : FinanceportfolioriskparityPoint) -> Double { self.z }

pub fn FinanceportfolioriskparityPoint::label(self : FinanceportfolioriskparityPoint) -> Int { self.label }

pub fn FinanceportfolioriskparityPoint::dist(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfolioriskparityPoint::add(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::sub(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::scale(self : FinanceportfolioriskparityPoint, s : Double) -> FinanceportfolioriskparityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::dot(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfolioriskparityPoint::cross(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfolioriskparityPoint::norm(self : FinanceportfolioriskparityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfolioriskparityPoint::normalize(self : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioriskparityPoint::negate(self : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::mid(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint) -> FinanceportfolioriskparityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::lerp(self : FinanceportfolioriskparityPoint, other : FinanceportfolioriskparityPoint, t : Double) -> FinanceportfolioriskparityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfolioriskparityPoint::to_string(self : FinanceportfolioriskparityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_risk_parity_make_series(vals : Array[Double], name : String) -> FinanceportfolioriskparitySeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfolioriskparitySeries::len(self : FinanceportfolioriskparitySeries) -> Int { self.vals.length() }

pub fn FinanceportfolioriskparitySeries::sum(self : FinanceportfolioriskparitySeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfolioriskparitySeries::mean(self : FinanceportfolioriskparitySeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfolioriskparitySeries::min(self : FinanceportfolioriskparitySeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfolioriskparitySeries::max(self : FinanceportfolioriskparitySeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfolioriskparitySeries::range(self : FinanceportfolioriskparitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfolioriskparitySeries::variance(self : FinanceportfolioriskparitySeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfolioriskparitySeries::std(self : FinanceportfolioriskparitySeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfolioriskparitySeries::median(self : FinanceportfolioriskparitySeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfolioriskparitySeries::scale(self : FinanceportfolioriskparitySeries, f : Double) -> FinanceportfolioriskparitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::add(self : FinanceportfolioriskparitySeries, other : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::sub(self : FinanceportfolioriskparitySeries, other : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::normalize(self : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfolioriskparitySeries::cumsum(self : FinanceportfolioriskparitySeries) -> FinanceportfolioriskparitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfolioriskparitySeries::to_string(self : FinanceportfolioriskparitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfolioriskparityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_risk_parity_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfolioriskparityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_risk_parity_matrix_identity(n : Int) -> FinanceportfolioriskparityMatrix {
  let m = finance_portfolio_risk_parity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfolioriskparityMatrix::get(self : FinanceportfolioriskparityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfolioriskparityMatrix::transpose(self : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  let result = finance_portfolio_risk_parity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfolioriskparityMatrix::add(self : FinanceportfolioriskparityMatrix, other : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_risk_parity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfolioriskparityMatrix::scale(self : FinanceportfolioriskparityMatrix, s : Double) -> FinanceportfolioriskparityMatrix {
  let result = finance_portfolio_risk_parity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfolioriskparityMatrix::multiply(self : FinanceportfolioriskparityMatrix, other : FinanceportfolioriskparityMatrix) -> FinanceportfolioriskparityMatrix {
  if self.cols != other.rows { return finance_portfolio_risk_parity_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_risk_parity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfolioriskparityMatrix::trace(self : FinanceportfolioriskparityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfolioriskparityMatrix::det(self : FinanceportfolioriskparityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfolioriskparityMatrix::norm(self : FinanceportfolioriskparityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfolioriskparityMatrix::to_string(self : FinanceportfolioriskparityMatrix) -> String {
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

pub(all) struct FinanceportfolioriskparityVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_risk_parity_make_vector(comps : Array[Double]) -> FinanceportfolioriskparityVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_risk_parity_vector_zero(dim : Int) -> FinanceportfolioriskparityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfolioriskparityVector::add(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioriskparityVector::sub(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfolioriskparityVector::scale(self : FinanceportfolioriskparityVector, s : Double) -> FinanceportfolioriskparityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfolioriskparityVector::dot(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfolioriskparityVector::norm(self : FinanceportfolioriskparityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfolioriskparityVector::normalize(self : FinanceportfolioriskparityVector) -> FinanceportfolioriskparityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfolioriskparityVector::dist(self : FinanceportfolioriskparityVector, other : FinanceportfolioriskparityVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfolioriskparityVector::to_string(self : FinanceportfolioriskparityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_risk_parity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_risk_parity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_risk_parity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_risk_parity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_risk_parity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_risk_parity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_risk_parity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_risk_parity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_risk_parity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_risk_parity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_risk_parity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_risk_parity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_risk_parity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_risk_parity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_risk_parity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_risk_parity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_risk_parity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_risk_parity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_risk_parity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_risk_parity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_risk_parity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_risk_parity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_risk_parity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_risk_parity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_risk_parity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_risk_parity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_risk_parity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_risk_parity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_risk_parity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfolioriskparityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_frame_make(size : Int) -> FinanceportfolioriskparityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_frame_len(s : FinanceportfolioriskparityFrame) -> Int { s.size }

pub fn finance_portfolio_risk_parity_frame_get(s : FinanceportfolioriskparityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_frame_set(s : FinanceportfolioriskparityFrame, i : Int, v : Double) -> FinanceportfolioriskparityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_sum(s : FinanceportfolioriskparityFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_frame_mean(s : FinanceportfolioriskparityFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_frame_scale(s : FinanceportfolioriskparityFrame, f : Double) -> FinanceportfolioriskparityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_add(a : FinanceportfolioriskparityFrame, b : FinanceportfolioriskparityFrame) -> FinanceportfolioriskparityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_frame_copy(s : FinanceportfolioriskparityFrame) -> FinanceportfolioriskparityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_fill(s : FinanceportfolioriskparityFrame, v : Double) -> FinanceportfolioriskparityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_frame_min(s : FinanceportfolioriskparityFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_frame_max(s : FinanceportfolioriskparityFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_frame_to_string(s : FinanceportfolioriskparityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_table_make(size : Int) -> FinanceportfolioriskparityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_table_len(s : FinanceportfolioriskparityTable) -> Int { s.size }

pub fn finance_portfolio_risk_parity_table_get(s : FinanceportfolioriskparityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_table_set(s : FinanceportfolioriskparityTable, i : Int, v : Double) -> FinanceportfolioriskparityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_sum(s : FinanceportfolioriskparityTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_table_mean(s : FinanceportfolioriskparityTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_table_scale(s : FinanceportfolioriskparityTable, f : Double) -> FinanceportfolioriskparityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_add(a : FinanceportfolioriskparityTable, b : FinanceportfolioriskparityTable) -> FinanceportfolioriskparityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_table_copy(s : FinanceportfolioriskparityTable) -> FinanceportfolioriskparityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_fill(s : FinanceportfolioriskparityTable, v : Double) -> FinanceportfolioriskparityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_table_min(s : FinanceportfolioriskparityTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_table_max(s : FinanceportfolioriskparityTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_table_to_string(s : FinanceportfolioriskparityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_graphn_make(size : Int) -> FinanceportfolioriskparityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_graphn_len(s : FinanceportfolioriskparityGraphN) -> Int { s.size }

pub fn finance_portfolio_risk_parity_graphn_get(s : FinanceportfolioriskparityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_graphn_set(s : FinanceportfolioriskparityGraphN, i : Int, v : Double) -> FinanceportfolioriskparityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_sum(s : FinanceportfolioriskparityGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_graphn_mean(s : FinanceportfolioriskparityGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_graphn_scale(s : FinanceportfolioriskparityGraphN, f : Double) -> FinanceportfolioriskparityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_add(a : FinanceportfolioriskparityGraphN, b : FinanceportfolioriskparityGraphN) -> FinanceportfolioriskparityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_graphn_copy(s : FinanceportfolioriskparityGraphN) -> FinanceportfolioriskparityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_fill(s : FinanceportfolioriskparityGraphN, v : Double) -> FinanceportfolioriskparityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_graphn_min(s : FinanceportfolioriskparityGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_graphn_max(s : FinanceportfolioriskparityGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_graphn_to_string(s : FinanceportfolioriskparityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_node_make(size : Int) -> FinanceportfolioriskparityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_node_len(s : FinanceportfolioriskparityNode) -> Int { s.size }

pub fn finance_portfolio_risk_parity_node_get(s : FinanceportfolioriskparityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_node_set(s : FinanceportfolioriskparityNode, i : Int, v : Double) -> FinanceportfolioriskparityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_sum(s : FinanceportfolioriskparityNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_node_mean(s : FinanceportfolioriskparityNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_node_scale(s : FinanceportfolioriskparityNode, f : Double) -> FinanceportfolioriskparityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_add(a : FinanceportfolioriskparityNode, b : FinanceportfolioriskparityNode) -> FinanceportfolioriskparityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_node_copy(s : FinanceportfolioriskparityNode) -> FinanceportfolioriskparityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_fill(s : FinanceportfolioriskparityNode, v : Double) -> FinanceportfolioriskparityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_node_min(s : FinanceportfolioriskparityNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_node_max(s : FinanceportfolioriskparityNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_node_to_string(s : FinanceportfolioriskparityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_edge_make(size : Int) -> FinanceportfolioriskparityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_edge_len(s : FinanceportfolioriskparityEdge) -> Int { s.size }

pub fn finance_portfolio_risk_parity_edge_get(s : FinanceportfolioriskparityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_edge_set(s : FinanceportfolioriskparityEdge, i : Int, v : Double) -> FinanceportfolioriskparityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_sum(s : FinanceportfolioriskparityEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_edge_mean(s : FinanceportfolioriskparityEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_edge_scale(s : FinanceportfolioriskparityEdge, f : Double) -> FinanceportfolioriskparityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_add(a : FinanceportfolioriskparityEdge, b : FinanceportfolioriskparityEdge) -> FinanceportfolioriskparityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_edge_copy(s : FinanceportfolioriskparityEdge) -> FinanceportfolioriskparityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_fill(s : FinanceportfolioriskparityEdge, v : Double) -> FinanceportfolioriskparityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_edge_min(s : FinanceportfolioriskparityEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_edge_max(s : FinanceportfolioriskparityEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_edge_to_string(s : FinanceportfolioriskparityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_path_make(size : Int) -> FinanceportfolioriskparityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_path_len(s : FinanceportfolioriskparityPath) -> Int { s.size }

pub fn finance_portfolio_risk_parity_path_get(s : FinanceportfolioriskparityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_path_set(s : FinanceportfolioriskparityPath, i : Int, v : Double) -> FinanceportfolioriskparityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_sum(s : FinanceportfolioriskparityPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_path_mean(s : FinanceportfolioriskparityPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_path_scale(s : FinanceportfolioriskparityPath, f : Double) -> FinanceportfolioriskparityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_add(a : FinanceportfolioriskparityPath, b : FinanceportfolioriskparityPath) -> FinanceportfolioriskparityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_path_copy(s : FinanceportfolioriskparityPath) -> FinanceportfolioriskparityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_fill(s : FinanceportfolioriskparityPath, v : Double) -> FinanceportfolioriskparityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_path_min(s : FinanceportfolioriskparityPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_path_max(s : FinanceportfolioriskparityPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_path_to_string(s : FinanceportfolioriskparityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_cluster_make(size : Int) -> FinanceportfolioriskparityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_cluster_len(s : FinanceportfolioriskparityCluster) -> Int { s.size }

pub fn finance_portfolio_risk_parity_cluster_get(s : FinanceportfolioriskparityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_cluster_set(s : FinanceportfolioriskparityCluster, i : Int, v : Double) -> FinanceportfolioriskparityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_sum(s : FinanceportfolioriskparityCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_cluster_mean(s : FinanceportfolioriskparityCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_cluster_scale(s : FinanceportfolioriskparityCluster, f : Double) -> FinanceportfolioriskparityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_add(a : FinanceportfolioriskparityCluster, b : FinanceportfolioriskparityCluster) -> FinanceportfolioriskparityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_cluster_copy(s : FinanceportfolioriskparityCluster) -> FinanceportfolioriskparityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_fill(s : FinanceportfolioriskparityCluster, v : Double) -> FinanceportfolioriskparityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cluster_min(s : FinanceportfolioriskparityCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_cluster_max(s : FinanceportfolioriskparityCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_cluster_to_string(s : FinanceportfolioriskparityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_model_make(size : Int) -> FinanceportfolioriskparityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_model_len(s : FinanceportfolioriskparityModel) -> Int { s.size }

pub fn finance_portfolio_risk_parity_model_get(s : FinanceportfolioriskparityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_model_set(s : FinanceportfolioriskparityModel, i : Int, v : Double) -> FinanceportfolioriskparityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_sum(s : FinanceportfolioriskparityModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_model_mean(s : FinanceportfolioriskparityModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_model_scale(s : FinanceportfolioriskparityModel, f : Double) -> FinanceportfolioriskparityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_add(a : FinanceportfolioriskparityModel, b : FinanceportfolioriskparityModel) -> FinanceportfolioriskparityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_model_copy(s : FinanceportfolioriskparityModel) -> FinanceportfolioriskparityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_fill(s : FinanceportfolioriskparityModel, v : Double) -> FinanceportfolioriskparityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_model_min(s : FinanceportfolioriskparityModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_model_max(s : FinanceportfolioriskparityModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_model_to_string(s : FinanceportfolioriskparityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_layer_make(size : Int) -> FinanceportfolioriskparityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_layer_len(s : FinanceportfolioriskparityLayer) -> Int { s.size }

pub fn finance_portfolio_risk_parity_layer_get(s : FinanceportfolioriskparityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_layer_set(s : FinanceportfolioriskparityLayer, i : Int, v : Double) -> FinanceportfolioriskparityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_sum(s : FinanceportfolioriskparityLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_layer_mean(s : FinanceportfolioriskparityLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_layer_scale(s : FinanceportfolioriskparityLayer, f : Double) -> FinanceportfolioriskparityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_add(a : FinanceportfolioriskparityLayer, b : FinanceportfolioriskparityLayer) -> FinanceportfolioriskparityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_layer_copy(s : FinanceportfolioriskparityLayer) -> FinanceportfolioriskparityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_fill(s : FinanceportfolioriskparityLayer, v : Double) -> FinanceportfolioriskparityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_layer_min(s : FinanceportfolioriskparityLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_layer_max(s : FinanceportfolioriskparityLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_layer_to_string(s : FinanceportfolioriskparityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_buffer_make(size : Int) -> FinanceportfolioriskparityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_buffer_len(s : FinanceportfolioriskparityBuffer) -> Int { s.size }

pub fn finance_portfolio_risk_parity_buffer_get(s : FinanceportfolioriskparityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_buffer_set(s : FinanceportfolioriskparityBuffer, i : Int, v : Double) -> FinanceportfolioriskparityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_sum(s : FinanceportfolioriskparityBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_buffer_mean(s : FinanceportfolioriskparityBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_buffer_scale(s : FinanceportfolioriskparityBuffer, f : Double) -> FinanceportfolioriskparityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_add(a : FinanceportfolioriskparityBuffer, b : FinanceportfolioriskparityBuffer) -> FinanceportfolioriskparityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_buffer_copy(s : FinanceportfolioriskparityBuffer) -> FinanceportfolioriskparityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_fill(s : FinanceportfolioriskparityBuffer, v : Double) -> FinanceportfolioriskparityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_buffer_min(s : FinanceportfolioriskparityBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_buffer_max(s : FinanceportfolioriskparityBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_buffer_to_string(s : FinanceportfolioriskparityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_cursor_make(size : Int) -> FinanceportfolioriskparityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_cursor_len(s : FinanceportfolioriskparityCursor) -> Int { s.size }

pub fn finance_portfolio_risk_parity_cursor_get(s : FinanceportfolioriskparityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_cursor_set(s : FinanceportfolioriskparityCursor, i : Int, v : Double) -> FinanceportfolioriskparityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_sum(s : FinanceportfolioriskparityCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_cursor_mean(s : FinanceportfolioriskparityCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_cursor_scale(s : FinanceportfolioriskparityCursor, f : Double) -> FinanceportfolioriskparityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_add(a : FinanceportfolioriskparityCursor, b : FinanceportfolioriskparityCursor) -> FinanceportfolioriskparityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_cursor_copy(s : FinanceportfolioriskparityCursor) -> FinanceportfolioriskparityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_fill(s : FinanceportfolioriskparityCursor, v : Double) -> FinanceportfolioriskparityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_cursor_min(s : FinanceportfolioriskparityCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_cursor_max(s : FinanceportfolioriskparityCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_cursor_to_string(s : FinanceportfolioriskparityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_view_make(size : Int) -> FinanceportfolioriskparityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_view_len(s : FinanceportfolioriskparityView) -> Int { s.size }

pub fn finance_portfolio_risk_parity_view_get(s : FinanceportfolioriskparityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_view_set(s : FinanceportfolioriskparityView, i : Int, v : Double) -> FinanceportfolioriskparityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_sum(s : FinanceportfolioriskparityView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_view_mean(s : FinanceportfolioriskparityView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_view_scale(s : FinanceportfolioriskparityView, f : Double) -> FinanceportfolioriskparityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_add(a : FinanceportfolioriskparityView, b : FinanceportfolioriskparityView) -> FinanceportfolioriskparityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_view_copy(s : FinanceportfolioriskparityView) -> FinanceportfolioriskparityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_fill(s : FinanceportfolioriskparityView, v : Double) -> FinanceportfolioriskparityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_view_min(s : FinanceportfolioriskparityView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_view_max(s : FinanceportfolioriskparityView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_view_to_string(s : FinanceportfolioriskparityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_range_make(size : Int) -> FinanceportfolioriskparityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_range_len(s : FinanceportfolioriskparityRange) -> Int { s.size }

pub fn finance_portfolio_risk_parity_range_get(s : FinanceportfolioriskparityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_range_set(s : FinanceportfolioriskparityRange, i : Int, v : Double) -> FinanceportfolioriskparityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_sum(s : FinanceportfolioriskparityRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_range_mean(s : FinanceportfolioriskparityRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_range_scale(s : FinanceportfolioriskparityRange, f : Double) -> FinanceportfolioriskparityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_add(a : FinanceportfolioriskparityRange, b : FinanceportfolioriskparityRange) -> FinanceportfolioriskparityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_range_copy(s : FinanceportfolioriskparityRange) -> FinanceportfolioriskparityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_fill(s : FinanceportfolioriskparityRange, v : Double) -> FinanceportfolioriskparityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_range_min(s : FinanceportfolioriskparityRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_range_max(s : FinanceportfolioriskparityRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_range_to_string(s : FinanceportfolioriskparityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfolioriskparitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_risk_parity_slice_make(size : Int) -> FinanceportfolioriskparitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_risk_parity_slice_len(s : FinanceportfolioriskparitySlice) -> Int { s.size }

pub fn finance_portfolio_risk_parity_slice_get(s : FinanceportfolioriskparitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_risk_parity_slice_set(s : FinanceportfolioriskparitySlice, i : Int, v : Double) -> FinanceportfolioriskparitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_sum(s : FinanceportfolioriskparitySlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_risk_parity_slice_mean(s : FinanceportfolioriskparitySlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_risk_parity_slice_scale(s : FinanceportfolioriskparitySlice, f : Double) -> FinanceportfolioriskparitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_add(a : FinanceportfolioriskparitySlice, b : FinanceportfolioriskparitySlice) -> FinanceportfolioriskparitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_risk_parity_slice_copy(s : FinanceportfolioriskparitySlice) -> FinanceportfolioriskparitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_fill(s : FinanceportfolioriskparitySlice, v : Double) -> FinanceportfolioriskparitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_risk_parity_slice_min(s : FinanceportfolioriskparitySlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_risk_parity_slice_max(s : FinanceportfolioriskparitySlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_risk_parity_slice_to_string(s : FinanceportfolioriskparitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

