///===
/// extcore/finance_time_extreme

pub(all) struct FinancetimeextremePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_extreme_make_point(x : Double, y : Double) -> FinancetimeextremePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_extreme_make_point3(x : Double, y : Double, z : Double) -> FinancetimeextremePoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimeextremePoint::x(self : FinancetimeextremePoint) -> Double { self.x }

pub fn FinancetimeextremePoint::y(self : FinancetimeextremePoint) -> Double { self.y }

pub fn FinancetimeextremePoint::z(self : FinancetimeextremePoint) -> Double { self.z }

pub fn FinancetimeextremePoint::label(self : FinancetimeextremePoint) -> Int { self.label }

pub fn FinancetimeextremePoint::dist(self : FinancetimeextremePoint, other : FinancetimeextremePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimeextremePoint::add(self : FinancetimeextremePoint, other : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimeextremePoint::sub(self : FinancetimeextremePoint, other : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimeextremePoint::scale(self : FinancetimeextremePoint, s : Double) -> FinancetimeextremePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimeextremePoint::dot(self : FinancetimeextremePoint, other : FinancetimeextremePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimeextremePoint::cross(self : FinancetimeextremePoint, other : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimeextremePoint::norm(self : FinancetimeextremePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimeextremePoint::normalize(self : FinancetimeextremePoint) -> FinancetimeextremePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeextremePoint::negate(self : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimeextremePoint::mid(self : FinancetimeextremePoint, other : FinancetimeextremePoint) -> FinancetimeextremePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimeextremePoint::lerp(self : FinancetimeextremePoint, other : FinancetimeextremePoint, t : Double) -> FinancetimeextremePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimeextremePoint::to_string(self : FinancetimeextremePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimeextremeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_extreme_make_series(vals : Array[Double], name : String) -> FinancetimeextremeSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimeextremeSeries::len(self : FinancetimeextremeSeries) -> Int { self.vals.length() }

pub fn FinancetimeextremeSeries::sum(self : FinancetimeextremeSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimeextremeSeries::mean(self : FinancetimeextremeSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimeextremeSeries::min(self : FinancetimeextremeSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimeextremeSeries::max(self : FinancetimeextremeSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimeextremeSeries::range(self : FinancetimeextremeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimeextremeSeries::variance(self : FinancetimeextremeSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimeextremeSeries::std(self : FinancetimeextremeSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimeextremeSeries::median(self : FinancetimeextremeSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimeextremeSeries::scale(self : FinancetimeextremeSeries, f : Double) -> FinancetimeextremeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimeextremeSeries::add(self : FinancetimeextremeSeries, other : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimeextremeSeries::sub(self : FinancetimeextremeSeries, other : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimeextremeSeries::normalize(self : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimeextremeSeries::cumsum(self : FinancetimeextremeSeries) -> FinancetimeextremeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimeextremeSeries::to_string(self : FinancetimeextremeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeextremeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_extreme_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeextremeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_extreme_matrix_identity(n : Int) -> FinancetimeextremeMatrix {
  let m = finance_time_extreme_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimeextremeMatrix::get(self : FinancetimeextremeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimeextremeMatrix::transpose(self : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimeextremeMatrix::add(self : FinancetimeextremeMatrix, other : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_extreme_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimeextremeMatrix::scale(self : FinancetimeextremeMatrix, s : Double) -> FinancetimeextremeMatrix {
  let result = finance_time_extreme_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimeextremeMatrix::multiply(self : FinancetimeextremeMatrix, other : FinancetimeextremeMatrix) -> FinancetimeextremeMatrix {
  if self.cols != other.rows { return finance_time_extreme_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_extreme_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimeextremeMatrix::trace(self : FinancetimeextremeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimeextremeMatrix::det(self : FinancetimeextremeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimeextremeMatrix::norm(self : FinancetimeextremeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimeextremeMatrix::to_string(self : FinancetimeextremeMatrix) -> String {
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

pub(all) struct FinancetimeextremeVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_extreme_make_vector(comps : Array[Double]) -> FinancetimeextremeVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_extreme_vector_zero(dim : Int) -> FinancetimeextremeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimeextremeVector::add(self : FinancetimeextremeVector, other : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeextremeVector::sub(self : FinancetimeextremeVector, other : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeextremeVector::scale(self : FinancetimeextremeVector, s : Double) -> FinancetimeextremeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimeextremeVector::dot(self : FinancetimeextremeVector, other : FinancetimeextremeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimeextremeVector::norm(self : FinancetimeextremeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimeextremeVector::normalize(self : FinancetimeextremeVector) -> FinancetimeextremeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeextremeVector::dist(self : FinancetimeextremeVector, other : FinancetimeextremeVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimeextremeVector::to_string(self : FinancetimeextremeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_extreme_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_extreme_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_extreme_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_extreme_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_extreme_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_extreme_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_extreme_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_extreme_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_extreme_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_extreme_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_extreme_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_extreme_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_extreme_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_extreme_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_extreme_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_extreme_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_extreme_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_extreme_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_extreme_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_extreme_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_extreme_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_extreme_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_extreme_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_extreme_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_extreme_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_extreme_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_extreme_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_extreme_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_extreme_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimeextremeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_frame_make(size : Int) -> FinancetimeextremeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_frame_len(s : FinancetimeextremeFrame) -> Int { s.size }

pub fn finance_time_extreme_frame_get(s : FinancetimeextremeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_frame_set(s : FinancetimeextremeFrame, i : Int, v : Double) -> FinancetimeextremeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_sum(s : FinancetimeextremeFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_frame_mean(s : FinancetimeextremeFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_frame_scale(s : FinancetimeextremeFrame, f : Double) -> FinancetimeextremeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_add(a : FinancetimeextremeFrame, b : FinancetimeextremeFrame) -> FinancetimeextremeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_frame_copy(s : FinancetimeextremeFrame) -> FinancetimeextremeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_fill(s : FinancetimeextremeFrame, v : Double) -> FinancetimeextremeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_frame_min(s : FinancetimeextremeFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_frame_max(s : FinancetimeextremeFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_frame_to_string(s : FinancetimeextremeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_table_make(size : Int) -> FinancetimeextremeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_table_len(s : FinancetimeextremeTable) -> Int { s.size }

pub fn finance_time_extreme_table_get(s : FinancetimeextremeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_table_set(s : FinancetimeextremeTable, i : Int, v : Double) -> FinancetimeextremeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_sum(s : FinancetimeextremeTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_table_mean(s : FinancetimeextremeTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_table_scale(s : FinancetimeextremeTable, f : Double) -> FinancetimeextremeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_add(a : FinancetimeextremeTable, b : FinancetimeextremeTable) -> FinancetimeextremeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_table_copy(s : FinancetimeextremeTable) -> FinancetimeextremeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_fill(s : FinancetimeextremeTable, v : Double) -> FinancetimeextremeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_table_min(s : FinancetimeextremeTable) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_table_max(s : FinancetimeextremeTable) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_table_to_string(s : FinancetimeextremeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_graphn_make(size : Int) -> FinancetimeextremeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_graphn_len(s : FinancetimeextremeGraphN) -> Int { s.size }

pub fn finance_time_extreme_graphn_get(s : FinancetimeextremeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_graphn_set(s : FinancetimeextremeGraphN, i : Int, v : Double) -> FinancetimeextremeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_sum(s : FinancetimeextremeGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_graphn_mean(s : FinancetimeextremeGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_graphn_scale(s : FinancetimeextremeGraphN, f : Double) -> FinancetimeextremeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_add(a : FinancetimeextremeGraphN, b : FinancetimeextremeGraphN) -> FinancetimeextremeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_graphn_copy(s : FinancetimeextremeGraphN) -> FinancetimeextremeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_fill(s : FinancetimeextremeGraphN, v : Double) -> FinancetimeextremeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_graphn_min(s : FinancetimeextremeGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_graphn_max(s : FinancetimeextremeGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_graphn_to_string(s : FinancetimeextremeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_node_make(size : Int) -> FinancetimeextremeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_node_len(s : FinancetimeextremeNode) -> Int { s.size }

pub fn finance_time_extreme_node_get(s : FinancetimeextremeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_node_set(s : FinancetimeextremeNode, i : Int, v : Double) -> FinancetimeextremeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_sum(s : FinancetimeextremeNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_node_mean(s : FinancetimeextremeNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_node_scale(s : FinancetimeextremeNode, f : Double) -> FinancetimeextremeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_add(a : FinancetimeextremeNode, b : FinancetimeextremeNode) -> FinancetimeextremeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_node_copy(s : FinancetimeextremeNode) -> FinancetimeextremeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_fill(s : FinancetimeextremeNode, v : Double) -> FinancetimeextremeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_node_min(s : FinancetimeextremeNode) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_node_max(s : FinancetimeextremeNode) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_node_to_string(s : FinancetimeextremeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_edge_make(size : Int) -> FinancetimeextremeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_edge_len(s : FinancetimeextremeEdge) -> Int { s.size }

pub fn finance_time_extreme_edge_get(s : FinancetimeextremeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_edge_set(s : FinancetimeextremeEdge, i : Int, v : Double) -> FinancetimeextremeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_sum(s : FinancetimeextremeEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_edge_mean(s : FinancetimeextremeEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_edge_scale(s : FinancetimeextremeEdge, f : Double) -> FinancetimeextremeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_add(a : FinancetimeextremeEdge, b : FinancetimeextremeEdge) -> FinancetimeextremeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_edge_copy(s : FinancetimeextremeEdge) -> FinancetimeextremeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_fill(s : FinancetimeextremeEdge, v : Double) -> FinancetimeextremeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_edge_min(s : FinancetimeextremeEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_edge_max(s : FinancetimeextremeEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_edge_to_string(s : FinancetimeextremeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_path_make(size : Int) -> FinancetimeextremePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_path_len(s : FinancetimeextremePath) -> Int { s.size }

pub fn finance_time_extreme_path_get(s : FinancetimeextremePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_path_set(s : FinancetimeextremePath, i : Int, v : Double) -> FinancetimeextremePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_sum(s : FinancetimeextremePath) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_path_mean(s : FinancetimeextremePath) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_path_scale(s : FinancetimeextremePath, f : Double) -> FinancetimeextremePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_add(a : FinancetimeextremePath, b : FinancetimeextremePath) -> FinancetimeextremePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_path_copy(s : FinancetimeextremePath) -> FinancetimeextremePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_fill(s : FinancetimeextremePath, v : Double) -> FinancetimeextremePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_path_min(s : FinancetimeextremePath) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_path_max(s : FinancetimeextremePath) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_path_to_string(s : FinancetimeextremePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_cluster_make(size : Int) -> FinancetimeextremeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_cluster_len(s : FinancetimeextremeCluster) -> Int { s.size }

pub fn finance_time_extreme_cluster_get(s : FinancetimeextremeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_cluster_set(s : FinancetimeextremeCluster, i : Int, v : Double) -> FinancetimeextremeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_sum(s : FinancetimeextremeCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_cluster_mean(s : FinancetimeextremeCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_cluster_scale(s : FinancetimeextremeCluster, f : Double) -> FinancetimeextremeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_add(a : FinancetimeextremeCluster, b : FinancetimeextremeCluster) -> FinancetimeextremeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_cluster_copy(s : FinancetimeextremeCluster) -> FinancetimeextremeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_fill(s : FinancetimeextremeCluster, v : Double) -> FinancetimeextremeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cluster_min(s : FinancetimeextremeCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_cluster_max(s : FinancetimeextremeCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_cluster_to_string(s : FinancetimeextremeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_model_make(size : Int) -> FinancetimeextremeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_model_len(s : FinancetimeextremeModel) -> Int { s.size }

pub fn finance_time_extreme_model_get(s : FinancetimeextremeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_model_set(s : FinancetimeextremeModel, i : Int, v : Double) -> FinancetimeextremeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_sum(s : FinancetimeextremeModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_model_mean(s : FinancetimeextremeModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_model_scale(s : FinancetimeextremeModel, f : Double) -> FinancetimeextremeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_add(a : FinancetimeextremeModel, b : FinancetimeextremeModel) -> FinancetimeextremeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_model_copy(s : FinancetimeextremeModel) -> FinancetimeextremeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_fill(s : FinancetimeextremeModel, v : Double) -> FinancetimeextremeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_model_min(s : FinancetimeextremeModel) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_model_max(s : FinancetimeextremeModel) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_model_to_string(s : FinancetimeextremeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_layer_make(size : Int) -> FinancetimeextremeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_layer_len(s : FinancetimeextremeLayer) -> Int { s.size }

pub fn finance_time_extreme_layer_get(s : FinancetimeextremeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_layer_set(s : FinancetimeextremeLayer, i : Int, v : Double) -> FinancetimeextremeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_sum(s : FinancetimeextremeLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_layer_mean(s : FinancetimeextremeLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_layer_scale(s : FinancetimeextremeLayer, f : Double) -> FinancetimeextremeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_add(a : FinancetimeextremeLayer, b : FinancetimeextremeLayer) -> FinancetimeextremeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_layer_copy(s : FinancetimeextremeLayer) -> FinancetimeextremeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_fill(s : FinancetimeextremeLayer, v : Double) -> FinancetimeextremeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_layer_min(s : FinancetimeextremeLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_layer_max(s : FinancetimeextremeLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_layer_to_string(s : FinancetimeextremeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_buffer_make(size : Int) -> FinancetimeextremeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_buffer_len(s : FinancetimeextremeBuffer) -> Int { s.size }

pub fn finance_time_extreme_buffer_get(s : FinancetimeextremeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_buffer_set(s : FinancetimeextremeBuffer, i : Int, v : Double) -> FinancetimeextremeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_sum(s : FinancetimeextremeBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_buffer_mean(s : FinancetimeextremeBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_buffer_scale(s : FinancetimeextremeBuffer, f : Double) -> FinancetimeextremeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_add(a : FinancetimeextremeBuffer, b : FinancetimeextremeBuffer) -> FinancetimeextremeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_buffer_copy(s : FinancetimeextremeBuffer) -> FinancetimeextremeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_fill(s : FinancetimeextremeBuffer, v : Double) -> FinancetimeextremeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_buffer_min(s : FinancetimeextremeBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_buffer_max(s : FinancetimeextremeBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_buffer_to_string(s : FinancetimeextremeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_cursor_make(size : Int) -> FinancetimeextremeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_cursor_len(s : FinancetimeextremeCursor) -> Int { s.size }

pub fn finance_time_extreme_cursor_get(s : FinancetimeextremeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_cursor_set(s : FinancetimeextremeCursor, i : Int, v : Double) -> FinancetimeextremeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_sum(s : FinancetimeextremeCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_cursor_mean(s : FinancetimeextremeCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_cursor_scale(s : FinancetimeextremeCursor, f : Double) -> FinancetimeextremeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_add(a : FinancetimeextremeCursor, b : FinancetimeextremeCursor) -> FinancetimeextremeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_cursor_copy(s : FinancetimeextremeCursor) -> FinancetimeextremeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_fill(s : FinancetimeextremeCursor, v : Double) -> FinancetimeextremeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_cursor_min(s : FinancetimeextremeCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_cursor_max(s : FinancetimeextremeCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_cursor_to_string(s : FinancetimeextremeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_view_make(size : Int) -> FinancetimeextremeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_view_len(s : FinancetimeextremeView) -> Int { s.size }

pub fn finance_time_extreme_view_get(s : FinancetimeextremeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_view_set(s : FinancetimeextremeView, i : Int, v : Double) -> FinancetimeextremeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_sum(s : FinancetimeextremeView) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_view_mean(s : FinancetimeextremeView) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_view_scale(s : FinancetimeextremeView, f : Double) -> FinancetimeextremeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_add(a : FinancetimeextremeView, b : FinancetimeextremeView) -> FinancetimeextremeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_view_copy(s : FinancetimeextremeView) -> FinancetimeextremeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_fill(s : FinancetimeextremeView, v : Double) -> FinancetimeextremeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_view_min(s : FinancetimeextremeView) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_view_max(s : FinancetimeextremeView) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_view_to_string(s : FinancetimeextremeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_range_make(size : Int) -> FinancetimeextremeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_range_len(s : FinancetimeextremeRange) -> Int { s.size }

pub fn finance_time_extreme_range_get(s : FinancetimeextremeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_range_set(s : FinancetimeextremeRange, i : Int, v : Double) -> FinancetimeextremeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_sum(s : FinancetimeextremeRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_range_mean(s : FinancetimeextremeRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_range_scale(s : FinancetimeextremeRange, f : Double) -> FinancetimeextremeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_add(a : FinancetimeextremeRange, b : FinancetimeextremeRange) -> FinancetimeextremeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_range_copy(s : FinancetimeextremeRange) -> FinancetimeextremeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_fill(s : FinancetimeextremeRange, v : Double) -> FinancetimeextremeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_range_min(s : FinancetimeextremeRange) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_range_max(s : FinancetimeextremeRange) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_range_to_string(s : FinancetimeextremeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimeextremeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_extreme_slice_make(size : Int) -> FinancetimeextremeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_extreme_slice_len(s : FinancetimeextremeSlice) -> Int { s.size }

pub fn finance_time_extreme_slice_get(s : FinancetimeextremeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_extreme_slice_set(s : FinancetimeextremeSlice, i : Int, v : Double) -> FinancetimeextremeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_sum(s : FinancetimeextremeSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_extreme_slice_mean(s : FinancetimeextremeSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_extreme_slice_scale(s : FinancetimeextremeSlice, f : Double) -> FinancetimeextremeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_add(a : FinancetimeextremeSlice, b : FinancetimeextremeSlice) -> FinancetimeextremeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_extreme_slice_copy(s : FinancetimeextremeSlice) -> FinancetimeextremeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_fill(s : FinancetimeextremeSlice, v : Double) -> FinancetimeextremeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_extreme_slice_min(s : FinancetimeextremeSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_extreme_slice_max(s : FinancetimeextremeSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_extreme_slice_to_string(s : FinancetimeextremeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

