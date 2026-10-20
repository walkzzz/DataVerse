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

pub fn SortexchangesmoothFrame::len(self : SortexchangesmoothFrame) -> Int { self.size }

pub fn SortexchangesmoothFrame::get(self : SortexchangesmoothFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothFrame::set(self : SortexchangesmoothFrame, i : Int, v : Double) -> SortexchangesmoothFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothFrame::sum(self : SortexchangesmoothFrame) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothFrame::mean(self : SortexchangesmoothFrame) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothFrame::scale(self : SortexchangesmoothFrame, f : Double) -> SortexchangesmoothFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothFrame::add(self : SortexchangesmoothFrame, other : SortexchangesmoothFrame) -> SortexchangesmoothFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothFrame::copy(self : SortexchangesmoothFrame) -> SortexchangesmoothFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothFrame::fill(self : SortexchangesmoothFrame, v : Double) -> SortexchangesmoothFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothFrame::min(self : SortexchangesmoothFrame) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothFrame::max(self : SortexchangesmoothFrame) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothFrame::to_string(self : SortexchangesmoothFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_table_make(size : Int) -> SortexchangesmoothTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothTable::len(self : SortexchangesmoothTable) -> Int { self.size }

pub fn SortexchangesmoothTable::get(self : SortexchangesmoothTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothTable::set(self : SortexchangesmoothTable, i : Int, v : Double) -> SortexchangesmoothTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothTable::sum(self : SortexchangesmoothTable) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothTable::mean(self : SortexchangesmoothTable) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothTable::scale(self : SortexchangesmoothTable, f : Double) -> SortexchangesmoothTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothTable::add(self : SortexchangesmoothTable, other : SortexchangesmoothTable) -> SortexchangesmoothTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothTable::copy(self : SortexchangesmoothTable) -> SortexchangesmoothTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothTable::fill(self : SortexchangesmoothTable, v : Double) -> SortexchangesmoothTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothTable::min(self : SortexchangesmoothTable) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothTable::max(self : SortexchangesmoothTable) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothTable::to_string(self : SortexchangesmoothTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_graphn_make(size : Int) -> SortexchangesmoothGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothGraphN::len(self : SortexchangesmoothGraphN) -> Int { self.size }

pub fn SortexchangesmoothGraphN::get(self : SortexchangesmoothGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothGraphN::set(self : SortexchangesmoothGraphN, i : Int, v : Double) -> SortexchangesmoothGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothGraphN::sum(self : SortexchangesmoothGraphN) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothGraphN::mean(self : SortexchangesmoothGraphN) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothGraphN::scale(self : SortexchangesmoothGraphN, f : Double) -> SortexchangesmoothGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothGraphN::add(self : SortexchangesmoothGraphN, other : SortexchangesmoothGraphN) -> SortexchangesmoothGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothGraphN::copy(self : SortexchangesmoothGraphN) -> SortexchangesmoothGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothGraphN::fill(self : SortexchangesmoothGraphN, v : Double) -> SortexchangesmoothGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothGraphN::min(self : SortexchangesmoothGraphN) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothGraphN::max(self : SortexchangesmoothGraphN) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothGraphN::to_string(self : SortexchangesmoothGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_node_make(size : Int) -> SortexchangesmoothNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothNode::len(self : SortexchangesmoothNode) -> Int { self.size }

pub fn SortexchangesmoothNode::get(self : SortexchangesmoothNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothNode::set(self : SortexchangesmoothNode, i : Int, v : Double) -> SortexchangesmoothNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothNode::sum(self : SortexchangesmoothNode) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothNode::mean(self : SortexchangesmoothNode) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothNode::scale(self : SortexchangesmoothNode, f : Double) -> SortexchangesmoothNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothNode::add(self : SortexchangesmoothNode, other : SortexchangesmoothNode) -> SortexchangesmoothNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothNode::copy(self : SortexchangesmoothNode) -> SortexchangesmoothNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothNode::fill(self : SortexchangesmoothNode, v : Double) -> SortexchangesmoothNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothNode::min(self : SortexchangesmoothNode) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothNode::max(self : SortexchangesmoothNode) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothNode::to_string(self : SortexchangesmoothNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_edge_make(size : Int) -> SortexchangesmoothEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothEdge::len(self : SortexchangesmoothEdge) -> Int { self.size }

pub fn SortexchangesmoothEdge::get(self : SortexchangesmoothEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothEdge::set(self : SortexchangesmoothEdge, i : Int, v : Double) -> SortexchangesmoothEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothEdge::sum(self : SortexchangesmoothEdge) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothEdge::mean(self : SortexchangesmoothEdge) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothEdge::scale(self : SortexchangesmoothEdge, f : Double) -> SortexchangesmoothEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothEdge::add(self : SortexchangesmoothEdge, other : SortexchangesmoothEdge) -> SortexchangesmoothEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothEdge::copy(self : SortexchangesmoothEdge) -> SortexchangesmoothEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothEdge::fill(self : SortexchangesmoothEdge, v : Double) -> SortexchangesmoothEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothEdge::min(self : SortexchangesmoothEdge) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothEdge::max(self : SortexchangesmoothEdge) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothEdge::to_string(self : SortexchangesmoothEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_path_make(size : Int) -> SortexchangesmoothPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothPath::len(self : SortexchangesmoothPath) -> Int { self.size }

pub fn SortexchangesmoothPath::get(self : SortexchangesmoothPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothPath::set(self : SortexchangesmoothPath, i : Int, v : Double) -> SortexchangesmoothPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothPath::sum(self : SortexchangesmoothPath) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothPath::mean(self : SortexchangesmoothPath) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothPath::scale(self : SortexchangesmoothPath, f : Double) -> SortexchangesmoothPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothPath::add(self : SortexchangesmoothPath, other : SortexchangesmoothPath) -> SortexchangesmoothPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothPath::copy(self : SortexchangesmoothPath) -> SortexchangesmoothPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothPath::fill(self : SortexchangesmoothPath, v : Double) -> SortexchangesmoothPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothPath::min(self : SortexchangesmoothPath) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothPath::max(self : SortexchangesmoothPath) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothPath::to_string(self : SortexchangesmoothPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_cluster_make(size : Int) -> SortexchangesmoothCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothCluster::len(self : SortexchangesmoothCluster) -> Int { self.size }

pub fn SortexchangesmoothCluster::get(self : SortexchangesmoothCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothCluster::set(self : SortexchangesmoothCluster, i : Int, v : Double) -> SortexchangesmoothCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCluster::sum(self : SortexchangesmoothCluster) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothCluster::mean(self : SortexchangesmoothCluster) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothCluster::scale(self : SortexchangesmoothCluster, f : Double) -> SortexchangesmoothCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCluster::add(self : SortexchangesmoothCluster, other : SortexchangesmoothCluster) -> SortexchangesmoothCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothCluster::copy(self : SortexchangesmoothCluster) -> SortexchangesmoothCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCluster::fill(self : SortexchangesmoothCluster, v : Double) -> SortexchangesmoothCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCluster::min(self : SortexchangesmoothCluster) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothCluster::max(self : SortexchangesmoothCluster) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothCluster::to_string(self : SortexchangesmoothCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_model_make(size : Int) -> SortexchangesmoothModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothModel::len(self : SortexchangesmoothModel) -> Int { self.size }

pub fn SortexchangesmoothModel::get(self : SortexchangesmoothModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothModel::set(self : SortexchangesmoothModel, i : Int, v : Double) -> SortexchangesmoothModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothModel::sum(self : SortexchangesmoothModel) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothModel::mean(self : SortexchangesmoothModel) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothModel::scale(self : SortexchangesmoothModel, f : Double) -> SortexchangesmoothModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothModel::add(self : SortexchangesmoothModel, other : SortexchangesmoothModel) -> SortexchangesmoothModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothModel::copy(self : SortexchangesmoothModel) -> SortexchangesmoothModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothModel::fill(self : SortexchangesmoothModel, v : Double) -> SortexchangesmoothModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothModel::min(self : SortexchangesmoothModel) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothModel::max(self : SortexchangesmoothModel) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothModel::to_string(self : SortexchangesmoothModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_layer_make(size : Int) -> SortexchangesmoothLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothLayer::len(self : SortexchangesmoothLayer) -> Int { self.size }

pub fn SortexchangesmoothLayer::get(self : SortexchangesmoothLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothLayer::set(self : SortexchangesmoothLayer, i : Int, v : Double) -> SortexchangesmoothLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothLayer::sum(self : SortexchangesmoothLayer) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothLayer::mean(self : SortexchangesmoothLayer) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothLayer::scale(self : SortexchangesmoothLayer, f : Double) -> SortexchangesmoothLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothLayer::add(self : SortexchangesmoothLayer, other : SortexchangesmoothLayer) -> SortexchangesmoothLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothLayer::copy(self : SortexchangesmoothLayer) -> SortexchangesmoothLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothLayer::fill(self : SortexchangesmoothLayer, v : Double) -> SortexchangesmoothLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothLayer::min(self : SortexchangesmoothLayer) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothLayer::max(self : SortexchangesmoothLayer) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothLayer::to_string(self : SortexchangesmoothLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_buffer_make(size : Int) -> SortexchangesmoothBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothBuffer::len(self : SortexchangesmoothBuffer) -> Int { self.size }

pub fn SortexchangesmoothBuffer::get(self : SortexchangesmoothBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothBuffer::set(self : SortexchangesmoothBuffer, i : Int, v : Double) -> SortexchangesmoothBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothBuffer::sum(self : SortexchangesmoothBuffer) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothBuffer::mean(self : SortexchangesmoothBuffer) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothBuffer::scale(self : SortexchangesmoothBuffer, f : Double) -> SortexchangesmoothBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothBuffer::add(self : SortexchangesmoothBuffer, other : SortexchangesmoothBuffer) -> SortexchangesmoothBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothBuffer::copy(self : SortexchangesmoothBuffer) -> SortexchangesmoothBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothBuffer::fill(self : SortexchangesmoothBuffer, v : Double) -> SortexchangesmoothBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothBuffer::min(self : SortexchangesmoothBuffer) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothBuffer::max(self : SortexchangesmoothBuffer) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothBuffer::to_string(self : SortexchangesmoothBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_cursor_make(size : Int) -> SortexchangesmoothCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothCursor::len(self : SortexchangesmoothCursor) -> Int { self.size }

pub fn SortexchangesmoothCursor::get(self : SortexchangesmoothCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothCursor::set(self : SortexchangesmoothCursor, i : Int, v : Double) -> SortexchangesmoothCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCursor::sum(self : SortexchangesmoothCursor) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothCursor::mean(self : SortexchangesmoothCursor) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothCursor::scale(self : SortexchangesmoothCursor, f : Double) -> SortexchangesmoothCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCursor::add(self : SortexchangesmoothCursor, other : SortexchangesmoothCursor) -> SortexchangesmoothCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothCursor::copy(self : SortexchangesmoothCursor) -> SortexchangesmoothCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCursor::fill(self : SortexchangesmoothCursor, v : Double) -> SortexchangesmoothCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothCursor::min(self : SortexchangesmoothCursor) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothCursor::max(self : SortexchangesmoothCursor) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothCursor::to_string(self : SortexchangesmoothCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_view_make(size : Int) -> SortexchangesmoothView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothView::len(self : SortexchangesmoothView) -> Int { self.size }

pub fn SortexchangesmoothView::get(self : SortexchangesmoothView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothView::set(self : SortexchangesmoothView, i : Int, v : Double) -> SortexchangesmoothView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothView::sum(self : SortexchangesmoothView) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothView::mean(self : SortexchangesmoothView) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothView::scale(self : SortexchangesmoothView, f : Double) -> SortexchangesmoothView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothView::add(self : SortexchangesmoothView, other : SortexchangesmoothView) -> SortexchangesmoothView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothView::copy(self : SortexchangesmoothView) -> SortexchangesmoothView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothView::fill(self : SortexchangesmoothView, v : Double) -> SortexchangesmoothView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothView::min(self : SortexchangesmoothView) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothView::max(self : SortexchangesmoothView) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothView::to_string(self : SortexchangesmoothView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_range_make(size : Int) -> SortexchangesmoothRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothRange::len(self : SortexchangesmoothRange) -> Int { self.size }

pub fn SortexchangesmoothRange::get(self : SortexchangesmoothRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothRange::set(self : SortexchangesmoothRange, i : Int, v : Double) -> SortexchangesmoothRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothRange::sum(self : SortexchangesmoothRange) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothRange::mean(self : SortexchangesmoothRange) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothRange::scale(self : SortexchangesmoothRange, f : Double) -> SortexchangesmoothRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothRange::add(self : SortexchangesmoothRange, other : SortexchangesmoothRange) -> SortexchangesmoothRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothRange::copy(self : SortexchangesmoothRange) -> SortexchangesmoothRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothRange::fill(self : SortexchangesmoothRange, v : Double) -> SortexchangesmoothRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothRange::min(self : SortexchangesmoothRange) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothRange::max(self : SortexchangesmoothRange) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothRange::to_string(self : SortexchangesmoothRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_slice_make(size : Int) -> SortexchangesmoothSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangesmoothSlice::len(self : SortexchangesmoothSlice) -> Int { self.size }

pub fn SortexchangesmoothSlice::get(self : SortexchangesmoothSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangesmoothSlice::set(self : SortexchangesmoothSlice, i : Int, v : Double) -> SortexchangesmoothSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothSlice::sum(self : SortexchangesmoothSlice) -> Double { @_common.sum(self.data) }

pub fn SortexchangesmoothSlice::mean(self : SortexchangesmoothSlice) -> Double { @_common.mean(self.data) }

pub fn SortexchangesmoothSlice::scale(self : SortexchangesmoothSlice, f : Double) -> SortexchangesmoothSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothSlice::add(self : SortexchangesmoothSlice, other : SortexchangesmoothSlice) -> SortexchangesmoothSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangesmoothSlice::copy(self : SortexchangesmoothSlice) -> SortexchangesmoothSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothSlice::fill(self : SortexchangesmoothSlice, v : Double) -> SortexchangesmoothSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangesmoothSlice::min(self : SortexchangesmoothSlice) -> Double { @_common.min(self.data) }

pub fn SortexchangesmoothSlice::max(self : SortexchangesmoothSlice) -> Double { @_common.max(self.data) }

pub fn SortexchangesmoothSlice::to_string(self : SortexchangesmoothSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

