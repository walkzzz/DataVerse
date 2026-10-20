///===
/// extcore/finance_time_crisis

pub(all) struct FinancetimecrisisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_crisis_make_point(x : Double, y : Double) -> FinancetimecrisisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_crisis_make_point3(x : Double, y : Double, z : Double) -> FinancetimecrisisPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimecrisisPoint::x(self : FinancetimecrisisPoint) -> Double { self.x }

pub fn FinancetimecrisisPoint::y(self : FinancetimecrisisPoint) -> Double { self.y }

pub fn FinancetimecrisisPoint::z(self : FinancetimecrisisPoint) -> Double { self.z }

pub fn FinancetimecrisisPoint::label(self : FinancetimecrisisPoint) -> Int { self.label }

pub fn FinancetimecrisisPoint::dist(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimecrisisPoint::add(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimecrisisPoint::sub(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimecrisisPoint::scale(self : FinancetimecrisisPoint, s : Double) -> FinancetimecrisisPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimecrisisPoint::dot(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimecrisisPoint::cross(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimecrisisPoint::norm(self : FinancetimecrisisPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimecrisisPoint::normalize(self : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimecrisisPoint::negate(self : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimecrisisPoint::mid(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimecrisisPoint::lerp(self : FinancetimecrisisPoint, other : FinancetimecrisisPoint, t : Double) -> FinancetimecrisisPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimecrisisPoint::to_string(self : FinancetimecrisisPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimecrisisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_crisis_make_series(vals : Array[Double], name : String) -> FinancetimecrisisSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimecrisisSeries::len(self : FinancetimecrisisSeries) -> Int { self.vals.length() }

pub fn FinancetimecrisisSeries::sum(self : FinancetimecrisisSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimecrisisSeries::mean(self : FinancetimecrisisSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimecrisisSeries::min(self : FinancetimecrisisSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimecrisisSeries::max(self : FinancetimecrisisSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimecrisisSeries::range(self : FinancetimecrisisSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimecrisisSeries::variance(self : FinancetimecrisisSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimecrisisSeries::std(self : FinancetimecrisisSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimecrisisSeries::median(self : FinancetimecrisisSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimecrisisSeries::scale(self : FinancetimecrisisSeries, f : Double) -> FinancetimecrisisSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimecrisisSeries::add(self : FinancetimecrisisSeries, other : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimecrisisSeries::sub(self : FinancetimecrisisSeries, other : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimecrisisSeries::normalize(self : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimecrisisSeries::cumsum(self : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimecrisisSeries::to_string(self : FinancetimecrisisSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimecrisisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_crisis_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimecrisisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_crisis_matrix_identity(n : Int) -> FinancetimecrisisMatrix {
  let m = finance_time_crisis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimecrisisMatrix::get(self : FinancetimecrisisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimecrisisMatrix::transpose(self : FinancetimecrisisMatrix) -> FinancetimecrisisMatrix {
  let result = finance_time_crisis_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimecrisisMatrix::add(self : FinancetimecrisisMatrix, other : FinancetimecrisisMatrix) -> FinancetimecrisisMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_crisis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimecrisisMatrix::scale(self : FinancetimecrisisMatrix, s : Double) -> FinancetimecrisisMatrix {
  let result = finance_time_crisis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimecrisisMatrix::multiply(self : FinancetimecrisisMatrix, other : FinancetimecrisisMatrix) -> FinancetimecrisisMatrix {
  if self.cols != other.rows { return finance_time_crisis_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_crisis_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimecrisisMatrix::trace(self : FinancetimecrisisMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimecrisisMatrix::det(self : FinancetimecrisisMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimecrisisMatrix::norm(self : FinancetimecrisisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimecrisisMatrix::to_string(self : FinancetimecrisisMatrix) -> String {
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

pub(all) struct FinancetimecrisisVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_crisis_make_vector(comps : Array[Double]) -> FinancetimecrisisVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_crisis_vector_zero(dim : Int) -> FinancetimecrisisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimecrisisVector::add(self : FinancetimecrisisVector, other : FinancetimecrisisVector) -> FinancetimecrisisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimecrisisVector::sub(self : FinancetimecrisisVector, other : FinancetimecrisisVector) -> FinancetimecrisisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimecrisisVector::scale(self : FinancetimecrisisVector, s : Double) -> FinancetimecrisisVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimecrisisVector::dot(self : FinancetimecrisisVector, other : FinancetimecrisisVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimecrisisVector::norm(self : FinancetimecrisisVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimecrisisVector::normalize(self : FinancetimecrisisVector) -> FinancetimecrisisVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimecrisisVector::dist(self : FinancetimecrisisVector, other : FinancetimecrisisVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimecrisisVector::to_string(self : FinancetimecrisisVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_crisis_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_crisis_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_crisis_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_crisis_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_crisis_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_crisis_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_crisis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_crisis_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_crisis_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_crisis_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_crisis_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_crisis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_crisis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_crisis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_crisis_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_crisis_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_crisis_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_crisis_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_crisis_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_crisis_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_crisis_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_crisis_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_crisis_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_crisis_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_crisis_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_crisis_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_crisis_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_crisis_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_crisis_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimecrisisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_frame_make(size : Int) -> FinancetimecrisisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_frame_len(s : FinancetimecrisisFrame) -> Int { s.size }

pub fn finance_time_crisis_frame_get(s : FinancetimecrisisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_frame_set(s : FinancetimecrisisFrame, i : Int, v : Double) -> FinancetimecrisisFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_frame_sum(s : FinancetimecrisisFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_frame_mean(s : FinancetimecrisisFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_frame_scale(s : FinancetimecrisisFrame, f : Double) -> FinancetimecrisisFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_frame_add(a : FinancetimecrisisFrame, b : FinancetimecrisisFrame) -> FinancetimecrisisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_frame_copy(s : FinancetimecrisisFrame) -> FinancetimecrisisFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_frame_fill(s : FinancetimecrisisFrame, v : Double) -> FinancetimecrisisFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_frame_min(s : FinancetimecrisisFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_frame_max(s : FinancetimecrisisFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_frame_to_string(s : FinancetimecrisisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_table_make(size : Int) -> FinancetimecrisisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_table_len(s : FinancetimecrisisTable) -> Int { s.size }

pub fn finance_time_crisis_table_get(s : FinancetimecrisisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_table_set(s : FinancetimecrisisTable, i : Int, v : Double) -> FinancetimecrisisTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_table_sum(s : FinancetimecrisisTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_table_mean(s : FinancetimecrisisTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_table_scale(s : FinancetimecrisisTable, f : Double) -> FinancetimecrisisTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_table_add(a : FinancetimecrisisTable, b : FinancetimecrisisTable) -> FinancetimecrisisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_table_copy(s : FinancetimecrisisTable) -> FinancetimecrisisTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_table_fill(s : FinancetimecrisisTable, v : Double) -> FinancetimecrisisTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_table_min(s : FinancetimecrisisTable) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_table_max(s : FinancetimecrisisTable) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_table_to_string(s : FinancetimecrisisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_graphn_make(size : Int) -> FinancetimecrisisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_graphn_len(s : FinancetimecrisisGraphN) -> Int { s.size }

pub fn finance_time_crisis_graphn_get(s : FinancetimecrisisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_graphn_set(s : FinancetimecrisisGraphN, i : Int, v : Double) -> FinancetimecrisisGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_graphn_sum(s : FinancetimecrisisGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_graphn_mean(s : FinancetimecrisisGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_graphn_scale(s : FinancetimecrisisGraphN, f : Double) -> FinancetimecrisisGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_graphn_add(a : FinancetimecrisisGraphN, b : FinancetimecrisisGraphN) -> FinancetimecrisisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_graphn_copy(s : FinancetimecrisisGraphN) -> FinancetimecrisisGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_graphn_fill(s : FinancetimecrisisGraphN, v : Double) -> FinancetimecrisisGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_graphn_min(s : FinancetimecrisisGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_graphn_max(s : FinancetimecrisisGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_graphn_to_string(s : FinancetimecrisisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_node_make(size : Int) -> FinancetimecrisisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_node_len(s : FinancetimecrisisNode) -> Int { s.size }

pub fn finance_time_crisis_node_get(s : FinancetimecrisisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_node_set(s : FinancetimecrisisNode, i : Int, v : Double) -> FinancetimecrisisNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_node_sum(s : FinancetimecrisisNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_node_mean(s : FinancetimecrisisNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_node_scale(s : FinancetimecrisisNode, f : Double) -> FinancetimecrisisNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_node_add(a : FinancetimecrisisNode, b : FinancetimecrisisNode) -> FinancetimecrisisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_node_copy(s : FinancetimecrisisNode) -> FinancetimecrisisNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_node_fill(s : FinancetimecrisisNode, v : Double) -> FinancetimecrisisNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_node_min(s : FinancetimecrisisNode) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_node_max(s : FinancetimecrisisNode) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_node_to_string(s : FinancetimecrisisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_edge_make(size : Int) -> FinancetimecrisisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_edge_len(s : FinancetimecrisisEdge) -> Int { s.size }

pub fn finance_time_crisis_edge_get(s : FinancetimecrisisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_edge_set(s : FinancetimecrisisEdge, i : Int, v : Double) -> FinancetimecrisisEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_edge_sum(s : FinancetimecrisisEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_edge_mean(s : FinancetimecrisisEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_edge_scale(s : FinancetimecrisisEdge, f : Double) -> FinancetimecrisisEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_edge_add(a : FinancetimecrisisEdge, b : FinancetimecrisisEdge) -> FinancetimecrisisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_edge_copy(s : FinancetimecrisisEdge) -> FinancetimecrisisEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_edge_fill(s : FinancetimecrisisEdge, v : Double) -> FinancetimecrisisEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_edge_min(s : FinancetimecrisisEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_edge_max(s : FinancetimecrisisEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_edge_to_string(s : FinancetimecrisisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_path_make(size : Int) -> FinancetimecrisisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_path_len(s : FinancetimecrisisPath) -> Int { s.size }

pub fn finance_time_crisis_path_get(s : FinancetimecrisisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_path_set(s : FinancetimecrisisPath, i : Int, v : Double) -> FinancetimecrisisPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_path_sum(s : FinancetimecrisisPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_path_mean(s : FinancetimecrisisPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_path_scale(s : FinancetimecrisisPath, f : Double) -> FinancetimecrisisPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_path_add(a : FinancetimecrisisPath, b : FinancetimecrisisPath) -> FinancetimecrisisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_path_copy(s : FinancetimecrisisPath) -> FinancetimecrisisPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_path_fill(s : FinancetimecrisisPath, v : Double) -> FinancetimecrisisPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_path_min(s : FinancetimecrisisPath) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_path_max(s : FinancetimecrisisPath) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_path_to_string(s : FinancetimecrisisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_cluster_make(size : Int) -> FinancetimecrisisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_cluster_len(s : FinancetimecrisisCluster) -> Int { s.size }

pub fn finance_time_crisis_cluster_get(s : FinancetimecrisisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_cluster_set(s : FinancetimecrisisCluster, i : Int, v : Double) -> FinancetimecrisisCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cluster_sum(s : FinancetimecrisisCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_cluster_mean(s : FinancetimecrisisCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_cluster_scale(s : FinancetimecrisisCluster, f : Double) -> FinancetimecrisisCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cluster_add(a : FinancetimecrisisCluster, b : FinancetimecrisisCluster) -> FinancetimecrisisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_cluster_copy(s : FinancetimecrisisCluster) -> FinancetimecrisisCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cluster_fill(s : FinancetimecrisisCluster, v : Double) -> FinancetimecrisisCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cluster_min(s : FinancetimecrisisCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_cluster_max(s : FinancetimecrisisCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_cluster_to_string(s : FinancetimecrisisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_model_make(size : Int) -> FinancetimecrisisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_model_len(s : FinancetimecrisisModel) -> Int { s.size }

pub fn finance_time_crisis_model_get(s : FinancetimecrisisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_model_set(s : FinancetimecrisisModel, i : Int, v : Double) -> FinancetimecrisisModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_model_sum(s : FinancetimecrisisModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_model_mean(s : FinancetimecrisisModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_model_scale(s : FinancetimecrisisModel, f : Double) -> FinancetimecrisisModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_model_add(a : FinancetimecrisisModel, b : FinancetimecrisisModel) -> FinancetimecrisisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_model_copy(s : FinancetimecrisisModel) -> FinancetimecrisisModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_model_fill(s : FinancetimecrisisModel, v : Double) -> FinancetimecrisisModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_model_min(s : FinancetimecrisisModel) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_model_max(s : FinancetimecrisisModel) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_model_to_string(s : FinancetimecrisisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_layer_make(size : Int) -> FinancetimecrisisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_layer_len(s : FinancetimecrisisLayer) -> Int { s.size }

pub fn finance_time_crisis_layer_get(s : FinancetimecrisisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_layer_set(s : FinancetimecrisisLayer, i : Int, v : Double) -> FinancetimecrisisLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_layer_sum(s : FinancetimecrisisLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_layer_mean(s : FinancetimecrisisLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_layer_scale(s : FinancetimecrisisLayer, f : Double) -> FinancetimecrisisLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_layer_add(a : FinancetimecrisisLayer, b : FinancetimecrisisLayer) -> FinancetimecrisisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_layer_copy(s : FinancetimecrisisLayer) -> FinancetimecrisisLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_layer_fill(s : FinancetimecrisisLayer, v : Double) -> FinancetimecrisisLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_layer_min(s : FinancetimecrisisLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_layer_max(s : FinancetimecrisisLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_layer_to_string(s : FinancetimecrisisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_buffer_make(size : Int) -> FinancetimecrisisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_buffer_len(s : FinancetimecrisisBuffer) -> Int { s.size }

pub fn finance_time_crisis_buffer_get(s : FinancetimecrisisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_buffer_set(s : FinancetimecrisisBuffer, i : Int, v : Double) -> FinancetimecrisisBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_buffer_sum(s : FinancetimecrisisBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_buffer_mean(s : FinancetimecrisisBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_buffer_scale(s : FinancetimecrisisBuffer, f : Double) -> FinancetimecrisisBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_buffer_add(a : FinancetimecrisisBuffer, b : FinancetimecrisisBuffer) -> FinancetimecrisisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_buffer_copy(s : FinancetimecrisisBuffer) -> FinancetimecrisisBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_buffer_fill(s : FinancetimecrisisBuffer, v : Double) -> FinancetimecrisisBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_buffer_min(s : FinancetimecrisisBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_buffer_max(s : FinancetimecrisisBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_buffer_to_string(s : FinancetimecrisisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_cursor_make(size : Int) -> FinancetimecrisisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_cursor_len(s : FinancetimecrisisCursor) -> Int { s.size }

pub fn finance_time_crisis_cursor_get(s : FinancetimecrisisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_cursor_set(s : FinancetimecrisisCursor, i : Int, v : Double) -> FinancetimecrisisCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cursor_sum(s : FinancetimecrisisCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_cursor_mean(s : FinancetimecrisisCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_cursor_scale(s : FinancetimecrisisCursor, f : Double) -> FinancetimecrisisCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cursor_add(a : FinancetimecrisisCursor, b : FinancetimecrisisCursor) -> FinancetimecrisisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_cursor_copy(s : FinancetimecrisisCursor) -> FinancetimecrisisCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cursor_fill(s : FinancetimecrisisCursor, v : Double) -> FinancetimecrisisCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_cursor_min(s : FinancetimecrisisCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_cursor_max(s : FinancetimecrisisCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_cursor_to_string(s : FinancetimecrisisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_view_make(size : Int) -> FinancetimecrisisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_view_len(s : FinancetimecrisisView) -> Int { s.size }

pub fn finance_time_crisis_view_get(s : FinancetimecrisisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_view_set(s : FinancetimecrisisView, i : Int, v : Double) -> FinancetimecrisisView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_view_sum(s : FinancetimecrisisView) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_view_mean(s : FinancetimecrisisView) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_view_scale(s : FinancetimecrisisView, f : Double) -> FinancetimecrisisView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_view_add(a : FinancetimecrisisView, b : FinancetimecrisisView) -> FinancetimecrisisView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_view_copy(s : FinancetimecrisisView) -> FinancetimecrisisView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_view_fill(s : FinancetimecrisisView, v : Double) -> FinancetimecrisisView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_view_min(s : FinancetimecrisisView) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_view_max(s : FinancetimecrisisView) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_view_to_string(s : FinancetimecrisisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_range_make(size : Int) -> FinancetimecrisisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_range_len(s : FinancetimecrisisRange) -> Int { s.size }

pub fn finance_time_crisis_range_get(s : FinancetimecrisisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_range_set(s : FinancetimecrisisRange, i : Int, v : Double) -> FinancetimecrisisRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_range_sum(s : FinancetimecrisisRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_range_mean(s : FinancetimecrisisRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_range_scale(s : FinancetimecrisisRange, f : Double) -> FinancetimecrisisRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_range_add(a : FinancetimecrisisRange, b : FinancetimecrisisRange) -> FinancetimecrisisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_range_copy(s : FinancetimecrisisRange) -> FinancetimecrisisRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_range_fill(s : FinancetimecrisisRange, v : Double) -> FinancetimecrisisRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_range_min(s : FinancetimecrisisRange) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_range_max(s : FinancetimecrisisRange) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_range_to_string(s : FinancetimecrisisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_slice_make(size : Int) -> FinancetimecrisisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_slice_len(s : FinancetimecrisisSlice) -> Int { s.size }

pub fn finance_time_crisis_slice_get(s : FinancetimecrisisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_slice_set(s : FinancetimecrisisSlice, i : Int, v : Double) -> FinancetimecrisisSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_slice_sum(s : FinancetimecrisisSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_crisis_slice_mean(s : FinancetimecrisisSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_crisis_slice_scale(s : FinancetimecrisisSlice, f : Double) -> FinancetimecrisisSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_slice_add(a : FinancetimecrisisSlice, b : FinancetimecrisisSlice) -> FinancetimecrisisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_crisis_slice_copy(s : FinancetimecrisisSlice) -> FinancetimecrisisSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_slice_fill(s : FinancetimecrisisSlice, v : Double) -> FinancetimecrisisSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_crisis_slice_min(s : FinancetimecrisisSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_crisis_slice_max(s : FinancetimecrisisSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_crisis_slice_to_string(s : FinancetimecrisisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

