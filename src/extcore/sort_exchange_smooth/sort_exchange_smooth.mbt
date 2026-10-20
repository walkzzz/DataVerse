///===
/// extcore/sort_exchange_smooth

pub(all) struct SortexchangesmoothPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_smooth_make_point(x : Double, y : Double) -> SortexchangesmoothPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_smooth_make_point3(x : Double, y : Double, z : Double) -> SortexchangesmoothPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangesmoothPoint::x(self : SortexchangesmoothPoint) -> Double { self.x }

pub fn SortexchangesmoothPoint::y(self : SortexchangesmoothPoint) -> Double { self.y }

pub fn SortexchangesmoothPoint::z(self : SortexchangesmoothPoint) -> Double { self.z }

pub fn SortexchangesmoothPoint::label(self : SortexchangesmoothPoint) -> Int { self.label }

pub fn SortexchangesmoothPoint::dist(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangesmoothPoint::add(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangesmoothPoint::sub(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangesmoothPoint::scale(self : SortexchangesmoothPoint, s : Double) -> SortexchangesmoothPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangesmoothPoint::dot(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangesmoothPoint::cross(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangesmoothPoint::norm(self : SortexchangesmoothPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangesmoothPoint::normalize(self : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangesmoothPoint::negate(self : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangesmoothPoint::mid(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangesmoothPoint::lerp(self : SortexchangesmoothPoint, other : SortexchangesmoothPoint, t : Double) -> SortexchangesmoothPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangesmoothPoint::to_string(self : SortexchangesmoothPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangesmoothSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_smooth_make_series(vals : Array[Double], name : String) -> SortexchangesmoothSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangesmoothSeries::len(self : SortexchangesmoothSeries) -> Int { self.vals.length() }

pub fn SortexchangesmoothSeries::sum(self : SortexchangesmoothSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangesmoothSeries::mean(self : SortexchangesmoothSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangesmoothSeries::min(self : SortexchangesmoothSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangesmoothSeries::max(self : SortexchangesmoothSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangesmoothSeries::range(self : SortexchangesmoothSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangesmoothSeries::variance(self : SortexchangesmoothSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangesmoothSeries::std(self : SortexchangesmoothSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangesmoothSeries::median(self : SortexchangesmoothSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangesmoothSeries::scale(self : SortexchangesmoothSeries, f : Double) -> SortexchangesmoothSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangesmoothSeries::add(self : SortexchangesmoothSeries, other : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangesmoothSeries::sub(self : SortexchangesmoothSeries, other : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangesmoothSeries::normalize(self : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangesmoothSeries::cumsum(self : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangesmoothSeries::to_string(self : SortexchangesmoothSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangesmoothMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_smooth_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangesmoothMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_smooth_matrix_identity(n : Int) -> SortexchangesmoothMatrix {
  let m = sort_exchange_smooth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangesmoothMatrix::get(self : SortexchangesmoothMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangesmoothMatrix::transpose(self : SortexchangesmoothMatrix) -> SortexchangesmoothMatrix {
  let result = sort_exchange_smooth_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangesmoothMatrix::add(self : SortexchangesmoothMatrix, other : SortexchangesmoothMatrix) -> SortexchangesmoothMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_smooth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangesmoothMatrix::scale(self : SortexchangesmoothMatrix, s : Double) -> SortexchangesmoothMatrix {
  let result = sort_exchange_smooth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangesmoothMatrix::multiply(self : SortexchangesmoothMatrix, other : SortexchangesmoothMatrix) -> SortexchangesmoothMatrix {
  if self.cols != other.rows { return sort_exchange_smooth_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_smooth_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangesmoothMatrix::trace(self : SortexchangesmoothMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangesmoothMatrix::det(self : SortexchangesmoothMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangesmoothMatrix::norm(self : SortexchangesmoothMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangesmoothMatrix::to_string(self : SortexchangesmoothMatrix) -> String {
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

pub(all) struct SortexchangesmoothVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_smooth_make_vector(comps : Array[Double]) -> SortexchangesmoothVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_smooth_vector_zero(dim : Int) -> SortexchangesmoothVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangesmoothVector::add(self : SortexchangesmoothVector, other : SortexchangesmoothVector) -> SortexchangesmoothVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangesmoothVector::sub(self : SortexchangesmoothVector, other : SortexchangesmoothVector) -> SortexchangesmoothVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangesmoothVector::scale(self : SortexchangesmoothVector, s : Double) -> SortexchangesmoothVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangesmoothVector::dot(self : SortexchangesmoothVector, other : SortexchangesmoothVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangesmoothVector::norm(self : SortexchangesmoothVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangesmoothVector::normalize(self : SortexchangesmoothVector) -> SortexchangesmoothVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangesmoothVector::dist(self : SortexchangesmoothVector, other : SortexchangesmoothVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangesmoothVector::to_string(self : SortexchangesmoothVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_smooth_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_smooth_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_smooth_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_smooth_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_smooth_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_smooth_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_smooth_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_smooth_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_smooth_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_smooth_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_smooth_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_smooth_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_smooth_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_smooth_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_smooth_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_smooth_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_smooth_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_smooth_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_smooth_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_smooth_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_smooth_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_smooth_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_smooth_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_smooth_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_smooth_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_smooth_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_smooth_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_smooth_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_smooth_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangesmoothFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_frame_make(size : Int) -> SortexchangesmoothFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_frame_len(s : SortexchangesmoothFrame) -> Int { s.size }

pub fn sort_exchange_smooth_frame_get(s : SortexchangesmoothFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_frame_set(s : SortexchangesmoothFrame, i : Int, v : Double) -> SortexchangesmoothFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_frame_sum(s : SortexchangesmoothFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_frame_mean(s : SortexchangesmoothFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_frame_scale(s : SortexchangesmoothFrame, f : Double) -> SortexchangesmoothFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_frame_add(a : SortexchangesmoothFrame, b : SortexchangesmoothFrame) -> SortexchangesmoothFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_frame_copy(s : SortexchangesmoothFrame) -> SortexchangesmoothFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_frame_fill(s : SortexchangesmoothFrame, v : Double) -> SortexchangesmoothFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_frame_min(s : SortexchangesmoothFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_frame_max(s : SortexchangesmoothFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_frame_to_string(s : SortexchangesmoothFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_table_make(size : Int) -> SortexchangesmoothTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_table_len(s : SortexchangesmoothTable) -> Int { s.size }

pub fn sort_exchange_smooth_table_get(s : SortexchangesmoothTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_table_set(s : SortexchangesmoothTable, i : Int, v : Double) -> SortexchangesmoothTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_table_sum(s : SortexchangesmoothTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_table_mean(s : SortexchangesmoothTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_table_scale(s : SortexchangesmoothTable, f : Double) -> SortexchangesmoothTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_table_add(a : SortexchangesmoothTable, b : SortexchangesmoothTable) -> SortexchangesmoothTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_table_copy(s : SortexchangesmoothTable) -> SortexchangesmoothTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_table_fill(s : SortexchangesmoothTable, v : Double) -> SortexchangesmoothTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_table_min(s : SortexchangesmoothTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_table_max(s : SortexchangesmoothTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_table_to_string(s : SortexchangesmoothTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_graphn_make(size : Int) -> SortexchangesmoothGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_graphn_len(s : SortexchangesmoothGraphN) -> Int { s.size }

pub fn sort_exchange_smooth_graphn_get(s : SortexchangesmoothGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_graphn_set(s : SortexchangesmoothGraphN, i : Int, v : Double) -> SortexchangesmoothGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_graphn_sum(s : SortexchangesmoothGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_graphn_mean(s : SortexchangesmoothGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_graphn_scale(s : SortexchangesmoothGraphN, f : Double) -> SortexchangesmoothGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_graphn_add(a : SortexchangesmoothGraphN, b : SortexchangesmoothGraphN) -> SortexchangesmoothGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_graphn_copy(s : SortexchangesmoothGraphN) -> SortexchangesmoothGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_graphn_fill(s : SortexchangesmoothGraphN, v : Double) -> SortexchangesmoothGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_graphn_min(s : SortexchangesmoothGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_graphn_max(s : SortexchangesmoothGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_graphn_to_string(s : SortexchangesmoothGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_node_make(size : Int) -> SortexchangesmoothNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_node_len(s : SortexchangesmoothNode) -> Int { s.size }

pub fn sort_exchange_smooth_node_get(s : SortexchangesmoothNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_node_set(s : SortexchangesmoothNode, i : Int, v : Double) -> SortexchangesmoothNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_node_sum(s : SortexchangesmoothNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_node_mean(s : SortexchangesmoothNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_node_scale(s : SortexchangesmoothNode, f : Double) -> SortexchangesmoothNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_node_add(a : SortexchangesmoothNode, b : SortexchangesmoothNode) -> SortexchangesmoothNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_node_copy(s : SortexchangesmoothNode) -> SortexchangesmoothNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_node_fill(s : SortexchangesmoothNode, v : Double) -> SortexchangesmoothNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_node_min(s : SortexchangesmoothNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_node_max(s : SortexchangesmoothNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_node_to_string(s : SortexchangesmoothNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_edge_make(size : Int) -> SortexchangesmoothEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_edge_len(s : SortexchangesmoothEdge) -> Int { s.size }

pub fn sort_exchange_smooth_edge_get(s : SortexchangesmoothEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_edge_set(s : SortexchangesmoothEdge, i : Int, v : Double) -> SortexchangesmoothEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_edge_sum(s : SortexchangesmoothEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_edge_mean(s : SortexchangesmoothEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_edge_scale(s : SortexchangesmoothEdge, f : Double) -> SortexchangesmoothEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_edge_add(a : SortexchangesmoothEdge, b : SortexchangesmoothEdge) -> SortexchangesmoothEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_edge_copy(s : SortexchangesmoothEdge) -> SortexchangesmoothEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_edge_fill(s : SortexchangesmoothEdge, v : Double) -> SortexchangesmoothEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_edge_min(s : SortexchangesmoothEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_edge_max(s : SortexchangesmoothEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_edge_to_string(s : SortexchangesmoothEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_path_make(size : Int) -> SortexchangesmoothPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_path_len(s : SortexchangesmoothPath) -> Int { s.size }

pub fn sort_exchange_smooth_path_get(s : SortexchangesmoothPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_path_set(s : SortexchangesmoothPath, i : Int, v : Double) -> SortexchangesmoothPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_path_sum(s : SortexchangesmoothPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_path_mean(s : SortexchangesmoothPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_path_scale(s : SortexchangesmoothPath, f : Double) -> SortexchangesmoothPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_path_add(a : SortexchangesmoothPath, b : SortexchangesmoothPath) -> SortexchangesmoothPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_path_copy(s : SortexchangesmoothPath) -> SortexchangesmoothPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_path_fill(s : SortexchangesmoothPath, v : Double) -> SortexchangesmoothPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_path_min(s : SortexchangesmoothPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_path_max(s : SortexchangesmoothPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_path_to_string(s : SortexchangesmoothPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_cluster_make(size : Int) -> SortexchangesmoothCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_cluster_len(s : SortexchangesmoothCluster) -> Int { s.size }

pub fn sort_exchange_smooth_cluster_get(s : SortexchangesmoothCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_cluster_set(s : SortexchangesmoothCluster, i : Int, v : Double) -> SortexchangesmoothCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cluster_sum(s : SortexchangesmoothCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_cluster_mean(s : SortexchangesmoothCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_cluster_scale(s : SortexchangesmoothCluster, f : Double) -> SortexchangesmoothCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cluster_add(a : SortexchangesmoothCluster, b : SortexchangesmoothCluster) -> SortexchangesmoothCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_cluster_copy(s : SortexchangesmoothCluster) -> SortexchangesmoothCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cluster_fill(s : SortexchangesmoothCluster, v : Double) -> SortexchangesmoothCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cluster_min(s : SortexchangesmoothCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_cluster_max(s : SortexchangesmoothCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_cluster_to_string(s : SortexchangesmoothCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_model_make(size : Int) -> SortexchangesmoothModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_model_len(s : SortexchangesmoothModel) -> Int { s.size }

pub fn sort_exchange_smooth_model_get(s : SortexchangesmoothModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_model_set(s : SortexchangesmoothModel, i : Int, v : Double) -> SortexchangesmoothModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_model_sum(s : SortexchangesmoothModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_model_mean(s : SortexchangesmoothModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_model_scale(s : SortexchangesmoothModel, f : Double) -> SortexchangesmoothModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_model_add(a : SortexchangesmoothModel, b : SortexchangesmoothModel) -> SortexchangesmoothModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_model_copy(s : SortexchangesmoothModel) -> SortexchangesmoothModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_model_fill(s : SortexchangesmoothModel, v : Double) -> SortexchangesmoothModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_model_min(s : SortexchangesmoothModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_model_max(s : SortexchangesmoothModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_model_to_string(s : SortexchangesmoothModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_layer_make(size : Int) -> SortexchangesmoothLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_layer_len(s : SortexchangesmoothLayer) -> Int { s.size }

pub fn sort_exchange_smooth_layer_get(s : SortexchangesmoothLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_layer_set(s : SortexchangesmoothLayer, i : Int, v : Double) -> SortexchangesmoothLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_layer_sum(s : SortexchangesmoothLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_layer_mean(s : SortexchangesmoothLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_layer_scale(s : SortexchangesmoothLayer, f : Double) -> SortexchangesmoothLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_layer_add(a : SortexchangesmoothLayer, b : SortexchangesmoothLayer) -> SortexchangesmoothLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_layer_copy(s : SortexchangesmoothLayer) -> SortexchangesmoothLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_layer_fill(s : SortexchangesmoothLayer, v : Double) -> SortexchangesmoothLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_layer_min(s : SortexchangesmoothLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_layer_max(s : SortexchangesmoothLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_layer_to_string(s : SortexchangesmoothLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_buffer_make(size : Int) -> SortexchangesmoothBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_buffer_len(s : SortexchangesmoothBuffer) -> Int { s.size }

pub fn sort_exchange_smooth_buffer_get(s : SortexchangesmoothBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_buffer_set(s : SortexchangesmoothBuffer, i : Int, v : Double) -> SortexchangesmoothBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_buffer_sum(s : SortexchangesmoothBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_buffer_mean(s : SortexchangesmoothBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_buffer_scale(s : SortexchangesmoothBuffer, f : Double) -> SortexchangesmoothBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_buffer_add(a : SortexchangesmoothBuffer, b : SortexchangesmoothBuffer) -> SortexchangesmoothBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_buffer_copy(s : SortexchangesmoothBuffer) -> SortexchangesmoothBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_buffer_fill(s : SortexchangesmoothBuffer, v : Double) -> SortexchangesmoothBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_buffer_min(s : SortexchangesmoothBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_buffer_max(s : SortexchangesmoothBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_buffer_to_string(s : SortexchangesmoothBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_cursor_make(size : Int) -> SortexchangesmoothCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_cursor_len(s : SortexchangesmoothCursor) -> Int { s.size }

pub fn sort_exchange_smooth_cursor_get(s : SortexchangesmoothCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_cursor_set(s : SortexchangesmoothCursor, i : Int, v : Double) -> SortexchangesmoothCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cursor_sum(s : SortexchangesmoothCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_cursor_mean(s : SortexchangesmoothCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_cursor_scale(s : SortexchangesmoothCursor, f : Double) -> SortexchangesmoothCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cursor_add(a : SortexchangesmoothCursor, b : SortexchangesmoothCursor) -> SortexchangesmoothCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_cursor_copy(s : SortexchangesmoothCursor) -> SortexchangesmoothCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cursor_fill(s : SortexchangesmoothCursor, v : Double) -> SortexchangesmoothCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_cursor_min(s : SortexchangesmoothCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_cursor_max(s : SortexchangesmoothCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_cursor_to_string(s : SortexchangesmoothCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_view_make(size : Int) -> SortexchangesmoothView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_view_len(s : SortexchangesmoothView) -> Int { s.size }

pub fn sort_exchange_smooth_view_get(s : SortexchangesmoothView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_view_set(s : SortexchangesmoothView, i : Int, v : Double) -> SortexchangesmoothView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_view_sum(s : SortexchangesmoothView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_view_mean(s : SortexchangesmoothView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_view_scale(s : SortexchangesmoothView, f : Double) -> SortexchangesmoothView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_view_add(a : SortexchangesmoothView, b : SortexchangesmoothView) -> SortexchangesmoothView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_view_copy(s : SortexchangesmoothView) -> SortexchangesmoothView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_view_fill(s : SortexchangesmoothView, v : Double) -> SortexchangesmoothView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_view_min(s : SortexchangesmoothView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_view_max(s : SortexchangesmoothView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_view_to_string(s : SortexchangesmoothView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_range_make(size : Int) -> SortexchangesmoothRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_range_len(s : SortexchangesmoothRange) -> Int { s.size }

pub fn sort_exchange_smooth_range_get(s : SortexchangesmoothRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_range_set(s : SortexchangesmoothRange, i : Int, v : Double) -> SortexchangesmoothRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_range_sum(s : SortexchangesmoothRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_range_mean(s : SortexchangesmoothRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_range_scale(s : SortexchangesmoothRange, f : Double) -> SortexchangesmoothRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_range_add(a : SortexchangesmoothRange, b : SortexchangesmoothRange) -> SortexchangesmoothRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_range_copy(s : SortexchangesmoothRange) -> SortexchangesmoothRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_range_fill(s : SortexchangesmoothRange, v : Double) -> SortexchangesmoothRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_range_min(s : SortexchangesmoothRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_range_max(s : SortexchangesmoothRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_range_to_string(s : SortexchangesmoothRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_slice_make(size : Int) -> SortexchangesmoothSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_slice_len(s : SortexchangesmoothSlice) -> Int { s.size }

pub fn sort_exchange_smooth_slice_get(s : SortexchangesmoothSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_slice_set(s : SortexchangesmoothSlice, i : Int, v : Double) -> SortexchangesmoothSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_slice_sum(s : SortexchangesmoothSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_smooth_slice_mean(s : SortexchangesmoothSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_smooth_slice_scale(s : SortexchangesmoothSlice, f : Double) -> SortexchangesmoothSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_slice_add(a : SortexchangesmoothSlice, b : SortexchangesmoothSlice) -> SortexchangesmoothSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_smooth_slice_copy(s : SortexchangesmoothSlice) -> SortexchangesmoothSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_slice_fill(s : SortexchangesmoothSlice, v : Double) -> SortexchangesmoothSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_smooth_slice_min(s : SortexchangesmoothSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_smooth_slice_max(s : SortexchangesmoothSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_smooth_slice_to_string(s : SortexchangesmoothSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

