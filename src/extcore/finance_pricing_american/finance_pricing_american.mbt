///===
/// extcore/finance_pricing_american

pub(all) struct FinancepricingamericanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_american_make_point(x : Double, y : Double) -> FinancepricingamericanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_american_make_point3(x : Double, y : Double, z : Double) -> FinancepricingamericanPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingamericanPoint::x(self : FinancepricingamericanPoint) -> Double { self.x }

pub fn FinancepricingamericanPoint::y(self : FinancepricingamericanPoint) -> Double { self.y }

pub fn FinancepricingamericanPoint::z(self : FinancepricingamericanPoint) -> Double { self.z }

pub fn FinancepricingamericanPoint::label(self : FinancepricingamericanPoint) -> Int { self.label }

pub fn FinancepricingamericanPoint::dist(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingamericanPoint::add(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingamericanPoint::sub(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingamericanPoint::scale(self : FinancepricingamericanPoint, s : Double) -> FinancepricingamericanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingamericanPoint::dot(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingamericanPoint::cross(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingamericanPoint::norm(self : FinancepricingamericanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingamericanPoint::normalize(self : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingamericanPoint::negate(self : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingamericanPoint::mid(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint) -> FinancepricingamericanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingamericanPoint::lerp(self : FinancepricingamericanPoint, other : FinancepricingamericanPoint, t : Double) -> FinancepricingamericanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingamericanPoint::to_string(self : FinancepricingamericanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingamericanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_american_make_series(vals : Array[Double], name : String) -> FinancepricingamericanSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingamericanSeries::len(self : FinancepricingamericanSeries) -> Int { self.vals.length() }

pub fn FinancepricingamericanSeries::sum(self : FinancepricingamericanSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingamericanSeries::mean(self : FinancepricingamericanSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingamericanSeries::min(self : FinancepricingamericanSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingamericanSeries::max(self : FinancepricingamericanSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingamericanSeries::range(self : FinancepricingamericanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingamericanSeries::variance(self : FinancepricingamericanSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingamericanSeries::std(self : FinancepricingamericanSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingamericanSeries::median(self : FinancepricingamericanSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingamericanSeries::scale(self : FinancepricingamericanSeries, f : Double) -> FinancepricingamericanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingamericanSeries::add(self : FinancepricingamericanSeries, other : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingamericanSeries::sub(self : FinancepricingamericanSeries, other : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingamericanSeries::normalize(self : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingamericanSeries::cumsum(self : FinancepricingamericanSeries) -> FinancepricingamericanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingamericanSeries::to_string(self : FinancepricingamericanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingamericanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_american_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingamericanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_american_matrix_identity(n : Int) -> FinancepricingamericanMatrix {
  let m = finance_pricing_american_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingamericanMatrix::get(self : FinancepricingamericanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingamericanMatrix::transpose(self : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingamericanMatrix::add(self : FinancepricingamericanMatrix, other : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_american_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingamericanMatrix::scale(self : FinancepricingamericanMatrix, s : Double) -> FinancepricingamericanMatrix {
  let result = finance_pricing_american_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingamericanMatrix::multiply(self : FinancepricingamericanMatrix, other : FinancepricingamericanMatrix) -> FinancepricingamericanMatrix {
  if self.cols != other.rows { return finance_pricing_american_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_american_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingamericanMatrix::trace(self : FinancepricingamericanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingamericanMatrix::det(self : FinancepricingamericanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingamericanMatrix::norm(self : FinancepricingamericanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingamericanMatrix::to_string(self : FinancepricingamericanMatrix) -> String {
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

pub(all) struct FinancepricingamericanVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_american_make_vector(comps : Array[Double]) -> FinancepricingamericanVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_american_vector_zero(dim : Int) -> FinancepricingamericanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingamericanVector::add(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingamericanVector::sub(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingamericanVector::scale(self : FinancepricingamericanVector, s : Double) -> FinancepricingamericanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingamericanVector::dot(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingamericanVector::norm(self : FinancepricingamericanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingamericanVector::normalize(self : FinancepricingamericanVector) -> FinancepricingamericanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingamericanVector::dist(self : FinancepricingamericanVector, other : FinancepricingamericanVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingamericanVector::to_string(self : FinancepricingamericanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_american_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_american_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_american_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_american_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_american_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_american_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_american_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_american_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_american_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_american_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_american_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_american_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_american_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_american_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_american_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_american_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_american_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_american_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_american_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_american_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_american_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_american_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_american_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_american_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_american_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_american_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_american_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_american_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_american_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingamericanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_frame_make(size : Int) -> FinancepricingamericanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_frame_len(s : FinancepricingamericanFrame) -> Int { s.size }

pub fn finance_pricing_american_frame_get(s : FinancepricingamericanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_frame_set(s : FinancepricingamericanFrame, i : Int, v : Double) -> FinancepricingamericanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_sum(s : FinancepricingamericanFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_frame_mean(s : FinancepricingamericanFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_frame_scale(s : FinancepricingamericanFrame, f : Double) -> FinancepricingamericanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_add(a : FinancepricingamericanFrame, b : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_frame_copy(s : FinancepricingamericanFrame) -> FinancepricingamericanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_fill(s : FinancepricingamericanFrame, v : Double) -> FinancepricingamericanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_frame_min(s : FinancepricingamericanFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_frame_max(s : FinancepricingamericanFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_frame_to_string(s : FinancepricingamericanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_table_make(size : Int) -> FinancepricingamericanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_table_len(s : FinancepricingamericanTable) -> Int { s.size }

pub fn finance_pricing_american_table_get(s : FinancepricingamericanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_table_set(s : FinancepricingamericanTable, i : Int, v : Double) -> FinancepricingamericanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_sum(s : FinancepricingamericanTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_table_mean(s : FinancepricingamericanTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_table_scale(s : FinancepricingamericanTable, f : Double) -> FinancepricingamericanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_add(a : FinancepricingamericanTable, b : FinancepricingamericanTable) -> FinancepricingamericanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_table_copy(s : FinancepricingamericanTable) -> FinancepricingamericanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_fill(s : FinancepricingamericanTable, v : Double) -> FinancepricingamericanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_table_min(s : FinancepricingamericanTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_table_max(s : FinancepricingamericanTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_table_to_string(s : FinancepricingamericanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_graphn_make(size : Int) -> FinancepricingamericanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_graphn_len(s : FinancepricingamericanGraphN) -> Int { s.size }

pub fn finance_pricing_american_graphn_get(s : FinancepricingamericanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_graphn_set(s : FinancepricingamericanGraphN, i : Int, v : Double) -> FinancepricingamericanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_sum(s : FinancepricingamericanGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_graphn_mean(s : FinancepricingamericanGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_graphn_scale(s : FinancepricingamericanGraphN, f : Double) -> FinancepricingamericanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_add(a : FinancepricingamericanGraphN, b : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_graphn_copy(s : FinancepricingamericanGraphN) -> FinancepricingamericanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_fill(s : FinancepricingamericanGraphN, v : Double) -> FinancepricingamericanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_graphn_min(s : FinancepricingamericanGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_graphn_max(s : FinancepricingamericanGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_graphn_to_string(s : FinancepricingamericanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_node_make(size : Int) -> FinancepricingamericanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_node_len(s : FinancepricingamericanNode) -> Int { s.size }

pub fn finance_pricing_american_node_get(s : FinancepricingamericanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_node_set(s : FinancepricingamericanNode, i : Int, v : Double) -> FinancepricingamericanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_sum(s : FinancepricingamericanNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_node_mean(s : FinancepricingamericanNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_node_scale(s : FinancepricingamericanNode, f : Double) -> FinancepricingamericanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_add(a : FinancepricingamericanNode, b : FinancepricingamericanNode) -> FinancepricingamericanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_node_copy(s : FinancepricingamericanNode) -> FinancepricingamericanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_fill(s : FinancepricingamericanNode, v : Double) -> FinancepricingamericanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_node_min(s : FinancepricingamericanNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_node_max(s : FinancepricingamericanNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_node_to_string(s : FinancepricingamericanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_edge_make(size : Int) -> FinancepricingamericanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_edge_len(s : FinancepricingamericanEdge) -> Int { s.size }

pub fn finance_pricing_american_edge_get(s : FinancepricingamericanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_edge_set(s : FinancepricingamericanEdge, i : Int, v : Double) -> FinancepricingamericanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_sum(s : FinancepricingamericanEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_edge_mean(s : FinancepricingamericanEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_edge_scale(s : FinancepricingamericanEdge, f : Double) -> FinancepricingamericanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_add(a : FinancepricingamericanEdge, b : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_edge_copy(s : FinancepricingamericanEdge) -> FinancepricingamericanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_fill(s : FinancepricingamericanEdge, v : Double) -> FinancepricingamericanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_edge_min(s : FinancepricingamericanEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_edge_max(s : FinancepricingamericanEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_edge_to_string(s : FinancepricingamericanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_path_make(size : Int) -> FinancepricingamericanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_path_len(s : FinancepricingamericanPath) -> Int { s.size }

pub fn finance_pricing_american_path_get(s : FinancepricingamericanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_path_set(s : FinancepricingamericanPath, i : Int, v : Double) -> FinancepricingamericanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_sum(s : FinancepricingamericanPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_path_mean(s : FinancepricingamericanPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_path_scale(s : FinancepricingamericanPath, f : Double) -> FinancepricingamericanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_add(a : FinancepricingamericanPath, b : FinancepricingamericanPath) -> FinancepricingamericanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_path_copy(s : FinancepricingamericanPath) -> FinancepricingamericanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_fill(s : FinancepricingamericanPath, v : Double) -> FinancepricingamericanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_path_min(s : FinancepricingamericanPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_path_max(s : FinancepricingamericanPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_path_to_string(s : FinancepricingamericanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cluster_make(size : Int) -> FinancepricingamericanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_cluster_len(s : FinancepricingamericanCluster) -> Int { s.size }

pub fn finance_pricing_american_cluster_get(s : FinancepricingamericanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_cluster_set(s : FinancepricingamericanCluster, i : Int, v : Double) -> FinancepricingamericanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_sum(s : FinancepricingamericanCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_cluster_mean(s : FinancepricingamericanCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_cluster_scale(s : FinancepricingamericanCluster, f : Double) -> FinancepricingamericanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_add(a : FinancepricingamericanCluster, b : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_cluster_copy(s : FinancepricingamericanCluster) -> FinancepricingamericanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_fill(s : FinancepricingamericanCluster, v : Double) -> FinancepricingamericanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cluster_min(s : FinancepricingamericanCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_cluster_max(s : FinancepricingamericanCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_cluster_to_string(s : FinancepricingamericanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_model_make(size : Int) -> FinancepricingamericanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_model_len(s : FinancepricingamericanModel) -> Int { s.size }

pub fn finance_pricing_american_model_get(s : FinancepricingamericanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_model_set(s : FinancepricingamericanModel, i : Int, v : Double) -> FinancepricingamericanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_sum(s : FinancepricingamericanModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_model_mean(s : FinancepricingamericanModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_model_scale(s : FinancepricingamericanModel, f : Double) -> FinancepricingamericanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_add(a : FinancepricingamericanModel, b : FinancepricingamericanModel) -> FinancepricingamericanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_model_copy(s : FinancepricingamericanModel) -> FinancepricingamericanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_fill(s : FinancepricingamericanModel, v : Double) -> FinancepricingamericanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_model_min(s : FinancepricingamericanModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_model_max(s : FinancepricingamericanModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_model_to_string(s : FinancepricingamericanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_layer_make(size : Int) -> FinancepricingamericanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_layer_len(s : FinancepricingamericanLayer) -> Int { s.size }

pub fn finance_pricing_american_layer_get(s : FinancepricingamericanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_layer_set(s : FinancepricingamericanLayer, i : Int, v : Double) -> FinancepricingamericanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_sum(s : FinancepricingamericanLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_layer_mean(s : FinancepricingamericanLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_layer_scale(s : FinancepricingamericanLayer, f : Double) -> FinancepricingamericanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_add(a : FinancepricingamericanLayer, b : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_layer_copy(s : FinancepricingamericanLayer) -> FinancepricingamericanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_fill(s : FinancepricingamericanLayer, v : Double) -> FinancepricingamericanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_layer_min(s : FinancepricingamericanLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_layer_max(s : FinancepricingamericanLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_layer_to_string(s : FinancepricingamericanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_buffer_make(size : Int) -> FinancepricingamericanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_buffer_len(s : FinancepricingamericanBuffer) -> Int { s.size }

pub fn finance_pricing_american_buffer_get(s : FinancepricingamericanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_buffer_set(s : FinancepricingamericanBuffer, i : Int, v : Double) -> FinancepricingamericanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_sum(s : FinancepricingamericanBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_buffer_mean(s : FinancepricingamericanBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_buffer_scale(s : FinancepricingamericanBuffer, f : Double) -> FinancepricingamericanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_add(a : FinancepricingamericanBuffer, b : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_buffer_copy(s : FinancepricingamericanBuffer) -> FinancepricingamericanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_fill(s : FinancepricingamericanBuffer, v : Double) -> FinancepricingamericanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_buffer_min(s : FinancepricingamericanBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_buffer_max(s : FinancepricingamericanBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_buffer_to_string(s : FinancepricingamericanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_cursor_make(size : Int) -> FinancepricingamericanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_cursor_len(s : FinancepricingamericanCursor) -> Int { s.size }

pub fn finance_pricing_american_cursor_get(s : FinancepricingamericanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_cursor_set(s : FinancepricingamericanCursor, i : Int, v : Double) -> FinancepricingamericanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_sum(s : FinancepricingamericanCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_cursor_mean(s : FinancepricingamericanCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_cursor_scale(s : FinancepricingamericanCursor, f : Double) -> FinancepricingamericanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_add(a : FinancepricingamericanCursor, b : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_cursor_copy(s : FinancepricingamericanCursor) -> FinancepricingamericanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_fill(s : FinancepricingamericanCursor, v : Double) -> FinancepricingamericanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_cursor_min(s : FinancepricingamericanCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_cursor_max(s : FinancepricingamericanCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_cursor_to_string(s : FinancepricingamericanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_view_make(size : Int) -> FinancepricingamericanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_view_len(s : FinancepricingamericanView) -> Int { s.size }

pub fn finance_pricing_american_view_get(s : FinancepricingamericanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_view_set(s : FinancepricingamericanView, i : Int, v : Double) -> FinancepricingamericanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_sum(s : FinancepricingamericanView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_view_mean(s : FinancepricingamericanView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_view_scale(s : FinancepricingamericanView, f : Double) -> FinancepricingamericanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_add(a : FinancepricingamericanView, b : FinancepricingamericanView) -> FinancepricingamericanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_view_copy(s : FinancepricingamericanView) -> FinancepricingamericanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_fill(s : FinancepricingamericanView, v : Double) -> FinancepricingamericanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_view_min(s : FinancepricingamericanView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_view_max(s : FinancepricingamericanView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_view_to_string(s : FinancepricingamericanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_range_make(size : Int) -> FinancepricingamericanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_range_len(s : FinancepricingamericanRange) -> Int { s.size }

pub fn finance_pricing_american_range_get(s : FinancepricingamericanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_range_set(s : FinancepricingamericanRange, i : Int, v : Double) -> FinancepricingamericanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_sum(s : FinancepricingamericanRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_range_mean(s : FinancepricingamericanRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_range_scale(s : FinancepricingamericanRange, f : Double) -> FinancepricingamericanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_add(a : FinancepricingamericanRange, b : FinancepricingamericanRange) -> FinancepricingamericanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_range_copy(s : FinancepricingamericanRange) -> FinancepricingamericanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_fill(s : FinancepricingamericanRange, v : Double) -> FinancepricingamericanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_range_min(s : FinancepricingamericanRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_range_max(s : FinancepricingamericanRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_range_to_string(s : FinancepricingamericanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingamericanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_american_slice_make(size : Int) -> FinancepricingamericanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_american_slice_len(s : FinancepricingamericanSlice) -> Int { s.size }

pub fn finance_pricing_american_slice_get(s : FinancepricingamericanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_american_slice_set(s : FinancepricingamericanSlice, i : Int, v : Double) -> FinancepricingamericanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_sum(s : FinancepricingamericanSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_american_slice_mean(s : FinancepricingamericanSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_american_slice_scale(s : FinancepricingamericanSlice, f : Double) -> FinancepricingamericanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_add(a : FinancepricingamericanSlice, b : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_american_slice_copy(s : FinancepricingamericanSlice) -> FinancepricingamericanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_fill(s : FinancepricingamericanSlice, v : Double) -> FinancepricingamericanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_american_slice_min(s : FinancepricingamericanSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_american_slice_max(s : FinancepricingamericanSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_american_slice_to_string(s : FinancepricingamericanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

