///===
/// extcore/finance_pricing_asian

pub(all) struct FinancepricingasianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_asian_make_point(x : Double, y : Double) -> FinancepricingasianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_asian_make_point3(x : Double, y : Double, z : Double) -> FinancepricingasianPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingasianPoint::x(self : FinancepricingasianPoint) -> Double { self.x }

pub fn FinancepricingasianPoint::y(self : FinancepricingasianPoint) -> Double { self.y }

pub fn FinancepricingasianPoint::z(self : FinancepricingasianPoint) -> Double { self.z }

pub fn FinancepricingasianPoint::label(self : FinancepricingasianPoint) -> Int { self.label }

pub fn FinancepricingasianPoint::dist(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingasianPoint::add(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingasianPoint::sub(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingasianPoint::scale(self : FinancepricingasianPoint, s : Double) -> FinancepricingasianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingasianPoint::dot(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingasianPoint::cross(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingasianPoint::norm(self : FinancepricingasianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingasianPoint::normalize(self : FinancepricingasianPoint) -> FinancepricingasianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingasianPoint::negate(self : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingasianPoint::mid(self : FinancepricingasianPoint, other : FinancepricingasianPoint) -> FinancepricingasianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingasianPoint::lerp(self : FinancepricingasianPoint, other : FinancepricingasianPoint, t : Double) -> FinancepricingasianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingasianPoint::to_string(self : FinancepricingasianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingasianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_asian_make_series(vals : Array[Double], name : String) -> FinancepricingasianSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingasianSeries::len(self : FinancepricingasianSeries) -> Int { self.vals.length() }

pub fn FinancepricingasianSeries::sum(self : FinancepricingasianSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingasianSeries::mean(self : FinancepricingasianSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingasianSeries::min(self : FinancepricingasianSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingasianSeries::max(self : FinancepricingasianSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingasianSeries::range(self : FinancepricingasianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingasianSeries::variance(self : FinancepricingasianSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingasianSeries::std(self : FinancepricingasianSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingasianSeries::median(self : FinancepricingasianSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingasianSeries::scale(self : FinancepricingasianSeries, f : Double) -> FinancepricingasianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingasianSeries::add(self : FinancepricingasianSeries, other : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingasianSeries::sub(self : FinancepricingasianSeries, other : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingasianSeries::normalize(self : FinancepricingasianSeries) -> FinancepricingasianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingasianSeries::cumsum(self : FinancepricingasianSeries) -> FinancepricingasianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingasianSeries::to_string(self : FinancepricingasianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingasianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_asian_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingasianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_asian_matrix_identity(n : Int) -> FinancepricingasianMatrix {
  let m = finance_pricing_asian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingasianMatrix::get(self : FinancepricingasianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingasianMatrix::transpose(self : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingasianMatrix::add(self : FinancepricingasianMatrix, other : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_asian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingasianMatrix::scale(self : FinancepricingasianMatrix, s : Double) -> FinancepricingasianMatrix {
  let result = finance_pricing_asian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingasianMatrix::multiply(self : FinancepricingasianMatrix, other : FinancepricingasianMatrix) -> FinancepricingasianMatrix {
  if self.cols != other.rows { return finance_pricing_asian_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_asian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingasianMatrix::trace(self : FinancepricingasianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingasianMatrix::det(self : FinancepricingasianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingasianMatrix::norm(self : FinancepricingasianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingasianMatrix::to_string(self : FinancepricingasianMatrix) -> String {
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

pub(all) struct FinancepricingasianVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_asian_make_vector(comps : Array[Double]) -> FinancepricingasianVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_asian_vector_zero(dim : Int) -> FinancepricingasianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingasianVector::add(self : FinancepricingasianVector, other : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingasianVector::sub(self : FinancepricingasianVector, other : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingasianVector::scale(self : FinancepricingasianVector, s : Double) -> FinancepricingasianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingasianVector::dot(self : FinancepricingasianVector, other : FinancepricingasianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingasianVector::norm(self : FinancepricingasianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingasianVector::normalize(self : FinancepricingasianVector) -> FinancepricingasianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingasianVector::dist(self : FinancepricingasianVector, other : FinancepricingasianVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingasianVector::to_string(self : FinancepricingasianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_asian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_asian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_asian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_asian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_asian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_asian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_asian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_asian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_asian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_asian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_asian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_asian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_asian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_asian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_asian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_asian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_asian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_asian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_asian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_asian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_asian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_asian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_asian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_asian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_asian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_asian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_asian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_asian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_asian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingasianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_frame_make(size : Int) -> FinancepricingasianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_frame_len(s : FinancepricingasianFrame) -> Int { s.size }

pub fn finance_pricing_asian_frame_get(s : FinancepricingasianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_frame_set(s : FinancepricingasianFrame, i : Int, v : Double) -> FinancepricingasianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_sum(s : FinancepricingasianFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_frame_mean(s : FinancepricingasianFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_frame_scale(s : FinancepricingasianFrame, f : Double) -> FinancepricingasianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_add(a : FinancepricingasianFrame, b : FinancepricingasianFrame) -> FinancepricingasianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_frame_copy(s : FinancepricingasianFrame) -> FinancepricingasianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_fill(s : FinancepricingasianFrame, v : Double) -> FinancepricingasianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_frame_min(s : FinancepricingasianFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_frame_max(s : FinancepricingasianFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_frame_to_string(s : FinancepricingasianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_table_make(size : Int) -> FinancepricingasianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_table_len(s : FinancepricingasianTable) -> Int { s.size }

pub fn finance_pricing_asian_table_get(s : FinancepricingasianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_table_set(s : FinancepricingasianTable, i : Int, v : Double) -> FinancepricingasianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_sum(s : FinancepricingasianTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_table_mean(s : FinancepricingasianTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_table_scale(s : FinancepricingasianTable, f : Double) -> FinancepricingasianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_add(a : FinancepricingasianTable, b : FinancepricingasianTable) -> FinancepricingasianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_table_copy(s : FinancepricingasianTable) -> FinancepricingasianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_fill(s : FinancepricingasianTable, v : Double) -> FinancepricingasianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_table_min(s : FinancepricingasianTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_table_max(s : FinancepricingasianTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_table_to_string(s : FinancepricingasianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_graphn_make(size : Int) -> FinancepricingasianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_graphn_len(s : FinancepricingasianGraphN) -> Int { s.size }

pub fn finance_pricing_asian_graphn_get(s : FinancepricingasianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_graphn_set(s : FinancepricingasianGraphN, i : Int, v : Double) -> FinancepricingasianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_sum(s : FinancepricingasianGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_graphn_mean(s : FinancepricingasianGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_graphn_scale(s : FinancepricingasianGraphN, f : Double) -> FinancepricingasianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_add(a : FinancepricingasianGraphN, b : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_graphn_copy(s : FinancepricingasianGraphN) -> FinancepricingasianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_fill(s : FinancepricingasianGraphN, v : Double) -> FinancepricingasianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_graphn_min(s : FinancepricingasianGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_graphn_max(s : FinancepricingasianGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_graphn_to_string(s : FinancepricingasianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_node_make(size : Int) -> FinancepricingasianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_node_len(s : FinancepricingasianNode) -> Int { s.size }

pub fn finance_pricing_asian_node_get(s : FinancepricingasianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_node_set(s : FinancepricingasianNode, i : Int, v : Double) -> FinancepricingasianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_sum(s : FinancepricingasianNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_node_mean(s : FinancepricingasianNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_node_scale(s : FinancepricingasianNode, f : Double) -> FinancepricingasianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_add(a : FinancepricingasianNode, b : FinancepricingasianNode) -> FinancepricingasianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_node_copy(s : FinancepricingasianNode) -> FinancepricingasianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_fill(s : FinancepricingasianNode, v : Double) -> FinancepricingasianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_node_min(s : FinancepricingasianNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_node_max(s : FinancepricingasianNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_node_to_string(s : FinancepricingasianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_edge_make(size : Int) -> FinancepricingasianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_edge_len(s : FinancepricingasianEdge) -> Int { s.size }

pub fn finance_pricing_asian_edge_get(s : FinancepricingasianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_edge_set(s : FinancepricingasianEdge, i : Int, v : Double) -> FinancepricingasianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_sum(s : FinancepricingasianEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_edge_mean(s : FinancepricingasianEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_edge_scale(s : FinancepricingasianEdge, f : Double) -> FinancepricingasianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_add(a : FinancepricingasianEdge, b : FinancepricingasianEdge) -> FinancepricingasianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_edge_copy(s : FinancepricingasianEdge) -> FinancepricingasianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_fill(s : FinancepricingasianEdge, v : Double) -> FinancepricingasianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_edge_min(s : FinancepricingasianEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_edge_max(s : FinancepricingasianEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_edge_to_string(s : FinancepricingasianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_path_make(size : Int) -> FinancepricingasianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_path_len(s : FinancepricingasianPath) -> Int { s.size }

pub fn finance_pricing_asian_path_get(s : FinancepricingasianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_path_set(s : FinancepricingasianPath, i : Int, v : Double) -> FinancepricingasianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_sum(s : FinancepricingasianPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_path_mean(s : FinancepricingasianPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_path_scale(s : FinancepricingasianPath, f : Double) -> FinancepricingasianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_add(a : FinancepricingasianPath, b : FinancepricingasianPath) -> FinancepricingasianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_path_copy(s : FinancepricingasianPath) -> FinancepricingasianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_fill(s : FinancepricingasianPath, v : Double) -> FinancepricingasianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_path_min(s : FinancepricingasianPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_path_max(s : FinancepricingasianPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_path_to_string(s : FinancepricingasianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cluster_make(size : Int) -> FinancepricingasianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_cluster_len(s : FinancepricingasianCluster) -> Int { s.size }

pub fn finance_pricing_asian_cluster_get(s : FinancepricingasianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_cluster_set(s : FinancepricingasianCluster, i : Int, v : Double) -> FinancepricingasianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_sum(s : FinancepricingasianCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_cluster_mean(s : FinancepricingasianCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_cluster_scale(s : FinancepricingasianCluster, f : Double) -> FinancepricingasianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_add(a : FinancepricingasianCluster, b : FinancepricingasianCluster) -> FinancepricingasianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_cluster_copy(s : FinancepricingasianCluster) -> FinancepricingasianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_fill(s : FinancepricingasianCluster, v : Double) -> FinancepricingasianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cluster_min(s : FinancepricingasianCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_cluster_max(s : FinancepricingasianCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_cluster_to_string(s : FinancepricingasianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_model_make(size : Int) -> FinancepricingasianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_model_len(s : FinancepricingasianModel) -> Int { s.size }

pub fn finance_pricing_asian_model_get(s : FinancepricingasianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_model_set(s : FinancepricingasianModel, i : Int, v : Double) -> FinancepricingasianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_sum(s : FinancepricingasianModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_model_mean(s : FinancepricingasianModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_model_scale(s : FinancepricingasianModel, f : Double) -> FinancepricingasianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_add(a : FinancepricingasianModel, b : FinancepricingasianModel) -> FinancepricingasianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_model_copy(s : FinancepricingasianModel) -> FinancepricingasianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_fill(s : FinancepricingasianModel, v : Double) -> FinancepricingasianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_model_min(s : FinancepricingasianModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_model_max(s : FinancepricingasianModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_model_to_string(s : FinancepricingasianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_layer_make(size : Int) -> FinancepricingasianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_layer_len(s : FinancepricingasianLayer) -> Int { s.size }

pub fn finance_pricing_asian_layer_get(s : FinancepricingasianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_layer_set(s : FinancepricingasianLayer, i : Int, v : Double) -> FinancepricingasianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_sum(s : FinancepricingasianLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_layer_mean(s : FinancepricingasianLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_layer_scale(s : FinancepricingasianLayer, f : Double) -> FinancepricingasianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_add(a : FinancepricingasianLayer, b : FinancepricingasianLayer) -> FinancepricingasianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_layer_copy(s : FinancepricingasianLayer) -> FinancepricingasianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_fill(s : FinancepricingasianLayer, v : Double) -> FinancepricingasianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_layer_min(s : FinancepricingasianLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_layer_max(s : FinancepricingasianLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_layer_to_string(s : FinancepricingasianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_buffer_make(size : Int) -> FinancepricingasianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_buffer_len(s : FinancepricingasianBuffer) -> Int { s.size }

pub fn finance_pricing_asian_buffer_get(s : FinancepricingasianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_buffer_set(s : FinancepricingasianBuffer, i : Int, v : Double) -> FinancepricingasianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_sum(s : FinancepricingasianBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_buffer_mean(s : FinancepricingasianBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_buffer_scale(s : FinancepricingasianBuffer, f : Double) -> FinancepricingasianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_add(a : FinancepricingasianBuffer, b : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_buffer_copy(s : FinancepricingasianBuffer) -> FinancepricingasianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_fill(s : FinancepricingasianBuffer, v : Double) -> FinancepricingasianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_buffer_min(s : FinancepricingasianBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_buffer_max(s : FinancepricingasianBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_buffer_to_string(s : FinancepricingasianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_cursor_make(size : Int) -> FinancepricingasianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_cursor_len(s : FinancepricingasianCursor) -> Int { s.size }

pub fn finance_pricing_asian_cursor_get(s : FinancepricingasianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_cursor_set(s : FinancepricingasianCursor, i : Int, v : Double) -> FinancepricingasianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_sum(s : FinancepricingasianCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_cursor_mean(s : FinancepricingasianCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_cursor_scale(s : FinancepricingasianCursor, f : Double) -> FinancepricingasianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_add(a : FinancepricingasianCursor, b : FinancepricingasianCursor) -> FinancepricingasianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_cursor_copy(s : FinancepricingasianCursor) -> FinancepricingasianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_fill(s : FinancepricingasianCursor, v : Double) -> FinancepricingasianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_cursor_min(s : FinancepricingasianCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_cursor_max(s : FinancepricingasianCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_cursor_to_string(s : FinancepricingasianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_view_make(size : Int) -> FinancepricingasianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_view_len(s : FinancepricingasianView) -> Int { s.size }

pub fn finance_pricing_asian_view_get(s : FinancepricingasianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_view_set(s : FinancepricingasianView, i : Int, v : Double) -> FinancepricingasianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_sum(s : FinancepricingasianView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_view_mean(s : FinancepricingasianView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_view_scale(s : FinancepricingasianView, f : Double) -> FinancepricingasianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_add(a : FinancepricingasianView, b : FinancepricingasianView) -> FinancepricingasianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_view_copy(s : FinancepricingasianView) -> FinancepricingasianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_fill(s : FinancepricingasianView, v : Double) -> FinancepricingasianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_view_min(s : FinancepricingasianView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_view_max(s : FinancepricingasianView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_view_to_string(s : FinancepricingasianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_range_make(size : Int) -> FinancepricingasianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_range_len(s : FinancepricingasianRange) -> Int { s.size }

pub fn finance_pricing_asian_range_get(s : FinancepricingasianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_range_set(s : FinancepricingasianRange, i : Int, v : Double) -> FinancepricingasianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_sum(s : FinancepricingasianRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_range_mean(s : FinancepricingasianRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_range_scale(s : FinancepricingasianRange, f : Double) -> FinancepricingasianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_add(a : FinancepricingasianRange, b : FinancepricingasianRange) -> FinancepricingasianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_range_copy(s : FinancepricingasianRange) -> FinancepricingasianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_fill(s : FinancepricingasianRange, v : Double) -> FinancepricingasianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_range_min(s : FinancepricingasianRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_range_max(s : FinancepricingasianRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_range_to_string(s : FinancepricingasianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingasianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_asian_slice_make(size : Int) -> FinancepricingasianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_asian_slice_len(s : FinancepricingasianSlice) -> Int { s.size }

pub fn finance_pricing_asian_slice_get(s : FinancepricingasianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_asian_slice_set(s : FinancepricingasianSlice, i : Int, v : Double) -> FinancepricingasianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_sum(s : FinancepricingasianSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_asian_slice_mean(s : FinancepricingasianSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_asian_slice_scale(s : FinancepricingasianSlice, f : Double) -> FinancepricingasianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_add(a : FinancepricingasianSlice, b : FinancepricingasianSlice) -> FinancepricingasianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_asian_slice_copy(s : FinancepricingasianSlice) -> FinancepricingasianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_fill(s : FinancepricingasianSlice, v : Double) -> FinancepricingasianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_asian_slice_min(s : FinancepricingasianSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_asian_slice_max(s : FinancepricingasianSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_asian_slice_to_string(s : FinancepricingasianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

