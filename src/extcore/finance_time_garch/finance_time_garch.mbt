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

pub fn FinancetimegarchFrame::len(self : FinancetimegarchFrame) -> Int { self.size }

pub fn FinancetimegarchFrame::get(self : FinancetimegarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchFrame::set(self : FinancetimegarchFrame, i : Int, v : Double) -> FinancetimegarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchFrame::sum(self : FinancetimegarchFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchFrame::mean(self : FinancetimegarchFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchFrame::scale(self : FinancetimegarchFrame, f : Double) -> FinancetimegarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchFrame::add(self : FinancetimegarchFrame, other : FinancetimegarchFrame) -> FinancetimegarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchFrame::copy(self : FinancetimegarchFrame) -> FinancetimegarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchFrame::fill(self : FinancetimegarchFrame, v : Double) -> FinancetimegarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchFrame::min(self : FinancetimegarchFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchFrame::max(self : FinancetimegarchFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchFrame::to_string(self : FinancetimegarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_table_make(size : Int) -> FinancetimegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchTable::len(self : FinancetimegarchTable) -> Int { self.size }

pub fn FinancetimegarchTable::get(self : FinancetimegarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchTable::set(self : FinancetimegarchTable, i : Int, v : Double) -> FinancetimegarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchTable::sum(self : FinancetimegarchTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchTable::mean(self : FinancetimegarchTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchTable::scale(self : FinancetimegarchTable, f : Double) -> FinancetimegarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchTable::add(self : FinancetimegarchTable, other : FinancetimegarchTable) -> FinancetimegarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchTable::copy(self : FinancetimegarchTable) -> FinancetimegarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchTable::fill(self : FinancetimegarchTable, v : Double) -> FinancetimegarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchTable::min(self : FinancetimegarchTable) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchTable::max(self : FinancetimegarchTable) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchTable::to_string(self : FinancetimegarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_graphn_make(size : Int) -> FinancetimegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchGraphN::len(self : FinancetimegarchGraphN) -> Int { self.size }

pub fn FinancetimegarchGraphN::get(self : FinancetimegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchGraphN::set(self : FinancetimegarchGraphN, i : Int, v : Double) -> FinancetimegarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchGraphN::sum(self : FinancetimegarchGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchGraphN::mean(self : FinancetimegarchGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchGraphN::scale(self : FinancetimegarchGraphN, f : Double) -> FinancetimegarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchGraphN::add(self : FinancetimegarchGraphN, other : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchGraphN::copy(self : FinancetimegarchGraphN) -> FinancetimegarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchGraphN::fill(self : FinancetimegarchGraphN, v : Double) -> FinancetimegarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchGraphN::min(self : FinancetimegarchGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchGraphN::max(self : FinancetimegarchGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchGraphN::to_string(self : FinancetimegarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_node_make(size : Int) -> FinancetimegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchNode::len(self : FinancetimegarchNode) -> Int { self.size }

pub fn FinancetimegarchNode::get(self : FinancetimegarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchNode::set(self : FinancetimegarchNode, i : Int, v : Double) -> FinancetimegarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchNode::sum(self : FinancetimegarchNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchNode::mean(self : FinancetimegarchNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchNode::scale(self : FinancetimegarchNode, f : Double) -> FinancetimegarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchNode::add(self : FinancetimegarchNode, other : FinancetimegarchNode) -> FinancetimegarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchNode::copy(self : FinancetimegarchNode) -> FinancetimegarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchNode::fill(self : FinancetimegarchNode, v : Double) -> FinancetimegarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchNode::min(self : FinancetimegarchNode) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchNode::max(self : FinancetimegarchNode) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchNode::to_string(self : FinancetimegarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_edge_make(size : Int) -> FinancetimegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchEdge::len(self : FinancetimegarchEdge) -> Int { self.size }

pub fn FinancetimegarchEdge::get(self : FinancetimegarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchEdge::set(self : FinancetimegarchEdge, i : Int, v : Double) -> FinancetimegarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchEdge::sum(self : FinancetimegarchEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchEdge::mean(self : FinancetimegarchEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchEdge::scale(self : FinancetimegarchEdge, f : Double) -> FinancetimegarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchEdge::add(self : FinancetimegarchEdge, other : FinancetimegarchEdge) -> FinancetimegarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchEdge::copy(self : FinancetimegarchEdge) -> FinancetimegarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchEdge::fill(self : FinancetimegarchEdge, v : Double) -> FinancetimegarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchEdge::min(self : FinancetimegarchEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchEdge::max(self : FinancetimegarchEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchEdge::to_string(self : FinancetimegarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_path_make(size : Int) -> FinancetimegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchPath::len(self : FinancetimegarchPath) -> Int { self.size }

pub fn FinancetimegarchPath::get(self : FinancetimegarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchPath::set(self : FinancetimegarchPath, i : Int, v : Double) -> FinancetimegarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchPath::sum(self : FinancetimegarchPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchPath::mean(self : FinancetimegarchPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchPath::scale(self : FinancetimegarchPath, f : Double) -> FinancetimegarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchPath::add(self : FinancetimegarchPath, other : FinancetimegarchPath) -> FinancetimegarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchPath::copy(self : FinancetimegarchPath) -> FinancetimegarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchPath::fill(self : FinancetimegarchPath, v : Double) -> FinancetimegarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchPath::min(self : FinancetimegarchPath) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchPath::max(self : FinancetimegarchPath) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchPath::to_string(self : FinancetimegarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cluster_make(size : Int) -> FinancetimegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchCluster::len(self : FinancetimegarchCluster) -> Int { self.size }

pub fn FinancetimegarchCluster::get(self : FinancetimegarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchCluster::set(self : FinancetimegarchCluster, i : Int, v : Double) -> FinancetimegarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCluster::sum(self : FinancetimegarchCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchCluster::mean(self : FinancetimegarchCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchCluster::scale(self : FinancetimegarchCluster, f : Double) -> FinancetimegarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCluster::add(self : FinancetimegarchCluster, other : FinancetimegarchCluster) -> FinancetimegarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchCluster::copy(self : FinancetimegarchCluster) -> FinancetimegarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCluster::fill(self : FinancetimegarchCluster, v : Double) -> FinancetimegarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCluster::min(self : FinancetimegarchCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchCluster::max(self : FinancetimegarchCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchCluster::to_string(self : FinancetimegarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_model_make(size : Int) -> FinancetimegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchModel::len(self : FinancetimegarchModel) -> Int { self.size }

pub fn FinancetimegarchModel::get(self : FinancetimegarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchModel::set(self : FinancetimegarchModel, i : Int, v : Double) -> FinancetimegarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchModel::sum(self : FinancetimegarchModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchModel::mean(self : FinancetimegarchModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchModel::scale(self : FinancetimegarchModel, f : Double) -> FinancetimegarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchModel::add(self : FinancetimegarchModel, other : FinancetimegarchModel) -> FinancetimegarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchModel::copy(self : FinancetimegarchModel) -> FinancetimegarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchModel::fill(self : FinancetimegarchModel, v : Double) -> FinancetimegarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchModel::min(self : FinancetimegarchModel) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchModel::max(self : FinancetimegarchModel) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchModel::to_string(self : FinancetimegarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_layer_make(size : Int) -> FinancetimegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchLayer::len(self : FinancetimegarchLayer) -> Int { self.size }

pub fn FinancetimegarchLayer::get(self : FinancetimegarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchLayer::set(self : FinancetimegarchLayer, i : Int, v : Double) -> FinancetimegarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchLayer::sum(self : FinancetimegarchLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchLayer::mean(self : FinancetimegarchLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchLayer::scale(self : FinancetimegarchLayer, f : Double) -> FinancetimegarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchLayer::add(self : FinancetimegarchLayer, other : FinancetimegarchLayer) -> FinancetimegarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchLayer::copy(self : FinancetimegarchLayer) -> FinancetimegarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchLayer::fill(self : FinancetimegarchLayer, v : Double) -> FinancetimegarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchLayer::min(self : FinancetimegarchLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchLayer::max(self : FinancetimegarchLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchLayer::to_string(self : FinancetimegarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_buffer_make(size : Int) -> FinancetimegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchBuffer::len(self : FinancetimegarchBuffer) -> Int { self.size }

pub fn FinancetimegarchBuffer::get(self : FinancetimegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchBuffer::set(self : FinancetimegarchBuffer, i : Int, v : Double) -> FinancetimegarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchBuffer::sum(self : FinancetimegarchBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchBuffer::mean(self : FinancetimegarchBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchBuffer::scale(self : FinancetimegarchBuffer, f : Double) -> FinancetimegarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchBuffer::add(self : FinancetimegarchBuffer, other : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchBuffer::copy(self : FinancetimegarchBuffer) -> FinancetimegarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchBuffer::fill(self : FinancetimegarchBuffer, v : Double) -> FinancetimegarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchBuffer::min(self : FinancetimegarchBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchBuffer::max(self : FinancetimegarchBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchBuffer::to_string(self : FinancetimegarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_cursor_make(size : Int) -> FinancetimegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchCursor::len(self : FinancetimegarchCursor) -> Int { self.size }

pub fn FinancetimegarchCursor::get(self : FinancetimegarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchCursor::set(self : FinancetimegarchCursor, i : Int, v : Double) -> FinancetimegarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCursor::sum(self : FinancetimegarchCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchCursor::mean(self : FinancetimegarchCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchCursor::scale(self : FinancetimegarchCursor, f : Double) -> FinancetimegarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCursor::add(self : FinancetimegarchCursor, other : FinancetimegarchCursor) -> FinancetimegarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchCursor::copy(self : FinancetimegarchCursor) -> FinancetimegarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCursor::fill(self : FinancetimegarchCursor, v : Double) -> FinancetimegarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchCursor::min(self : FinancetimegarchCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchCursor::max(self : FinancetimegarchCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchCursor::to_string(self : FinancetimegarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_view_make(size : Int) -> FinancetimegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchView::len(self : FinancetimegarchView) -> Int { self.size }

pub fn FinancetimegarchView::get(self : FinancetimegarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchView::set(self : FinancetimegarchView, i : Int, v : Double) -> FinancetimegarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchView::sum(self : FinancetimegarchView) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchView::mean(self : FinancetimegarchView) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchView::scale(self : FinancetimegarchView, f : Double) -> FinancetimegarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchView::add(self : FinancetimegarchView, other : FinancetimegarchView) -> FinancetimegarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchView::copy(self : FinancetimegarchView) -> FinancetimegarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchView::fill(self : FinancetimegarchView, v : Double) -> FinancetimegarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchView::min(self : FinancetimegarchView) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchView::max(self : FinancetimegarchView) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchView::to_string(self : FinancetimegarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_range_make(size : Int) -> FinancetimegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchRange::len(self : FinancetimegarchRange) -> Int { self.size }

pub fn FinancetimegarchRange::get(self : FinancetimegarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchRange::set(self : FinancetimegarchRange, i : Int, v : Double) -> FinancetimegarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchRange::sum(self : FinancetimegarchRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchRange::mean(self : FinancetimegarchRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchRange::scale(self : FinancetimegarchRange, f : Double) -> FinancetimegarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchRange::add(self : FinancetimegarchRange, other : FinancetimegarchRange) -> FinancetimegarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchRange::copy(self : FinancetimegarchRange) -> FinancetimegarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchRange::fill(self : FinancetimegarchRange, v : Double) -> FinancetimegarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchRange::min(self : FinancetimegarchRange) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchRange::max(self : FinancetimegarchRange) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchRange::to_string(self : FinancetimegarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_garch_slice_make(size : Int) -> FinancetimegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimegarchSlice::len(self : FinancetimegarchSlice) -> Int { self.size }

pub fn FinancetimegarchSlice::get(self : FinancetimegarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimegarchSlice::set(self : FinancetimegarchSlice, i : Int, v : Double) -> FinancetimegarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimegarchSlice::sum(self : FinancetimegarchSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimegarchSlice::mean(self : FinancetimegarchSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimegarchSlice::scale(self : FinancetimegarchSlice, f : Double) -> FinancetimegarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchSlice::add(self : FinancetimegarchSlice, other : FinancetimegarchSlice) -> FinancetimegarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimegarchSlice::copy(self : FinancetimegarchSlice) -> FinancetimegarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchSlice::fill(self : FinancetimegarchSlice, v : Double) -> FinancetimegarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimegarchSlice::min(self : FinancetimegarchSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimegarchSlice::max(self : FinancetimegarchSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimegarchSlice::to_string(self : FinancetimegarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

