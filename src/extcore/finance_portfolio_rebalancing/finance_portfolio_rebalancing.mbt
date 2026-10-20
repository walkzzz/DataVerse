///===
/// extcore/finance_portfolio_rebalancing

pub(all) struct FinanceportfoliorebalancingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_portfolio_rebalancing_make_point(x : Double, y : Double) -> FinanceportfoliorebalancingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_portfolio_rebalancing_make_point3(x : Double, y : Double, z : Double) -> FinanceportfoliorebalancingPoint {
  { x, y, z, label: 0 }
}

pub fn FinanceportfoliorebalancingPoint::x(self : FinanceportfoliorebalancingPoint) -> Double { self.x }

pub fn FinanceportfoliorebalancingPoint::y(self : FinanceportfoliorebalancingPoint) -> Double { self.y }

pub fn FinanceportfoliorebalancingPoint::z(self : FinanceportfoliorebalancingPoint) -> Double { self.z }

pub fn FinanceportfoliorebalancingPoint::label(self : FinanceportfoliorebalancingPoint) -> Int { self.label }

pub fn FinanceportfoliorebalancingPoint::dist(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinanceportfoliorebalancingPoint::add(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinanceportfoliorebalancingPoint::sub(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinanceportfoliorebalancingPoint::scale(self : FinanceportfoliorebalancingPoint, s : Double) -> FinanceportfoliorebalancingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinanceportfoliorebalancingPoint::dot(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinanceportfoliorebalancingPoint::cross(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinanceportfoliorebalancingPoint::norm(self : FinanceportfoliorebalancingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinanceportfoliorebalancingPoint::normalize(self : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliorebalancingPoint::negate(self : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinanceportfoliorebalancingPoint::mid(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint) -> FinanceportfoliorebalancingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinanceportfoliorebalancingPoint::lerp(self : FinanceportfoliorebalancingPoint, other : FinanceportfoliorebalancingPoint, t : Double) -> FinanceportfoliorebalancingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinanceportfoliorebalancingPoint::to_string(self : FinanceportfoliorebalancingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_portfolio_rebalancing_make_series(vals : Array[Double], name : String) -> FinanceportfoliorebalancingSeries {
  { vals, name, meta: 0 }
}

pub fn FinanceportfoliorebalancingSeries::len(self : FinanceportfoliorebalancingSeries) -> Int { self.vals.length() }

pub fn FinanceportfoliorebalancingSeries::sum(self : FinanceportfoliorebalancingSeries) -> Double { @_common.sum(self.vals) }

pub fn FinanceportfoliorebalancingSeries::mean(self : FinanceportfoliorebalancingSeries) -> Double { @_common.mean(self.vals) }

pub fn FinanceportfoliorebalancingSeries::min(self : FinanceportfoliorebalancingSeries) -> Double { @_common.min(self.vals) }

pub fn FinanceportfoliorebalancingSeries::max(self : FinanceportfoliorebalancingSeries) -> Double { @_common.max(self.vals) }

pub fn FinanceportfoliorebalancingSeries::range(self : FinanceportfoliorebalancingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinanceportfoliorebalancingSeries::variance(self : FinanceportfoliorebalancingSeries) -> Double { @_common.variance(self.vals) }

pub fn FinanceportfoliorebalancingSeries::std(self : FinanceportfoliorebalancingSeries) -> Double { @_common.std(self.vals) }

pub fn FinanceportfoliorebalancingSeries::median(self : FinanceportfoliorebalancingSeries) -> Double { @_common.median(self.vals) }

pub fn FinanceportfoliorebalancingSeries::scale(self : FinanceportfoliorebalancingSeries, f : Double) -> FinanceportfoliorebalancingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinanceportfoliorebalancingSeries::add(self : FinanceportfoliorebalancingSeries, other : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinanceportfoliorebalancingSeries::sub(self : FinanceportfoliorebalancingSeries, other : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinanceportfoliorebalancingSeries::normalize(self : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinanceportfoliorebalancingSeries::cumsum(self : FinanceportfoliorebalancingSeries) -> FinanceportfoliorebalancingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinanceportfoliorebalancingSeries::to_string(self : FinanceportfoliorebalancingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceportfoliorebalancingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_portfolio_rebalancing_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceportfoliorebalancingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_portfolio_rebalancing_matrix_identity(n : Int) -> FinanceportfoliorebalancingMatrix {
  let m = finance_portfolio_rebalancing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinanceportfoliorebalancingMatrix::get(self : FinanceportfoliorebalancingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinanceportfoliorebalancingMatrix::transpose(self : FinanceportfoliorebalancingMatrix) -> FinanceportfoliorebalancingMatrix {
  let result = finance_portfolio_rebalancing_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinanceportfoliorebalancingMatrix::add(self : FinanceportfoliorebalancingMatrix, other : FinanceportfoliorebalancingMatrix) -> FinanceportfoliorebalancingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_portfolio_rebalancing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinanceportfoliorebalancingMatrix::scale(self : FinanceportfoliorebalancingMatrix, s : Double) -> FinanceportfoliorebalancingMatrix {
  let result = finance_portfolio_rebalancing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinanceportfoliorebalancingMatrix::multiply(self : FinanceportfoliorebalancingMatrix, other : FinanceportfoliorebalancingMatrix) -> FinanceportfoliorebalancingMatrix {
  if self.cols != other.rows { return finance_portfolio_rebalancing_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_portfolio_rebalancing_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinanceportfoliorebalancingMatrix::trace(self : FinanceportfoliorebalancingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinanceportfoliorebalancingMatrix::det(self : FinanceportfoliorebalancingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinanceportfoliorebalancingMatrix::norm(self : FinanceportfoliorebalancingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinanceportfoliorebalancingMatrix::to_string(self : FinanceportfoliorebalancingMatrix) -> String {
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

pub(all) struct FinanceportfoliorebalancingVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_portfolio_rebalancing_make_vector(comps : Array[Double]) -> FinanceportfoliorebalancingVector {
  { comps, dim: comps.length() }
}

pub fn finance_portfolio_rebalancing_vector_zero(dim : Int) -> FinanceportfoliorebalancingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinanceportfoliorebalancingVector::add(self : FinanceportfoliorebalancingVector, other : FinanceportfoliorebalancingVector) -> FinanceportfoliorebalancingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliorebalancingVector::sub(self : FinanceportfoliorebalancingVector, other : FinanceportfoliorebalancingVector) -> FinanceportfoliorebalancingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinanceportfoliorebalancingVector::scale(self : FinanceportfoliorebalancingVector, s : Double) -> FinanceportfoliorebalancingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinanceportfoliorebalancingVector::dot(self : FinanceportfoliorebalancingVector, other : FinanceportfoliorebalancingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinanceportfoliorebalancingVector::norm(self : FinanceportfoliorebalancingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinanceportfoliorebalancingVector::normalize(self : FinanceportfoliorebalancingVector) -> FinanceportfoliorebalancingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinanceportfoliorebalancingVector::dist(self : FinanceportfoliorebalancingVector, other : FinanceportfoliorebalancingVector) -> Double {
  self.sub(other).norm()
}

pub fn FinanceportfoliorebalancingVector::to_string(self : FinanceportfoliorebalancingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_portfolio_rebalancing_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_portfolio_rebalancing_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_portfolio_rebalancing_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_portfolio_rebalancing_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_portfolio_rebalancing_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_portfolio_rebalancing_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_portfolio_rebalancing_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_portfolio_rebalancing_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_portfolio_rebalancing_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_portfolio_rebalancing_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_portfolio_rebalancing_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_portfolio_rebalancing_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_portfolio_rebalancing_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_portfolio_rebalancing_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_portfolio_rebalancing_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_portfolio_rebalancing_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_portfolio_rebalancing_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_portfolio_rebalancing_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_portfolio_rebalancing_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_portfolio_rebalancing_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_portfolio_rebalancing_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_portfolio_rebalancing_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_portfolio_rebalancing_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_portfolio_rebalancing_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_portfolio_rebalancing_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_portfolio_rebalancing_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_portfolio_rebalancing_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_portfolio_rebalancing_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_portfolio_rebalancing_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceportfoliorebalancingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_frame_make(size : Int) -> FinanceportfoliorebalancingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_frame_len(s : FinanceportfoliorebalancingFrame) -> Int { s.size }

pub fn finance_portfolio_rebalancing_frame_get(s : FinanceportfoliorebalancingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_frame_set(s : FinanceportfoliorebalancingFrame, i : Int, v : Double) -> FinanceportfoliorebalancingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_frame_sum(s : FinanceportfoliorebalancingFrame) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_frame_mean(s : FinanceportfoliorebalancingFrame) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_frame_scale(s : FinanceportfoliorebalancingFrame, f : Double) -> FinanceportfoliorebalancingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_frame_add(a : FinanceportfoliorebalancingFrame, b : FinanceportfoliorebalancingFrame) -> FinanceportfoliorebalancingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_frame_copy(s : FinanceportfoliorebalancingFrame) -> FinanceportfoliorebalancingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_frame_fill(s : FinanceportfoliorebalancingFrame, v : Double) -> FinanceportfoliorebalancingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_frame_min(s : FinanceportfoliorebalancingFrame) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_frame_max(s : FinanceportfoliorebalancingFrame) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_frame_to_string(s : FinanceportfoliorebalancingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_table_make(size : Int) -> FinanceportfoliorebalancingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_table_len(s : FinanceportfoliorebalancingTable) -> Int { s.size }

pub fn finance_portfolio_rebalancing_table_get(s : FinanceportfoliorebalancingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_table_set(s : FinanceportfoliorebalancingTable, i : Int, v : Double) -> FinanceportfoliorebalancingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_table_sum(s : FinanceportfoliorebalancingTable) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_table_mean(s : FinanceportfoliorebalancingTable) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_table_scale(s : FinanceportfoliorebalancingTable, f : Double) -> FinanceportfoliorebalancingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_table_add(a : FinanceportfoliorebalancingTable, b : FinanceportfoliorebalancingTable) -> FinanceportfoliorebalancingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_table_copy(s : FinanceportfoliorebalancingTable) -> FinanceportfoliorebalancingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_table_fill(s : FinanceportfoliorebalancingTable, v : Double) -> FinanceportfoliorebalancingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_table_min(s : FinanceportfoliorebalancingTable) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_table_max(s : FinanceportfoliorebalancingTable) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_table_to_string(s : FinanceportfoliorebalancingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_graphn_make(size : Int) -> FinanceportfoliorebalancingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_graphn_len(s : FinanceportfoliorebalancingGraphN) -> Int { s.size }

pub fn finance_portfolio_rebalancing_graphn_get(s : FinanceportfoliorebalancingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_graphn_set(s : FinanceportfoliorebalancingGraphN, i : Int, v : Double) -> FinanceportfoliorebalancingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_graphn_sum(s : FinanceportfoliorebalancingGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_graphn_mean(s : FinanceportfoliorebalancingGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_graphn_scale(s : FinanceportfoliorebalancingGraphN, f : Double) -> FinanceportfoliorebalancingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_graphn_add(a : FinanceportfoliorebalancingGraphN, b : FinanceportfoliorebalancingGraphN) -> FinanceportfoliorebalancingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_graphn_copy(s : FinanceportfoliorebalancingGraphN) -> FinanceportfoliorebalancingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_graphn_fill(s : FinanceportfoliorebalancingGraphN, v : Double) -> FinanceportfoliorebalancingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_graphn_min(s : FinanceportfoliorebalancingGraphN) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_graphn_max(s : FinanceportfoliorebalancingGraphN) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_graphn_to_string(s : FinanceportfoliorebalancingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_node_make(size : Int) -> FinanceportfoliorebalancingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_node_len(s : FinanceportfoliorebalancingNode) -> Int { s.size }

pub fn finance_portfolio_rebalancing_node_get(s : FinanceportfoliorebalancingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_node_set(s : FinanceportfoliorebalancingNode, i : Int, v : Double) -> FinanceportfoliorebalancingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_node_sum(s : FinanceportfoliorebalancingNode) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_node_mean(s : FinanceportfoliorebalancingNode) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_node_scale(s : FinanceportfoliorebalancingNode, f : Double) -> FinanceportfoliorebalancingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_node_add(a : FinanceportfoliorebalancingNode, b : FinanceportfoliorebalancingNode) -> FinanceportfoliorebalancingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_node_copy(s : FinanceportfoliorebalancingNode) -> FinanceportfoliorebalancingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_node_fill(s : FinanceportfoliorebalancingNode, v : Double) -> FinanceportfoliorebalancingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_node_min(s : FinanceportfoliorebalancingNode) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_node_max(s : FinanceportfoliorebalancingNode) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_node_to_string(s : FinanceportfoliorebalancingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_edge_make(size : Int) -> FinanceportfoliorebalancingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_edge_len(s : FinanceportfoliorebalancingEdge) -> Int { s.size }

pub fn finance_portfolio_rebalancing_edge_get(s : FinanceportfoliorebalancingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_edge_set(s : FinanceportfoliorebalancingEdge, i : Int, v : Double) -> FinanceportfoliorebalancingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_edge_sum(s : FinanceportfoliorebalancingEdge) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_edge_mean(s : FinanceportfoliorebalancingEdge) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_edge_scale(s : FinanceportfoliorebalancingEdge, f : Double) -> FinanceportfoliorebalancingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_edge_add(a : FinanceportfoliorebalancingEdge, b : FinanceportfoliorebalancingEdge) -> FinanceportfoliorebalancingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_edge_copy(s : FinanceportfoliorebalancingEdge) -> FinanceportfoliorebalancingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_edge_fill(s : FinanceportfoliorebalancingEdge, v : Double) -> FinanceportfoliorebalancingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_edge_min(s : FinanceportfoliorebalancingEdge) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_edge_max(s : FinanceportfoliorebalancingEdge) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_edge_to_string(s : FinanceportfoliorebalancingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_path_make(size : Int) -> FinanceportfoliorebalancingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_path_len(s : FinanceportfoliorebalancingPath) -> Int { s.size }

pub fn finance_portfolio_rebalancing_path_get(s : FinanceportfoliorebalancingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_path_set(s : FinanceportfoliorebalancingPath, i : Int, v : Double) -> FinanceportfoliorebalancingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_path_sum(s : FinanceportfoliorebalancingPath) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_path_mean(s : FinanceportfoliorebalancingPath) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_path_scale(s : FinanceportfoliorebalancingPath, f : Double) -> FinanceportfoliorebalancingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_path_add(a : FinanceportfoliorebalancingPath, b : FinanceportfoliorebalancingPath) -> FinanceportfoliorebalancingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_path_copy(s : FinanceportfoliorebalancingPath) -> FinanceportfoliorebalancingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_path_fill(s : FinanceportfoliorebalancingPath, v : Double) -> FinanceportfoliorebalancingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_path_min(s : FinanceportfoliorebalancingPath) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_path_max(s : FinanceportfoliorebalancingPath) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_path_to_string(s : FinanceportfoliorebalancingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_cluster_make(size : Int) -> FinanceportfoliorebalancingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_cluster_len(s : FinanceportfoliorebalancingCluster) -> Int { s.size }

pub fn finance_portfolio_rebalancing_cluster_get(s : FinanceportfoliorebalancingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_cluster_set(s : FinanceportfoliorebalancingCluster, i : Int, v : Double) -> FinanceportfoliorebalancingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cluster_sum(s : FinanceportfoliorebalancingCluster) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_cluster_mean(s : FinanceportfoliorebalancingCluster) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_cluster_scale(s : FinanceportfoliorebalancingCluster, f : Double) -> FinanceportfoliorebalancingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cluster_add(a : FinanceportfoliorebalancingCluster, b : FinanceportfoliorebalancingCluster) -> FinanceportfoliorebalancingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_cluster_copy(s : FinanceportfoliorebalancingCluster) -> FinanceportfoliorebalancingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cluster_fill(s : FinanceportfoliorebalancingCluster, v : Double) -> FinanceportfoliorebalancingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cluster_min(s : FinanceportfoliorebalancingCluster) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_cluster_max(s : FinanceportfoliorebalancingCluster) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_cluster_to_string(s : FinanceportfoliorebalancingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_model_make(size : Int) -> FinanceportfoliorebalancingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_model_len(s : FinanceportfoliorebalancingModel) -> Int { s.size }

pub fn finance_portfolio_rebalancing_model_get(s : FinanceportfoliorebalancingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_model_set(s : FinanceportfoliorebalancingModel, i : Int, v : Double) -> FinanceportfoliorebalancingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_model_sum(s : FinanceportfoliorebalancingModel) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_model_mean(s : FinanceportfoliorebalancingModel) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_model_scale(s : FinanceportfoliorebalancingModel, f : Double) -> FinanceportfoliorebalancingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_model_add(a : FinanceportfoliorebalancingModel, b : FinanceportfoliorebalancingModel) -> FinanceportfoliorebalancingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_model_copy(s : FinanceportfoliorebalancingModel) -> FinanceportfoliorebalancingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_model_fill(s : FinanceportfoliorebalancingModel, v : Double) -> FinanceportfoliorebalancingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_model_min(s : FinanceportfoliorebalancingModel) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_model_max(s : FinanceportfoliorebalancingModel) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_model_to_string(s : FinanceportfoliorebalancingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_layer_make(size : Int) -> FinanceportfoliorebalancingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_layer_len(s : FinanceportfoliorebalancingLayer) -> Int { s.size }

pub fn finance_portfolio_rebalancing_layer_get(s : FinanceportfoliorebalancingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_layer_set(s : FinanceportfoliorebalancingLayer, i : Int, v : Double) -> FinanceportfoliorebalancingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_layer_sum(s : FinanceportfoliorebalancingLayer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_layer_mean(s : FinanceportfoliorebalancingLayer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_layer_scale(s : FinanceportfoliorebalancingLayer, f : Double) -> FinanceportfoliorebalancingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_layer_add(a : FinanceportfoliorebalancingLayer, b : FinanceportfoliorebalancingLayer) -> FinanceportfoliorebalancingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_layer_copy(s : FinanceportfoliorebalancingLayer) -> FinanceportfoliorebalancingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_layer_fill(s : FinanceportfoliorebalancingLayer, v : Double) -> FinanceportfoliorebalancingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_layer_min(s : FinanceportfoliorebalancingLayer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_layer_max(s : FinanceportfoliorebalancingLayer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_layer_to_string(s : FinanceportfoliorebalancingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_buffer_make(size : Int) -> FinanceportfoliorebalancingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_buffer_len(s : FinanceportfoliorebalancingBuffer) -> Int { s.size }

pub fn finance_portfolio_rebalancing_buffer_get(s : FinanceportfoliorebalancingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_buffer_set(s : FinanceportfoliorebalancingBuffer, i : Int, v : Double) -> FinanceportfoliorebalancingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_buffer_sum(s : FinanceportfoliorebalancingBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_buffer_mean(s : FinanceportfoliorebalancingBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_buffer_scale(s : FinanceportfoliorebalancingBuffer, f : Double) -> FinanceportfoliorebalancingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_buffer_add(a : FinanceportfoliorebalancingBuffer, b : FinanceportfoliorebalancingBuffer) -> FinanceportfoliorebalancingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_buffer_copy(s : FinanceportfoliorebalancingBuffer) -> FinanceportfoliorebalancingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_buffer_fill(s : FinanceportfoliorebalancingBuffer, v : Double) -> FinanceportfoliorebalancingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_buffer_min(s : FinanceportfoliorebalancingBuffer) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_buffer_max(s : FinanceportfoliorebalancingBuffer) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_buffer_to_string(s : FinanceportfoliorebalancingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_cursor_make(size : Int) -> FinanceportfoliorebalancingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_cursor_len(s : FinanceportfoliorebalancingCursor) -> Int { s.size }

pub fn finance_portfolio_rebalancing_cursor_get(s : FinanceportfoliorebalancingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_cursor_set(s : FinanceportfoliorebalancingCursor, i : Int, v : Double) -> FinanceportfoliorebalancingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cursor_sum(s : FinanceportfoliorebalancingCursor) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_cursor_mean(s : FinanceportfoliorebalancingCursor) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_cursor_scale(s : FinanceportfoliorebalancingCursor, f : Double) -> FinanceportfoliorebalancingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cursor_add(a : FinanceportfoliorebalancingCursor, b : FinanceportfoliorebalancingCursor) -> FinanceportfoliorebalancingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_cursor_copy(s : FinanceportfoliorebalancingCursor) -> FinanceportfoliorebalancingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cursor_fill(s : FinanceportfoliorebalancingCursor, v : Double) -> FinanceportfoliorebalancingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_cursor_min(s : FinanceportfoliorebalancingCursor) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_cursor_max(s : FinanceportfoliorebalancingCursor) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_cursor_to_string(s : FinanceportfoliorebalancingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_view_make(size : Int) -> FinanceportfoliorebalancingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_view_len(s : FinanceportfoliorebalancingView) -> Int { s.size }

pub fn finance_portfolio_rebalancing_view_get(s : FinanceportfoliorebalancingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_view_set(s : FinanceportfoliorebalancingView, i : Int, v : Double) -> FinanceportfoliorebalancingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_view_sum(s : FinanceportfoliorebalancingView) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_view_mean(s : FinanceportfoliorebalancingView) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_view_scale(s : FinanceportfoliorebalancingView, f : Double) -> FinanceportfoliorebalancingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_view_add(a : FinanceportfoliorebalancingView, b : FinanceportfoliorebalancingView) -> FinanceportfoliorebalancingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_view_copy(s : FinanceportfoliorebalancingView) -> FinanceportfoliorebalancingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_view_fill(s : FinanceportfoliorebalancingView, v : Double) -> FinanceportfoliorebalancingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_view_min(s : FinanceportfoliorebalancingView) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_view_max(s : FinanceportfoliorebalancingView) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_view_to_string(s : FinanceportfoliorebalancingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_range_make(size : Int) -> FinanceportfoliorebalancingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_range_len(s : FinanceportfoliorebalancingRange) -> Int { s.size }

pub fn finance_portfolio_rebalancing_range_get(s : FinanceportfoliorebalancingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_range_set(s : FinanceportfoliorebalancingRange, i : Int, v : Double) -> FinanceportfoliorebalancingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_range_sum(s : FinanceportfoliorebalancingRange) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_range_mean(s : FinanceportfoliorebalancingRange) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_range_scale(s : FinanceportfoliorebalancingRange, f : Double) -> FinanceportfoliorebalancingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_range_add(a : FinanceportfoliorebalancingRange, b : FinanceportfoliorebalancingRange) -> FinanceportfoliorebalancingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_range_copy(s : FinanceportfoliorebalancingRange) -> FinanceportfoliorebalancingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_range_fill(s : FinanceportfoliorebalancingRange, v : Double) -> FinanceportfoliorebalancingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_range_min(s : FinanceportfoliorebalancingRange) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_range_max(s : FinanceportfoliorebalancingRange) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_range_to_string(s : FinanceportfoliorebalancingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceportfoliorebalancingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_portfolio_rebalancing_slice_make(size : Int) -> FinanceportfoliorebalancingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_portfolio_rebalancing_slice_len(s : FinanceportfoliorebalancingSlice) -> Int { s.size }

pub fn finance_portfolio_rebalancing_slice_get(s : FinanceportfoliorebalancingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_portfolio_rebalancing_slice_set(s : FinanceportfoliorebalancingSlice, i : Int, v : Double) -> FinanceportfoliorebalancingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_slice_sum(s : FinanceportfoliorebalancingSlice) -> Double { @_common.sum(s.data) }

pub fn finance_portfolio_rebalancing_slice_mean(s : FinanceportfoliorebalancingSlice) -> Double { @_common.mean(s.data) }

pub fn finance_portfolio_rebalancing_slice_scale(s : FinanceportfoliorebalancingSlice, f : Double) -> FinanceportfoliorebalancingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_slice_add(a : FinanceportfoliorebalancingSlice, b : FinanceportfoliorebalancingSlice) -> FinanceportfoliorebalancingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_portfolio_rebalancing_slice_copy(s : FinanceportfoliorebalancingSlice) -> FinanceportfoliorebalancingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_slice_fill(s : FinanceportfoliorebalancingSlice, v : Double) -> FinanceportfoliorebalancingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_portfolio_rebalancing_slice_min(s : FinanceportfoliorebalancingSlice) -> Double { @_common.min(s.data) }

pub fn finance_portfolio_rebalancing_slice_max(s : FinanceportfoliorebalancingSlice) -> Double { @_common.max(s.data) }

pub fn finance_portfolio_rebalancing_slice_to_string(s : FinanceportfoliorebalancingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

