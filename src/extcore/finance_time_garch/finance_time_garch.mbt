///===
/// extcore/finance_time_garch

pub(all) struct FinancetimegarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_garch_make_point(x : Double, y : Double) -> FinancetimegarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_garch_make_point3(x : Double, y : Double, z : Double) -> FinancetimegarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimegarchPoint::x(self : FinancetimegarchPoint) -> Double { self.x }

pub fn FinancetimegarchPoint::y(self : FinancetimegarchPoint) -> Double { self.y }

pub fn FinancetimegarchPoint::z(self : FinancetimegarchPoint) -> Double { self.z }

pub fn FinancetimegarchPoint::label(self : FinancetimegarchPoint) -> Int { self.label }

pub fn FinancetimegarchPoint::dist(self : FinancetimegarchPoint, other : FinancetimegarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimegarchPoint::add(self : FinancetimegarchPoint, other : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimegarchPoint::sub(self : FinancetimegarchPoint, other : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimegarchPoint::scale(self : FinancetimegarchPoint, s : Double) -> FinancetimegarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimegarchPoint::dot(self : FinancetimegarchPoint, other : FinancetimegarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimegarchPoint::cross(self : FinancetimegarchPoint, other : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimegarchPoint::norm(self : FinancetimegarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimegarchPoint::normalize(self : FinancetimegarchPoint) -> FinancetimegarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimegarchPoint::negate(self : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimegarchPoint::mid(self : FinancetimegarchPoint, other : FinancetimegarchPoint) -> FinancetimegarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimegarchPoint::lerp(self : FinancetimegarchPoint, other : FinancetimegarchPoint, t : Double) -> FinancetimegarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimegarchPoint::to_string(self : FinancetimegarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimegarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_garch_make_series(vals : Array[Double], name : String) -> FinancetimegarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimegarchSeries::len(self : FinancetimegarchSeries) -> Int { self.vals.length() }

pub fn FinancetimegarchSeries::sum(self : FinancetimegarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimegarchSeries::mean(self : FinancetimegarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimegarchSeries::min(self : FinancetimegarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimegarchSeries::max(self : FinancetimegarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimegarchSeries::range(self : FinancetimegarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimegarchSeries::variance(self : FinancetimegarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimegarchSeries::std(self : FinancetimegarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimegarchSeries::median(self : FinancetimegarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimegarchSeries::scale(self : FinancetimegarchSeries, f : Double) -> FinancetimegarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimegarchSeries::add(self : FinancetimegarchSeries, other : FinancetimegarchSeries) -> FinancetimegarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimegarchSeries::sub(self : FinancetimegarchSeries, other : FinancetimegarchSeries) -> FinancetimegarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimegarchSeries::normalize(self : FinancetimegarchSeries) -> FinancetimegarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimegarchSeries::cumsum(self : FinancetimegarchSeries) -> FinancetimegarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimegarchSeries::to_string(self : FinancetimegarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimegarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_garch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimegarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_garch_matrix_identity(n : Int) -> FinancetimegarchMatrix {
  let m = finance_time_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimegarchMatrix::get(self : FinancetimegarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimegarchMatrix::transpose(self : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  let result = finance_time_garch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimegarchMatrix::add(self : FinancetimegarchMatrix, other : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_garch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimegarchMatrix::scale(self : FinancetimegarchMatrix, s : Double) -> FinancetimegarchMatrix {
  let result = finance_time_garch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimegarchMatrix::multiply(self : FinancetimegarchMatrix, other : FinancetimegarchMatrix) -> FinancetimegarchMatrix {
  if self.cols != other.rows { return finance_time_garch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_garch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimegarchMatrix::trace(self : FinancetimegarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimegarchMatrix::det(self : FinancetimegarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimegarchMatrix::norm(self : FinancetimegarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimegarchMatrix::to_string(self : FinancetimegarchMatrix) -> String {
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

pub(all) struct FinancetimegarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_garch_make_vector(comps : Array[Double]) -> FinancetimegarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_garch_vector_zero(dim : Int) -> FinancetimegarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimegarchVector::add(self : FinancetimegarchVector, other : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimegarchVector::sub(self : FinancetimegarchVector, other : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimegarchVector::scale(self : FinancetimegarchVector, s : Double) -> FinancetimegarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimegarchVector::dot(self : FinancetimegarchVector, other : FinancetimegarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimegarchVector::norm(self : FinancetimegarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimegarchVector::normalize(self : FinancetimegarchVector) -> FinancetimegarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimegarchVector::dist(self : FinancetimegarchVector, other : FinancetimegarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimegarchVector::to_string(self : FinancetimegarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_garch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_garch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_garch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_garch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_garch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_garch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_garch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_garch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_garch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_garch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_garch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_garch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_garch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_garch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_garch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_garch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_garch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_garch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_garch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_garch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_garch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_garch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_garch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_garch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_garch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_garch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_garch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_garch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_garch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimegarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_frame_make(size : Int) -> FinancetimegarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_frame_len(s : FinancetimegarchFrame) -> Int { s.size }

pub fn finance_time_garch_frame_get(s : FinancetimegarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_frame_set(s : FinancetimegarchFrame, i : Int, v : Double) -> FinancetimegarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_frame_sum(s : FinancetimegarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_frame_mean(s : FinancetimegarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_frame_scale(s : FinancetimegarchFrame, f : Double) -> FinancetimegarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_frame_add(a : FinancetimegarchFrame, b : FinancetimegarchFrame) -> FinancetimegarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_frame_copy(s : FinancetimegarchFrame) -> FinancetimegarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_frame_fill(s : FinancetimegarchFrame, v : Double) -> FinancetimegarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_frame_min(s : FinancetimegarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_frame_max(s : FinancetimegarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_frame_to_string(s : FinancetimegarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_table_make(size : Int) -> FinancetimegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_table_len(s : FinancetimegarchTable) -> Int { s.size }

pub fn finance_time_garch_table_get(s : FinancetimegarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_table_set(s : FinancetimegarchTable, i : Int, v : Double) -> FinancetimegarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_table_sum(s : FinancetimegarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_table_mean(s : FinancetimegarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_table_scale(s : FinancetimegarchTable, f : Double) -> FinancetimegarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_table_add(a : FinancetimegarchTable, b : FinancetimegarchTable) -> FinancetimegarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_table_copy(s : FinancetimegarchTable) -> FinancetimegarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_table_fill(s : FinancetimegarchTable, v : Double) -> FinancetimegarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_table_min(s : FinancetimegarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_table_max(s : FinancetimegarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_table_to_string(s : FinancetimegarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_graphn_make(size : Int) -> FinancetimegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_graphn_len(s : FinancetimegarchGraphN) -> Int { s.size }

pub fn finance_time_garch_graphn_get(s : FinancetimegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_graphn_set(s : FinancetimegarchGraphN, i : Int, v : Double) -> FinancetimegarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_graphn_sum(s : FinancetimegarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_graphn_mean(s : FinancetimegarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_graphn_scale(s : FinancetimegarchGraphN, f : Double) -> FinancetimegarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_graphn_add(a : FinancetimegarchGraphN, b : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_graphn_copy(s : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_graphn_fill(s : FinancetimegarchGraphN, v : Double) -> FinancetimegarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_graphn_min(s : FinancetimegarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_graphn_max(s : FinancetimegarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_graphn_to_string(s : FinancetimegarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_node_make(size : Int) -> FinancetimegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_node_len(s : FinancetimegarchNode) -> Int { s.size }

pub fn finance_time_garch_node_get(s : FinancetimegarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_node_set(s : FinancetimegarchNode, i : Int, v : Double) -> FinancetimegarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_node_sum(s : FinancetimegarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_node_mean(s : FinancetimegarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_node_scale(s : FinancetimegarchNode, f : Double) -> FinancetimegarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_node_add(a : FinancetimegarchNode, b : FinancetimegarchNode) -> FinancetimegarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_node_copy(s : FinancetimegarchNode) -> FinancetimegarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_node_fill(s : FinancetimegarchNode, v : Double) -> FinancetimegarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_node_min(s : FinancetimegarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_node_max(s : FinancetimegarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_node_to_string(s : FinancetimegarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_edge_make(size : Int) -> FinancetimegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_edge_len(s : FinancetimegarchEdge) -> Int { s.size }

pub fn finance_time_garch_edge_get(s : FinancetimegarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_edge_set(s : FinancetimegarchEdge, i : Int, v : Double) -> FinancetimegarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_edge_sum(s : FinancetimegarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_edge_mean(s : FinancetimegarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_edge_scale(s : FinancetimegarchEdge, f : Double) -> FinancetimegarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_edge_add(a : FinancetimegarchEdge, b : FinancetimegarchEdge) -> FinancetimegarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_edge_copy(s : FinancetimegarchEdge) -> FinancetimegarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_edge_fill(s : FinancetimegarchEdge, v : Double) -> FinancetimegarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_edge_min(s : FinancetimegarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_edge_max(s : FinancetimegarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_edge_to_string(s : FinancetimegarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_path_make(size : Int) -> FinancetimegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_path_len(s : FinancetimegarchPath) -> Int { s.size }

pub fn finance_time_garch_path_get(s : FinancetimegarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_path_set(s : FinancetimegarchPath, i : Int, v : Double) -> FinancetimegarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_path_sum(s : FinancetimegarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_path_mean(s : FinancetimegarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_path_scale(s : FinancetimegarchPath, f : Double) -> FinancetimegarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_path_add(a : FinancetimegarchPath, b : FinancetimegarchPath) -> FinancetimegarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_path_copy(s : FinancetimegarchPath) -> FinancetimegarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_path_fill(s : FinancetimegarchPath, v : Double) -> FinancetimegarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_path_min(s : FinancetimegarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_path_max(s : FinancetimegarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_path_to_string(s : FinancetimegarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cluster_make(size : Int) -> FinancetimegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_cluster_len(s : FinancetimegarchCluster) -> Int { s.size }

pub fn finance_time_garch_cluster_get(s : FinancetimegarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_cluster_set(s : FinancetimegarchCluster, i : Int, v : Double) -> FinancetimegarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cluster_sum(s : FinancetimegarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_cluster_mean(s : FinancetimegarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_cluster_scale(s : FinancetimegarchCluster, f : Double) -> FinancetimegarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cluster_add(a : FinancetimegarchCluster, b : FinancetimegarchCluster) -> FinancetimegarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_cluster_copy(s : FinancetimegarchCluster) -> FinancetimegarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cluster_fill(s : FinancetimegarchCluster, v : Double) -> FinancetimegarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cluster_min(s : FinancetimegarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_cluster_max(s : FinancetimegarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_cluster_to_string(s : FinancetimegarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_model_make(size : Int) -> FinancetimegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_model_len(s : FinancetimegarchModel) -> Int { s.size }

pub fn finance_time_garch_model_get(s : FinancetimegarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_model_set(s : FinancetimegarchModel, i : Int, v : Double) -> FinancetimegarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_model_sum(s : FinancetimegarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_model_mean(s : FinancetimegarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_model_scale(s : FinancetimegarchModel, f : Double) -> FinancetimegarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_model_add(a : FinancetimegarchModel, b : FinancetimegarchModel) -> FinancetimegarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_model_copy(s : FinancetimegarchModel) -> FinancetimegarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_model_fill(s : FinancetimegarchModel, v : Double) -> FinancetimegarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_model_min(s : FinancetimegarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_model_max(s : FinancetimegarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_model_to_string(s : FinancetimegarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_layer_make(size : Int) -> FinancetimegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_layer_len(s : FinancetimegarchLayer) -> Int { s.size }

pub fn finance_time_garch_layer_get(s : FinancetimegarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_layer_set(s : FinancetimegarchLayer, i : Int, v : Double) -> FinancetimegarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_layer_sum(s : FinancetimegarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_layer_mean(s : FinancetimegarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_layer_scale(s : FinancetimegarchLayer, f : Double) -> FinancetimegarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_layer_add(a : FinancetimegarchLayer, b : FinancetimegarchLayer) -> FinancetimegarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_layer_copy(s : FinancetimegarchLayer) -> FinancetimegarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_layer_fill(s : FinancetimegarchLayer, v : Double) -> FinancetimegarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_layer_min(s : FinancetimegarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_layer_max(s : FinancetimegarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_layer_to_string(s : FinancetimegarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_buffer_make(size : Int) -> FinancetimegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_buffer_len(s : FinancetimegarchBuffer) -> Int { s.size }

pub fn finance_time_garch_buffer_get(s : FinancetimegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_buffer_set(s : FinancetimegarchBuffer, i : Int, v : Double) -> FinancetimegarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_buffer_sum(s : FinancetimegarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_buffer_mean(s : FinancetimegarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_buffer_scale(s : FinancetimegarchBuffer, f : Double) -> FinancetimegarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_buffer_add(a : FinancetimegarchBuffer, b : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_buffer_copy(s : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_buffer_fill(s : FinancetimegarchBuffer, v : Double) -> FinancetimegarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_buffer_min(s : FinancetimegarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_buffer_max(s : FinancetimegarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_buffer_to_string(s : FinancetimegarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cursor_make(size : Int) -> FinancetimegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_cursor_len(s : FinancetimegarchCursor) -> Int { s.size }

pub fn finance_time_garch_cursor_get(s : FinancetimegarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_cursor_set(s : FinancetimegarchCursor, i : Int, v : Double) -> FinancetimegarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cursor_sum(s : FinancetimegarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_cursor_mean(s : FinancetimegarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_cursor_scale(s : FinancetimegarchCursor, f : Double) -> FinancetimegarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cursor_add(a : FinancetimegarchCursor, b : FinancetimegarchCursor) -> FinancetimegarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_cursor_copy(s : FinancetimegarchCursor) -> FinancetimegarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cursor_fill(s : FinancetimegarchCursor, v : Double) -> FinancetimegarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_cursor_min(s : FinancetimegarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_cursor_max(s : FinancetimegarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_cursor_to_string(s : FinancetimegarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_view_make(size : Int) -> FinancetimegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_view_len(s : FinancetimegarchView) -> Int { s.size }

pub fn finance_time_garch_view_get(s : FinancetimegarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_view_set(s : FinancetimegarchView, i : Int, v : Double) -> FinancetimegarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_view_sum(s : FinancetimegarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_view_mean(s : FinancetimegarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_view_scale(s : FinancetimegarchView, f : Double) -> FinancetimegarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_view_add(a : FinancetimegarchView, b : FinancetimegarchView) -> FinancetimegarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_view_copy(s : FinancetimegarchView) -> FinancetimegarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_view_fill(s : FinancetimegarchView, v : Double) -> FinancetimegarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_view_min(s : FinancetimegarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_view_max(s : FinancetimegarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_view_to_string(s : FinancetimegarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_range_make(size : Int) -> FinancetimegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_range_len(s : FinancetimegarchRange) -> Int { s.size }

pub fn finance_time_garch_range_get(s : FinancetimegarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_range_set(s : FinancetimegarchRange, i : Int, v : Double) -> FinancetimegarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_range_sum(s : FinancetimegarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_range_mean(s : FinancetimegarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_range_scale(s : FinancetimegarchRange, f : Double) -> FinancetimegarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_range_add(a : FinancetimegarchRange, b : FinancetimegarchRange) -> FinancetimegarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_range_copy(s : FinancetimegarchRange) -> FinancetimegarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_range_fill(s : FinancetimegarchRange, v : Double) -> FinancetimegarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_range_min(s : FinancetimegarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_range_max(s : FinancetimegarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_range_to_string(s : FinancetimegarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_slice_make(size : Int) -> FinancetimegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_garch_slice_len(s : FinancetimegarchSlice) -> Int { s.size }

pub fn finance_time_garch_slice_get(s : FinancetimegarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_garch_slice_set(s : FinancetimegarchSlice, i : Int, v : Double) -> FinancetimegarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_garch_slice_sum(s : FinancetimegarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_garch_slice_mean(s : FinancetimegarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_garch_slice_scale(s : FinancetimegarchSlice, f : Double) -> FinancetimegarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_slice_add(a : FinancetimegarchSlice, b : FinancetimegarchSlice) -> FinancetimegarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_garch_slice_copy(s : FinancetimegarchSlice) -> FinancetimegarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_slice_fill(s : FinancetimegarchSlice, v : Double) -> FinancetimegarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_garch_slice_min(s : FinancetimegarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_garch_slice_max(s : FinancetimegarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_garch_slice_to_string(s : FinancetimegarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

