///===
/// extcore/finance_pricing_barrier

pub(all) struct FinancepricingbarrierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_barrier_make_point(x : Double, y : Double) -> FinancepricingbarrierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_barrier_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbarrierPoint {
  { x, y, z, label: 0 }
}

pub fn FinancepricingbarrierPoint::x(self : FinancepricingbarrierPoint) -> Double { self.x }

pub fn FinancepricingbarrierPoint::y(self : FinancepricingbarrierPoint) -> Double { self.y }

pub fn FinancepricingbarrierPoint::z(self : FinancepricingbarrierPoint) -> Double { self.z }

pub fn FinancepricingbarrierPoint::label(self : FinancepricingbarrierPoint) -> Int { self.label }

pub fn FinancepricingbarrierPoint::dist(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancepricingbarrierPoint::add(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancepricingbarrierPoint::sub(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancepricingbarrierPoint::scale(self : FinancepricingbarrierPoint, s : Double) -> FinancepricingbarrierPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancepricingbarrierPoint::dot(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancepricingbarrierPoint::cross(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancepricingbarrierPoint::norm(self : FinancepricingbarrierPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancepricingbarrierPoint::normalize(self : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbarrierPoint::negate(self : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancepricingbarrierPoint::mid(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint) -> FinancepricingbarrierPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancepricingbarrierPoint::lerp(self : FinancepricingbarrierPoint, other : FinancepricingbarrierPoint, t : Double) -> FinancepricingbarrierPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancepricingbarrierPoint::to_string(self : FinancepricingbarrierPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancepricingbarrierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_barrier_make_series(vals : Array[Double], name : String) -> FinancepricingbarrierSeries {
  { vals, name, meta: 0 }
}

pub fn FinancepricingbarrierSeries::len(self : FinancepricingbarrierSeries) -> Int { self.vals.length() }

pub fn FinancepricingbarrierSeries::sum(self : FinancepricingbarrierSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancepricingbarrierSeries::mean(self : FinancepricingbarrierSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancepricingbarrierSeries::min(self : FinancepricingbarrierSeries) -> Double { @_common.min(self.vals) }

pub fn FinancepricingbarrierSeries::max(self : FinancepricingbarrierSeries) -> Double { @_common.max(self.vals) }

pub fn FinancepricingbarrierSeries::range(self : FinancepricingbarrierSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancepricingbarrierSeries::variance(self : FinancepricingbarrierSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancepricingbarrierSeries::std(self : FinancepricingbarrierSeries) -> Double { @_common.std(self.vals) }

pub fn FinancepricingbarrierSeries::median(self : FinancepricingbarrierSeries) -> Double { @_common.median(self.vals) }

pub fn FinancepricingbarrierSeries::scale(self : FinancepricingbarrierSeries, f : Double) -> FinancepricingbarrierSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancepricingbarrierSeries::add(self : FinancepricingbarrierSeries, other : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancepricingbarrierSeries::sub(self : FinancepricingbarrierSeries, other : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancepricingbarrierSeries::normalize(self : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancepricingbarrierSeries::cumsum(self : FinancepricingbarrierSeries) -> FinancepricingbarrierSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancepricingbarrierSeries::to_string(self : FinancepricingbarrierSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbarrierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_barrier_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbarrierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_barrier_matrix_identity(n : Int) -> FinancepricingbarrierMatrix {
  let m = finance_pricing_barrier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancepricingbarrierMatrix::get(self : FinancepricingbarrierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancepricingbarrierMatrix::transpose(self : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  let result = finance_pricing_barrier_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancepricingbarrierMatrix::add(self : FinancepricingbarrierMatrix, other : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_pricing_barrier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancepricingbarrierMatrix::scale(self : FinancepricingbarrierMatrix, s : Double) -> FinancepricingbarrierMatrix {
  let result = finance_pricing_barrier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancepricingbarrierMatrix::multiply(self : FinancepricingbarrierMatrix, other : FinancepricingbarrierMatrix) -> FinancepricingbarrierMatrix {
  if self.cols != other.rows { return finance_pricing_barrier_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_pricing_barrier_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancepricingbarrierMatrix::trace(self : FinancepricingbarrierMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancepricingbarrierMatrix::det(self : FinancepricingbarrierMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancepricingbarrierMatrix::norm(self : FinancepricingbarrierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancepricingbarrierMatrix::to_string(self : FinancepricingbarrierMatrix) -> String {
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

pub(all) struct FinancepricingbarrierVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_barrier_make_vector(comps : Array[Double]) -> FinancepricingbarrierVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_barrier_vector_zero(dim : Int) -> FinancepricingbarrierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancepricingbarrierVector::add(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbarrierVector::sub(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancepricingbarrierVector::scale(self : FinancepricingbarrierVector, s : Double) -> FinancepricingbarrierVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancepricingbarrierVector::dot(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancepricingbarrierVector::norm(self : FinancepricingbarrierVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancepricingbarrierVector::normalize(self : FinancepricingbarrierVector) -> FinancepricingbarrierVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancepricingbarrierVector::dist(self : FinancepricingbarrierVector, other : FinancepricingbarrierVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancepricingbarrierVector::to_string(self : FinancepricingbarrierVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_barrier_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_barrier_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_barrier_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_barrier_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_barrier_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_barrier_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_barrier_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_barrier_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_barrier_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_barrier_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_barrier_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_barrier_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_barrier_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_barrier_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_barrier_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_barrier_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_barrier_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_barrier_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_barrier_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_barrier_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_barrier_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_barrier_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_barrier_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_barrier_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_barrier_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_barrier_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_barrier_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_barrier_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_barrier_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingbarrierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_frame_make(size : Int) -> FinancepricingbarrierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_frame_len(s : FinancepricingbarrierFrame) -> Int { s.size }

pub fn finance_pricing_barrier_frame_get(s : FinancepricingbarrierFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_frame_set(s : FinancepricingbarrierFrame, i : Int, v : Double) -> FinancepricingbarrierFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_sum(s : FinancepricingbarrierFrame) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_frame_mean(s : FinancepricingbarrierFrame) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_frame_scale(s : FinancepricingbarrierFrame, f : Double) -> FinancepricingbarrierFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_add(a : FinancepricingbarrierFrame, b : FinancepricingbarrierFrame) -> FinancepricingbarrierFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_frame_copy(s : FinancepricingbarrierFrame) -> FinancepricingbarrierFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_fill(s : FinancepricingbarrierFrame, v : Double) -> FinancepricingbarrierFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_frame_min(s : FinancepricingbarrierFrame) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_frame_max(s : FinancepricingbarrierFrame) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_frame_to_string(s : FinancepricingbarrierFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_table_make(size : Int) -> FinancepricingbarrierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_table_len(s : FinancepricingbarrierTable) -> Int { s.size }

pub fn finance_pricing_barrier_table_get(s : FinancepricingbarrierTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_table_set(s : FinancepricingbarrierTable, i : Int, v : Double) -> FinancepricingbarrierTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_sum(s : FinancepricingbarrierTable) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_table_mean(s : FinancepricingbarrierTable) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_table_scale(s : FinancepricingbarrierTable, f : Double) -> FinancepricingbarrierTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_add(a : FinancepricingbarrierTable, b : FinancepricingbarrierTable) -> FinancepricingbarrierTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_table_copy(s : FinancepricingbarrierTable) -> FinancepricingbarrierTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_fill(s : FinancepricingbarrierTable, v : Double) -> FinancepricingbarrierTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_table_min(s : FinancepricingbarrierTable) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_table_max(s : FinancepricingbarrierTable) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_table_to_string(s : FinancepricingbarrierTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_graphn_make(size : Int) -> FinancepricingbarrierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_graphn_len(s : FinancepricingbarrierGraphN) -> Int { s.size }

pub fn finance_pricing_barrier_graphn_get(s : FinancepricingbarrierGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_graphn_set(s : FinancepricingbarrierGraphN, i : Int, v : Double) -> FinancepricingbarrierGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_sum(s : FinancepricingbarrierGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_graphn_mean(s : FinancepricingbarrierGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_graphn_scale(s : FinancepricingbarrierGraphN, f : Double) -> FinancepricingbarrierGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_add(a : FinancepricingbarrierGraphN, b : FinancepricingbarrierGraphN) -> FinancepricingbarrierGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_graphn_copy(s : FinancepricingbarrierGraphN) -> FinancepricingbarrierGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_fill(s : FinancepricingbarrierGraphN, v : Double) -> FinancepricingbarrierGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_graphn_min(s : FinancepricingbarrierGraphN) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_graphn_max(s : FinancepricingbarrierGraphN) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_graphn_to_string(s : FinancepricingbarrierGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_node_make(size : Int) -> FinancepricingbarrierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_node_len(s : FinancepricingbarrierNode) -> Int { s.size }

pub fn finance_pricing_barrier_node_get(s : FinancepricingbarrierNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_node_set(s : FinancepricingbarrierNode, i : Int, v : Double) -> FinancepricingbarrierNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_sum(s : FinancepricingbarrierNode) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_node_mean(s : FinancepricingbarrierNode) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_node_scale(s : FinancepricingbarrierNode, f : Double) -> FinancepricingbarrierNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_add(a : FinancepricingbarrierNode, b : FinancepricingbarrierNode) -> FinancepricingbarrierNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_node_copy(s : FinancepricingbarrierNode) -> FinancepricingbarrierNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_fill(s : FinancepricingbarrierNode, v : Double) -> FinancepricingbarrierNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_node_min(s : FinancepricingbarrierNode) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_node_max(s : FinancepricingbarrierNode) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_node_to_string(s : FinancepricingbarrierNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_edge_make(size : Int) -> FinancepricingbarrierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_edge_len(s : FinancepricingbarrierEdge) -> Int { s.size }

pub fn finance_pricing_barrier_edge_get(s : FinancepricingbarrierEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_edge_set(s : FinancepricingbarrierEdge, i : Int, v : Double) -> FinancepricingbarrierEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_sum(s : FinancepricingbarrierEdge) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_edge_mean(s : FinancepricingbarrierEdge) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_edge_scale(s : FinancepricingbarrierEdge, f : Double) -> FinancepricingbarrierEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_add(a : FinancepricingbarrierEdge, b : FinancepricingbarrierEdge) -> FinancepricingbarrierEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_edge_copy(s : FinancepricingbarrierEdge) -> FinancepricingbarrierEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_fill(s : FinancepricingbarrierEdge, v : Double) -> FinancepricingbarrierEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_edge_min(s : FinancepricingbarrierEdge) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_edge_max(s : FinancepricingbarrierEdge) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_edge_to_string(s : FinancepricingbarrierEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_path_make(size : Int) -> FinancepricingbarrierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_path_len(s : FinancepricingbarrierPath) -> Int { s.size }

pub fn finance_pricing_barrier_path_get(s : FinancepricingbarrierPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_path_set(s : FinancepricingbarrierPath, i : Int, v : Double) -> FinancepricingbarrierPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_sum(s : FinancepricingbarrierPath) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_path_mean(s : FinancepricingbarrierPath) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_path_scale(s : FinancepricingbarrierPath, f : Double) -> FinancepricingbarrierPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_add(a : FinancepricingbarrierPath, b : FinancepricingbarrierPath) -> FinancepricingbarrierPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_path_copy(s : FinancepricingbarrierPath) -> FinancepricingbarrierPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_fill(s : FinancepricingbarrierPath, v : Double) -> FinancepricingbarrierPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_path_min(s : FinancepricingbarrierPath) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_path_max(s : FinancepricingbarrierPath) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_path_to_string(s : FinancepricingbarrierPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_cluster_make(size : Int) -> FinancepricingbarrierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_cluster_len(s : FinancepricingbarrierCluster) -> Int { s.size }

pub fn finance_pricing_barrier_cluster_get(s : FinancepricingbarrierCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_cluster_set(s : FinancepricingbarrierCluster, i : Int, v : Double) -> FinancepricingbarrierCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_sum(s : FinancepricingbarrierCluster) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_cluster_mean(s : FinancepricingbarrierCluster) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_cluster_scale(s : FinancepricingbarrierCluster, f : Double) -> FinancepricingbarrierCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_add(a : FinancepricingbarrierCluster, b : FinancepricingbarrierCluster) -> FinancepricingbarrierCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_cluster_copy(s : FinancepricingbarrierCluster) -> FinancepricingbarrierCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_fill(s : FinancepricingbarrierCluster, v : Double) -> FinancepricingbarrierCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cluster_min(s : FinancepricingbarrierCluster) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_cluster_max(s : FinancepricingbarrierCluster) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_cluster_to_string(s : FinancepricingbarrierCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_model_make(size : Int) -> FinancepricingbarrierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_model_len(s : FinancepricingbarrierModel) -> Int { s.size }

pub fn finance_pricing_barrier_model_get(s : FinancepricingbarrierModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_model_set(s : FinancepricingbarrierModel, i : Int, v : Double) -> FinancepricingbarrierModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_sum(s : FinancepricingbarrierModel) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_model_mean(s : FinancepricingbarrierModel) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_model_scale(s : FinancepricingbarrierModel, f : Double) -> FinancepricingbarrierModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_add(a : FinancepricingbarrierModel, b : FinancepricingbarrierModel) -> FinancepricingbarrierModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_model_copy(s : FinancepricingbarrierModel) -> FinancepricingbarrierModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_fill(s : FinancepricingbarrierModel, v : Double) -> FinancepricingbarrierModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_model_min(s : FinancepricingbarrierModel) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_model_max(s : FinancepricingbarrierModel) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_model_to_string(s : FinancepricingbarrierModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_layer_make(size : Int) -> FinancepricingbarrierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_layer_len(s : FinancepricingbarrierLayer) -> Int { s.size }

pub fn finance_pricing_barrier_layer_get(s : FinancepricingbarrierLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_layer_set(s : FinancepricingbarrierLayer, i : Int, v : Double) -> FinancepricingbarrierLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_sum(s : FinancepricingbarrierLayer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_layer_mean(s : FinancepricingbarrierLayer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_layer_scale(s : FinancepricingbarrierLayer, f : Double) -> FinancepricingbarrierLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_add(a : FinancepricingbarrierLayer, b : FinancepricingbarrierLayer) -> FinancepricingbarrierLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_layer_copy(s : FinancepricingbarrierLayer) -> FinancepricingbarrierLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_fill(s : FinancepricingbarrierLayer, v : Double) -> FinancepricingbarrierLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_layer_min(s : FinancepricingbarrierLayer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_layer_max(s : FinancepricingbarrierLayer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_layer_to_string(s : FinancepricingbarrierLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_buffer_make(size : Int) -> FinancepricingbarrierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_buffer_len(s : FinancepricingbarrierBuffer) -> Int { s.size }

pub fn finance_pricing_barrier_buffer_get(s : FinancepricingbarrierBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_buffer_set(s : FinancepricingbarrierBuffer, i : Int, v : Double) -> FinancepricingbarrierBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_sum(s : FinancepricingbarrierBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_buffer_mean(s : FinancepricingbarrierBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_buffer_scale(s : FinancepricingbarrierBuffer, f : Double) -> FinancepricingbarrierBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_add(a : FinancepricingbarrierBuffer, b : FinancepricingbarrierBuffer) -> FinancepricingbarrierBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_buffer_copy(s : FinancepricingbarrierBuffer) -> FinancepricingbarrierBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_fill(s : FinancepricingbarrierBuffer, v : Double) -> FinancepricingbarrierBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_buffer_min(s : FinancepricingbarrierBuffer) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_buffer_max(s : FinancepricingbarrierBuffer) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_buffer_to_string(s : FinancepricingbarrierBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_cursor_make(size : Int) -> FinancepricingbarrierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_cursor_len(s : FinancepricingbarrierCursor) -> Int { s.size }

pub fn finance_pricing_barrier_cursor_get(s : FinancepricingbarrierCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_cursor_set(s : FinancepricingbarrierCursor, i : Int, v : Double) -> FinancepricingbarrierCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_sum(s : FinancepricingbarrierCursor) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_cursor_mean(s : FinancepricingbarrierCursor) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_cursor_scale(s : FinancepricingbarrierCursor, f : Double) -> FinancepricingbarrierCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_add(a : FinancepricingbarrierCursor, b : FinancepricingbarrierCursor) -> FinancepricingbarrierCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_cursor_copy(s : FinancepricingbarrierCursor) -> FinancepricingbarrierCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_fill(s : FinancepricingbarrierCursor, v : Double) -> FinancepricingbarrierCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_cursor_min(s : FinancepricingbarrierCursor) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_cursor_max(s : FinancepricingbarrierCursor) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_cursor_to_string(s : FinancepricingbarrierCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_view_make(size : Int) -> FinancepricingbarrierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_view_len(s : FinancepricingbarrierView) -> Int { s.size }

pub fn finance_pricing_barrier_view_get(s : FinancepricingbarrierView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_view_set(s : FinancepricingbarrierView, i : Int, v : Double) -> FinancepricingbarrierView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_sum(s : FinancepricingbarrierView) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_view_mean(s : FinancepricingbarrierView) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_view_scale(s : FinancepricingbarrierView, f : Double) -> FinancepricingbarrierView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_add(a : FinancepricingbarrierView, b : FinancepricingbarrierView) -> FinancepricingbarrierView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_view_copy(s : FinancepricingbarrierView) -> FinancepricingbarrierView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_fill(s : FinancepricingbarrierView, v : Double) -> FinancepricingbarrierView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_view_min(s : FinancepricingbarrierView) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_view_max(s : FinancepricingbarrierView) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_view_to_string(s : FinancepricingbarrierView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_range_make(size : Int) -> FinancepricingbarrierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_range_len(s : FinancepricingbarrierRange) -> Int { s.size }

pub fn finance_pricing_barrier_range_get(s : FinancepricingbarrierRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_range_set(s : FinancepricingbarrierRange, i : Int, v : Double) -> FinancepricingbarrierRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_sum(s : FinancepricingbarrierRange) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_range_mean(s : FinancepricingbarrierRange) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_range_scale(s : FinancepricingbarrierRange, f : Double) -> FinancepricingbarrierRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_add(a : FinancepricingbarrierRange, b : FinancepricingbarrierRange) -> FinancepricingbarrierRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_range_copy(s : FinancepricingbarrierRange) -> FinancepricingbarrierRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_fill(s : FinancepricingbarrierRange, v : Double) -> FinancepricingbarrierRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_range_min(s : FinancepricingbarrierRange) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_range_max(s : FinancepricingbarrierRange) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_range_to_string(s : FinancepricingbarrierRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbarrierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_barrier_slice_make(size : Int) -> FinancepricingbarrierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_barrier_slice_len(s : FinancepricingbarrierSlice) -> Int { s.size }

pub fn finance_pricing_barrier_slice_get(s : FinancepricingbarrierSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_barrier_slice_set(s : FinancepricingbarrierSlice, i : Int, v : Double) -> FinancepricingbarrierSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_sum(s : FinancepricingbarrierSlice) -> Double { @_common.sum(s.data) }

pub fn finance_pricing_barrier_slice_mean(s : FinancepricingbarrierSlice) -> Double { @_common.mean(s.data) }

pub fn finance_pricing_barrier_slice_scale(s : FinancepricingbarrierSlice, f : Double) -> FinancepricingbarrierSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_add(a : FinancepricingbarrierSlice, b : FinancepricingbarrierSlice) -> FinancepricingbarrierSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_pricing_barrier_slice_copy(s : FinancepricingbarrierSlice) -> FinancepricingbarrierSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_fill(s : FinancepricingbarrierSlice, v : Double) -> FinancepricingbarrierSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_pricing_barrier_slice_min(s : FinancepricingbarrierSlice) -> Double { @_common.min(s.data) }

pub fn finance_pricing_barrier_slice_max(s : FinancepricingbarrierSlice) -> Double { @_common.max(s.data) }

pub fn finance_pricing_barrier_slice_to_string(s : FinancepricingbarrierSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

