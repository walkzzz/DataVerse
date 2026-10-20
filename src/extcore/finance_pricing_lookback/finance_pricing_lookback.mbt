///===
/// extcore/finance_pricing_lookback

pub(all) struct FinancepricinglookbackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_lookback_make_point(x : Double, y : Double) -> FinancepricinglookbackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_lookback_make_point3(x : Double, y : Double, z : Double) -> FinancepricinglookbackPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricinglookbackPoint::x(self : FinancepricinglookbackPoint) -> Double { self.x }

pub fn FinancepricinglookbackPoint::y(self : FinancepricinglookbackPoint) -> Double { self.y }

pub fn FinancepricinglookbackPoint::z(self : FinancepricinglookbackPoint) -> Double { self.z }

pub fn FinancepricinglookbackPoint::label(self : FinancepricinglookbackPoint) -> Int { self.label }

pub fn FinancepricinglookbackPoint::dist(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricinglookbackPoint::add(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricinglookbackPoint::sub(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricinglookbackPoint::scale(self : FinancepricinglookbackPoint, s : Double) -> FinancepricinglookbackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricinglookbackPoint::dot(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricinglookbackPoint::cross(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricinglookbackPoint::norm(self : FinancepricinglookbackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricinglookbackPoint::normalize(self : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricinglookbackPoint::negate(self : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricinglookbackPoint::mid(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint) -> FinancepricinglookbackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricinglookbackPoint::lerp(self : FinancepricinglookbackPoint, other : FinancepricinglookbackPoint, t : Double) -> FinancepricinglookbackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricinglookbackPoint::to_string(self : FinancepricinglookbackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricinglookbackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_lookback_make_series(vals : Array[Double], name : String) -> FinancepricinglookbackSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricinglookbackSeries::len(self : FinancepricinglookbackSeries) -> Int { self.vals.length() }

pub fn FinancepricinglookbackSeries::sum(self : FinancepricinglookbackSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricinglookbackSeries::mean(self : FinancepricinglookbackSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricinglookbackSeries::min(self : FinancepricinglookbackSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricinglookbackSeries::max(self : FinancepricinglookbackSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricinglookbackSeries::range(self : FinancepricinglookbackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricinglookbackSeries::variance(self : FinancepricinglookbackSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricinglookbackSeries::std(self : FinancepricinglookbackSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricinglookbackSeries::median(self : FinancepricinglookbackSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricinglookbackSeries::scale(self : FinancepricinglookbackSeries, f : Double) -> FinancepricinglookbackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricinglookbackSeries::add(self : FinancepricinglookbackSeries, other : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricinglookbackSeries::sub(self : FinancepricinglookbackSeries, other : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricinglookbackSeries::normalize(self : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricinglookbackSeries::cumsum(self : FinancepricinglookbackSeries) -> FinancepricinglookbackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricinglookbackSeries::to_string(self : FinancepricinglookbackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricinglookbackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_lookback_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricinglookbackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_lookback_matrix_identity(n : Int) -> FinancepricinglookbackMatrix {
  let m = finance_pricing_lookback_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricinglookbackMatrix::get(self : FinancepricinglookbackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricinglookbackMatrix::transpose(self : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  let result = finance_pricing_lookback_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricinglookbackMatrix::add(self : FinancepricinglookbackMatrix, other : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_lookback_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricinglookbackMatrix::scale(self : FinancepricinglookbackMatrix, s : Double) -> FinancepricinglookbackMatrix {
  let result = finance_pricing_lookback_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricinglookbackMatrix::multiply(self : FinancepricinglookbackMatrix, other : FinancepricinglookbackMatrix) -> FinancepricinglookbackMatrix {
  if self.cols != other.rows { return finance_pricing_lookback_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_lookback_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricinglookbackMatrix::trace(self : FinancepricinglookbackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricinglookbackMatrix::det(self : FinancepricinglookbackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricinglookbackMatrix::norm(self : FinancepricinglookbackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricinglookbackMatrix::to_string(self : FinancepricinglookbackMatrix) -> String {
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

pub(all) struct FinancepricinglookbackVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_lookback_make_vector(comps : Array[Double]) -> FinancepricinglookbackVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_lookback_vector_zero(dim : Int) -> FinancepricinglookbackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricinglookbackVector::add(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricinglookbackVector::sub(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricinglookbackVector::scale(self : FinancepricinglookbackVector, s : Double) -> FinancepricinglookbackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricinglookbackVector::dot(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricinglookbackVector::norm(self : FinancepricinglookbackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricinglookbackVector::normalize(self : FinancepricinglookbackVector) -> FinancepricinglookbackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricinglookbackVector::dist(self : FinancepricinglookbackVector, other : FinancepricinglookbackVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricinglookbackVector::to_string(self : FinancepricinglookbackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_lookback_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_lookback_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_lookback_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_lookback_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_lookback_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_lookback_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_lookback_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_lookback_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_lookback_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_lookback_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_lookback_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_lookback_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_lookback_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_lookback_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_lookback_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_lookback_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_lookback_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_lookback_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_lookback_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_lookback_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_lookback_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_lookback_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_lookback_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_lookback_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_lookback_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_lookback_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_lookback_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_lookback_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_lookback_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricinglookbackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_frame_make(size : Int) -> FinancepricinglookbackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_frame_len(s : FinancepricinglookbackFrame) -> Int { s.size }

pub fn finance_pricing_lookback_frame_get(s : FinancepricinglookbackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_frame_set(s : FinancepricinglookbackFrame, i : Int, v : Double) -> FinancepricinglookbackFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_frame_sum(s : FinancepricinglookbackFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_frame_mean(s : FinancepricinglookbackFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_frame_scale(s : FinancepricinglookbackFrame, f : Double) -> FinancepricinglookbackFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_frame_add(a : FinancepricinglookbackFrame, b : FinancepricinglookbackFrame) -> FinancepricinglookbackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_frame_copy(s : FinancepricinglookbackFrame) -> FinancepricinglookbackFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_frame_fill(s : FinancepricinglookbackFrame, v : Double) -> FinancepricinglookbackFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_frame_min(s : FinancepricinglookbackFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_frame_max(s : FinancepricinglookbackFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_frame_to_string(s : FinancepricinglookbackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_table_make(size : Int) -> FinancepricinglookbackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_table_len(s : FinancepricinglookbackTable) -> Int { s.size }

pub fn finance_pricing_lookback_table_get(s : FinancepricinglookbackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_table_set(s : FinancepricinglookbackTable, i : Int, v : Double) -> FinancepricinglookbackTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_table_sum(s : FinancepricinglookbackTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_table_mean(s : FinancepricinglookbackTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_table_scale(s : FinancepricinglookbackTable, f : Double) -> FinancepricinglookbackTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_table_add(a : FinancepricinglookbackTable, b : FinancepricinglookbackTable) -> FinancepricinglookbackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_table_copy(s : FinancepricinglookbackTable) -> FinancepricinglookbackTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_table_fill(s : FinancepricinglookbackTable, v : Double) -> FinancepricinglookbackTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_table_min(s : FinancepricinglookbackTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_table_max(s : FinancepricinglookbackTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_table_to_string(s : FinancepricinglookbackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_graphn_make(size : Int) -> FinancepricinglookbackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_graphn_len(s : FinancepricinglookbackGraphN) -> Int { s.size }

pub fn finance_pricing_lookback_graphn_get(s : FinancepricinglookbackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_graphn_set(s : FinancepricinglookbackGraphN, i : Int, v : Double) -> FinancepricinglookbackGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_graphn_sum(s : FinancepricinglookbackGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_graphn_mean(s : FinancepricinglookbackGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_graphn_scale(s : FinancepricinglookbackGraphN, f : Double) -> FinancepricinglookbackGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_graphn_add(a : FinancepricinglookbackGraphN, b : FinancepricinglookbackGraphN) -> FinancepricinglookbackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_graphn_copy(s : FinancepricinglookbackGraphN) -> FinancepricinglookbackGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_graphn_fill(s : FinancepricinglookbackGraphN, v : Double) -> FinancepricinglookbackGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_graphn_min(s : FinancepricinglookbackGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_graphn_max(s : FinancepricinglookbackGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_graphn_to_string(s : FinancepricinglookbackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_node_make(size : Int) -> FinancepricinglookbackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_node_len(s : FinancepricinglookbackNode) -> Int { s.size }

pub fn finance_pricing_lookback_node_get(s : FinancepricinglookbackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_node_set(s : FinancepricinglookbackNode, i : Int, v : Double) -> FinancepricinglookbackNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_node_sum(s : FinancepricinglookbackNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_node_mean(s : FinancepricinglookbackNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_node_scale(s : FinancepricinglookbackNode, f : Double) -> FinancepricinglookbackNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_node_add(a : FinancepricinglookbackNode, b : FinancepricinglookbackNode) -> FinancepricinglookbackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_node_copy(s : FinancepricinglookbackNode) -> FinancepricinglookbackNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_node_fill(s : FinancepricinglookbackNode, v : Double) -> FinancepricinglookbackNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_node_min(s : FinancepricinglookbackNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_node_max(s : FinancepricinglookbackNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_node_to_string(s : FinancepricinglookbackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_edge_make(size : Int) -> FinancepricinglookbackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_edge_len(s : FinancepricinglookbackEdge) -> Int { s.size }

pub fn finance_pricing_lookback_edge_get(s : FinancepricinglookbackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_edge_set(s : FinancepricinglookbackEdge, i : Int, v : Double) -> FinancepricinglookbackEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_edge_sum(s : FinancepricinglookbackEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_edge_mean(s : FinancepricinglookbackEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_edge_scale(s : FinancepricinglookbackEdge, f : Double) -> FinancepricinglookbackEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_edge_add(a : FinancepricinglookbackEdge, b : FinancepricinglookbackEdge) -> FinancepricinglookbackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_edge_copy(s : FinancepricinglookbackEdge) -> FinancepricinglookbackEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_edge_fill(s : FinancepricinglookbackEdge, v : Double) -> FinancepricinglookbackEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_edge_min(s : FinancepricinglookbackEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_edge_max(s : FinancepricinglookbackEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_edge_to_string(s : FinancepricinglookbackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_path_make(size : Int) -> FinancepricinglookbackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_path_len(s : FinancepricinglookbackPath) -> Int { s.size }

pub fn finance_pricing_lookback_path_get(s : FinancepricinglookbackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_path_set(s : FinancepricinglookbackPath, i : Int, v : Double) -> FinancepricinglookbackPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_path_sum(s : FinancepricinglookbackPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_path_mean(s : FinancepricinglookbackPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_path_scale(s : FinancepricinglookbackPath, f : Double) -> FinancepricinglookbackPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_path_add(a : FinancepricinglookbackPath, b : FinancepricinglookbackPath) -> FinancepricinglookbackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_path_copy(s : FinancepricinglookbackPath) -> FinancepricinglookbackPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_path_fill(s : FinancepricinglookbackPath, v : Double) -> FinancepricinglookbackPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_path_min(s : FinancepricinglookbackPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_path_max(s : FinancepricinglookbackPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_path_to_string(s : FinancepricinglookbackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_cluster_make(size : Int) -> FinancepricinglookbackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_cluster_len(s : FinancepricinglookbackCluster) -> Int { s.size }

pub fn finance_pricing_lookback_cluster_get(s : FinancepricinglookbackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_cluster_set(s : FinancepricinglookbackCluster, i : Int, v : Double) -> FinancepricinglookbackCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cluster_sum(s : FinancepricinglookbackCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_cluster_mean(s : FinancepricinglookbackCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_cluster_scale(s : FinancepricinglookbackCluster, f : Double) -> FinancepricinglookbackCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cluster_add(a : FinancepricinglookbackCluster, b : FinancepricinglookbackCluster) -> FinancepricinglookbackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_cluster_copy(s : FinancepricinglookbackCluster) -> FinancepricinglookbackCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cluster_fill(s : FinancepricinglookbackCluster, v : Double) -> FinancepricinglookbackCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cluster_min(s : FinancepricinglookbackCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_cluster_max(s : FinancepricinglookbackCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_cluster_to_string(s : FinancepricinglookbackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_model_make(size : Int) -> FinancepricinglookbackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_model_len(s : FinancepricinglookbackModel) -> Int { s.size }

pub fn finance_pricing_lookback_model_get(s : FinancepricinglookbackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_model_set(s : FinancepricinglookbackModel, i : Int, v : Double) -> FinancepricinglookbackModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_model_sum(s : FinancepricinglookbackModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_model_mean(s : FinancepricinglookbackModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_model_scale(s : FinancepricinglookbackModel, f : Double) -> FinancepricinglookbackModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_model_add(a : FinancepricinglookbackModel, b : FinancepricinglookbackModel) -> FinancepricinglookbackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_model_copy(s : FinancepricinglookbackModel) -> FinancepricinglookbackModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_model_fill(s : FinancepricinglookbackModel, v : Double) -> FinancepricinglookbackModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_model_min(s : FinancepricinglookbackModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_model_max(s : FinancepricinglookbackModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_model_to_string(s : FinancepricinglookbackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_layer_make(size : Int) -> FinancepricinglookbackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_layer_len(s : FinancepricinglookbackLayer) -> Int { s.size }

pub fn finance_pricing_lookback_layer_get(s : FinancepricinglookbackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_layer_set(s : FinancepricinglookbackLayer, i : Int, v : Double) -> FinancepricinglookbackLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_layer_sum(s : FinancepricinglookbackLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_layer_mean(s : FinancepricinglookbackLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_layer_scale(s : FinancepricinglookbackLayer, f : Double) -> FinancepricinglookbackLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_layer_add(a : FinancepricinglookbackLayer, b : FinancepricinglookbackLayer) -> FinancepricinglookbackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_layer_copy(s : FinancepricinglookbackLayer) -> FinancepricinglookbackLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_layer_fill(s : FinancepricinglookbackLayer, v : Double) -> FinancepricinglookbackLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_layer_min(s : FinancepricinglookbackLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_layer_max(s : FinancepricinglookbackLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_layer_to_string(s : FinancepricinglookbackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_buffer_make(size : Int) -> FinancepricinglookbackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_buffer_len(s : FinancepricinglookbackBuffer) -> Int { s.size }

pub fn finance_pricing_lookback_buffer_get(s : FinancepricinglookbackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_buffer_set(s : FinancepricinglookbackBuffer, i : Int, v : Double) -> FinancepricinglookbackBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_buffer_sum(s : FinancepricinglookbackBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_buffer_mean(s : FinancepricinglookbackBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_buffer_scale(s : FinancepricinglookbackBuffer, f : Double) -> FinancepricinglookbackBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_buffer_add(a : FinancepricinglookbackBuffer, b : FinancepricinglookbackBuffer) -> FinancepricinglookbackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_buffer_copy(s : FinancepricinglookbackBuffer) -> FinancepricinglookbackBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_buffer_fill(s : FinancepricinglookbackBuffer, v : Double) -> FinancepricinglookbackBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_buffer_min(s : FinancepricinglookbackBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_buffer_max(s : FinancepricinglookbackBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_buffer_to_string(s : FinancepricinglookbackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_cursor_make(size : Int) -> FinancepricinglookbackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_cursor_len(s : FinancepricinglookbackCursor) -> Int { s.size }

pub fn finance_pricing_lookback_cursor_get(s : FinancepricinglookbackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_cursor_set(s : FinancepricinglookbackCursor, i : Int, v : Double) -> FinancepricinglookbackCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cursor_sum(s : FinancepricinglookbackCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_cursor_mean(s : FinancepricinglookbackCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_cursor_scale(s : FinancepricinglookbackCursor, f : Double) -> FinancepricinglookbackCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cursor_add(a : FinancepricinglookbackCursor, b : FinancepricinglookbackCursor) -> FinancepricinglookbackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_cursor_copy(s : FinancepricinglookbackCursor) -> FinancepricinglookbackCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cursor_fill(s : FinancepricinglookbackCursor, v : Double) -> FinancepricinglookbackCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_cursor_min(s : FinancepricinglookbackCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_cursor_max(s : FinancepricinglookbackCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_cursor_to_string(s : FinancepricinglookbackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_view_make(size : Int) -> FinancepricinglookbackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_view_len(s : FinancepricinglookbackView) -> Int { s.size }

pub fn finance_pricing_lookback_view_get(s : FinancepricinglookbackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_view_set(s : FinancepricinglookbackView, i : Int, v : Double) -> FinancepricinglookbackView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_view_sum(s : FinancepricinglookbackView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_view_mean(s : FinancepricinglookbackView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_view_scale(s : FinancepricinglookbackView, f : Double) -> FinancepricinglookbackView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_view_add(a : FinancepricinglookbackView, b : FinancepricinglookbackView) -> FinancepricinglookbackView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_view_copy(s : FinancepricinglookbackView) -> FinancepricinglookbackView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_view_fill(s : FinancepricinglookbackView, v : Double) -> FinancepricinglookbackView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_view_min(s : FinancepricinglookbackView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_view_max(s : FinancepricinglookbackView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_view_to_string(s : FinancepricinglookbackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_range_make(size : Int) -> FinancepricinglookbackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_range_len(s : FinancepricinglookbackRange) -> Int { s.size }

pub fn finance_pricing_lookback_range_get(s : FinancepricinglookbackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_range_set(s : FinancepricinglookbackRange, i : Int, v : Double) -> FinancepricinglookbackRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_range_sum(s : FinancepricinglookbackRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_range_mean(s : FinancepricinglookbackRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_range_scale(s : FinancepricinglookbackRange, f : Double) -> FinancepricinglookbackRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_range_add(a : FinancepricinglookbackRange, b : FinancepricinglookbackRange) -> FinancepricinglookbackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_range_copy(s : FinancepricinglookbackRange) -> FinancepricinglookbackRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_range_fill(s : FinancepricinglookbackRange, v : Double) -> FinancepricinglookbackRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_range_min(s : FinancepricinglookbackRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_range_max(s : FinancepricinglookbackRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_range_to_string(s : FinancepricinglookbackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricinglookbackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_lookback_slice_make(size : Int) -> FinancepricinglookbackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_lookback_slice_len(s : FinancepricinglookbackSlice) -> Int { s.size }

pub fn finance_pricing_lookback_slice_get(s : FinancepricinglookbackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_lookback_slice_set(s : FinancepricinglookbackSlice, i : Int, v : Double) -> FinancepricinglookbackSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_slice_sum(s : FinancepricinglookbackSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_lookback_slice_mean(s : FinancepricinglookbackSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_lookback_slice_scale(s : FinancepricinglookbackSlice, f : Double) -> FinancepricinglookbackSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_slice_add(a : FinancepricinglookbackSlice, b : FinancepricinglookbackSlice) -> FinancepricinglookbackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_lookback_slice_copy(s : FinancepricinglookbackSlice) -> FinancepricinglookbackSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_slice_fill(s : FinancepricinglookbackSlice, v : Double) -> FinancepricinglookbackSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_lookback_slice_min(s : FinancepricinglookbackSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_lookback_slice_max(s : FinancepricinglookbackSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_lookback_slice_to_string(s : FinancepricinglookbackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

