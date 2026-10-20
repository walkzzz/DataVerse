///===
/// extcore/finance_time_figarch

pub(all) struct FinancetimefigarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_figarch_make_point(x : Double, y : Double) -> FinancetimefigarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_figarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimefigarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimefigarchPoint::x(self : FinancetimefigarchPoint) -> Double { self.x }

pub fn FinancetimefigarchPoint::y(self : FinancetimefigarchPoint) -> Double { self.y }

pub fn FinancetimefigarchPoint::z(self : FinancetimefigarchPoint) -> Double { self.z }

pub fn FinancetimefigarchPoint::label(self : FinancetimefigarchPoint) -> Int { self.label }

pub fn FinancetimefigarchPoint::dist(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimefigarchPoint::add(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimefigarchPoint::sub(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimefigarchPoint::scale(self : FinancetimefigarchPoint, s : Double) -> FinancetimefigarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimefigarchPoint::dot(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimefigarchPoint::cross(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimefigarchPoint::norm(self : FinancetimefigarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimefigarchPoint::normalize(self : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimefigarchPoint::negate(self : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimefigarchPoint::mid(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimefigarchPoint::lerp(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint, t : Double) -> FinancetimefigarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimefigarchPoint::to_string(self : FinancetimefigarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimefigarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_figarch_make_series(vals : Array[Double], name : String) -> FinancetimefigarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimefigarchSeries::len(self : FinancetimefigarchSeries) -> Int { self.vals.length() }

pub fn FinancetimefigarchSeries::sum(self : FinancetimefigarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimefigarchSeries::mean(self : FinancetimefigarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimefigarchSeries::min(self : FinancetimefigarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimefigarchSeries::max(self : FinancetimefigarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimefigarchSeries::range(self : FinancetimefigarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimefigarchSeries::variance(self : FinancetimefigarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimefigarchSeries::std(self : FinancetimefigarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimefigarchSeries::median(self : FinancetimefigarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimefigarchSeries::scale(self : FinancetimefigarchSeries, f : Double) -> FinancetimefigarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimefigarchSeries::add(self : FinancetimefigarchSeries, other : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimefigarchSeries::sub(self : FinancetimefigarchSeries, other : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimefigarchSeries::normalize(self : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimefigarchSeries::cumsum(self : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimefigarchSeries::to_string(self : FinancetimefigarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimefigarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_figarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimefigarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_figarch_matrix_identity(n : Int) -> FinancetimefigarchMatrix {
  let m = finance_time_figarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimefigarchMatrix::get(self : FinancetimefigarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimefigarchMatrix::transpose(self : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimefigarchMatrix::add(self : FinancetimefigarchMatrix, other : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_figarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimefigarchMatrix::scale(self : FinancetimefigarchMatrix, s : Double) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimefigarchMatrix::multiply(self : FinancetimefigarchMatrix, other : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if self.cols != other.rows { return finance_time_figarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_figarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimefigarchMatrix::trace(self : FinancetimefigarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimefigarchMatrix::det(self : FinancetimefigarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimefigarchMatrix::norm(self : FinancetimefigarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimefigarchMatrix::to_string(self : FinancetimefigarchMatrix) -> String {
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

pub(all) struct FinancetimefigarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_figarch_make_vector(comps : Array[Double]) -> FinancetimefigarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_figarch_vector_zero(dim : Int) -> FinancetimefigarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimefigarchVector::add(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimefigarchVector::sub(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimefigarchVector::scale(self : FinancetimefigarchVector, s : Double) -> FinancetimefigarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimefigarchVector::dot(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimefigarchVector::norm(self : FinancetimefigarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimefigarchVector::normalize(self : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimefigarchVector::dist(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimefigarchVector::to_string(self : FinancetimefigarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_figarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_figarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_figarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_figarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_figarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_figarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_figarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_figarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_figarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_figarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_figarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_figarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_figarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_figarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_figarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_figarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_figarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_figarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_figarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_figarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_figarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_figarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_figarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_figarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_figarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_figarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_figarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_figarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_figarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimefigarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_frame_make(size : Int) -> FinancetimefigarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_frame_len(s : FinancetimefigarchFrame) -> Int { s.size }

pub fn finance_time_figarch_frame_get(s : FinancetimefigarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_frame_set(s : FinancetimefigarchFrame, i : Int, v : Double) -> FinancetimefigarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_sum(s : FinancetimefigarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_frame_mean(s : FinancetimefigarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_frame_scale(s : FinancetimefigarchFrame, f : Double) -> FinancetimefigarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_add(a : FinancetimefigarchFrame, b : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_frame_copy(s : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_fill(s : FinancetimefigarchFrame, v : Double) -> FinancetimefigarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_frame_min(s : FinancetimefigarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_frame_max(s : FinancetimefigarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_frame_to_string(s : FinancetimefigarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_table_make(size : Int) -> FinancetimefigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_table_len(s : FinancetimefigarchTable) -> Int { s.size }

pub fn finance_time_figarch_table_get(s : FinancetimefigarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_table_set(s : FinancetimefigarchTable, i : Int, v : Double) -> FinancetimefigarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_sum(s : FinancetimefigarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_table_mean(s : FinancetimefigarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_table_scale(s : FinancetimefigarchTable, f : Double) -> FinancetimefigarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_add(a : FinancetimefigarchTable, b : FinancetimefigarchTable) -> FinancetimefigarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_table_copy(s : FinancetimefigarchTable) -> FinancetimefigarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_fill(s : FinancetimefigarchTable, v : Double) -> FinancetimefigarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_table_min(s : FinancetimefigarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_table_max(s : FinancetimefigarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_table_to_string(s : FinancetimefigarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_graphn_make(size : Int) -> FinancetimefigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_graphn_len(s : FinancetimefigarchGraphN) -> Int { s.size }

pub fn finance_time_figarch_graphn_get(s : FinancetimefigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_graphn_set(s : FinancetimefigarchGraphN, i : Int, v : Double) -> FinancetimefigarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_sum(s : FinancetimefigarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_graphn_mean(s : FinancetimefigarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_graphn_scale(s : FinancetimefigarchGraphN, f : Double) -> FinancetimefigarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_add(a : FinancetimefigarchGraphN, b : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_graphn_copy(s : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_fill(s : FinancetimefigarchGraphN, v : Double) -> FinancetimefigarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_graphn_min(s : FinancetimefigarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_graphn_max(s : FinancetimefigarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_graphn_to_string(s : FinancetimefigarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_node_make(size : Int) -> FinancetimefigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_node_len(s : FinancetimefigarchNode) -> Int { s.size }

pub fn finance_time_figarch_node_get(s : FinancetimefigarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_node_set(s : FinancetimefigarchNode, i : Int, v : Double) -> FinancetimefigarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_sum(s : FinancetimefigarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_node_mean(s : FinancetimefigarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_node_scale(s : FinancetimefigarchNode, f : Double) -> FinancetimefigarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_add(a : FinancetimefigarchNode, b : FinancetimefigarchNode) -> FinancetimefigarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_node_copy(s : FinancetimefigarchNode) -> FinancetimefigarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_fill(s : FinancetimefigarchNode, v : Double) -> FinancetimefigarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_node_min(s : FinancetimefigarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_node_max(s : FinancetimefigarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_node_to_string(s : FinancetimefigarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_edge_make(size : Int) -> FinancetimefigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_edge_len(s : FinancetimefigarchEdge) -> Int { s.size }

pub fn finance_time_figarch_edge_get(s : FinancetimefigarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_edge_set(s : FinancetimefigarchEdge, i : Int, v : Double) -> FinancetimefigarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_sum(s : FinancetimefigarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_edge_mean(s : FinancetimefigarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_edge_scale(s : FinancetimefigarchEdge, f : Double) -> FinancetimefigarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_add(a : FinancetimefigarchEdge, b : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_edge_copy(s : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_fill(s : FinancetimefigarchEdge, v : Double) -> FinancetimefigarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_edge_min(s : FinancetimefigarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_edge_max(s : FinancetimefigarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_edge_to_string(s : FinancetimefigarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_path_make(size : Int) -> FinancetimefigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_path_len(s : FinancetimefigarchPath) -> Int { s.size }

pub fn finance_time_figarch_path_get(s : FinancetimefigarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_path_set(s : FinancetimefigarchPath, i : Int, v : Double) -> FinancetimefigarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_sum(s : FinancetimefigarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_path_mean(s : FinancetimefigarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_path_scale(s : FinancetimefigarchPath, f : Double) -> FinancetimefigarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_add(a : FinancetimefigarchPath, b : FinancetimefigarchPath) -> FinancetimefigarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_path_copy(s : FinancetimefigarchPath) -> FinancetimefigarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_fill(s : FinancetimefigarchPath, v : Double) -> FinancetimefigarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_path_min(s : FinancetimefigarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_path_max(s : FinancetimefigarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_path_to_string(s : FinancetimefigarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cluster_make(size : Int) -> FinancetimefigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_cluster_len(s : FinancetimefigarchCluster) -> Int { s.size }

pub fn finance_time_figarch_cluster_get(s : FinancetimefigarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_cluster_set(s : FinancetimefigarchCluster, i : Int, v : Double) -> FinancetimefigarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_sum(s : FinancetimefigarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_cluster_mean(s : FinancetimefigarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_cluster_scale(s : FinancetimefigarchCluster, f : Double) -> FinancetimefigarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_add(a : FinancetimefigarchCluster, b : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_cluster_copy(s : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_fill(s : FinancetimefigarchCluster, v : Double) -> FinancetimefigarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cluster_min(s : FinancetimefigarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_cluster_max(s : FinancetimefigarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_cluster_to_string(s : FinancetimefigarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_model_make(size : Int) -> FinancetimefigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_model_len(s : FinancetimefigarchModel) -> Int { s.size }

pub fn finance_time_figarch_model_get(s : FinancetimefigarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_model_set(s : FinancetimefigarchModel, i : Int, v : Double) -> FinancetimefigarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_sum(s : FinancetimefigarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_model_mean(s : FinancetimefigarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_model_scale(s : FinancetimefigarchModel, f : Double) -> FinancetimefigarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_add(a : FinancetimefigarchModel, b : FinancetimefigarchModel) -> FinancetimefigarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_model_copy(s : FinancetimefigarchModel) -> FinancetimefigarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_fill(s : FinancetimefigarchModel, v : Double) -> FinancetimefigarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_model_min(s : FinancetimefigarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_model_max(s : FinancetimefigarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_model_to_string(s : FinancetimefigarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_layer_make(size : Int) -> FinancetimefigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_layer_len(s : FinancetimefigarchLayer) -> Int { s.size }

pub fn finance_time_figarch_layer_get(s : FinancetimefigarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_layer_set(s : FinancetimefigarchLayer, i : Int, v : Double) -> FinancetimefigarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_sum(s : FinancetimefigarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_layer_mean(s : FinancetimefigarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_layer_scale(s : FinancetimefigarchLayer, f : Double) -> FinancetimefigarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_add(a : FinancetimefigarchLayer, b : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_layer_copy(s : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_fill(s : FinancetimefigarchLayer, v : Double) -> FinancetimefigarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_layer_min(s : FinancetimefigarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_layer_max(s : FinancetimefigarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_layer_to_string(s : FinancetimefigarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_buffer_make(size : Int) -> FinancetimefigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_buffer_len(s : FinancetimefigarchBuffer) -> Int { s.size }

pub fn finance_time_figarch_buffer_get(s : FinancetimefigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_buffer_set(s : FinancetimefigarchBuffer, i : Int, v : Double) -> FinancetimefigarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_sum(s : FinancetimefigarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_buffer_mean(s : FinancetimefigarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_buffer_scale(s : FinancetimefigarchBuffer, f : Double) -> FinancetimefigarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_add(a : FinancetimefigarchBuffer, b : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_buffer_copy(s : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_fill(s : FinancetimefigarchBuffer, v : Double) -> FinancetimefigarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_buffer_min(s : FinancetimefigarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_buffer_max(s : FinancetimefigarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_buffer_to_string(s : FinancetimefigarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cursor_make(size : Int) -> FinancetimefigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_cursor_len(s : FinancetimefigarchCursor) -> Int { s.size }

pub fn finance_time_figarch_cursor_get(s : FinancetimefigarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_cursor_set(s : FinancetimefigarchCursor, i : Int, v : Double) -> FinancetimefigarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_sum(s : FinancetimefigarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_cursor_mean(s : FinancetimefigarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_cursor_scale(s : FinancetimefigarchCursor, f : Double) -> FinancetimefigarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_add(a : FinancetimefigarchCursor, b : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_cursor_copy(s : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_fill(s : FinancetimefigarchCursor, v : Double) -> FinancetimefigarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_cursor_min(s : FinancetimefigarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_cursor_max(s : FinancetimefigarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_cursor_to_string(s : FinancetimefigarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_view_make(size : Int) -> FinancetimefigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_view_len(s : FinancetimefigarchView) -> Int { s.size }

pub fn finance_time_figarch_view_get(s : FinancetimefigarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_view_set(s : FinancetimefigarchView, i : Int, v : Double) -> FinancetimefigarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_sum(s : FinancetimefigarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_view_mean(s : FinancetimefigarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_view_scale(s : FinancetimefigarchView, f : Double) -> FinancetimefigarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_add(a : FinancetimefigarchView, b : FinancetimefigarchView) -> FinancetimefigarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_view_copy(s : FinancetimefigarchView) -> FinancetimefigarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_fill(s : FinancetimefigarchView, v : Double) -> FinancetimefigarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_view_min(s : FinancetimefigarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_view_max(s : FinancetimefigarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_view_to_string(s : FinancetimefigarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_range_make(size : Int) -> FinancetimefigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_range_len(s : FinancetimefigarchRange) -> Int { s.size }

pub fn finance_time_figarch_range_get(s : FinancetimefigarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_range_set(s : FinancetimefigarchRange, i : Int, v : Double) -> FinancetimefigarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_sum(s : FinancetimefigarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_range_mean(s : FinancetimefigarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_range_scale(s : FinancetimefigarchRange, f : Double) -> FinancetimefigarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_add(a : FinancetimefigarchRange, b : FinancetimefigarchRange) -> FinancetimefigarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_range_copy(s : FinancetimefigarchRange) -> FinancetimefigarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_fill(s : FinancetimefigarchRange, v : Double) -> FinancetimefigarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_range_min(s : FinancetimefigarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_range_max(s : FinancetimefigarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_range_to_string(s : FinancetimefigarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_slice_make(size : Int) -> FinancetimefigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_figarch_slice_len(s : FinancetimefigarchSlice) -> Int { s.size }

pub fn finance_time_figarch_slice_get(s : FinancetimefigarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_figarch_slice_set(s : FinancetimefigarchSlice, i : Int, v : Double) -> FinancetimefigarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_sum(s : FinancetimefigarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_figarch_slice_mean(s : FinancetimefigarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_figarch_slice_scale(s : FinancetimefigarchSlice, f : Double) -> FinancetimefigarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_add(a : FinancetimefigarchSlice, b : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_figarch_slice_copy(s : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_fill(s : FinancetimefigarchSlice, v : Double) -> FinancetimefigarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_figarch_slice_min(s : FinancetimefigarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_figarch_slice_max(s : FinancetimefigarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_figarch_slice_to_string(s : FinancetimefigarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

