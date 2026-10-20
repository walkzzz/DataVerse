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

pub fn FinancetimeigarchFrame::len(self : FinancetimeigarchFrame) -> Int { self.size }

pub fn FinancetimeigarchFrame::get(self : FinancetimeigarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchFrame::set(self : FinancetimeigarchFrame, i : Int, v : Double) -> FinancetimeigarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchFrame::sum(self : FinancetimeigarchFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchFrame::mean(self : FinancetimeigarchFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchFrame::scale(self : FinancetimeigarchFrame, f : Double) -> FinancetimeigarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchFrame::add(self : FinancetimeigarchFrame, other : FinancetimeigarchFrame) -> FinancetimeigarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchFrame::copy(self : FinancetimeigarchFrame) -> FinancetimeigarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchFrame::fill(self : FinancetimeigarchFrame, v : Double) -> FinancetimeigarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchFrame::min(self : FinancetimeigarchFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchFrame::max(self : FinancetimeigarchFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchFrame::to_string(self : FinancetimeigarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_table_make(size : Int) -> FinancetimeigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchTable::len(self : FinancetimeigarchTable) -> Int { self.size }

pub fn FinancetimeigarchTable::get(self : FinancetimeigarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchTable::set(self : FinancetimeigarchTable, i : Int, v : Double) -> FinancetimeigarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchTable::sum(self : FinancetimeigarchTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchTable::mean(self : FinancetimeigarchTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchTable::scale(self : FinancetimeigarchTable, f : Double) -> FinancetimeigarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchTable::add(self : FinancetimeigarchTable, other : FinancetimeigarchTable) -> FinancetimeigarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchTable::copy(self : FinancetimeigarchTable) -> FinancetimeigarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchTable::fill(self : FinancetimeigarchTable, v : Double) -> FinancetimeigarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchTable::min(self : FinancetimeigarchTable) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchTable::max(self : FinancetimeigarchTable) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchTable::to_string(self : FinancetimeigarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_graphn_make(size : Int) -> FinancetimeigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchGraphN::len(self : FinancetimeigarchGraphN) -> Int { self.size }

pub fn FinancetimeigarchGraphN::get(self : FinancetimeigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchGraphN::set(self : FinancetimeigarchGraphN, i : Int, v : Double) -> FinancetimeigarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchGraphN::sum(self : FinancetimeigarchGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchGraphN::mean(self : FinancetimeigarchGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchGraphN::scale(self : FinancetimeigarchGraphN, f : Double) -> FinancetimeigarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchGraphN::add(self : FinancetimeigarchGraphN, other : FinancetimeigarchGraphN) -> FinancetimeigarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchGraphN::copy(self : FinancetimeigarchGraphN) -> FinancetimeigarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchGraphN::fill(self : FinancetimeigarchGraphN, v : Double) -> FinancetimeigarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchGraphN::min(self : FinancetimeigarchGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchGraphN::max(self : FinancetimeigarchGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchGraphN::to_string(self : FinancetimeigarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_node_make(size : Int) -> FinancetimeigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchNode::len(self : FinancetimeigarchNode) -> Int { self.size }

pub fn FinancetimeigarchNode::get(self : FinancetimeigarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchNode::set(self : FinancetimeigarchNode, i : Int, v : Double) -> FinancetimeigarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchNode::sum(self : FinancetimeigarchNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchNode::mean(self : FinancetimeigarchNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchNode::scale(self : FinancetimeigarchNode, f : Double) -> FinancetimeigarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchNode::add(self : FinancetimeigarchNode, other : FinancetimeigarchNode) -> FinancetimeigarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchNode::copy(self : FinancetimeigarchNode) -> FinancetimeigarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchNode::fill(self : FinancetimeigarchNode, v : Double) -> FinancetimeigarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchNode::min(self : FinancetimeigarchNode) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchNode::max(self : FinancetimeigarchNode) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchNode::to_string(self : FinancetimeigarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_edge_make(size : Int) -> FinancetimeigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchEdge::len(self : FinancetimeigarchEdge) -> Int { self.size }

pub fn FinancetimeigarchEdge::get(self : FinancetimeigarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchEdge::set(self : FinancetimeigarchEdge, i : Int, v : Double) -> FinancetimeigarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchEdge::sum(self : FinancetimeigarchEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchEdge::mean(self : FinancetimeigarchEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchEdge::scale(self : FinancetimeigarchEdge, f : Double) -> FinancetimeigarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchEdge::add(self : FinancetimeigarchEdge, other : FinancetimeigarchEdge) -> FinancetimeigarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchEdge::copy(self : FinancetimeigarchEdge) -> FinancetimeigarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchEdge::fill(self : FinancetimeigarchEdge, v : Double) -> FinancetimeigarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchEdge::min(self : FinancetimeigarchEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchEdge::max(self : FinancetimeigarchEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchEdge::to_string(self : FinancetimeigarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_path_make(size : Int) -> FinancetimeigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchPath::len(self : FinancetimeigarchPath) -> Int { self.size }

pub fn FinancetimeigarchPath::get(self : FinancetimeigarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchPath::set(self : FinancetimeigarchPath, i : Int, v : Double) -> FinancetimeigarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchPath::sum(self : FinancetimeigarchPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchPath::mean(self : FinancetimeigarchPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchPath::scale(self : FinancetimeigarchPath, f : Double) -> FinancetimeigarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchPath::add(self : FinancetimeigarchPath, other : FinancetimeigarchPath) -> FinancetimeigarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchPath::copy(self : FinancetimeigarchPath) -> FinancetimeigarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchPath::fill(self : FinancetimeigarchPath, v : Double) -> FinancetimeigarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchPath::min(self : FinancetimeigarchPath) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchPath::max(self : FinancetimeigarchPath) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchPath::to_string(self : FinancetimeigarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_cluster_make(size : Int) -> FinancetimeigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchCluster::len(self : FinancetimeigarchCluster) -> Int { self.size }

pub fn FinancetimeigarchCluster::get(self : FinancetimeigarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchCluster::set(self : FinancetimeigarchCluster, i : Int, v : Double) -> FinancetimeigarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCluster::sum(self : FinancetimeigarchCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchCluster::mean(self : FinancetimeigarchCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchCluster::scale(self : FinancetimeigarchCluster, f : Double) -> FinancetimeigarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCluster::add(self : FinancetimeigarchCluster, other : FinancetimeigarchCluster) -> FinancetimeigarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchCluster::copy(self : FinancetimeigarchCluster) -> FinancetimeigarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCluster::fill(self : FinancetimeigarchCluster, v : Double) -> FinancetimeigarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCluster::min(self : FinancetimeigarchCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchCluster::max(self : FinancetimeigarchCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchCluster::to_string(self : FinancetimeigarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_model_make(size : Int) -> FinancetimeigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchModel::len(self : FinancetimeigarchModel) -> Int { self.size }

pub fn FinancetimeigarchModel::get(self : FinancetimeigarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchModel::set(self : FinancetimeigarchModel, i : Int, v : Double) -> FinancetimeigarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchModel::sum(self : FinancetimeigarchModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchModel::mean(self : FinancetimeigarchModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchModel::scale(self : FinancetimeigarchModel, f : Double) -> FinancetimeigarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchModel::add(self : FinancetimeigarchModel, other : FinancetimeigarchModel) -> FinancetimeigarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchModel::copy(self : FinancetimeigarchModel) -> FinancetimeigarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchModel::fill(self : FinancetimeigarchModel, v : Double) -> FinancetimeigarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchModel::min(self : FinancetimeigarchModel) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchModel::max(self : FinancetimeigarchModel) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchModel::to_string(self : FinancetimeigarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_layer_make(size : Int) -> FinancetimeigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchLayer::len(self : FinancetimeigarchLayer) -> Int { self.size }

pub fn FinancetimeigarchLayer::get(self : FinancetimeigarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchLayer::set(self : FinancetimeigarchLayer, i : Int, v : Double) -> FinancetimeigarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchLayer::sum(self : FinancetimeigarchLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchLayer::mean(self : FinancetimeigarchLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchLayer::scale(self : FinancetimeigarchLayer, f : Double) -> FinancetimeigarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchLayer::add(self : FinancetimeigarchLayer, other : FinancetimeigarchLayer) -> FinancetimeigarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchLayer::copy(self : FinancetimeigarchLayer) -> FinancetimeigarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchLayer::fill(self : FinancetimeigarchLayer, v : Double) -> FinancetimeigarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchLayer::min(self : FinancetimeigarchLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchLayer::max(self : FinancetimeigarchLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchLayer::to_string(self : FinancetimeigarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_buffer_make(size : Int) -> FinancetimeigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchBuffer::len(self : FinancetimeigarchBuffer) -> Int { self.size }

pub fn FinancetimeigarchBuffer::get(self : FinancetimeigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchBuffer::set(self : FinancetimeigarchBuffer, i : Int, v : Double) -> FinancetimeigarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchBuffer::sum(self : FinancetimeigarchBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchBuffer::mean(self : FinancetimeigarchBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchBuffer::scale(self : FinancetimeigarchBuffer, f : Double) -> FinancetimeigarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchBuffer::add(self : FinancetimeigarchBuffer, other : FinancetimeigarchBuffer) -> FinancetimeigarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchBuffer::copy(self : FinancetimeigarchBuffer) -> FinancetimeigarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchBuffer::fill(self : FinancetimeigarchBuffer, v : Double) -> FinancetimeigarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchBuffer::min(self : FinancetimeigarchBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchBuffer::max(self : FinancetimeigarchBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchBuffer::to_string(self : FinancetimeigarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_cursor_make(size : Int) -> FinancetimeigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchCursor::len(self : FinancetimeigarchCursor) -> Int { self.size }

pub fn FinancetimeigarchCursor::get(self : FinancetimeigarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchCursor::set(self : FinancetimeigarchCursor, i : Int, v : Double) -> FinancetimeigarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCursor::sum(self : FinancetimeigarchCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchCursor::mean(self : FinancetimeigarchCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchCursor::scale(self : FinancetimeigarchCursor, f : Double) -> FinancetimeigarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCursor::add(self : FinancetimeigarchCursor, other : FinancetimeigarchCursor) -> FinancetimeigarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchCursor::copy(self : FinancetimeigarchCursor) -> FinancetimeigarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCursor::fill(self : FinancetimeigarchCursor, v : Double) -> FinancetimeigarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchCursor::min(self : FinancetimeigarchCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchCursor::max(self : FinancetimeigarchCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchCursor::to_string(self : FinancetimeigarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_view_make(size : Int) -> FinancetimeigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchView::len(self : FinancetimeigarchView) -> Int { self.size }

pub fn FinancetimeigarchView::get(self : FinancetimeigarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchView::set(self : FinancetimeigarchView, i : Int, v : Double) -> FinancetimeigarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchView::sum(self : FinancetimeigarchView) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchView::mean(self : FinancetimeigarchView) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchView::scale(self : FinancetimeigarchView, f : Double) -> FinancetimeigarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchView::add(self : FinancetimeigarchView, other : FinancetimeigarchView) -> FinancetimeigarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchView::copy(self : FinancetimeigarchView) -> FinancetimeigarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchView::fill(self : FinancetimeigarchView, v : Double) -> FinancetimeigarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchView::min(self : FinancetimeigarchView) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchView::max(self : FinancetimeigarchView) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchView::to_string(self : FinancetimeigarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_range_make(size : Int) -> FinancetimeigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchRange::len(self : FinancetimeigarchRange) -> Int { self.size }

pub fn FinancetimeigarchRange::get(self : FinancetimeigarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchRange::set(self : FinancetimeigarchRange, i : Int, v : Double) -> FinancetimeigarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchRange::sum(self : FinancetimeigarchRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchRange::mean(self : FinancetimeigarchRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchRange::scale(self : FinancetimeigarchRange, f : Double) -> FinancetimeigarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchRange::add(self : FinancetimeigarchRange, other : FinancetimeigarchRange) -> FinancetimeigarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchRange::copy(self : FinancetimeigarchRange) -> FinancetimeigarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchRange::fill(self : FinancetimeigarchRange, v : Double) -> FinancetimeigarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchRange::min(self : FinancetimeigarchRange) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchRange::max(self : FinancetimeigarchRange) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchRange::to_string(self : FinancetimeigarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_igarch_slice_make(size : Int) -> FinancetimeigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeigarchSlice::len(self : FinancetimeigarchSlice) -> Int { self.size }

pub fn FinancetimeigarchSlice::get(self : FinancetimeigarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeigarchSlice::set(self : FinancetimeigarchSlice, i : Int, v : Double) -> FinancetimeigarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchSlice::sum(self : FinancetimeigarchSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimeigarchSlice::mean(self : FinancetimeigarchSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimeigarchSlice::scale(self : FinancetimeigarchSlice, f : Double) -> FinancetimeigarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchSlice::add(self : FinancetimeigarchSlice, other : FinancetimeigarchSlice) -> FinancetimeigarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeigarchSlice::copy(self : FinancetimeigarchSlice) -> FinancetimeigarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchSlice::fill(self : FinancetimeigarchSlice, v : Double) -> FinancetimeigarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeigarchSlice::min(self : FinancetimeigarchSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimeigarchSlice::max(self : FinancetimeigarchSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimeigarchSlice::to_string(self : FinancetimeigarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

