///===
/// extcore/finance_pricing_finite_diff

pub(all) struct FinancepricingfinitediffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_finite_diff_make_point(x : Double, y : Double) -> FinancepricingfinitediffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_finite_diff_make_point3(x : Double, y : Double, z : Double) -> FinancepricingfinitediffPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingfinitediffPoint::x(self : FinancepricingfinitediffPoint) -> Double { self.x }

pub fn FinancepricingfinitediffPoint::y(self : FinancepricingfinitediffPoint) -> Double { self.y }

pub fn FinancepricingfinitediffPoint::z(self : FinancepricingfinitediffPoint) -> Double { self.z }

pub fn FinancepricingfinitediffPoint::label(self : FinancepricingfinitediffPoint) -> Int { self.label }

pub fn FinancepricingfinitediffPoint::dist(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingfinitediffPoint::add(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingfinitediffPoint::sub(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingfinitediffPoint::scale(self : FinancepricingfinitediffPoint, s : Double) -> FinancepricingfinitediffPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingfinitediffPoint::dot(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingfinitediffPoint::cross(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingfinitediffPoint::norm(self : FinancepricingfinitediffPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingfinitediffPoint::normalize(self : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingfinitediffPoint::negate(self : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingfinitediffPoint::mid(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint) -> FinancepricingfinitediffPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingfinitediffPoint::lerp(self : FinancepricingfinitediffPoint, other : FinancepricingfinitediffPoint, t : Double) -> FinancepricingfinitediffPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingfinitediffPoint::to_string(self : FinancepricingfinitediffPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_finite_diff_make_series(vals : Array[Double], name : String) -> FinancepricingfinitediffSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingfinitediffSeries::len(self : FinancepricingfinitediffSeries) -> Int { self.vals.length() }

pub fn FinancepricingfinitediffSeries::sum(self : FinancepricingfinitediffSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingfinitediffSeries::mean(self : FinancepricingfinitediffSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingfinitediffSeries::min(self : FinancepricingfinitediffSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingfinitediffSeries::max(self : FinancepricingfinitediffSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingfinitediffSeries::range(self : FinancepricingfinitediffSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingfinitediffSeries::variance(self : FinancepricingfinitediffSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingfinitediffSeries::std(self : FinancepricingfinitediffSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingfinitediffSeries::median(self : FinancepricingfinitediffSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingfinitediffSeries::scale(self : FinancepricingfinitediffSeries, f : Double) -> FinancepricingfinitediffSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingfinitediffSeries::add(self : FinancepricingfinitediffSeries, other : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingfinitediffSeries::sub(self : FinancepricingfinitediffSeries, other : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingfinitediffSeries::normalize(self : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingfinitediffSeries::cumsum(self : FinancepricingfinitediffSeries) -> FinancepricingfinitediffSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingfinitediffSeries::to_string(self : FinancepricingfinitediffSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingfinitediffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_finite_diff_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingfinitediffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_finite_diff_matrix_identity(n : Int) -> FinancepricingfinitediffMatrix {
  let m = finance_pricing_finite_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingfinitediffMatrix::get(self : FinancepricingfinitediffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingfinitediffMatrix::transpose(self : FinancepricingfinitediffMatrix) -> FinancepricingfinitediffMatrix {
  let result = finance_pricing_finite_diff_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingfinitediffMatrix::add(self : FinancepricingfinitediffMatrix, other : FinancepricingfinitediffMatrix) -> FinancepricingfinitediffMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_finite_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingfinitediffMatrix::scale(self : FinancepricingfinitediffMatrix, s : Double) -> FinancepricingfinitediffMatrix {
  let result = finance_pricing_finite_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingfinitediffMatrix::multiply(self : FinancepricingfinitediffMatrix, other : FinancepricingfinitediffMatrix) -> FinancepricingfinitediffMatrix {
  if self.cols != other.rows { return finance_pricing_finite_diff_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_finite_diff_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingfinitediffMatrix::trace(self : FinancepricingfinitediffMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingfinitediffMatrix::det(self : FinancepricingfinitediffMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingfinitediffMatrix::norm(self : FinancepricingfinitediffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingfinitediffMatrix::to_string(self : FinancepricingfinitediffMatrix) -> String {
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

pub(all) struct FinancepricingfinitediffVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_finite_diff_make_vector(comps : Array[Double]) -> FinancepricingfinitediffVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_finite_diff_vector_zero(dim : Int) -> FinancepricingfinitediffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingfinitediffVector::add(self : FinancepricingfinitediffVector, other : FinancepricingfinitediffVector) -> FinancepricingfinitediffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingfinitediffVector::sub(self : FinancepricingfinitediffVector, other : FinancepricingfinitediffVector) -> FinancepricingfinitediffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingfinitediffVector::scale(self : FinancepricingfinitediffVector, s : Double) -> FinancepricingfinitediffVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingfinitediffVector::dot(self : FinancepricingfinitediffVector, other : FinancepricingfinitediffVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingfinitediffVector::norm(self : FinancepricingfinitediffVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingfinitediffVector::normalize(self : FinancepricingfinitediffVector) -> FinancepricingfinitediffVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingfinitediffVector::dist(self : FinancepricingfinitediffVector, other : FinancepricingfinitediffVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingfinitediffVector::to_string(self : FinancepricingfinitediffVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_finite_diff_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_finite_diff_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_finite_diff_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_finite_diff_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_finite_diff_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_finite_diff_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_finite_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_finite_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_finite_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_finite_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_finite_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_finite_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_finite_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_finite_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_finite_diff_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_finite_diff_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_finite_diff_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_finite_diff_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_finite_diff_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_finite_diff_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_finite_diff_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_finite_diff_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_finite_diff_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_finite_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_finite_diff_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_finite_diff_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_finite_diff_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_finite_diff_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_finite_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingfinitediffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_frame_make(size : Int) -> FinancepricingfinitediffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffFrame::len(self : FinancepricingfinitediffFrame) -> Int { self.size }

pub fn FinancepricingfinitediffFrame::get(self : FinancepricingfinitediffFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffFrame::set(self : FinancepricingfinitediffFrame, i : Int, v : Double) -> FinancepricingfinitediffFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffFrame::sum(self : FinancepricingfinitediffFrame) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffFrame::mean(self : FinancepricingfinitediffFrame) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffFrame::scale(self : FinancepricingfinitediffFrame, f : Double) -> FinancepricingfinitediffFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffFrame::add(self : FinancepricingfinitediffFrame, other : FinancepricingfinitediffFrame) -> FinancepricingfinitediffFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffFrame::copy(self : FinancepricingfinitediffFrame) -> FinancepricingfinitediffFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffFrame::fill(self : FinancepricingfinitediffFrame, v : Double) -> FinancepricingfinitediffFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffFrame::min(self : FinancepricingfinitediffFrame) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffFrame::max(self : FinancepricingfinitediffFrame) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffFrame::to_string(self : FinancepricingfinitediffFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_table_make(size : Int) -> FinancepricingfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffTable::len(self : FinancepricingfinitediffTable) -> Int { self.size }

pub fn FinancepricingfinitediffTable::get(self : FinancepricingfinitediffTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffTable::set(self : FinancepricingfinitediffTable, i : Int, v : Double) -> FinancepricingfinitediffTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffTable::sum(self : FinancepricingfinitediffTable) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffTable::mean(self : FinancepricingfinitediffTable) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffTable::scale(self : FinancepricingfinitediffTable, f : Double) -> FinancepricingfinitediffTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffTable::add(self : FinancepricingfinitediffTable, other : FinancepricingfinitediffTable) -> FinancepricingfinitediffTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffTable::copy(self : FinancepricingfinitediffTable) -> FinancepricingfinitediffTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffTable::fill(self : FinancepricingfinitediffTable, v : Double) -> FinancepricingfinitediffTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffTable::min(self : FinancepricingfinitediffTable) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffTable::max(self : FinancepricingfinitediffTable) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffTable::to_string(self : FinancepricingfinitediffTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_graphn_make(size : Int) -> FinancepricingfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffGraphN::len(self : FinancepricingfinitediffGraphN) -> Int { self.size }

pub fn FinancepricingfinitediffGraphN::get(self : FinancepricingfinitediffGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffGraphN::set(self : FinancepricingfinitediffGraphN, i : Int, v : Double) -> FinancepricingfinitediffGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffGraphN::sum(self : FinancepricingfinitediffGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffGraphN::mean(self : FinancepricingfinitediffGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffGraphN::scale(self : FinancepricingfinitediffGraphN, f : Double) -> FinancepricingfinitediffGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffGraphN::add(self : FinancepricingfinitediffGraphN, other : FinancepricingfinitediffGraphN) -> FinancepricingfinitediffGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffGraphN::copy(self : FinancepricingfinitediffGraphN) -> FinancepricingfinitediffGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffGraphN::fill(self : FinancepricingfinitediffGraphN, v : Double) -> FinancepricingfinitediffGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffGraphN::min(self : FinancepricingfinitediffGraphN) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffGraphN::max(self : FinancepricingfinitediffGraphN) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffGraphN::to_string(self : FinancepricingfinitediffGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_node_make(size : Int) -> FinancepricingfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffNode::len(self : FinancepricingfinitediffNode) -> Int { self.size }

pub fn FinancepricingfinitediffNode::get(self : FinancepricingfinitediffNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffNode::set(self : FinancepricingfinitediffNode, i : Int, v : Double) -> FinancepricingfinitediffNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffNode::sum(self : FinancepricingfinitediffNode) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffNode::mean(self : FinancepricingfinitediffNode) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffNode::scale(self : FinancepricingfinitediffNode, f : Double) -> FinancepricingfinitediffNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffNode::add(self : FinancepricingfinitediffNode, other : FinancepricingfinitediffNode) -> FinancepricingfinitediffNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffNode::copy(self : FinancepricingfinitediffNode) -> FinancepricingfinitediffNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffNode::fill(self : FinancepricingfinitediffNode, v : Double) -> FinancepricingfinitediffNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffNode::min(self : FinancepricingfinitediffNode) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffNode::max(self : FinancepricingfinitediffNode) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffNode::to_string(self : FinancepricingfinitediffNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_edge_make(size : Int) -> FinancepricingfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffEdge::len(self : FinancepricingfinitediffEdge) -> Int { self.size }

pub fn FinancepricingfinitediffEdge::get(self : FinancepricingfinitediffEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffEdge::set(self : FinancepricingfinitediffEdge, i : Int, v : Double) -> FinancepricingfinitediffEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffEdge::sum(self : FinancepricingfinitediffEdge) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffEdge::mean(self : FinancepricingfinitediffEdge) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffEdge::scale(self : FinancepricingfinitediffEdge, f : Double) -> FinancepricingfinitediffEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffEdge::add(self : FinancepricingfinitediffEdge, other : FinancepricingfinitediffEdge) -> FinancepricingfinitediffEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffEdge::copy(self : FinancepricingfinitediffEdge) -> FinancepricingfinitediffEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffEdge::fill(self : FinancepricingfinitediffEdge, v : Double) -> FinancepricingfinitediffEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffEdge::min(self : FinancepricingfinitediffEdge) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffEdge::max(self : FinancepricingfinitediffEdge) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffEdge::to_string(self : FinancepricingfinitediffEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_path_make(size : Int) -> FinancepricingfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffPath::len(self : FinancepricingfinitediffPath) -> Int { self.size }

pub fn FinancepricingfinitediffPath::get(self : FinancepricingfinitediffPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffPath::set(self : FinancepricingfinitediffPath, i : Int, v : Double) -> FinancepricingfinitediffPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffPath::sum(self : FinancepricingfinitediffPath) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffPath::mean(self : FinancepricingfinitediffPath) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffPath::scale(self : FinancepricingfinitediffPath, f : Double) -> FinancepricingfinitediffPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffPath::add(self : FinancepricingfinitediffPath, other : FinancepricingfinitediffPath) -> FinancepricingfinitediffPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffPath::copy(self : FinancepricingfinitediffPath) -> FinancepricingfinitediffPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffPath::fill(self : FinancepricingfinitediffPath, v : Double) -> FinancepricingfinitediffPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffPath::min(self : FinancepricingfinitediffPath) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffPath::max(self : FinancepricingfinitediffPath) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffPath::to_string(self : FinancepricingfinitediffPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_cluster_make(size : Int) -> FinancepricingfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffCluster::len(self : FinancepricingfinitediffCluster) -> Int { self.size }

pub fn FinancepricingfinitediffCluster::get(self : FinancepricingfinitediffCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffCluster::set(self : FinancepricingfinitediffCluster, i : Int, v : Double) -> FinancepricingfinitediffCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCluster::sum(self : FinancepricingfinitediffCluster) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffCluster::mean(self : FinancepricingfinitediffCluster) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffCluster::scale(self : FinancepricingfinitediffCluster, f : Double) -> FinancepricingfinitediffCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCluster::add(self : FinancepricingfinitediffCluster, other : FinancepricingfinitediffCluster) -> FinancepricingfinitediffCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffCluster::copy(self : FinancepricingfinitediffCluster) -> FinancepricingfinitediffCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCluster::fill(self : FinancepricingfinitediffCluster, v : Double) -> FinancepricingfinitediffCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCluster::min(self : FinancepricingfinitediffCluster) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffCluster::max(self : FinancepricingfinitediffCluster) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffCluster::to_string(self : FinancepricingfinitediffCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_model_make(size : Int) -> FinancepricingfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffModel::len(self : FinancepricingfinitediffModel) -> Int { self.size }

pub fn FinancepricingfinitediffModel::get(self : FinancepricingfinitediffModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffModel::set(self : FinancepricingfinitediffModel, i : Int, v : Double) -> FinancepricingfinitediffModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffModel::sum(self : FinancepricingfinitediffModel) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffModel::mean(self : FinancepricingfinitediffModel) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffModel::scale(self : FinancepricingfinitediffModel, f : Double) -> FinancepricingfinitediffModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffModel::add(self : FinancepricingfinitediffModel, other : FinancepricingfinitediffModel) -> FinancepricingfinitediffModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffModel::copy(self : FinancepricingfinitediffModel) -> FinancepricingfinitediffModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffModel::fill(self : FinancepricingfinitediffModel, v : Double) -> FinancepricingfinitediffModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffModel::min(self : FinancepricingfinitediffModel) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffModel::max(self : FinancepricingfinitediffModel) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffModel::to_string(self : FinancepricingfinitediffModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_layer_make(size : Int) -> FinancepricingfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffLayer::len(self : FinancepricingfinitediffLayer) -> Int { self.size }

pub fn FinancepricingfinitediffLayer::get(self : FinancepricingfinitediffLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffLayer::set(self : FinancepricingfinitediffLayer, i : Int, v : Double) -> FinancepricingfinitediffLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffLayer::sum(self : FinancepricingfinitediffLayer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffLayer::mean(self : FinancepricingfinitediffLayer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffLayer::scale(self : FinancepricingfinitediffLayer, f : Double) -> FinancepricingfinitediffLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffLayer::add(self : FinancepricingfinitediffLayer, other : FinancepricingfinitediffLayer) -> FinancepricingfinitediffLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffLayer::copy(self : FinancepricingfinitediffLayer) -> FinancepricingfinitediffLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffLayer::fill(self : FinancepricingfinitediffLayer, v : Double) -> FinancepricingfinitediffLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffLayer::min(self : FinancepricingfinitediffLayer) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffLayer::max(self : FinancepricingfinitediffLayer) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffLayer::to_string(self : FinancepricingfinitediffLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_buffer_make(size : Int) -> FinancepricingfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffBuffer::len(self : FinancepricingfinitediffBuffer) -> Int { self.size }

pub fn FinancepricingfinitediffBuffer::get(self : FinancepricingfinitediffBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffBuffer::set(self : FinancepricingfinitediffBuffer, i : Int, v : Double) -> FinancepricingfinitediffBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffBuffer::sum(self : FinancepricingfinitediffBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffBuffer::mean(self : FinancepricingfinitediffBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffBuffer::scale(self : FinancepricingfinitediffBuffer, f : Double) -> FinancepricingfinitediffBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffBuffer::add(self : FinancepricingfinitediffBuffer, other : FinancepricingfinitediffBuffer) -> FinancepricingfinitediffBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffBuffer::copy(self : FinancepricingfinitediffBuffer) -> FinancepricingfinitediffBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffBuffer::fill(self : FinancepricingfinitediffBuffer, v : Double) -> FinancepricingfinitediffBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffBuffer::min(self : FinancepricingfinitediffBuffer) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffBuffer::max(self : FinancepricingfinitediffBuffer) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffBuffer::to_string(self : FinancepricingfinitediffBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_cursor_make(size : Int) -> FinancepricingfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffCursor::len(self : FinancepricingfinitediffCursor) -> Int { self.size }

pub fn FinancepricingfinitediffCursor::get(self : FinancepricingfinitediffCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffCursor::set(self : FinancepricingfinitediffCursor, i : Int, v : Double) -> FinancepricingfinitediffCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCursor::sum(self : FinancepricingfinitediffCursor) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffCursor::mean(self : FinancepricingfinitediffCursor) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffCursor::scale(self : FinancepricingfinitediffCursor, f : Double) -> FinancepricingfinitediffCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCursor::add(self : FinancepricingfinitediffCursor, other : FinancepricingfinitediffCursor) -> FinancepricingfinitediffCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffCursor::copy(self : FinancepricingfinitediffCursor) -> FinancepricingfinitediffCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCursor::fill(self : FinancepricingfinitediffCursor, v : Double) -> FinancepricingfinitediffCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffCursor::min(self : FinancepricingfinitediffCursor) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffCursor::max(self : FinancepricingfinitediffCursor) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffCursor::to_string(self : FinancepricingfinitediffCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_view_make(size : Int) -> FinancepricingfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffView::len(self : FinancepricingfinitediffView) -> Int { self.size }

pub fn FinancepricingfinitediffView::get(self : FinancepricingfinitediffView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffView::set(self : FinancepricingfinitediffView, i : Int, v : Double) -> FinancepricingfinitediffView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffView::sum(self : FinancepricingfinitediffView) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffView::mean(self : FinancepricingfinitediffView) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffView::scale(self : FinancepricingfinitediffView, f : Double) -> FinancepricingfinitediffView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffView::add(self : FinancepricingfinitediffView, other : FinancepricingfinitediffView) -> FinancepricingfinitediffView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffView::copy(self : FinancepricingfinitediffView) -> FinancepricingfinitediffView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffView::fill(self : FinancepricingfinitediffView, v : Double) -> FinancepricingfinitediffView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffView::min(self : FinancepricingfinitediffView) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffView::max(self : FinancepricingfinitediffView) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffView::to_string(self : FinancepricingfinitediffView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_range_make(size : Int) -> FinancepricingfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffRange::len(self : FinancepricingfinitediffRange) -> Int { self.size }

pub fn FinancepricingfinitediffRange::get(self : FinancepricingfinitediffRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffRange::set(self : FinancepricingfinitediffRange, i : Int, v : Double) -> FinancepricingfinitediffRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffRange::sum(self : FinancepricingfinitediffRange) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffRange::mean(self : FinancepricingfinitediffRange) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffRange::scale(self : FinancepricingfinitediffRange, f : Double) -> FinancepricingfinitediffRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffRange::add(self : FinancepricingfinitediffRange, other : FinancepricingfinitediffRange) -> FinancepricingfinitediffRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffRange::copy(self : FinancepricingfinitediffRange) -> FinancepricingfinitediffRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffRange::fill(self : FinancepricingfinitediffRange, v : Double) -> FinancepricingfinitediffRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffRange::min(self : FinancepricingfinitediffRange) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffRange::max(self : FinancepricingfinitediffRange) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffRange::to_string(self : FinancepricingfinitediffRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_slice_make(size : Int) -> FinancepricingfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancepricingfinitediffSlice::len(self : FinancepricingfinitediffSlice) -> Int { self.size }

pub fn FinancepricingfinitediffSlice::get(self : FinancepricingfinitediffSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancepricingfinitediffSlice::set(self : FinancepricingfinitediffSlice, i : Int, v : Double) -> FinancepricingfinitediffSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffSlice::sum(self : FinancepricingfinitediffSlice) -> Double { @_common.sum(self.data) }

pub fn FinancepricingfinitediffSlice::mean(self : FinancepricingfinitediffSlice) -> Double { @_common.mean(self.data) }

pub fn FinancepricingfinitediffSlice::scale(self : FinancepricingfinitediffSlice, f : Double) -> FinancepricingfinitediffSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffSlice::add(self : FinancepricingfinitediffSlice, other : FinancepricingfinitediffSlice) -> FinancepricingfinitediffSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancepricingfinitediffSlice::copy(self : FinancepricingfinitediffSlice) -> FinancepricingfinitediffSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffSlice::fill(self : FinancepricingfinitediffSlice, v : Double) -> FinancepricingfinitediffSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancepricingfinitediffSlice::min(self : FinancepricingfinitediffSlice) -> Double { @_common.min(self.data) }

pub fn FinancepricingfinitediffSlice::max(self : FinancepricingfinitediffSlice) -> Double { @_common.max(self.data) }

pub fn FinancepricingfinitediffSlice::to_string(self : FinancepricingfinitediffSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

