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

pub fn finance_pricing_finite_diff_frame_len(s : FinancepricingfinitediffFrame) -> Int { s.size }

pub fn finance_pricing_finite_diff_frame_get(s : FinancepricingfinitediffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_frame_set(s : FinancepricingfinitediffFrame, i : Int, v : Double) -> FinancepricingfinitediffFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_frame_sum(s : FinancepricingfinitediffFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_frame_mean(s : FinancepricingfinitediffFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_frame_scale(s : FinancepricingfinitediffFrame, f : Double) -> FinancepricingfinitediffFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_frame_add(a : FinancepricingfinitediffFrame, b : FinancepricingfinitediffFrame) -> FinancepricingfinitediffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_frame_copy(s : FinancepricingfinitediffFrame) -> FinancepricingfinitediffFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_frame_fill(s : FinancepricingfinitediffFrame, v : Double) -> FinancepricingfinitediffFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_frame_min(s : FinancepricingfinitediffFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_frame_max(s : FinancepricingfinitediffFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_frame_to_string(s : FinancepricingfinitediffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_table_make(size : Int) -> FinancepricingfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_table_len(s : FinancepricingfinitediffTable) -> Int { s.size }

pub fn finance_pricing_finite_diff_table_get(s : FinancepricingfinitediffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_table_set(s : FinancepricingfinitediffTable, i : Int, v : Double) -> FinancepricingfinitediffTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_table_sum(s : FinancepricingfinitediffTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_table_mean(s : FinancepricingfinitediffTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_table_scale(s : FinancepricingfinitediffTable, f : Double) -> FinancepricingfinitediffTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_table_add(a : FinancepricingfinitediffTable, b : FinancepricingfinitediffTable) -> FinancepricingfinitediffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_table_copy(s : FinancepricingfinitediffTable) -> FinancepricingfinitediffTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_table_fill(s : FinancepricingfinitediffTable, v : Double) -> FinancepricingfinitediffTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_table_min(s : FinancepricingfinitediffTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_table_max(s : FinancepricingfinitediffTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_table_to_string(s : FinancepricingfinitediffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_graphn_make(size : Int) -> FinancepricingfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_graphn_len(s : FinancepricingfinitediffGraphN) -> Int { s.size }

pub fn finance_pricing_finite_diff_graphn_get(s : FinancepricingfinitediffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_graphn_set(s : FinancepricingfinitediffGraphN, i : Int, v : Double) -> FinancepricingfinitediffGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_graphn_sum(s : FinancepricingfinitediffGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_graphn_mean(s : FinancepricingfinitediffGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_graphn_scale(s : FinancepricingfinitediffGraphN, f : Double) -> FinancepricingfinitediffGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_graphn_add(a : FinancepricingfinitediffGraphN, b : FinancepricingfinitediffGraphN) -> FinancepricingfinitediffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_graphn_copy(s : FinancepricingfinitediffGraphN) -> FinancepricingfinitediffGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_graphn_fill(s : FinancepricingfinitediffGraphN, v : Double) -> FinancepricingfinitediffGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_graphn_min(s : FinancepricingfinitediffGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_graphn_max(s : FinancepricingfinitediffGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_graphn_to_string(s : FinancepricingfinitediffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_node_make(size : Int) -> FinancepricingfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_node_len(s : FinancepricingfinitediffNode) -> Int { s.size }

pub fn finance_pricing_finite_diff_node_get(s : FinancepricingfinitediffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_node_set(s : FinancepricingfinitediffNode, i : Int, v : Double) -> FinancepricingfinitediffNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_node_sum(s : FinancepricingfinitediffNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_node_mean(s : FinancepricingfinitediffNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_node_scale(s : FinancepricingfinitediffNode, f : Double) -> FinancepricingfinitediffNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_node_add(a : FinancepricingfinitediffNode, b : FinancepricingfinitediffNode) -> FinancepricingfinitediffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_node_copy(s : FinancepricingfinitediffNode) -> FinancepricingfinitediffNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_node_fill(s : FinancepricingfinitediffNode, v : Double) -> FinancepricingfinitediffNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_node_min(s : FinancepricingfinitediffNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_node_max(s : FinancepricingfinitediffNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_node_to_string(s : FinancepricingfinitediffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_edge_make(size : Int) -> FinancepricingfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_edge_len(s : FinancepricingfinitediffEdge) -> Int { s.size }

pub fn finance_pricing_finite_diff_edge_get(s : FinancepricingfinitediffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_edge_set(s : FinancepricingfinitediffEdge, i : Int, v : Double) -> FinancepricingfinitediffEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_edge_sum(s : FinancepricingfinitediffEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_edge_mean(s : FinancepricingfinitediffEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_edge_scale(s : FinancepricingfinitediffEdge, f : Double) -> FinancepricingfinitediffEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_edge_add(a : FinancepricingfinitediffEdge, b : FinancepricingfinitediffEdge) -> FinancepricingfinitediffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_edge_copy(s : FinancepricingfinitediffEdge) -> FinancepricingfinitediffEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_edge_fill(s : FinancepricingfinitediffEdge, v : Double) -> FinancepricingfinitediffEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_edge_min(s : FinancepricingfinitediffEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_edge_max(s : FinancepricingfinitediffEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_edge_to_string(s : FinancepricingfinitediffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_path_make(size : Int) -> FinancepricingfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_path_len(s : FinancepricingfinitediffPath) -> Int { s.size }

pub fn finance_pricing_finite_diff_path_get(s : FinancepricingfinitediffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_path_set(s : FinancepricingfinitediffPath, i : Int, v : Double) -> FinancepricingfinitediffPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_path_sum(s : FinancepricingfinitediffPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_path_mean(s : FinancepricingfinitediffPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_path_scale(s : FinancepricingfinitediffPath, f : Double) -> FinancepricingfinitediffPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_path_add(a : FinancepricingfinitediffPath, b : FinancepricingfinitediffPath) -> FinancepricingfinitediffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_path_copy(s : FinancepricingfinitediffPath) -> FinancepricingfinitediffPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_path_fill(s : FinancepricingfinitediffPath, v : Double) -> FinancepricingfinitediffPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_path_min(s : FinancepricingfinitediffPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_path_max(s : FinancepricingfinitediffPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_path_to_string(s : FinancepricingfinitediffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_cluster_make(size : Int) -> FinancepricingfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_cluster_len(s : FinancepricingfinitediffCluster) -> Int { s.size }

pub fn finance_pricing_finite_diff_cluster_get(s : FinancepricingfinitediffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_cluster_set(s : FinancepricingfinitediffCluster, i : Int, v : Double) -> FinancepricingfinitediffCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cluster_sum(s : FinancepricingfinitediffCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_cluster_mean(s : FinancepricingfinitediffCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_cluster_scale(s : FinancepricingfinitediffCluster, f : Double) -> FinancepricingfinitediffCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cluster_add(a : FinancepricingfinitediffCluster, b : FinancepricingfinitediffCluster) -> FinancepricingfinitediffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_cluster_copy(s : FinancepricingfinitediffCluster) -> FinancepricingfinitediffCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cluster_fill(s : FinancepricingfinitediffCluster, v : Double) -> FinancepricingfinitediffCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cluster_min(s : FinancepricingfinitediffCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_cluster_max(s : FinancepricingfinitediffCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_cluster_to_string(s : FinancepricingfinitediffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_model_make(size : Int) -> FinancepricingfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_model_len(s : FinancepricingfinitediffModel) -> Int { s.size }

pub fn finance_pricing_finite_diff_model_get(s : FinancepricingfinitediffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_model_set(s : FinancepricingfinitediffModel, i : Int, v : Double) -> FinancepricingfinitediffModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_model_sum(s : FinancepricingfinitediffModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_model_mean(s : FinancepricingfinitediffModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_model_scale(s : FinancepricingfinitediffModel, f : Double) -> FinancepricingfinitediffModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_model_add(a : FinancepricingfinitediffModel, b : FinancepricingfinitediffModel) -> FinancepricingfinitediffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_model_copy(s : FinancepricingfinitediffModel) -> FinancepricingfinitediffModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_model_fill(s : FinancepricingfinitediffModel, v : Double) -> FinancepricingfinitediffModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_model_min(s : FinancepricingfinitediffModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_model_max(s : FinancepricingfinitediffModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_model_to_string(s : FinancepricingfinitediffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_layer_make(size : Int) -> FinancepricingfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_layer_len(s : FinancepricingfinitediffLayer) -> Int { s.size }

pub fn finance_pricing_finite_diff_layer_get(s : FinancepricingfinitediffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_layer_set(s : FinancepricingfinitediffLayer, i : Int, v : Double) -> FinancepricingfinitediffLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_layer_sum(s : FinancepricingfinitediffLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_layer_mean(s : FinancepricingfinitediffLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_layer_scale(s : FinancepricingfinitediffLayer, f : Double) -> FinancepricingfinitediffLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_layer_add(a : FinancepricingfinitediffLayer, b : FinancepricingfinitediffLayer) -> FinancepricingfinitediffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_layer_copy(s : FinancepricingfinitediffLayer) -> FinancepricingfinitediffLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_layer_fill(s : FinancepricingfinitediffLayer, v : Double) -> FinancepricingfinitediffLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_layer_min(s : FinancepricingfinitediffLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_layer_max(s : FinancepricingfinitediffLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_layer_to_string(s : FinancepricingfinitediffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_buffer_make(size : Int) -> FinancepricingfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_buffer_len(s : FinancepricingfinitediffBuffer) -> Int { s.size }

pub fn finance_pricing_finite_diff_buffer_get(s : FinancepricingfinitediffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_buffer_set(s : FinancepricingfinitediffBuffer, i : Int, v : Double) -> FinancepricingfinitediffBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_buffer_sum(s : FinancepricingfinitediffBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_buffer_mean(s : FinancepricingfinitediffBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_buffer_scale(s : FinancepricingfinitediffBuffer, f : Double) -> FinancepricingfinitediffBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_buffer_add(a : FinancepricingfinitediffBuffer, b : FinancepricingfinitediffBuffer) -> FinancepricingfinitediffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_buffer_copy(s : FinancepricingfinitediffBuffer) -> FinancepricingfinitediffBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_buffer_fill(s : FinancepricingfinitediffBuffer, v : Double) -> FinancepricingfinitediffBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_buffer_min(s : FinancepricingfinitediffBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_buffer_max(s : FinancepricingfinitediffBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_buffer_to_string(s : FinancepricingfinitediffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_cursor_make(size : Int) -> FinancepricingfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_cursor_len(s : FinancepricingfinitediffCursor) -> Int { s.size }

pub fn finance_pricing_finite_diff_cursor_get(s : FinancepricingfinitediffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_cursor_set(s : FinancepricingfinitediffCursor, i : Int, v : Double) -> FinancepricingfinitediffCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cursor_sum(s : FinancepricingfinitediffCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_cursor_mean(s : FinancepricingfinitediffCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_cursor_scale(s : FinancepricingfinitediffCursor, f : Double) -> FinancepricingfinitediffCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cursor_add(a : FinancepricingfinitediffCursor, b : FinancepricingfinitediffCursor) -> FinancepricingfinitediffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_cursor_copy(s : FinancepricingfinitediffCursor) -> FinancepricingfinitediffCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cursor_fill(s : FinancepricingfinitediffCursor, v : Double) -> FinancepricingfinitediffCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_cursor_min(s : FinancepricingfinitediffCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_cursor_max(s : FinancepricingfinitediffCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_cursor_to_string(s : FinancepricingfinitediffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_view_make(size : Int) -> FinancepricingfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_view_len(s : FinancepricingfinitediffView) -> Int { s.size }

pub fn finance_pricing_finite_diff_view_get(s : FinancepricingfinitediffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_view_set(s : FinancepricingfinitediffView, i : Int, v : Double) -> FinancepricingfinitediffView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_view_sum(s : FinancepricingfinitediffView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_view_mean(s : FinancepricingfinitediffView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_view_scale(s : FinancepricingfinitediffView, f : Double) -> FinancepricingfinitediffView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_view_add(a : FinancepricingfinitediffView, b : FinancepricingfinitediffView) -> FinancepricingfinitediffView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_view_copy(s : FinancepricingfinitediffView) -> FinancepricingfinitediffView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_view_fill(s : FinancepricingfinitediffView, v : Double) -> FinancepricingfinitediffView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_view_min(s : FinancepricingfinitediffView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_view_max(s : FinancepricingfinitediffView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_view_to_string(s : FinancepricingfinitediffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_range_make(size : Int) -> FinancepricingfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_range_len(s : FinancepricingfinitediffRange) -> Int { s.size }

pub fn finance_pricing_finite_diff_range_get(s : FinancepricingfinitediffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_range_set(s : FinancepricingfinitediffRange, i : Int, v : Double) -> FinancepricingfinitediffRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_range_sum(s : FinancepricingfinitediffRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_range_mean(s : FinancepricingfinitediffRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_range_scale(s : FinancepricingfinitediffRange, f : Double) -> FinancepricingfinitediffRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_range_add(a : FinancepricingfinitediffRange, b : FinancepricingfinitediffRange) -> FinancepricingfinitediffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_range_copy(s : FinancepricingfinitediffRange) -> FinancepricingfinitediffRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_range_fill(s : FinancepricingfinitediffRange, v : Double) -> FinancepricingfinitediffRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_range_min(s : FinancepricingfinitediffRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_range_max(s : FinancepricingfinitediffRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_range_to_string(s : FinancepricingfinitediffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingfinitediffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_finite_diff_slice_make(size : Int) -> FinancepricingfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_finite_diff_slice_len(s : FinancepricingfinitediffSlice) -> Int { s.size }

pub fn finance_pricing_finite_diff_slice_get(s : FinancepricingfinitediffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_finite_diff_slice_set(s : FinancepricingfinitediffSlice, i : Int, v : Double) -> FinancepricingfinitediffSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_slice_sum(s : FinancepricingfinitediffSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_finite_diff_slice_mean(s : FinancepricingfinitediffSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_finite_diff_slice_scale(s : FinancepricingfinitediffSlice, f : Double) -> FinancepricingfinitediffSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_slice_add(a : FinancepricingfinitediffSlice, b : FinancepricingfinitediffSlice) -> FinancepricingfinitediffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_finite_diff_slice_copy(s : FinancepricingfinitediffSlice) -> FinancepricingfinitediffSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_slice_fill(s : FinancepricingfinitediffSlice, v : Double) -> FinancepricingfinitediffSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_finite_diff_slice_min(s : FinancepricingfinitediffSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_finite_diff_slice_max(s : FinancepricingfinitediffSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_finite_diff_slice_to_string(s : FinancepricingfinitediffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

