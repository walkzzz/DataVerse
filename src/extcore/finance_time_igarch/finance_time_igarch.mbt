///===
/// extcore/finance_time_igarch

pub(all) struct FinancetimeigarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_igarch_make_point(x : Double, y : Double) -> FinancetimeigarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_igarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimeigarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimeigarchPoint::x(self : FinancetimeigarchPoint) -> Double { self.x }

pub fn FinancetimeigarchPoint::y(self : FinancetimeigarchPoint) -> Double { self.y }

pub fn FinancetimeigarchPoint::z(self : FinancetimeigarchPoint) -> Double { self.z }

pub fn FinancetimeigarchPoint::label(self : FinancetimeigarchPoint) -> Int { self.label }

pub fn FinancetimeigarchPoint::dist(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimeigarchPoint::add(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimeigarchPoint::sub(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimeigarchPoint::scale(self : FinancetimeigarchPoint, s : Double) -> FinancetimeigarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimeigarchPoint::dot(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimeigarchPoint::cross(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimeigarchPoint::norm(self : FinancetimeigarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimeigarchPoint::normalize(self : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeigarchPoint::negate(self : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimeigarchPoint::mid(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint) -> FinancetimeigarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimeigarchPoint::lerp(self : FinancetimeigarchPoint, other : FinancetimeigarchPoint, t : Double) -> FinancetimeigarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimeigarchPoint::to_string(self : FinancetimeigarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimeigarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_igarch_make_series(vals : Array[Double], name : String) -> FinancetimeigarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimeigarchSeries::len(self : FinancetimeigarchSeries) -> Int { self.vals.length() }

pub fn FinancetimeigarchSeries::sum(self : FinancetimeigarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimeigarchSeries::mean(self : FinancetimeigarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimeigarchSeries::min(self : FinancetimeigarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimeigarchSeries::max(self : FinancetimeigarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimeigarchSeries::range(self : FinancetimeigarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimeigarchSeries::variance(self : FinancetimeigarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimeigarchSeries::std(self : FinancetimeigarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimeigarchSeries::median(self : FinancetimeigarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimeigarchSeries::scale(self : FinancetimeigarchSeries, f : Double) -> FinancetimeigarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimeigarchSeries::add(self : FinancetimeigarchSeries, other : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimeigarchSeries::sub(self : FinancetimeigarchSeries, other : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimeigarchSeries::normalize(self : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimeigarchSeries::cumsum(self : FinancetimeigarchSeries) -> FinancetimeigarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimeigarchSeries::to_string(self : FinancetimeigarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeigarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_igarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeigarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_igarch_matrix_identity(n : Int) -> FinancetimeigarchMatrix {
  let m = finance_time_igarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimeigarchMatrix::get(self : FinancetimeigarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimeigarchMatrix::transpose(self : FinancetimeigarchMatrix) -> FinancetimeigarchMatrix {
  let result = finance_time_igarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimeigarchMatrix::add(self : FinancetimeigarchMatrix, other : FinancetimeigarchMatrix) -> FinancetimeigarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_igarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimeigarchMatrix::scale(self : FinancetimeigarchMatrix, s : Double) -> FinancetimeigarchMatrix {
  let result = finance_time_igarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimeigarchMatrix::multiply(self : FinancetimeigarchMatrix, other : FinancetimeigarchMatrix) -> FinancetimeigarchMatrix {
  if self.cols != other.rows { return finance_time_igarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_igarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimeigarchMatrix::trace(self : FinancetimeigarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimeigarchMatrix::det(self : FinancetimeigarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimeigarchMatrix::norm(self : FinancetimeigarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimeigarchMatrix::to_string(self : FinancetimeigarchMatrix) -> String {
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

pub(all) struct FinancetimeigarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_igarch_make_vector(comps : Array[Double]) -> FinancetimeigarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_igarch_vector_zero(dim : Int) -> FinancetimeigarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimeigarchVector::add(self : FinancetimeigarchVector, other : FinancetimeigarchVector) -> FinancetimeigarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeigarchVector::sub(self : FinancetimeigarchVector, other : FinancetimeigarchVector) -> FinancetimeigarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeigarchVector::scale(self : FinancetimeigarchVector, s : Double) -> FinancetimeigarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimeigarchVector::dot(self : FinancetimeigarchVector, other : FinancetimeigarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimeigarchVector::norm(self : FinancetimeigarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimeigarchVector::normalize(self : FinancetimeigarchVector) -> FinancetimeigarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeigarchVector::dist(self : FinancetimeigarchVector, other : FinancetimeigarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimeigarchVector::to_string(self : FinancetimeigarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_igarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_igarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_igarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_igarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_igarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_igarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_igarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_igarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_igarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_igarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_igarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_igarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_igarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_igarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_igarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_igarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_igarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_igarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_igarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_igarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_igarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_igarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_igarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_igarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_igarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_igarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_igarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_igarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_igarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeigarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_frame_make(size : Int) -> FinancetimeigarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_frame_len(s : FinancetimeigarchFrame) -> Int { s.size }

pub fn finance_time_igarch_frame_get(s : FinancetimeigarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_frame_set(s : FinancetimeigarchFrame, i : Int, v : Double) -> FinancetimeigarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_frame_sum(s : FinancetimeigarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_frame_mean(s : FinancetimeigarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_frame_scale(s : FinancetimeigarchFrame, f : Double) -> FinancetimeigarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_frame_add(a : FinancetimeigarchFrame, b : FinancetimeigarchFrame) -> FinancetimeigarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_frame_copy(s : FinancetimeigarchFrame) -> FinancetimeigarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_frame_fill(s : FinancetimeigarchFrame, v : Double) -> FinancetimeigarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_frame_min(s : FinancetimeigarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_frame_max(s : FinancetimeigarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_frame_to_string(s : FinancetimeigarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_table_make(size : Int) -> FinancetimeigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_table_len(s : FinancetimeigarchTable) -> Int { s.size }

pub fn finance_time_igarch_table_get(s : FinancetimeigarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_table_set(s : FinancetimeigarchTable, i : Int, v : Double) -> FinancetimeigarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_table_sum(s : FinancetimeigarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_table_mean(s : FinancetimeigarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_table_scale(s : FinancetimeigarchTable, f : Double) -> FinancetimeigarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_table_add(a : FinancetimeigarchTable, b : FinancetimeigarchTable) -> FinancetimeigarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_table_copy(s : FinancetimeigarchTable) -> FinancetimeigarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_table_fill(s : FinancetimeigarchTable, v : Double) -> FinancetimeigarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_table_min(s : FinancetimeigarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_table_max(s : FinancetimeigarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_table_to_string(s : FinancetimeigarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_graphn_make(size : Int) -> FinancetimeigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_graphn_len(s : FinancetimeigarchGraphN) -> Int { s.size }

pub fn finance_time_igarch_graphn_get(s : FinancetimeigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_graphn_set(s : FinancetimeigarchGraphN, i : Int, v : Double) -> FinancetimeigarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_graphn_sum(s : FinancetimeigarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_graphn_mean(s : FinancetimeigarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_graphn_scale(s : FinancetimeigarchGraphN, f : Double) -> FinancetimeigarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_graphn_add(a : FinancetimeigarchGraphN, b : FinancetimeigarchGraphN) -> FinancetimeigarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_graphn_copy(s : FinancetimeigarchGraphN) -> FinancetimeigarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_graphn_fill(s : FinancetimeigarchGraphN, v : Double) -> FinancetimeigarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_graphn_min(s : FinancetimeigarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_graphn_max(s : FinancetimeigarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_graphn_to_string(s : FinancetimeigarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_node_make(size : Int) -> FinancetimeigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_node_len(s : FinancetimeigarchNode) -> Int { s.size }

pub fn finance_time_igarch_node_get(s : FinancetimeigarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_node_set(s : FinancetimeigarchNode, i : Int, v : Double) -> FinancetimeigarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_node_sum(s : FinancetimeigarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_node_mean(s : FinancetimeigarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_node_scale(s : FinancetimeigarchNode, f : Double) -> FinancetimeigarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_node_add(a : FinancetimeigarchNode, b : FinancetimeigarchNode) -> FinancetimeigarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_node_copy(s : FinancetimeigarchNode) -> FinancetimeigarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_node_fill(s : FinancetimeigarchNode, v : Double) -> FinancetimeigarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_node_min(s : FinancetimeigarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_node_max(s : FinancetimeigarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_node_to_string(s : FinancetimeigarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_edge_make(size : Int) -> FinancetimeigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_edge_len(s : FinancetimeigarchEdge) -> Int { s.size }

pub fn finance_time_igarch_edge_get(s : FinancetimeigarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_edge_set(s : FinancetimeigarchEdge, i : Int, v : Double) -> FinancetimeigarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_edge_sum(s : FinancetimeigarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_edge_mean(s : FinancetimeigarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_edge_scale(s : FinancetimeigarchEdge, f : Double) -> FinancetimeigarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_edge_add(a : FinancetimeigarchEdge, b : FinancetimeigarchEdge) -> FinancetimeigarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_edge_copy(s : FinancetimeigarchEdge) -> FinancetimeigarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_edge_fill(s : FinancetimeigarchEdge, v : Double) -> FinancetimeigarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_edge_min(s : FinancetimeigarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_edge_max(s : FinancetimeigarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_edge_to_string(s : FinancetimeigarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_path_make(size : Int) -> FinancetimeigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_path_len(s : FinancetimeigarchPath) -> Int { s.size }

pub fn finance_time_igarch_path_get(s : FinancetimeigarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_path_set(s : FinancetimeigarchPath, i : Int, v : Double) -> FinancetimeigarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_path_sum(s : FinancetimeigarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_path_mean(s : FinancetimeigarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_path_scale(s : FinancetimeigarchPath, f : Double) -> FinancetimeigarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_path_add(a : FinancetimeigarchPath, b : FinancetimeigarchPath) -> FinancetimeigarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_path_copy(s : FinancetimeigarchPath) -> FinancetimeigarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_path_fill(s : FinancetimeigarchPath, v : Double) -> FinancetimeigarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_path_min(s : FinancetimeigarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_path_max(s : FinancetimeigarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_path_to_string(s : FinancetimeigarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_cluster_make(size : Int) -> FinancetimeigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_cluster_len(s : FinancetimeigarchCluster) -> Int { s.size }

pub fn finance_time_igarch_cluster_get(s : FinancetimeigarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_cluster_set(s : FinancetimeigarchCluster, i : Int, v : Double) -> FinancetimeigarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cluster_sum(s : FinancetimeigarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_cluster_mean(s : FinancetimeigarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_cluster_scale(s : FinancetimeigarchCluster, f : Double) -> FinancetimeigarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cluster_add(a : FinancetimeigarchCluster, b : FinancetimeigarchCluster) -> FinancetimeigarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_cluster_copy(s : FinancetimeigarchCluster) -> FinancetimeigarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cluster_fill(s : FinancetimeigarchCluster, v : Double) -> FinancetimeigarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cluster_min(s : FinancetimeigarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_cluster_max(s : FinancetimeigarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_cluster_to_string(s : FinancetimeigarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_model_make(size : Int) -> FinancetimeigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_model_len(s : FinancetimeigarchModel) -> Int { s.size }

pub fn finance_time_igarch_model_get(s : FinancetimeigarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_model_set(s : FinancetimeigarchModel, i : Int, v : Double) -> FinancetimeigarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_model_sum(s : FinancetimeigarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_model_mean(s : FinancetimeigarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_model_scale(s : FinancetimeigarchModel, f : Double) -> FinancetimeigarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_model_add(a : FinancetimeigarchModel, b : FinancetimeigarchModel) -> FinancetimeigarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_model_copy(s : FinancetimeigarchModel) -> FinancetimeigarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_model_fill(s : FinancetimeigarchModel, v : Double) -> FinancetimeigarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_model_min(s : FinancetimeigarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_model_max(s : FinancetimeigarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_model_to_string(s : FinancetimeigarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_layer_make(size : Int) -> FinancetimeigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_layer_len(s : FinancetimeigarchLayer) -> Int { s.size }

pub fn finance_time_igarch_layer_get(s : FinancetimeigarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_layer_set(s : FinancetimeigarchLayer, i : Int, v : Double) -> FinancetimeigarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_layer_sum(s : FinancetimeigarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_layer_mean(s : FinancetimeigarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_layer_scale(s : FinancetimeigarchLayer, f : Double) -> FinancetimeigarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_layer_add(a : FinancetimeigarchLayer, b : FinancetimeigarchLayer) -> FinancetimeigarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_layer_copy(s : FinancetimeigarchLayer) -> FinancetimeigarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_layer_fill(s : FinancetimeigarchLayer, v : Double) -> FinancetimeigarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_layer_min(s : FinancetimeigarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_layer_max(s : FinancetimeigarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_layer_to_string(s : FinancetimeigarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_buffer_make(size : Int) -> FinancetimeigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_buffer_len(s : FinancetimeigarchBuffer) -> Int { s.size }

pub fn finance_time_igarch_buffer_get(s : FinancetimeigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_buffer_set(s : FinancetimeigarchBuffer, i : Int, v : Double) -> FinancetimeigarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_buffer_sum(s : FinancetimeigarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_buffer_mean(s : FinancetimeigarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_buffer_scale(s : FinancetimeigarchBuffer, f : Double) -> FinancetimeigarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_buffer_add(a : FinancetimeigarchBuffer, b : FinancetimeigarchBuffer) -> FinancetimeigarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_buffer_copy(s : FinancetimeigarchBuffer) -> FinancetimeigarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_buffer_fill(s : FinancetimeigarchBuffer, v : Double) -> FinancetimeigarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_buffer_min(s : FinancetimeigarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_buffer_max(s : FinancetimeigarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_buffer_to_string(s : FinancetimeigarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_cursor_make(size : Int) -> FinancetimeigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_cursor_len(s : FinancetimeigarchCursor) -> Int { s.size }

pub fn finance_time_igarch_cursor_get(s : FinancetimeigarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_cursor_set(s : FinancetimeigarchCursor, i : Int, v : Double) -> FinancetimeigarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cursor_sum(s : FinancetimeigarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_cursor_mean(s : FinancetimeigarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_cursor_scale(s : FinancetimeigarchCursor, f : Double) -> FinancetimeigarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cursor_add(a : FinancetimeigarchCursor, b : FinancetimeigarchCursor) -> FinancetimeigarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_cursor_copy(s : FinancetimeigarchCursor) -> FinancetimeigarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cursor_fill(s : FinancetimeigarchCursor, v : Double) -> FinancetimeigarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_cursor_min(s : FinancetimeigarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_cursor_max(s : FinancetimeigarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_cursor_to_string(s : FinancetimeigarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_view_make(size : Int) -> FinancetimeigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_view_len(s : FinancetimeigarchView) -> Int { s.size }

pub fn finance_time_igarch_view_get(s : FinancetimeigarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_view_set(s : FinancetimeigarchView, i : Int, v : Double) -> FinancetimeigarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_view_sum(s : FinancetimeigarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_view_mean(s : FinancetimeigarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_view_scale(s : FinancetimeigarchView, f : Double) -> FinancetimeigarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_view_add(a : FinancetimeigarchView, b : FinancetimeigarchView) -> FinancetimeigarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_view_copy(s : FinancetimeigarchView) -> FinancetimeigarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_view_fill(s : FinancetimeigarchView, v : Double) -> FinancetimeigarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_view_min(s : FinancetimeigarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_view_max(s : FinancetimeigarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_view_to_string(s : FinancetimeigarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_range_make(size : Int) -> FinancetimeigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_range_len(s : FinancetimeigarchRange) -> Int { s.size }

pub fn finance_time_igarch_range_get(s : FinancetimeigarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_range_set(s : FinancetimeigarchRange, i : Int, v : Double) -> FinancetimeigarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_range_sum(s : FinancetimeigarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_range_mean(s : FinancetimeigarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_range_scale(s : FinancetimeigarchRange, f : Double) -> FinancetimeigarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_range_add(a : FinancetimeigarchRange, b : FinancetimeigarchRange) -> FinancetimeigarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_range_copy(s : FinancetimeigarchRange) -> FinancetimeigarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_range_fill(s : FinancetimeigarchRange, v : Double) -> FinancetimeigarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_range_min(s : FinancetimeigarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_range_max(s : FinancetimeigarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_range_to_string(s : FinancetimeigarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_slice_make(size : Int) -> FinancetimeigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_igarch_slice_len(s : FinancetimeigarchSlice) -> Int { s.size }

pub fn finance_time_igarch_slice_get(s : FinancetimeigarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_igarch_slice_set(s : FinancetimeigarchSlice, i : Int, v : Double) -> FinancetimeigarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_slice_sum(s : FinancetimeigarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_igarch_slice_mean(s : FinancetimeigarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_igarch_slice_scale(s : FinancetimeigarchSlice, f : Double) -> FinancetimeigarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_slice_add(a : FinancetimeigarchSlice, b : FinancetimeigarchSlice) -> FinancetimeigarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_igarch_slice_copy(s : FinancetimeigarchSlice) -> FinancetimeigarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_slice_fill(s : FinancetimeigarchSlice, v : Double) -> FinancetimeigarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_igarch_slice_min(s : FinancetimeigarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_igarch_slice_max(s : FinancetimeigarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_igarch_slice_to_string(s : FinancetimeigarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

