///===
/// extcore/finance_time_egarch

pub(all) struct FinancetimeegarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_egarch_make_point(x : Double, y : Double) -> FinancetimeegarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_egarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimeegarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimeegarchPoint::x(self : FinancetimeegarchPoint) -> Double { self.x }

pub fn FinancetimeegarchPoint::y(self : FinancetimeegarchPoint) -> Double { self.y }

pub fn FinancetimeegarchPoint::z(self : FinancetimeegarchPoint) -> Double { self.z }

pub fn FinancetimeegarchPoint::label(self : FinancetimeegarchPoint) -> Int { self.label }

pub fn FinancetimeegarchPoint::dist(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimeegarchPoint::add(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimeegarchPoint::sub(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimeegarchPoint::scale(self : FinancetimeegarchPoint, s : Double) -> FinancetimeegarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimeegarchPoint::dot(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimeegarchPoint::cross(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimeegarchPoint::norm(self : FinancetimeegarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimeegarchPoint::normalize(self : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeegarchPoint::negate(self : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimeegarchPoint::mid(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimeegarchPoint::lerp(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint, t : Double) -> FinancetimeegarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimeegarchPoint::to_string(self : FinancetimeegarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimeegarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_egarch_make_series(vals : Array[Double], name : String) -> FinancetimeegarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimeegarchSeries::len(self : FinancetimeegarchSeries) -> Int { self.vals.length() }

pub fn FinancetimeegarchSeries::sum(self : FinancetimeegarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimeegarchSeries::mean(self : FinancetimeegarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimeegarchSeries::min(self : FinancetimeegarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimeegarchSeries::max(self : FinancetimeegarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimeegarchSeries::range(self : FinancetimeegarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimeegarchSeries::variance(self : FinancetimeegarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimeegarchSeries::std(self : FinancetimeegarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimeegarchSeries::median(self : FinancetimeegarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimeegarchSeries::scale(self : FinancetimeegarchSeries, f : Double) -> FinancetimeegarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimeegarchSeries::add(self : FinancetimeegarchSeries, other : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimeegarchSeries::sub(self : FinancetimeegarchSeries, other : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimeegarchSeries::normalize(self : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimeegarchSeries::cumsum(self : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimeegarchSeries::to_string(self : FinancetimeegarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeegarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_egarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeegarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_egarch_matrix_identity(n : Int) -> FinancetimeegarchMatrix {
  let m = finance_time_egarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimeegarchMatrix::get(self : FinancetimeegarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimeegarchMatrix::transpose(self : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  let result = finance_time_egarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimeegarchMatrix::add(self : FinancetimeegarchMatrix, other : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_egarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimeegarchMatrix::scale(self : FinancetimeegarchMatrix, s : Double) -> FinancetimeegarchMatrix {
  let result = finance_time_egarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimeegarchMatrix::multiply(self : FinancetimeegarchMatrix, other : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  if self.cols != other.rows { return finance_time_egarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_egarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimeegarchMatrix::trace(self : FinancetimeegarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimeegarchMatrix::det(self : FinancetimeegarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimeegarchMatrix::norm(self : FinancetimeegarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimeegarchMatrix::to_string(self : FinancetimeegarchMatrix) -> String {
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

pub(all) struct FinancetimeegarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_egarch_make_vector(comps : Array[Double]) -> FinancetimeegarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_egarch_vector_zero(dim : Int) -> FinancetimeegarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimeegarchVector::add(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeegarchVector::sub(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeegarchVector::scale(self : FinancetimeegarchVector, s : Double) -> FinancetimeegarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimeegarchVector::dot(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimeegarchVector::norm(self : FinancetimeegarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimeegarchVector::normalize(self : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeegarchVector::dist(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimeegarchVector::to_string(self : FinancetimeegarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_egarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_egarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_egarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_egarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_egarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_egarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_egarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_egarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_egarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_egarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_egarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_egarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_egarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_egarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_egarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_egarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_egarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_egarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_egarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_egarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_egarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_egarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_egarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_egarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_egarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_egarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_egarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_egarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_egarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeegarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_frame_make(size : Int) -> FinancetimeegarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_frame_len(s : FinancetimeegarchFrame) -> Int { s.size }

pub fn finance_time_egarch_frame_get(s : FinancetimeegarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_frame_set(s : FinancetimeegarchFrame, i : Int, v : Double) -> FinancetimeegarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_sum(s : FinancetimeegarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_frame_mean(s : FinancetimeegarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_frame_scale(s : FinancetimeegarchFrame, f : Double) -> FinancetimeegarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_add(a : FinancetimeegarchFrame, b : FinancetimeegarchFrame) -> FinancetimeegarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_frame_copy(s : FinancetimeegarchFrame) -> FinancetimeegarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_fill(s : FinancetimeegarchFrame, v : Double) -> FinancetimeegarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_frame_min(s : FinancetimeegarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_frame_max(s : FinancetimeegarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_frame_to_string(s : FinancetimeegarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_table_make(size : Int) -> FinancetimeegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_table_len(s : FinancetimeegarchTable) -> Int { s.size }

pub fn finance_time_egarch_table_get(s : FinancetimeegarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_table_set(s : FinancetimeegarchTable, i : Int, v : Double) -> FinancetimeegarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_sum(s : FinancetimeegarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_table_mean(s : FinancetimeegarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_table_scale(s : FinancetimeegarchTable, f : Double) -> FinancetimeegarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_add(a : FinancetimeegarchTable, b : FinancetimeegarchTable) -> FinancetimeegarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_table_copy(s : FinancetimeegarchTable) -> FinancetimeegarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_fill(s : FinancetimeegarchTable, v : Double) -> FinancetimeegarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_table_min(s : FinancetimeegarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_table_max(s : FinancetimeegarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_table_to_string(s : FinancetimeegarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_graphn_make(size : Int) -> FinancetimeegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_graphn_len(s : FinancetimeegarchGraphN) -> Int { s.size }

pub fn finance_time_egarch_graphn_get(s : FinancetimeegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_graphn_set(s : FinancetimeegarchGraphN, i : Int, v : Double) -> FinancetimeegarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_sum(s : FinancetimeegarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_graphn_mean(s : FinancetimeegarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_graphn_scale(s : FinancetimeegarchGraphN, f : Double) -> FinancetimeegarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_add(a : FinancetimeegarchGraphN, b : FinancetimeegarchGraphN) -> FinancetimeegarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_graphn_copy(s : FinancetimeegarchGraphN) -> FinancetimeegarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_fill(s : FinancetimeegarchGraphN, v : Double) -> FinancetimeegarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_graphn_min(s : FinancetimeegarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_graphn_max(s : FinancetimeegarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_graphn_to_string(s : FinancetimeegarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_node_make(size : Int) -> FinancetimeegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_node_len(s : FinancetimeegarchNode) -> Int { s.size }

pub fn finance_time_egarch_node_get(s : FinancetimeegarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_node_set(s : FinancetimeegarchNode, i : Int, v : Double) -> FinancetimeegarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_sum(s : FinancetimeegarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_node_mean(s : FinancetimeegarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_node_scale(s : FinancetimeegarchNode, f : Double) -> FinancetimeegarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_add(a : FinancetimeegarchNode, b : FinancetimeegarchNode) -> FinancetimeegarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_node_copy(s : FinancetimeegarchNode) -> FinancetimeegarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_fill(s : FinancetimeegarchNode, v : Double) -> FinancetimeegarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_node_min(s : FinancetimeegarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_node_max(s : FinancetimeegarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_node_to_string(s : FinancetimeegarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_edge_make(size : Int) -> FinancetimeegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_edge_len(s : FinancetimeegarchEdge) -> Int { s.size }

pub fn finance_time_egarch_edge_get(s : FinancetimeegarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_edge_set(s : FinancetimeegarchEdge, i : Int, v : Double) -> FinancetimeegarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_sum(s : FinancetimeegarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_edge_mean(s : FinancetimeegarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_edge_scale(s : FinancetimeegarchEdge, f : Double) -> FinancetimeegarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_add(a : FinancetimeegarchEdge, b : FinancetimeegarchEdge) -> FinancetimeegarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_edge_copy(s : FinancetimeegarchEdge) -> FinancetimeegarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_fill(s : FinancetimeegarchEdge, v : Double) -> FinancetimeegarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_edge_min(s : FinancetimeegarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_edge_max(s : FinancetimeegarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_edge_to_string(s : FinancetimeegarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_path_make(size : Int) -> FinancetimeegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_path_len(s : FinancetimeegarchPath) -> Int { s.size }

pub fn finance_time_egarch_path_get(s : FinancetimeegarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_path_set(s : FinancetimeegarchPath, i : Int, v : Double) -> FinancetimeegarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_sum(s : FinancetimeegarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_path_mean(s : FinancetimeegarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_path_scale(s : FinancetimeegarchPath, f : Double) -> FinancetimeegarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_add(a : FinancetimeegarchPath, b : FinancetimeegarchPath) -> FinancetimeegarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_path_copy(s : FinancetimeegarchPath) -> FinancetimeegarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_fill(s : FinancetimeegarchPath, v : Double) -> FinancetimeegarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_path_min(s : FinancetimeegarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_path_max(s : FinancetimeegarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_path_to_string(s : FinancetimeegarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_cluster_make(size : Int) -> FinancetimeegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_cluster_len(s : FinancetimeegarchCluster) -> Int { s.size }

pub fn finance_time_egarch_cluster_get(s : FinancetimeegarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_cluster_set(s : FinancetimeegarchCluster, i : Int, v : Double) -> FinancetimeegarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_sum(s : FinancetimeegarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_cluster_mean(s : FinancetimeegarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_cluster_scale(s : FinancetimeegarchCluster, f : Double) -> FinancetimeegarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_add(a : FinancetimeegarchCluster, b : FinancetimeegarchCluster) -> FinancetimeegarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_cluster_copy(s : FinancetimeegarchCluster) -> FinancetimeegarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_fill(s : FinancetimeegarchCluster, v : Double) -> FinancetimeegarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cluster_min(s : FinancetimeegarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_cluster_max(s : FinancetimeegarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_cluster_to_string(s : FinancetimeegarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_model_make(size : Int) -> FinancetimeegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_model_len(s : FinancetimeegarchModel) -> Int { s.size }

pub fn finance_time_egarch_model_get(s : FinancetimeegarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_model_set(s : FinancetimeegarchModel, i : Int, v : Double) -> FinancetimeegarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_sum(s : FinancetimeegarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_model_mean(s : FinancetimeegarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_model_scale(s : FinancetimeegarchModel, f : Double) -> FinancetimeegarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_add(a : FinancetimeegarchModel, b : FinancetimeegarchModel) -> FinancetimeegarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_model_copy(s : FinancetimeegarchModel) -> FinancetimeegarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_fill(s : FinancetimeegarchModel, v : Double) -> FinancetimeegarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_model_min(s : FinancetimeegarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_model_max(s : FinancetimeegarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_model_to_string(s : FinancetimeegarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_layer_make(size : Int) -> FinancetimeegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_layer_len(s : FinancetimeegarchLayer) -> Int { s.size }

pub fn finance_time_egarch_layer_get(s : FinancetimeegarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_layer_set(s : FinancetimeegarchLayer, i : Int, v : Double) -> FinancetimeegarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_sum(s : FinancetimeegarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_layer_mean(s : FinancetimeegarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_layer_scale(s : FinancetimeegarchLayer, f : Double) -> FinancetimeegarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_add(a : FinancetimeegarchLayer, b : FinancetimeegarchLayer) -> FinancetimeegarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_layer_copy(s : FinancetimeegarchLayer) -> FinancetimeegarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_fill(s : FinancetimeegarchLayer, v : Double) -> FinancetimeegarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_layer_min(s : FinancetimeegarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_layer_max(s : FinancetimeegarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_layer_to_string(s : FinancetimeegarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_buffer_make(size : Int) -> FinancetimeegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_buffer_len(s : FinancetimeegarchBuffer) -> Int { s.size }

pub fn finance_time_egarch_buffer_get(s : FinancetimeegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_buffer_set(s : FinancetimeegarchBuffer, i : Int, v : Double) -> FinancetimeegarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_sum(s : FinancetimeegarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_buffer_mean(s : FinancetimeegarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_buffer_scale(s : FinancetimeegarchBuffer, f : Double) -> FinancetimeegarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_add(a : FinancetimeegarchBuffer, b : FinancetimeegarchBuffer) -> FinancetimeegarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_buffer_copy(s : FinancetimeegarchBuffer) -> FinancetimeegarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_fill(s : FinancetimeegarchBuffer, v : Double) -> FinancetimeegarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_buffer_min(s : FinancetimeegarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_buffer_max(s : FinancetimeegarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_buffer_to_string(s : FinancetimeegarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_cursor_make(size : Int) -> FinancetimeegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_cursor_len(s : FinancetimeegarchCursor) -> Int { s.size }

pub fn finance_time_egarch_cursor_get(s : FinancetimeegarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_cursor_set(s : FinancetimeegarchCursor, i : Int, v : Double) -> FinancetimeegarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_sum(s : FinancetimeegarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_cursor_mean(s : FinancetimeegarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_cursor_scale(s : FinancetimeegarchCursor, f : Double) -> FinancetimeegarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_add(a : FinancetimeegarchCursor, b : FinancetimeegarchCursor) -> FinancetimeegarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_cursor_copy(s : FinancetimeegarchCursor) -> FinancetimeegarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_fill(s : FinancetimeegarchCursor, v : Double) -> FinancetimeegarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_cursor_min(s : FinancetimeegarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_cursor_max(s : FinancetimeegarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_cursor_to_string(s : FinancetimeegarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_view_make(size : Int) -> FinancetimeegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_view_len(s : FinancetimeegarchView) -> Int { s.size }

pub fn finance_time_egarch_view_get(s : FinancetimeegarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_view_set(s : FinancetimeegarchView, i : Int, v : Double) -> FinancetimeegarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_sum(s : FinancetimeegarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_view_mean(s : FinancetimeegarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_view_scale(s : FinancetimeegarchView, f : Double) -> FinancetimeegarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_add(a : FinancetimeegarchView, b : FinancetimeegarchView) -> FinancetimeegarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_view_copy(s : FinancetimeegarchView) -> FinancetimeegarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_fill(s : FinancetimeegarchView, v : Double) -> FinancetimeegarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_view_min(s : FinancetimeegarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_view_max(s : FinancetimeegarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_view_to_string(s : FinancetimeegarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_range_make(size : Int) -> FinancetimeegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_range_len(s : FinancetimeegarchRange) -> Int { s.size }

pub fn finance_time_egarch_range_get(s : FinancetimeegarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_range_set(s : FinancetimeegarchRange, i : Int, v : Double) -> FinancetimeegarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_sum(s : FinancetimeegarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_range_mean(s : FinancetimeegarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_range_scale(s : FinancetimeegarchRange, f : Double) -> FinancetimeegarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_add(a : FinancetimeegarchRange, b : FinancetimeegarchRange) -> FinancetimeegarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_range_copy(s : FinancetimeegarchRange) -> FinancetimeegarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_fill(s : FinancetimeegarchRange, v : Double) -> FinancetimeegarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_range_min(s : FinancetimeegarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_range_max(s : FinancetimeegarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_range_to_string(s : FinancetimeegarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_slice_make(size : Int) -> FinancetimeegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_egarch_slice_len(s : FinancetimeegarchSlice) -> Int { s.size }

pub fn finance_time_egarch_slice_get(s : FinancetimeegarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_egarch_slice_set(s : FinancetimeegarchSlice, i : Int, v : Double) -> FinancetimeegarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_sum(s : FinancetimeegarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_egarch_slice_mean(s : FinancetimeegarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_egarch_slice_scale(s : FinancetimeegarchSlice, f : Double) -> FinancetimeegarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_add(a : FinancetimeegarchSlice, b : FinancetimeegarchSlice) -> FinancetimeegarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_egarch_slice_copy(s : FinancetimeegarchSlice) -> FinancetimeegarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_fill(s : FinancetimeegarchSlice, v : Double) -> FinancetimeegarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_egarch_slice_min(s : FinancetimeegarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_egarch_slice_max(s : FinancetimeegarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_egarch_slice_to_string(s : FinancetimeegarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

