///===
/// extcore/finance_time_mgarch

pub(all) struct FinancetimemgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_mgarch_make_point(x : Double, y : Double) -> FinancetimemgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_mgarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimemgarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimemgarchPoint::x(self : FinancetimemgarchPoint) -> Double { self.x }

pub fn FinancetimemgarchPoint::y(self : FinancetimemgarchPoint) -> Double { self.y }

pub fn FinancetimemgarchPoint::z(self : FinancetimemgarchPoint) -> Double { self.z }

pub fn FinancetimemgarchPoint::label(self : FinancetimemgarchPoint) -> Int { self.label }

pub fn FinancetimemgarchPoint::dist(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimemgarchPoint::add(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimemgarchPoint::sub(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimemgarchPoint::scale(self : FinancetimemgarchPoint, s : Double) -> FinancetimemgarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimemgarchPoint::dot(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimemgarchPoint::cross(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimemgarchPoint::norm(self : FinancetimemgarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimemgarchPoint::normalize(self : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimemgarchPoint::negate(self : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimemgarchPoint::mid(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimemgarchPoint::lerp(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint, t : Double) -> FinancetimemgarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimemgarchPoint::to_string(self : FinancetimemgarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimemgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_mgarch_make_series(vals : Array[Double], name : String) -> FinancetimemgarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimemgarchSeries::len(self : FinancetimemgarchSeries) -> Int { self.vals.length() }

pub fn FinancetimemgarchSeries::sum(self : FinancetimemgarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimemgarchSeries::mean(self : FinancetimemgarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimemgarchSeries::min(self : FinancetimemgarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimemgarchSeries::max(self : FinancetimemgarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimemgarchSeries::range(self : FinancetimemgarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimemgarchSeries::variance(self : FinancetimemgarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimemgarchSeries::std(self : FinancetimemgarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimemgarchSeries::median(self : FinancetimemgarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimemgarchSeries::scale(self : FinancetimemgarchSeries, f : Double) -> FinancetimemgarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimemgarchSeries::add(self : FinancetimemgarchSeries, other : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimemgarchSeries::sub(self : FinancetimemgarchSeries, other : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimemgarchSeries::normalize(self : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimemgarchSeries::cumsum(self : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimemgarchSeries::to_string(self : FinancetimemgarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimemgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_mgarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimemgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_mgarch_matrix_identity(n : Int) -> FinancetimemgarchMatrix {
  let m = finance_time_mgarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimemgarchMatrix::get(self : FinancetimemgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimemgarchMatrix::transpose(self : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  let result = finance_time_mgarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimemgarchMatrix::add(self : FinancetimemgarchMatrix, other : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_mgarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimemgarchMatrix::scale(self : FinancetimemgarchMatrix, s : Double) -> FinancetimemgarchMatrix {
  let result = finance_time_mgarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimemgarchMatrix::multiply(self : FinancetimemgarchMatrix, other : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  if self.cols != other.rows { return finance_time_mgarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_mgarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimemgarchMatrix::trace(self : FinancetimemgarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimemgarchMatrix::det(self : FinancetimemgarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimemgarchMatrix::norm(self : FinancetimemgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimemgarchMatrix::to_string(self : FinancetimemgarchMatrix) -> String {
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

pub(all) struct FinancetimemgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_mgarch_make_vector(comps : Array[Double]) -> FinancetimemgarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_mgarch_vector_zero(dim : Int) -> FinancetimemgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimemgarchVector::add(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimemgarchVector::sub(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimemgarchVector::scale(self : FinancetimemgarchVector, s : Double) -> FinancetimemgarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimemgarchVector::dot(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimemgarchVector::norm(self : FinancetimemgarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimemgarchVector::normalize(self : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimemgarchVector::dist(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimemgarchVector::to_string(self : FinancetimemgarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_mgarch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_mgarch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_mgarch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_mgarch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_mgarch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_mgarch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_mgarch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_mgarch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_mgarch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_mgarch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_mgarch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_mgarch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_mgarch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_mgarch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_mgarch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_mgarch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_mgarch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_mgarch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_mgarch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_mgarch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_mgarch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_mgarch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_mgarch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_mgarch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_mgarch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_mgarch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_mgarch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_mgarch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_mgarch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimemgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_frame_make(size : Int) -> FinancetimemgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_frame_len(s : FinancetimemgarchFrame) -> Int { s.size }

pub fn finance_time_mgarch_frame_get(s : FinancetimemgarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_frame_set(s : FinancetimemgarchFrame, i : Int, v : Double) -> FinancetimemgarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_frame_sum(s : FinancetimemgarchFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_frame_mean(s : FinancetimemgarchFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_frame_scale(s : FinancetimemgarchFrame, f : Double) -> FinancetimemgarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_frame_add(a : FinancetimemgarchFrame, b : FinancetimemgarchFrame) -> FinancetimemgarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_frame_copy(s : FinancetimemgarchFrame) -> FinancetimemgarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_frame_fill(s : FinancetimemgarchFrame, v : Double) -> FinancetimemgarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_frame_min(s : FinancetimemgarchFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_frame_max(s : FinancetimemgarchFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_frame_to_string(s : FinancetimemgarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_table_make(size : Int) -> FinancetimemgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_table_len(s : FinancetimemgarchTable) -> Int { s.size }

pub fn finance_time_mgarch_table_get(s : FinancetimemgarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_table_set(s : FinancetimemgarchTable, i : Int, v : Double) -> FinancetimemgarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_table_sum(s : FinancetimemgarchTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_table_mean(s : FinancetimemgarchTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_table_scale(s : FinancetimemgarchTable, f : Double) -> FinancetimemgarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_table_add(a : FinancetimemgarchTable, b : FinancetimemgarchTable) -> FinancetimemgarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_table_copy(s : FinancetimemgarchTable) -> FinancetimemgarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_table_fill(s : FinancetimemgarchTable, v : Double) -> FinancetimemgarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_table_min(s : FinancetimemgarchTable) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_table_max(s : FinancetimemgarchTable) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_table_to_string(s : FinancetimemgarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_graphn_make(size : Int) -> FinancetimemgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_graphn_len(s : FinancetimemgarchGraphN) -> Int { s.size }

pub fn finance_time_mgarch_graphn_get(s : FinancetimemgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_graphn_set(s : FinancetimemgarchGraphN, i : Int, v : Double) -> FinancetimemgarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_graphn_sum(s : FinancetimemgarchGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_graphn_mean(s : FinancetimemgarchGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_graphn_scale(s : FinancetimemgarchGraphN, f : Double) -> FinancetimemgarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_graphn_add(a : FinancetimemgarchGraphN, b : FinancetimemgarchGraphN) -> FinancetimemgarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_graphn_copy(s : FinancetimemgarchGraphN) -> FinancetimemgarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_graphn_fill(s : FinancetimemgarchGraphN, v : Double) -> FinancetimemgarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_graphn_min(s : FinancetimemgarchGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_graphn_max(s : FinancetimemgarchGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_graphn_to_string(s : FinancetimemgarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_node_make(size : Int) -> FinancetimemgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_node_len(s : FinancetimemgarchNode) -> Int { s.size }

pub fn finance_time_mgarch_node_get(s : FinancetimemgarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_node_set(s : FinancetimemgarchNode, i : Int, v : Double) -> FinancetimemgarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_node_sum(s : FinancetimemgarchNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_node_mean(s : FinancetimemgarchNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_node_scale(s : FinancetimemgarchNode, f : Double) -> FinancetimemgarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_node_add(a : FinancetimemgarchNode, b : FinancetimemgarchNode) -> FinancetimemgarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_node_copy(s : FinancetimemgarchNode) -> FinancetimemgarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_node_fill(s : FinancetimemgarchNode, v : Double) -> FinancetimemgarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_node_min(s : FinancetimemgarchNode) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_node_max(s : FinancetimemgarchNode) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_node_to_string(s : FinancetimemgarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_edge_make(size : Int) -> FinancetimemgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_edge_len(s : FinancetimemgarchEdge) -> Int { s.size }

pub fn finance_time_mgarch_edge_get(s : FinancetimemgarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_edge_set(s : FinancetimemgarchEdge, i : Int, v : Double) -> FinancetimemgarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_edge_sum(s : FinancetimemgarchEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_edge_mean(s : FinancetimemgarchEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_edge_scale(s : FinancetimemgarchEdge, f : Double) -> FinancetimemgarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_edge_add(a : FinancetimemgarchEdge, b : FinancetimemgarchEdge) -> FinancetimemgarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_edge_copy(s : FinancetimemgarchEdge) -> FinancetimemgarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_edge_fill(s : FinancetimemgarchEdge, v : Double) -> FinancetimemgarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_edge_min(s : FinancetimemgarchEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_edge_max(s : FinancetimemgarchEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_edge_to_string(s : FinancetimemgarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_path_make(size : Int) -> FinancetimemgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_path_len(s : FinancetimemgarchPath) -> Int { s.size }

pub fn finance_time_mgarch_path_get(s : FinancetimemgarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_path_set(s : FinancetimemgarchPath, i : Int, v : Double) -> FinancetimemgarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_path_sum(s : FinancetimemgarchPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_path_mean(s : FinancetimemgarchPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_path_scale(s : FinancetimemgarchPath, f : Double) -> FinancetimemgarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_path_add(a : FinancetimemgarchPath, b : FinancetimemgarchPath) -> FinancetimemgarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_path_copy(s : FinancetimemgarchPath) -> FinancetimemgarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_path_fill(s : FinancetimemgarchPath, v : Double) -> FinancetimemgarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_path_min(s : FinancetimemgarchPath) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_path_max(s : FinancetimemgarchPath) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_path_to_string(s : FinancetimemgarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_cluster_make(size : Int) -> FinancetimemgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_cluster_len(s : FinancetimemgarchCluster) -> Int { s.size }

pub fn finance_time_mgarch_cluster_get(s : FinancetimemgarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_cluster_set(s : FinancetimemgarchCluster, i : Int, v : Double) -> FinancetimemgarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cluster_sum(s : FinancetimemgarchCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_cluster_mean(s : FinancetimemgarchCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_cluster_scale(s : FinancetimemgarchCluster, f : Double) -> FinancetimemgarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cluster_add(a : FinancetimemgarchCluster, b : FinancetimemgarchCluster) -> FinancetimemgarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_cluster_copy(s : FinancetimemgarchCluster) -> FinancetimemgarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cluster_fill(s : FinancetimemgarchCluster, v : Double) -> FinancetimemgarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cluster_min(s : FinancetimemgarchCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_cluster_max(s : FinancetimemgarchCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_cluster_to_string(s : FinancetimemgarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_model_make(size : Int) -> FinancetimemgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_model_len(s : FinancetimemgarchModel) -> Int { s.size }

pub fn finance_time_mgarch_model_get(s : FinancetimemgarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_model_set(s : FinancetimemgarchModel, i : Int, v : Double) -> FinancetimemgarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_model_sum(s : FinancetimemgarchModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_model_mean(s : FinancetimemgarchModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_model_scale(s : FinancetimemgarchModel, f : Double) -> FinancetimemgarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_model_add(a : FinancetimemgarchModel, b : FinancetimemgarchModel) -> FinancetimemgarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_model_copy(s : FinancetimemgarchModel) -> FinancetimemgarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_model_fill(s : FinancetimemgarchModel, v : Double) -> FinancetimemgarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_model_min(s : FinancetimemgarchModel) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_model_max(s : FinancetimemgarchModel) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_model_to_string(s : FinancetimemgarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_layer_make(size : Int) -> FinancetimemgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_layer_len(s : FinancetimemgarchLayer) -> Int { s.size }

pub fn finance_time_mgarch_layer_get(s : FinancetimemgarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_layer_set(s : FinancetimemgarchLayer, i : Int, v : Double) -> FinancetimemgarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_layer_sum(s : FinancetimemgarchLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_layer_mean(s : FinancetimemgarchLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_layer_scale(s : FinancetimemgarchLayer, f : Double) -> FinancetimemgarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_layer_add(a : FinancetimemgarchLayer, b : FinancetimemgarchLayer) -> FinancetimemgarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_layer_copy(s : FinancetimemgarchLayer) -> FinancetimemgarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_layer_fill(s : FinancetimemgarchLayer, v : Double) -> FinancetimemgarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_layer_min(s : FinancetimemgarchLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_layer_max(s : FinancetimemgarchLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_layer_to_string(s : FinancetimemgarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_buffer_make(size : Int) -> FinancetimemgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_buffer_len(s : FinancetimemgarchBuffer) -> Int { s.size }

pub fn finance_time_mgarch_buffer_get(s : FinancetimemgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_buffer_set(s : FinancetimemgarchBuffer, i : Int, v : Double) -> FinancetimemgarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_buffer_sum(s : FinancetimemgarchBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_buffer_mean(s : FinancetimemgarchBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_buffer_scale(s : FinancetimemgarchBuffer, f : Double) -> FinancetimemgarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_buffer_add(a : FinancetimemgarchBuffer, b : FinancetimemgarchBuffer) -> FinancetimemgarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_buffer_copy(s : FinancetimemgarchBuffer) -> FinancetimemgarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_buffer_fill(s : FinancetimemgarchBuffer, v : Double) -> FinancetimemgarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_buffer_min(s : FinancetimemgarchBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_buffer_max(s : FinancetimemgarchBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_buffer_to_string(s : FinancetimemgarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_cursor_make(size : Int) -> FinancetimemgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_cursor_len(s : FinancetimemgarchCursor) -> Int { s.size }

pub fn finance_time_mgarch_cursor_get(s : FinancetimemgarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_cursor_set(s : FinancetimemgarchCursor, i : Int, v : Double) -> FinancetimemgarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cursor_sum(s : FinancetimemgarchCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_cursor_mean(s : FinancetimemgarchCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_cursor_scale(s : FinancetimemgarchCursor, f : Double) -> FinancetimemgarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cursor_add(a : FinancetimemgarchCursor, b : FinancetimemgarchCursor) -> FinancetimemgarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_cursor_copy(s : FinancetimemgarchCursor) -> FinancetimemgarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cursor_fill(s : FinancetimemgarchCursor, v : Double) -> FinancetimemgarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_cursor_min(s : FinancetimemgarchCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_cursor_max(s : FinancetimemgarchCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_cursor_to_string(s : FinancetimemgarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_view_make(size : Int) -> FinancetimemgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_view_len(s : FinancetimemgarchView) -> Int { s.size }

pub fn finance_time_mgarch_view_get(s : FinancetimemgarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_view_set(s : FinancetimemgarchView, i : Int, v : Double) -> FinancetimemgarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_view_sum(s : FinancetimemgarchView) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_view_mean(s : FinancetimemgarchView) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_view_scale(s : FinancetimemgarchView, f : Double) -> FinancetimemgarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_view_add(a : FinancetimemgarchView, b : FinancetimemgarchView) -> FinancetimemgarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_view_copy(s : FinancetimemgarchView) -> FinancetimemgarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_view_fill(s : FinancetimemgarchView, v : Double) -> FinancetimemgarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_view_min(s : FinancetimemgarchView) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_view_max(s : FinancetimemgarchView) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_view_to_string(s : FinancetimemgarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_range_make(size : Int) -> FinancetimemgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_range_len(s : FinancetimemgarchRange) -> Int { s.size }

pub fn finance_time_mgarch_range_get(s : FinancetimemgarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_range_set(s : FinancetimemgarchRange, i : Int, v : Double) -> FinancetimemgarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_range_sum(s : FinancetimemgarchRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_range_mean(s : FinancetimemgarchRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_range_scale(s : FinancetimemgarchRange, f : Double) -> FinancetimemgarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_range_add(a : FinancetimemgarchRange, b : FinancetimemgarchRange) -> FinancetimemgarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_range_copy(s : FinancetimemgarchRange) -> FinancetimemgarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_range_fill(s : FinancetimemgarchRange, v : Double) -> FinancetimemgarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_range_min(s : FinancetimemgarchRange) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_range_max(s : FinancetimemgarchRange) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_range_to_string(s : FinancetimemgarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_slice_make(size : Int) -> FinancetimemgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_mgarch_slice_len(s : FinancetimemgarchSlice) -> Int { s.size }

pub fn finance_time_mgarch_slice_get(s : FinancetimemgarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_mgarch_slice_set(s : FinancetimemgarchSlice, i : Int, v : Double) -> FinancetimemgarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_slice_sum(s : FinancetimemgarchSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_mgarch_slice_mean(s : FinancetimemgarchSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_mgarch_slice_scale(s : FinancetimemgarchSlice, f : Double) -> FinancetimemgarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_slice_add(a : FinancetimemgarchSlice, b : FinancetimemgarchSlice) -> FinancetimemgarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_mgarch_slice_copy(s : FinancetimemgarchSlice) -> FinancetimemgarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_slice_fill(s : FinancetimemgarchSlice, v : Double) -> FinancetimemgarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_mgarch_slice_min(s : FinancetimemgarchSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_mgarch_slice_max(s : FinancetimemgarchSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_mgarch_slice_to_string(s : FinancetimemgarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

