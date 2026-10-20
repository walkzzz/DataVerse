///===
/// extcore/finance_pricing_european

pub(all) struct FinancepricingeuropeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_european_make_point(x : Double, y : Double) -> FinancepricingeuropeanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_european_make_point3(x : Double, y : Double, z : Double) -> FinancepricingeuropeanPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingeuropeanPoint::x(self : FinancepricingeuropeanPoint) -> Double { self.x }

pub fn FinancepricingeuropeanPoint::y(self : FinancepricingeuropeanPoint) -> Double { self.y }

pub fn FinancepricingeuropeanPoint::z(self : FinancepricingeuropeanPoint) -> Double { self.z }

pub fn FinancepricingeuropeanPoint::label(self : FinancepricingeuropeanPoint) -> Int { self.label }

pub fn FinancepricingeuropeanPoint::dist(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingeuropeanPoint::add(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingeuropeanPoint::sub(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingeuropeanPoint::scale(self : FinancepricingeuropeanPoint, s : Double) -> FinancepricingeuropeanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingeuropeanPoint::dot(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingeuropeanPoint::cross(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingeuropeanPoint::norm(self : FinancepricingeuropeanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingeuropeanPoint::normalize(self : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingeuropeanPoint::negate(self : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingeuropeanPoint::mid(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint) -> FinancepricingeuropeanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingeuropeanPoint::lerp(self : FinancepricingeuropeanPoint, other : FinancepricingeuropeanPoint, t : Double) -> FinancepricingeuropeanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingeuropeanPoint::to_string(self : FinancepricingeuropeanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_european_make_series(vals : Array[Double], name : String) -> FinancepricingeuropeanSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingeuropeanSeries::len(self : FinancepricingeuropeanSeries) -> Int { self.vals.length() }

pub fn FinancepricingeuropeanSeries::sum(self : FinancepricingeuropeanSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingeuropeanSeries::mean(self : FinancepricingeuropeanSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingeuropeanSeries::min(self : FinancepricingeuropeanSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingeuropeanSeries::max(self : FinancepricingeuropeanSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingeuropeanSeries::range(self : FinancepricingeuropeanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingeuropeanSeries::variance(self : FinancepricingeuropeanSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingeuropeanSeries::std(self : FinancepricingeuropeanSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingeuropeanSeries::median(self : FinancepricingeuropeanSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingeuropeanSeries::scale(self : FinancepricingeuropeanSeries, f : Double) -> FinancepricingeuropeanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingeuropeanSeries::add(self : FinancepricingeuropeanSeries, other : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingeuropeanSeries::sub(self : FinancepricingeuropeanSeries, other : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingeuropeanSeries::normalize(self : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingeuropeanSeries::cumsum(self : FinancepricingeuropeanSeries) -> FinancepricingeuropeanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingeuropeanSeries::to_string(self : FinancepricingeuropeanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingeuropeanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_european_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingeuropeanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_european_matrix_identity(n : Int) -> FinancepricingeuropeanMatrix {
  let m = finance_pricing_european_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingeuropeanMatrix::get(self : FinancepricingeuropeanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingeuropeanMatrix::transpose(self : FinancepricingeuropeanMatrix) -> FinancepricingeuropeanMatrix {
  let result = finance_pricing_european_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingeuropeanMatrix::add(self : FinancepricingeuropeanMatrix, other : FinancepricingeuropeanMatrix) -> FinancepricingeuropeanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_european_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingeuropeanMatrix::scale(self : FinancepricingeuropeanMatrix, s : Double) -> FinancepricingeuropeanMatrix {
  let result = finance_pricing_european_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingeuropeanMatrix::multiply(self : FinancepricingeuropeanMatrix, other : FinancepricingeuropeanMatrix) -> FinancepricingeuropeanMatrix {
  if self.cols != other.rows { return finance_pricing_european_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_european_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingeuropeanMatrix::trace(self : FinancepricingeuropeanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingeuropeanMatrix::det(self : FinancepricingeuropeanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingeuropeanMatrix::norm(self : FinancepricingeuropeanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingeuropeanMatrix::to_string(self : FinancepricingeuropeanMatrix) -> String {
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

pub(all) struct FinancepricingeuropeanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_european_make_vector(comps : Array[Double]) -> FinancepricingeuropeanVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_european_vector_zero(dim : Int) -> FinancepricingeuropeanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingeuropeanVector::add(self : FinancepricingeuropeanVector, other : FinancepricingeuropeanVector) -> FinancepricingeuropeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingeuropeanVector::sub(self : FinancepricingeuropeanVector, other : FinancepricingeuropeanVector) -> FinancepricingeuropeanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingeuropeanVector::scale(self : FinancepricingeuropeanVector, s : Double) -> FinancepricingeuropeanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingeuropeanVector::dot(self : FinancepricingeuropeanVector, other : FinancepricingeuropeanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingeuropeanVector::norm(self : FinancepricingeuropeanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingeuropeanVector::normalize(self : FinancepricingeuropeanVector) -> FinancepricingeuropeanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingeuropeanVector::dist(self : FinancepricingeuropeanVector, other : FinancepricingeuropeanVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingeuropeanVector::to_string(self : FinancepricingeuropeanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_european_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_european_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_european_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_european_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_european_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_european_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_european_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_european_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_european_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_european_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_european_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_european_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_european_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_european_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_european_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_european_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_european_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_european_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_european_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_european_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_european_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_european_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_european_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_european_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_european_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_european_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_european_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_european_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_european_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingeuropeanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_frame_make(size : Int) -> FinancepricingeuropeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_frame_len(s : FinancepricingeuropeanFrame) -> Int { s.size }

pub fn finance_pricing_european_frame_get(s : FinancepricingeuropeanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_frame_set(s : FinancepricingeuropeanFrame, i : Int, v : Double) -> FinancepricingeuropeanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_frame_sum(s : FinancepricingeuropeanFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_frame_mean(s : FinancepricingeuropeanFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_frame_scale(s : FinancepricingeuropeanFrame, f : Double) -> FinancepricingeuropeanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_frame_add(a : FinancepricingeuropeanFrame, b : FinancepricingeuropeanFrame) -> FinancepricingeuropeanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_frame_copy(s : FinancepricingeuropeanFrame) -> FinancepricingeuropeanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_frame_fill(s : FinancepricingeuropeanFrame, v : Double) -> FinancepricingeuropeanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_frame_min(s : FinancepricingeuropeanFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_frame_max(s : FinancepricingeuropeanFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_frame_to_string(s : FinancepricingeuropeanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_table_make(size : Int) -> FinancepricingeuropeanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_table_len(s : FinancepricingeuropeanTable) -> Int { s.size }

pub fn finance_pricing_european_table_get(s : FinancepricingeuropeanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_table_set(s : FinancepricingeuropeanTable, i : Int, v : Double) -> FinancepricingeuropeanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_table_sum(s : FinancepricingeuropeanTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_table_mean(s : FinancepricingeuropeanTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_table_scale(s : FinancepricingeuropeanTable, f : Double) -> FinancepricingeuropeanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_table_add(a : FinancepricingeuropeanTable, b : FinancepricingeuropeanTable) -> FinancepricingeuropeanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_table_copy(s : FinancepricingeuropeanTable) -> FinancepricingeuropeanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_table_fill(s : FinancepricingeuropeanTable, v : Double) -> FinancepricingeuropeanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_table_min(s : FinancepricingeuropeanTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_table_max(s : FinancepricingeuropeanTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_table_to_string(s : FinancepricingeuropeanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_graphn_make(size : Int) -> FinancepricingeuropeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_graphn_len(s : FinancepricingeuropeanGraphN) -> Int { s.size }

pub fn finance_pricing_european_graphn_get(s : FinancepricingeuropeanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_graphn_set(s : FinancepricingeuropeanGraphN, i : Int, v : Double) -> FinancepricingeuropeanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_graphn_sum(s : FinancepricingeuropeanGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_graphn_mean(s : FinancepricingeuropeanGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_graphn_scale(s : FinancepricingeuropeanGraphN, f : Double) -> FinancepricingeuropeanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_graphn_add(a : FinancepricingeuropeanGraphN, b : FinancepricingeuropeanGraphN) -> FinancepricingeuropeanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_graphn_copy(s : FinancepricingeuropeanGraphN) -> FinancepricingeuropeanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_graphn_fill(s : FinancepricingeuropeanGraphN, v : Double) -> FinancepricingeuropeanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_graphn_min(s : FinancepricingeuropeanGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_graphn_max(s : FinancepricingeuropeanGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_graphn_to_string(s : FinancepricingeuropeanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_node_make(size : Int) -> FinancepricingeuropeanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_node_len(s : FinancepricingeuropeanNode) -> Int { s.size }

pub fn finance_pricing_european_node_get(s : FinancepricingeuropeanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_node_set(s : FinancepricingeuropeanNode, i : Int, v : Double) -> FinancepricingeuropeanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_node_sum(s : FinancepricingeuropeanNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_node_mean(s : FinancepricingeuropeanNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_node_scale(s : FinancepricingeuropeanNode, f : Double) -> FinancepricingeuropeanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_node_add(a : FinancepricingeuropeanNode, b : FinancepricingeuropeanNode) -> FinancepricingeuropeanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_node_copy(s : FinancepricingeuropeanNode) -> FinancepricingeuropeanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_node_fill(s : FinancepricingeuropeanNode, v : Double) -> FinancepricingeuropeanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_node_min(s : FinancepricingeuropeanNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_node_max(s : FinancepricingeuropeanNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_node_to_string(s : FinancepricingeuropeanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_edge_make(size : Int) -> FinancepricingeuropeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_edge_len(s : FinancepricingeuropeanEdge) -> Int { s.size }

pub fn finance_pricing_european_edge_get(s : FinancepricingeuropeanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_edge_set(s : FinancepricingeuropeanEdge, i : Int, v : Double) -> FinancepricingeuropeanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_edge_sum(s : FinancepricingeuropeanEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_edge_mean(s : FinancepricingeuropeanEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_edge_scale(s : FinancepricingeuropeanEdge, f : Double) -> FinancepricingeuropeanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_edge_add(a : FinancepricingeuropeanEdge, b : FinancepricingeuropeanEdge) -> FinancepricingeuropeanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_edge_copy(s : FinancepricingeuropeanEdge) -> FinancepricingeuropeanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_edge_fill(s : FinancepricingeuropeanEdge, v : Double) -> FinancepricingeuropeanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_edge_min(s : FinancepricingeuropeanEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_edge_max(s : FinancepricingeuropeanEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_edge_to_string(s : FinancepricingeuropeanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_path_make(size : Int) -> FinancepricingeuropeanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_path_len(s : FinancepricingeuropeanPath) -> Int { s.size }

pub fn finance_pricing_european_path_get(s : FinancepricingeuropeanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_path_set(s : FinancepricingeuropeanPath, i : Int, v : Double) -> FinancepricingeuropeanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_path_sum(s : FinancepricingeuropeanPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_path_mean(s : FinancepricingeuropeanPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_path_scale(s : FinancepricingeuropeanPath, f : Double) -> FinancepricingeuropeanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_path_add(a : FinancepricingeuropeanPath, b : FinancepricingeuropeanPath) -> FinancepricingeuropeanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_path_copy(s : FinancepricingeuropeanPath) -> FinancepricingeuropeanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_path_fill(s : FinancepricingeuropeanPath, v : Double) -> FinancepricingeuropeanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_path_min(s : FinancepricingeuropeanPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_path_max(s : FinancepricingeuropeanPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_path_to_string(s : FinancepricingeuropeanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_cluster_make(size : Int) -> FinancepricingeuropeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_cluster_len(s : FinancepricingeuropeanCluster) -> Int { s.size }

pub fn finance_pricing_european_cluster_get(s : FinancepricingeuropeanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_cluster_set(s : FinancepricingeuropeanCluster, i : Int, v : Double) -> FinancepricingeuropeanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cluster_sum(s : FinancepricingeuropeanCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_cluster_mean(s : FinancepricingeuropeanCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_cluster_scale(s : FinancepricingeuropeanCluster, f : Double) -> FinancepricingeuropeanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cluster_add(a : FinancepricingeuropeanCluster, b : FinancepricingeuropeanCluster) -> FinancepricingeuropeanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_cluster_copy(s : FinancepricingeuropeanCluster) -> FinancepricingeuropeanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cluster_fill(s : FinancepricingeuropeanCluster, v : Double) -> FinancepricingeuropeanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cluster_min(s : FinancepricingeuropeanCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_cluster_max(s : FinancepricingeuropeanCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_cluster_to_string(s : FinancepricingeuropeanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_model_make(size : Int) -> FinancepricingeuropeanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_model_len(s : FinancepricingeuropeanModel) -> Int { s.size }

pub fn finance_pricing_european_model_get(s : FinancepricingeuropeanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_model_set(s : FinancepricingeuropeanModel, i : Int, v : Double) -> FinancepricingeuropeanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_model_sum(s : FinancepricingeuropeanModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_model_mean(s : FinancepricingeuropeanModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_model_scale(s : FinancepricingeuropeanModel, f : Double) -> FinancepricingeuropeanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_model_add(a : FinancepricingeuropeanModel, b : FinancepricingeuropeanModel) -> FinancepricingeuropeanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_model_copy(s : FinancepricingeuropeanModel) -> FinancepricingeuropeanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_model_fill(s : FinancepricingeuropeanModel, v : Double) -> FinancepricingeuropeanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_model_min(s : FinancepricingeuropeanModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_model_max(s : FinancepricingeuropeanModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_model_to_string(s : FinancepricingeuropeanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_layer_make(size : Int) -> FinancepricingeuropeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_layer_len(s : FinancepricingeuropeanLayer) -> Int { s.size }

pub fn finance_pricing_european_layer_get(s : FinancepricingeuropeanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_layer_set(s : FinancepricingeuropeanLayer, i : Int, v : Double) -> FinancepricingeuropeanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_layer_sum(s : FinancepricingeuropeanLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_layer_mean(s : FinancepricingeuropeanLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_layer_scale(s : FinancepricingeuropeanLayer, f : Double) -> FinancepricingeuropeanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_layer_add(a : FinancepricingeuropeanLayer, b : FinancepricingeuropeanLayer) -> FinancepricingeuropeanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_layer_copy(s : FinancepricingeuropeanLayer) -> FinancepricingeuropeanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_layer_fill(s : FinancepricingeuropeanLayer, v : Double) -> FinancepricingeuropeanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_layer_min(s : FinancepricingeuropeanLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_layer_max(s : FinancepricingeuropeanLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_layer_to_string(s : FinancepricingeuropeanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_buffer_make(size : Int) -> FinancepricingeuropeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_buffer_len(s : FinancepricingeuropeanBuffer) -> Int { s.size }

pub fn finance_pricing_european_buffer_get(s : FinancepricingeuropeanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_buffer_set(s : FinancepricingeuropeanBuffer, i : Int, v : Double) -> FinancepricingeuropeanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_buffer_sum(s : FinancepricingeuropeanBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_buffer_mean(s : FinancepricingeuropeanBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_buffer_scale(s : FinancepricingeuropeanBuffer, f : Double) -> FinancepricingeuropeanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_buffer_add(a : FinancepricingeuropeanBuffer, b : FinancepricingeuropeanBuffer) -> FinancepricingeuropeanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_buffer_copy(s : FinancepricingeuropeanBuffer) -> FinancepricingeuropeanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_buffer_fill(s : FinancepricingeuropeanBuffer, v : Double) -> FinancepricingeuropeanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_buffer_min(s : FinancepricingeuropeanBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_buffer_max(s : FinancepricingeuropeanBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_buffer_to_string(s : FinancepricingeuropeanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_cursor_make(size : Int) -> FinancepricingeuropeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_cursor_len(s : FinancepricingeuropeanCursor) -> Int { s.size }

pub fn finance_pricing_european_cursor_get(s : FinancepricingeuropeanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_cursor_set(s : FinancepricingeuropeanCursor, i : Int, v : Double) -> FinancepricingeuropeanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cursor_sum(s : FinancepricingeuropeanCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_cursor_mean(s : FinancepricingeuropeanCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_cursor_scale(s : FinancepricingeuropeanCursor, f : Double) -> FinancepricingeuropeanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cursor_add(a : FinancepricingeuropeanCursor, b : FinancepricingeuropeanCursor) -> FinancepricingeuropeanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_cursor_copy(s : FinancepricingeuropeanCursor) -> FinancepricingeuropeanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cursor_fill(s : FinancepricingeuropeanCursor, v : Double) -> FinancepricingeuropeanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_cursor_min(s : FinancepricingeuropeanCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_cursor_max(s : FinancepricingeuropeanCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_cursor_to_string(s : FinancepricingeuropeanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_view_make(size : Int) -> FinancepricingeuropeanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_view_len(s : FinancepricingeuropeanView) -> Int { s.size }

pub fn finance_pricing_european_view_get(s : FinancepricingeuropeanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_view_set(s : FinancepricingeuropeanView, i : Int, v : Double) -> FinancepricingeuropeanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_view_sum(s : FinancepricingeuropeanView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_view_mean(s : FinancepricingeuropeanView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_view_scale(s : FinancepricingeuropeanView, f : Double) -> FinancepricingeuropeanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_view_add(a : FinancepricingeuropeanView, b : FinancepricingeuropeanView) -> FinancepricingeuropeanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_view_copy(s : FinancepricingeuropeanView) -> FinancepricingeuropeanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_view_fill(s : FinancepricingeuropeanView, v : Double) -> FinancepricingeuropeanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_view_min(s : FinancepricingeuropeanView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_view_max(s : FinancepricingeuropeanView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_view_to_string(s : FinancepricingeuropeanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_range_make(size : Int) -> FinancepricingeuropeanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_range_len(s : FinancepricingeuropeanRange) -> Int { s.size }

pub fn finance_pricing_european_range_get(s : FinancepricingeuropeanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_range_set(s : FinancepricingeuropeanRange, i : Int, v : Double) -> FinancepricingeuropeanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_range_sum(s : FinancepricingeuropeanRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_range_mean(s : FinancepricingeuropeanRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_range_scale(s : FinancepricingeuropeanRange, f : Double) -> FinancepricingeuropeanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_range_add(a : FinancepricingeuropeanRange, b : FinancepricingeuropeanRange) -> FinancepricingeuropeanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_range_copy(s : FinancepricingeuropeanRange) -> FinancepricingeuropeanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_range_fill(s : FinancepricingeuropeanRange, v : Double) -> FinancepricingeuropeanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_range_min(s : FinancepricingeuropeanRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_range_max(s : FinancepricingeuropeanRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_range_to_string(s : FinancepricingeuropeanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingeuropeanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_european_slice_make(size : Int) -> FinancepricingeuropeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_european_slice_len(s : FinancepricingeuropeanSlice) -> Int { s.size }

pub fn finance_pricing_european_slice_get(s : FinancepricingeuropeanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_european_slice_set(s : FinancepricingeuropeanSlice, i : Int, v : Double) -> FinancepricingeuropeanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_slice_sum(s : FinancepricingeuropeanSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_european_slice_mean(s : FinancepricingeuropeanSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_european_slice_scale(s : FinancepricingeuropeanSlice, f : Double) -> FinancepricingeuropeanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_slice_add(a : FinancepricingeuropeanSlice, b : FinancepricingeuropeanSlice) -> FinancepricingeuropeanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_european_slice_copy(s : FinancepricingeuropeanSlice) -> FinancepricingeuropeanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_slice_fill(s : FinancepricingeuropeanSlice, v : Double) -> FinancepricingeuropeanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_european_slice_min(s : FinancepricingeuropeanSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_european_slice_max(s : FinancepricingeuropeanSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_european_slice_to_string(s : FinancepricingeuropeanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

