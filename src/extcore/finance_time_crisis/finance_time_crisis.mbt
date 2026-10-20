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

pub fn FinancetimecrisisFrame::len(self : FinancetimecrisisFrame) -> Int { self.size }

pub fn FinancetimecrisisFrame::get(self : FinancetimecrisisFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisFrame::set(self : FinancetimecrisisFrame, i : Int, v : Double) -> FinancetimecrisisFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisFrame::sum(self : FinancetimecrisisFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisFrame::mean(self : FinancetimecrisisFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisFrame::scale(self : FinancetimecrisisFrame, f : Double) -> FinancetimecrisisFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisFrame::add(self : FinancetimecrisisFrame, other : FinancetimecrisisFrame) -> FinancetimecrisisFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisFrame::copy(self : FinancetimecrisisFrame) -> FinancetimecrisisFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisFrame::fill(self : FinancetimecrisisFrame, v : Double) -> FinancetimecrisisFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisFrame::min(self : FinancetimecrisisFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisFrame::max(self : FinancetimecrisisFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisFrame::to_string(self : FinancetimecrisisFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_table_make(size : Int) -> FinancetimecrisisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisTable::len(self : FinancetimecrisisTable) -> Int { self.size }

pub fn FinancetimecrisisTable::get(self : FinancetimecrisisTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisTable::set(self : FinancetimecrisisTable, i : Int, v : Double) -> FinancetimecrisisTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisTable::sum(self : FinancetimecrisisTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisTable::mean(self : FinancetimecrisisTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisTable::scale(self : FinancetimecrisisTable, f : Double) -> FinancetimecrisisTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisTable::add(self : FinancetimecrisisTable, other : FinancetimecrisisTable) -> FinancetimecrisisTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisTable::copy(self : FinancetimecrisisTable) -> FinancetimecrisisTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisTable::fill(self : FinancetimecrisisTable, v : Double) -> FinancetimecrisisTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisTable::min(self : FinancetimecrisisTable) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisTable::max(self : FinancetimecrisisTable) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisTable::to_string(self : FinancetimecrisisTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_graphn_make(size : Int) -> FinancetimecrisisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisGraphN::len(self : FinancetimecrisisGraphN) -> Int { self.size }

pub fn FinancetimecrisisGraphN::get(self : FinancetimecrisisGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisGraphN::set(self : FinancetimecrisisGraphN, i : Int, v : Double) -> FinancetimecrisisGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisGraphN::sum(self : FinancetimecrisisGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisGraphN::mean(self : FinancetimecrisisGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisGraphN::scale(self : FinancetimecrisisGraphN, f : Double) -> FinancetimecrisisGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisGraphN::add(self : FinancetimecrisisGraphN, other : FinancetimecrisisGraphN) -> FinancetimecrisisGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisGraphN::copy(self : FinancetimecrisisGraphN) -> FinancetimecrisisGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisGraphN::fill(self : FinancetimecrisisGraphN, v : Double) -> FinancetimecrisisGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisGraphN::min(self : FinancetimecrisisGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisGraphN::max(self : FinancetimecrisisGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisGraphN::to_string(self : FinancetimecrisisGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_node_make(size : Int) -> FinancetimecrisisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisNode::len(self : FinancetimecrisisNode) -> Int { self.size }

pub fn FinancetimecrisisNode::get(self : FinancetimecrisisNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisNode::set(self : FinancetimecrisisNode, i : Int, v : Double) -> FinancetimecrisisNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisNode::sum(self : FinancetimecrisisNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisNode::mean(self : FinancetimecrisisNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisNode::scale(self : FinancetimecrisisNode, f : Double) -> FinancetimecrisisNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisNode::add(self : FinancetimecrisisNode, other : FinancetimecrisisNode) -> FinancetimecrisisNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisNode::copy(self : FinancetimecrisisNode) -> FinancetimecrisisNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisNode::fill(self : FinancetimecrisisNode, v : Double) -> FinancetimecrisisNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisNode::min(self : FinancetimecrisisNode) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisNode::max(self : FinancetimecrisisNode) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisNode::to_string(self : FinancetimecrisisNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_edge_make(size : Int) -> FinancetimecrisisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisEdge::len(self : FinancetimecrisisEdge) -> Int { self.size }

pub fn FinancetimecrisisEdge::get(self : FinancetimecrisisEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisEdge::set(self : FinancetimecrisisEdge, i : Int, v : Double) -> FinancetimecrisisEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisEdge::sum(self : FinancetimecrisisEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisEdge::mean(self : FinancetimecrisisEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisEdge::scale(self : FinancetimecrisisEdge, f : Double) -> FinancetimecrisisEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisEdge::add(self : FinancetimecrisisEdge, other : FinancetimecrisisEdge) -> FinancetimecrisisEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisEdge::copy(self : FinancetimecrisisEdge) -> FinancetimecrisisEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisEdge::fill(self : FinancetimecrisisEdge, v : Double) -> FinancetimecrisisEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisEdge::min(self : FinancetimecrisisEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisEdge::max(self : FinancetimecrisisEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisEdge::to_string(self : FinancetimecrisisEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_path_make(size : Int) -> FinancetimecrisisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisPath::len(self : FinancetimecrisisPath) -> Int { self.size }

pub fn FinancetimecrisisPath::get(self : FinancetimecrisisPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisPath::set(self : FinancetimecrisisPath, i : Int, v : Double) -> FinancetimecrisisPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisPath::sum(self : FinancetimecrisisPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisPath::mean(self : FinancetimecrisisPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisPath::scale(self : FinancetimecrisisPath, f : Double) -> FinancetimecrisisPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisPath::add(self : FinancetimecrisisPath, other : FinancetimecrisisPath) -> FinancetimecrisisPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisPath::copy(self : FinancetimecrisisPath) -> FinancetimecrisisPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisPath::fill(self : FinancetimecrisisPath, v : Double) -> FinancetimecrisisPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisPath::min(self : FinancetimecrisisPath) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisPath::max(self : FinancetimecrisisPath) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisPath::to_string(self : FinancetimecrisisPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_cluster_make(size : Int) -> FinancetimecrisisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisCluster::len(self : FinancetimecrisisCluster) -> Int { self.size }

pub fn FinancetimecrisisCluster::get(self : FinancetimecrisisCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisCluster::set(self : FinancetimecrisisCluster, i : Int, v : Double) -> FinancetimecrisisCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCluster::sum(self : FinancetimecrisisCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisCluster::mean(self : FinancetimecrisisCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisCluster::scale(self : FinancetimecrisisCluster, f : Double) -> FinancetimecrisisCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCluster::add(self : FinancetimecrisisCluster, other : FinancetimecrisisCluster) -> FinancetimecrisisCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisCluster::copy(self : FinancetimecrisisCluster) -> FinancetimecrisisCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCluster::fill(self : FinancetimecrisisCluster, v : Double) -> FinancetimecrisisCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCluster::min(self : FinancetimecrisisCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisCluster::max(self : FinancetimecrisisCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisCluster::to_string(self : FinancetimecrisisCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_model_make(size : Int) -> FinancetimecrisisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisModel::len(self : FinancetimecrisisModel) -> Int { self.size }

pub fn FinancetimecrisisModel::get(self : FinancetimecrisisModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisModel::set(self : FinancetimecrisisModel, i : Int, v : Double) -> FinancetimecrisisModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisModel::sum(self : FinancetimecrisisModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisModel::mean(self : FinancetimecrisisModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisModel::scale(self : FinancetimecrisisModel, f : Double) -> FinancetimecrisisModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisModel::add(self : FinancetimecrisisModel, other : FinancetimecrisisModel) -> FinancetimecrisisModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisModel::copy(self : FinancetimecrisisModel) -> FinancetimecrisisModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisModel::fill(self : FinancetimecrisisModel, v : Double) -> FinancetimecrisisModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisModel::min(self : FinancetimecrisisModel) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisModel::max(self : FinancetimecrisisModel) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisModel::to_string(self : FinancetimecrisisModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_layer_make(size : Int) -> FinancetimecrisisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisLayer::len(self : FinancetimecrisisLayer) -> Int { self.size }

pub fn FinancetimecrisisLayer::get(self : FinancetimecrisisLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisLayer::set(self : FinancetimecrisisLayer, i : Int, v : Double) -> FinancetimecrisisLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisLayer::sum(self : FinancetimecrisisLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisLayer::mean(self : FinancetimecrisisLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisLayer::scale(self : FinancetimecrisisLayer, f : Double) -> FinancetimecrisisLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisLayer::add(self : FinancetimecrisisLayer, other : FinancetimecrisisLayer) -> FinancetimecrisisLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisLayer::copy(self : FinancetimecrisisLayer) -> FinancetimecrisisLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisLayer::fill(self : FinancetimecrisisLayer, v : Double) -> FinancetimecrisisLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisLayer::min(self : FinancetimecrisisLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisLayer::max(self : FinancetimecrisisLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisLayer::to_string(self : FinancetimecrisisLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_buffer_make(size : Int) -> FinancetimecrisisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisBuffer::len(self : FinancetimecrisisBuffer) -> Int { self.size }

pub fn FinancetimecrisisBuffer::get(self : FinancetimecrisisBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisBuffer::set(self : FinancetimecrisisBuffer, i : Int, v : Double) -> FinancetimecrisisBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisBuffer::sum(self : FinancetimecrisisBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisBuffer::mean(self : FinancetimecrisisBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisBuffer::scale(self : FinancetimecrisisBuffer, f : Double) -> FinancetimecrisisBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisBuffer::add(self : FinancetimecrisisBuffer, other : FinancetimecrisisBuffer) -> FinancetimecrisisBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisBuffer::copy(self : FinancetimecrisisBuffer) -> FinancetimecrisisBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisBuffer::fill(self : FinancetimecrisisBuffer, v : Double) -> FinancetimecrisisBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisBuffer::min(self : FinancetimecrisisBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisBuffer::max(self : FinancetimecrisisBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisBuffer::to_string(self : FinancetimecrisisBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_cursor_make(size : Int) -> FinancetimecrisisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisCursor::len(self : FinancetimecrisisCursor) -> Int { self.size }

pub fn FinancetimecrisisCursor::get(self : FinancetimecrisisCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisCursor::set(self : FinancetimecrisisCursor, i : Int, v : Double) -> FinancetimecrisisCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCursor::sum(self : FinancetimecrisisCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisCursor::mean(self : FinancetimecrisisCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisCursor::scale(self : FinancetimecrisisCursor, f : Double) -> FinancetimecrisisCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCursor::add(self : FinancetimecrisisCursor, other : FinancetimecrisisCursor) -> FinancetimecrisisCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisCursor::copy(self : FinancetimecrisisCursor) -> FinancetimecrisisCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCursor::fill(self : FinancetimecrisisCursor, v : Double) -> FinancetimecrisisCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisCursor::min(self : FinancetimecrisisCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisCursor::max(self : FinancetimecrisisCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisCursor::to_string(self : FinancetimecrisisCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_view_make(size : Int) -> FinancetimecrisisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisView::len(self : FinancetimecrisisView) -> Int { self.size }

pub fn FinancetimecrisisView::get(self : FinancetimecrisisView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisView::set(self : FinancetimecrisisView, i : Int, v : Double) -> FinancetimecrisisView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisView::sum(self : FinancetimecrisisView) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisView::mean(self : FinancetimecrisisView) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisView::scale(self : FinancetimecrisisView, f : Double) -> FinancetimecrisisView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisView::add(self : FinancetimecrisisView, other : FinancetimecrisisView) -> FinancetimecrisisView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisView::copy(self : FinancetimecrisisView) -> FinancetimecrisisView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisView::fill(self : FinancetimecrisisView, v : Double) -> FinancetimecrisisView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisView::min(self : FinancetimecrisisView) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisView::max(self : FinancetimecrisisView) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisView::to_string(self : FinancetimecrisisView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_range_make(size : Int) -> FinancetimecrisisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisRange::len(self : FinancetimecrisisRange) -> Int { self.size }

pub fn FinancetimecrisisRange::get(self : FinancetimecrisisRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisRange::set(self : FinancetimecrisisRange, i : Int, v : Double) -> FinancetimecrisisRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisRange::sum(self : FinancetimecrisisRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisRange::mean(self : FinancetimecrisisRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisRange::scale(self : FinancetimecrisisRange, f : Double) -> FinancetimecrisisRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisRange::add(self : FinancetimecrisisRange, other : FinancetimecrisisRange) -> FinancetimecrisisRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisRange::copy(self : FinancetimecrisisRange) -> FinancetimecrisisRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisRange::fill(self : FinancetimecrisisRange, v : Double) -> FinancetimecrisisRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisRange::min(self : FinancetimecrisisRange) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisRange::max(self : FinancetimecrisisRange) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisRange::to_string(self : FinancetimecrisisRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_slice_make(size : Int) -> FinancetimecrisisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimecrisisSlice::len(self : FinancetimecrisisSlice) -> Int { self.size }

pub fn FinancetimecrisisSlice::get(self : FinancetimecrisisSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimecrisisSlice::set(self : FinancetimecrisisSlice, i : Int, v : Double) -> FinancetimecrisisSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisSlice::sum(self : FinancetimecrisisSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimecrisisSlice::mean(self : FinancetimecrisisSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimecrisisSlice::scale(self : FinancetimecrisisSlice, f : Double) -> FinancetimecrisisSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisSlice::add(self : FinancetimecrisisSlice, other : FinancetimecrisisSlice) -> FinancetimecrisisSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimecrisisSlice::copy(self : FinancetimecrisisSlice) -> FinancetimecrisisSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisSlice::fill(self : FinancetimecrisisSlice, v : Double) -> FinancetimecrisisSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimecrisisSlice::min(self : FinancetimecrisisSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimecrisisSlice::max(self : FinancetimecrisisSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimecrisisSlice::to_string(self : FinancetimecrisisSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

