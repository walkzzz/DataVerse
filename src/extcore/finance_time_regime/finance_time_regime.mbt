///===
/// extcore/finance_time_regime

pub(all) struct FinancetimeregimePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_regime_make_point(x : Double, y : Double) -> FinancetimeregimePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_regime_make_point3(x : Double, y : Double, z : Double) -> FinancetimeregimePoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimeregimePoint::x(self : FinancetimeregimePoint) -> Double { self.x }

pub fn FinancetimeregimePoint::y(self : FinancetimeregimePoint) -> Double { self.y }

pub fn FinancetimeregimePoint::z(self : FinancetimeregimePoint) -> Double { self.z }

pub fn FinancetimeregimePoint::label(self : FinancetimeregimePoint) -> Int { self.label }

pub fn FinancetimeregimePoint::dist(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimeregimePoint::add(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimeregimePoint::sub(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimeregimePoint::scale(self : FinancetimeregimePoint, s : Double) -> FinancetimeregimePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimeregimePoint::dot(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimeregimePoint::cross(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimeregimePoint::norm(self : FinancetimeregimePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimeregimePoint::normalize(self : FinancetimeregimePoint) -> FinancetimeregimePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeregimePoint::negate(self : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimeregimePoint::mid(self : FinancetimeregimePoint, other : FinancetimeregimePoint) -> FinancetimeregimePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimeregimePoint::lerp(self : FinancetimeregimePoint, other : FinancetimeregimePoint, t : Double) -> FinancetimeregimePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimeregimePoint::to_string(self : FinancetimeregimePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimeregimeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_regime_make_series(vals : Array[Double], name : String) -> FinancetimeregimeSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimeregimeSeries::len(self : FinancetimeregimeSeries) -> Int { self.vals.length() }

pub fn FinancetimeregimeSeries::sum(self : FinancetimeregimeSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimeregimeSeries::mean(self : FinancetimeregimeSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimeregimeSeries::min(self : FinancetimeregimeSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimeregimeSeries::max(self : FinancetimeregimeSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimeregimeSeries::range(self : FinancetimeregimeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimeregimeSeries::variance(self : FinancetimeregimeSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimeregimeSeries::std(self : FinancetimeregimeSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimeregimeSeries::median(self : FinancetimeregimeSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimeregimeSeries::scale(self : FinancetimeregimeSeries, f : Double) -> FinancetimeregimeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimeregimeSeries::add(self : FinancetimeregimeSeries, other : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimeregimeSeries::sub(self : FinancetimeregimeSeries, other : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimeregimeSeries::normalize(self : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimeregimeSeries::cumsum(self : FinancetimeregimeSeries) -> FinancetimeregimeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimeregimeSeries::to_string(self : FinancetimeregimeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeregimeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_regime_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeregimeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_regime_matrix_identity(n : Int) -> FinancetimeregimeMatrix {
  let m = finance_time_regime_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimeregimeMatrix::get(self : FinancetimeregimeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimeregimeMatrix::transpose(self : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  let result = finance_time_regime_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimeregimeMatrix::add(self : FinancetimeregimeMatrix, other : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_regime_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimeregimeMatrix::scale(self : FinancetimeregimeMatrix, s : Double) -> FinancetimeregimeMatrix {
  let result = finance_time_regime_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimeregimeMatrix::multiply(self : FinancetimeregimeMatrix, other : FinancetimeregimeMatrix) -> FinancetimeregimeMatrix {
  if self.cols != other.rows { return finance_time_regime_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_regime_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimeregimeMatrix::trace(self : FinancetimeregimeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimeregimeMatrix::det(self : FinancetimeregimeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimeregimeMatrix::norm(self : FinancetimeregimeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimeregimeMatrix::to_string(self : FinancetimeregimeMatrix) -> String {
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

pub(all) struct FinancetimeregimeVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_regime_make_vector(comps : Array[Double]) -> FinancetimeregimeVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_regime_vector_zero(dim : Int) -> FinancetimeregimeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimeregimeVector::add(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeregimeVector::sub(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeregimeVector::scale(self : FinancetimeregimeVector, s : Double) -> FinancetimeregimeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimeregimeVector::dot(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimeregimeVector::norm(self : FinancetimeregimeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimeregimeVector::normalize(self : FinancetimeregimeVector) -> FinancetimeregimeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeregimeVector::dist(self : FinancetimeregimeVector, other : FinancetimeregimeVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimeregimeVector::to_string(self : FinancetimeregimeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_regime_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_regime_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_regime_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_regime_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_regime_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_regime_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_regime_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_regime_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_regime_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_regime_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_regime_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_regime_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_regime_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_regime_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_regime_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_regime_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_regime_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_regime_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_regime_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_regime_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_regime_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_regime_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_regime_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_regime_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_regime_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_regime_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_regime_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_regime_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_regime_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeregimeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_frame_make(size : Int) -> FinancetimeregimeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_frame_len(s : FinancetimeregimeFrame) -> Int { s.size }

pub fn finance_time_regime_frame_get(s : FinancetimeregimeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_frame_set(s : FinancetimeregimeFrame, i : Int, v : Double) -> FinancetimeregimeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_frame_sum(s : FinancetimeregimeFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_frame_mean(s : FinancetimeregimeFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_frame_scale(s : FinancetimeregimeFrame, f : Double) -> FinancetimeregimeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_frame_add(a : FinancetimeregimeFrame, b : FinancetimeregimeFrame) -> FinancetimeregimeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_frame_copy(s : FinancetimeregimeFrame) -> FinancetimeregimeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_frame_fill(s : FinancetimeregimeFrame, v : Double) -> FinancetimeregimeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_frame_min(s : FinancetimeregimeFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_frame_max(s : FinancetimeregimeFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_frame_to_string(s : FinancetimeregimeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_table_make(size : Int) -> FinancetimeregimeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_table_len(s : FinancetimeregimeTable) -> Int { s.size }

pub fn finance_time_regime_table_get(s : FinancetimeregimeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_table_set(s : FinancetimeregimeTable, i : Int, v : Double) -> FinancetimeregimeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_table_sum(s : FinancetimeregimeTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_table_mean(s : FinancetimeregimeTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_table_scale(s : FinancetimeregimeTable, f : Double) -> FinancetimeregimeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_table_add(a : FinancetimeregimeTable, b : FinancetimeregimeTable) -> FinancetimeregimeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_table_copy(s : FinancetimeregimeTable) -> FinancetimeregimeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_table_fill(s : FinancetimeregimeTable, v : Double) -> FinancetimeregimeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_table_min(s : FinancetimeregimeTable) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_table_max(s : FinancetimeregimeTable) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_table_to_string(s : FinancetimeregimeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_graphn_make(size : Int) -> FinancetimeregimeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_graphn_len(s : FinancetimeregimeGraphN) -> Int { s.size }

pub fn finance_time_regime_graphn_get(s : FinancetimeregimeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_graphn_set(s : FinancetimeregimeGraphN, i : Int, v : Double) -> FinancetimeregimeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_graphn_sum(s : FinancetimeregimeGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_graphn_mean(s : FinancetimeregimeGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_graphn_scale(s : FinancetimeregimeGraphN, f : Double) -> FinancetimeregimeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_graphn_add(a : FinancetimeregimeGraphN, b : FinancetimeregimeGraphN) -> FinancetimeregimeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_graphn_copy(s : FinancetimeregimeGraphN) -> FinancetimeregimeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_graphn_fill(s : FinancetimeregimeGraphN, v : Double) -> FinancetimeregimeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_graphn_min(s : FinancetimeregimeGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_graphn_max(s : FinancetimeregimeGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_graphn_to_string(s : FinancetimeregimeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_node_make(size : Int) -> FinancetimeregimeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_node_len(s : FinancetimeregimeNode) -> Int { s.size }

pub fn finance_time_regime_node_get(s : FinancetimeregimeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_node_set(s : FinancetimeregimeNode, i : Int, v : Double) -> FinancetimeregimeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_node_sum(s : FinancetimeregimeNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_node_mean(s : FinancetimeregimeNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_node_scale(s : FinancetimeregimeNode, f : Double) -> FinancetimeregimeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_node_add(a : FinancetimeregimeNode, b : FinancetimeregimeNode) -> FinancetimeregimeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_node_copy(s : FinancetimeregimeNode) -> FinancetimeregimeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_node_fill(s : FinancetimeregimeNode, v : Double) -> FinancetimeregimeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_node_min(s : FinancetimeregimeNode) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_node_max(s : FinancetimeregimeNode) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_node_to_string(s : FinancetimeregimeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_edge_make(size : Int) -> FinancetimeregimeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_edge_len(s : FinancetimeregimeEdge) -> Int { s.size }

pub fn finance_time_regime_edge_get(s : FinancetimeregimeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_edge_set(s : FinancetimeregimeEdge, i : Int, v : Double) -> FinancetimeregimeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_edge_sum(s : FinancetimeregimeEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_edge_mean(s : FinancetimeregimeEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_edge_scale(s : FinancetimeregimeEdge, f : Double) -> FinancetimeregimeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_edge_add(a : FinancetimeregimeEdge, b : FinancetimeregimeEdge) -> FinancetimeregimeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_edge_copy(s : FinancetimeregimeEdge) -> FinancetimeregimeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_edge_fill(s : FinancetimeregimeEdge, v : Double) -> FinancetimeregimeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_edge_min(s : FinancetimeregimeEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_edge_max(s : FinancetimeregimeEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_edge_to_string(s : FinancetimeregimeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_path_make(size : Int) -> FinancetimeregimePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_path_len(s : FinancetimeregimePath) -> Int { s.size }

pub fn finance_time_regime_path_get(s : FinancetimeregimePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_path_set(s : FinancetimeregimePath, i : Int, v : Double) -> FinancetimeregimePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_path_sum(s : FinancetimeregimePath) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_path_mean(s : FinancetimeregimePath) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_path_scale(s : FinancetimeregimePath, f : Double) -> FinancetimeregimePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_path_add(a : FinancetimeregimePath, b : FinancetimeregimePath) -> FinancetimeregimePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_path_copy(s : FinancetimeregimePath) -> FinancetimeregimePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_path_fill(s : FinancetimeregimePath, v : Double) -> FinancetimeregimePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_path_min(s : FinancetimeregimePath) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_path_max(s : FinancetimeregimePath) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_path_to_string(s : FinancetimeregimePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_cluster_make(size : Int) -> FinancetimeregimeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_cluster_len(s : FinancetimeregimeCluster) -> Int { s.size }

pub fn finance_time_regime_cluster_get(s : FinancetimeregimeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_cluster_set(s : FinancetimeregimeCluster, i : Int, v : Double) -> FinancetimeregimeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cluster_sum(s : FinancetimeregimeCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_cluster_mean(s : FinancetimeregimeCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_cluster_scale(s : FinancetimeregimeCluster, f : Double) -> FinancetimeregimeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cluster_add(a : FinancetimeregimeCluster, b : FinancetimeregimeCluster) -> FinancetimeregimeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_cluster_copy(s : FinancetimeregimeCluster) -> FinancetimeregimeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cluster_fill(s : FinancetimeregimeCluster, v : Double) -> FinancetimeregimeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cluster_min(s : FinancetimeregimeCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_cluster_max(s : FinancetimeregimeCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_cluster_to_string(s : FinancetimeregimeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_model_make(size : Int) -> FinancetimeregimeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_model_len(s : FinancetimeregimeModel) -> Int { s.size }

pub fn finance_time_regime_model_get(s : FinancetimeregimeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_model_set(s : FinancetimeregimeModel, i : Int, v : Double) -> FinancetimeregimeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_model_sum(s : FinancetimeregimeModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_model_mean(s : FinancetimeregimeModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_model_scale(s : FinancetimeregimeModel, f : Double) -> FinancetimeregimeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_model_add(a : FinancetimeregimeModel, b : FinancetimeregimeModel) -> FinancetimeregimeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_model_copy(s : FinancetimeregimeModel) -> FinancetimeregimeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_model_fill(s : FinancetimeregimeModel, v : Double) -> FinancetimeregimeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_model_min(s : FinancetimeregimeModel) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_model_max(s : FinancetimeregimeModel) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_model_to_string(s : FinancetimeregimeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_layer_make(size : Int) -> FinancetimeregimeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_layer_len(s : FinancetimeregimeLayer) -> Int { s.size }

pub fn finance_time_regime_layer_get(s : FinancetimeregimeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_layer_set(s : FinancetimeregimeLayer, i : Int, v : Double) -> FinancetimeregimeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_layer_sum(s : FinancetimeregimeLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_layer_mean(s : FinancetimeregimeLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_layer_scale(s : FinancetimeregimeLayer, f : Double) -> FinancetimeregimeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_layer_add(a : FinancetimeregimeLayer, b : FinancetimeregimeLayer) -> FinancetimeregimeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_layer_copy(s : FinancetimeregimeLayer) -> FinancetimeregimeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_layer_fill(s : FinancetimeregimeLayer, v : Double) -> FinancetimeregimeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_layer_min(s : FinancetimeregimeLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_layer_max(s : FinancetimeregimeLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_layer_to_string(s : FinancetimeregimeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_buffer_make(size : Int) -> FinancetimeregimeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_buffer_len(s : FinancetimeregimeBuffer) -> Int { s.size }

pub fn finance_time_regime_buffer_get(s : FinancetimeregimeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_buffer_set(s : FinancetimeregimeBuffer, i : Int, v : Double) -> FinancetimeregimeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_buffer_sum(s : FinancetimeregimeBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_buffer_mean(s : FinancetimeregimeBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_buffer_scale(s : FinancetimeregimeBuffer, f : Double) -> FinancetimeregimeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_buffer_add(a : FinancetimeregimeBuffer, b : FinancetimeregimeBuffer) -> FinancetimeregimeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_buffer_copy(s : FinancetimeregimeBuffer) -> FinancetimeregimeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_buffer_fill(s : FinancetimeregimeBuffer, v : Double) -> FinancetimeregimeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_buffer_min(s : FinancetimeregimeBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_buffer_max(s : FinancetimeregimeBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_buffer_to_string(s : FinancetimeregimeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_cursor_make(size : Int) -> FinancetimeregimeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_cursor_len(s : FinancetimeregimeCursor) -> Int { s.size }

pub fn finance_time_regime_cursor_get(s : FinancetimeregimeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_cursor_set(s : FinancetimeregimeCursor, i : Int, v : Double) -> FinancetimeregimeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cursor_sum(s : FinancetimeregimeCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_cursor_mean(s : FinancetimeregimeCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_cursor_scale(s : FinancetimeregimeCursor, f : Double) -> FinancetimeregimeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cursor_add(a : FinancetimeregimeCursor, b : FinancetimeregimeCursor) -> FinancetimeregimeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_cursor_copy(s : FinancetimeregimeCursor) -> FinancetimeregimeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cursor_fill(s : FinancetimeregimeCursor, v : Double) -> FinancetimeregimeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_cursor_min(s : FinancetimeregimeCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_cursor_max(s : FinancetimeregimeCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_cursor_to_string(s : FinancetimeregimeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_view_make(size : Int) -> FinancetimeregimeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_view_len(s : FinancetimeregimeView) -> Int { s.size }

pub fn finance_time_regime_view_get(s : FinancetimeregimeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_view_set(s : FinancetimeregimeView, i : Int, v : Double) -> FinancetimeregimeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_view_sum(s : FinancetimeregimeView) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_view_mean(s : FinancetimeregimeView) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_view_scale(s : FinancetimeregimeView, f : Double) -> FinancetimeregimeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_view_add(a : FinancetimeregimeView, b : FinancetimeregimeView) -> FinancetimeregimeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_view_copy(s : FinancetimeregimeView) -> FinancetimeregimeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_view_fill(s : FinancetimeregimeView, v : Double) -> FinancetimeregimeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_view_min(s : FinancetimeregimeView) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_view_max(s : FinancetimeregimeView) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_view_to_string(s : FinancetimeregimeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_range_make(size : Int) -> FinancetimeregimeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_range_len(s : FinancetimeregimeRange) -> Int { s.size }

pub fn finance_time_regime_range_get(s : FinancetimeregimeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_range_set(s : FinancetimeregimeRange, i : Int, v : Double) -> FinancetimeregimeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_range_sum(s : FinancetimeregimeRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_range_mean(s : FinancetimeregimeRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_range_scale(s : FinancetimeregimeRange, f : Double) -> FinancetimeregimeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_range_add(a : FinancetimeregimeRange, b : FinancetimeregimeRange) -> FinancetimeregimeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_range_copy(s : FinancetimeregimeRange) -> FinancetimeregimeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_range_fill(s : FinancetimeregimeRange, v : Double) -> FinancetimeregimeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_range_min(s : FinancetimeregimeRange) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_range_max(s : FinancetimeregimeRange) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_range_to_string(s : FinancetimeregimeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeregimeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_regime_slice_make(size : Int) -> FinancetimeregimeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_regime_slice_len(s : FinancetimeregimeSlice) -> Int { s.size }

pub fn finance_time_regime_slice_get(s : FinancetimeregimeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_regime_slice_set(s : FinancetimeregimeSlice, i : Int, v : Double) -> FinancetimeregimeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_regime_slice_sum(s : FinancetimeregimeSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_regime_slice_mean(s : FinancetimeregimeSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_regime_slice_scale(s : FinancetimeregimeSlice, f : Double) -> FinancetimeregimeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_slice_add(a : FinancetimeregimeSlice, b : FinancetimeregimeSlice) -> FinancetimeregimeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_regime_slice_copy(s : FinancetimeregimeSlice) -> FinancetimeregimeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_slice_fill(s : FinancetimeregimeSlice, v : Double) -> FinancetimeregimeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_regime_slice_min(s : FinancetimeregimeSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_regime_slice_max(s : FinancetimeregimeSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_regime_slice_to_string(s : FinancetimeregimeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

