///===
/// extcore/timeseries_decomp_wavelet

pub(all) struct TimeseriesdecompwaveletPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_wavelet_make_point(x : Double, y : Double) -> TimeseriesdecompwaveletPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_wavelet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompwaveletPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompwaveletPoint::x(self : TimeseriesdecompwaveletPoint) -> Double { self.x }

pub fn TimeseriesdecompwaveletPoint::y(self : TimeseriesdecompwaveletPoint) -> Double { self.y }

pub fn TimeseriesdecompwaveletPoint::z(self : TimeseriesdecompwaveletPoint) -> Double { self.z }

pub fn TimeseriesdecompwaveletPoint::label(self : TimeseriesdecompwaveletPoint) -> Int { self.label }

pub fn TimeseriesdecompwaveletPoint::dist(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompwaveletPoint::add(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompwaveletPoint::sub(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompwaveletPoint::scale(self : TimeseriesdecompwaveletPoint, s : Double) -> TimeseriesdecompwaveletPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompwaveletPoint::dot(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompwaveletPoint::cross(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompwaveletPoint::norm(self : TimeseriesdecompwaveletPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompwaveletPoint::normalize(self : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompwaveletPoint::negate(self : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompwaveletPoint::mid(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint) -> TimeseriesdecompwaveletPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompwaveletPoint::lerp(self : TimeseriesdecompwaveletPoint, other : TimeseriesdecompwaveletPoint, t : Double) -> TimeseriesdecompwaveletPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompwaveletPoint::to_string(self : TimeseriesdecompwaveletPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_wavelet_make_series(vals : Array[Double], name : String) -> TimeseriesdecompwaveletSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompwaveletSeries::len(self : TimeseriesdecompwaveletSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompwaveletSeries::sum(self : TimeseriesdecompwaveletSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompwaveletSeries::mean(self : TimeseriesdecompwaveletSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompwaveletSeries::min(self : TimeseriesdecompwaveletSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompwaveletSeries::max(self : TimeseriesdecompwaveletSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompwaveletSeries::range(self : TimeseriesdecompwaveletSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompwaveletSeries::variance(self : TimeseriesdecompwaveletSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompwaveletSeries::std(self : TimeseriesdecompwaveletSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompwaveletSeries::median(self : TimeseriesdecompwaveletSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompwaveletSeries::scale(self : TimeseriesdecompwaveletSeries, f : Double) -> TimeseriesdecompwaveletSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompwaveletSeries::add(self : TimeseriesdecompwaveletSeries, other : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompwaveletSeries::sub(self : TimeseriesdecompwaveletSeries, other : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompwaveletSeries::normalize(self : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompwaveletSeries::cumsum(self : TimeseriesdecompwaveletSeries) -> TimeseriesdecompwaveletSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompwaveletSeries::to_string(self : TimeseriesdecompwaveletSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompwaveletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_wavelet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompwaveletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_wavelet_matrix_identity(n : Int) -> TimeseriesdecompwaveletMatrix {
  let m = timeseries_decomp_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompwaveletMatrix::get(self : TimeseriesdecompwaveletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompwaveletMatrix::transpose(self : TimeseriesdecompwaveletMatrix) -> TimeseriesdecompwaveletMatrix {
  let result = timeseries_decomp_wavelet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompwaveletMatrix::add(self : TimeseriesdecompwaveletMatrix, other : TimeseriesdecompwaveletMatrix) -> TimeseriesdecompwaveletMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_wavelet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompwaveletMatrix::scale(self : TimeseriesdecompwaveletMatrix, s : Double) -> TimeseriesdecompwaveletMatrix {
  let result = timeseries_decomp_wavelet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompwaveletMatrix::multiply(self : TimeseriesdecompwaveletMatrix, other : TimeseriesdecompwaveletMatrix) -> TimeseriesdecompwaveletMatrix {
  if self.cols != other.rows { return timeseries_decomp_wavelet_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_wavelet_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompwaveletMatrix::trace(self : TimeseriesdecompwaveletMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompwaveletMatrix::det(self : TimeseriesdecompwaveletMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompwaveletMatrix::norm(self : TimeseriesdecompwaveletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompwaveletMatrix::to_string(self : TimeseriesdecompwaveletMatrix) -> String {
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

pub(all) struct TimeseriesdecompwaveletVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_wavelet_make_vector(comps : Array[Double]) -> TimeseriesdecompwaveletVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_wavelet_vector_zero(dim : Int) -> TimeseriesdecompwaveletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompwaveletVector::add(self : TimeseriesdecompwaveletVector, other : TimeseriesdecompwaveletVector) -> TimeseriesdecompwaveletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompwaveletVector::sub(self : TimeseriesdecompwaveletVector, other : TimeseriesdecompwaveletVector) -> TimeseriesdecompwaveletVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompwaveletVector::scale(self : TimeseriesdecompwaveletVector, s : Double) -> TimeseriesdecompwaveletVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompwaveletVector::dot(self : TimeseriesdecompwaveletVector, other : TimeseriesdecompwaveletVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompwaveletVector::norm(self : TimeseriesdecompwaveletVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompwaveletVector::normalize(self : TimeseriesdecompwaveletVector) -> TimeseriesdecompwaveletVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompwaveletVector::dist(self : TimeseriesdecompwaveletVector, other : TimeseriesdecompwaveletVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompwaveletVector::to_string(self : TimeseriesdecompwaveletVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_wavelet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_wavelet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_wavelet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_wavelet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_wavelet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_wavelet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_wavelet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_wavelet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_wavelet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_wavelet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_wavelet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_wavelet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_wavelet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_wavelet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_wavelet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_wavelet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_wavelet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_wavelet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_wavelet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_wavelet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_wavelet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_wavelet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_wavelet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_wavelet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_wavelet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_wavelet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_wavelet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_wavelet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_wavelet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompwaveletFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_frame_make(size : Int) -> TimeseriesdecompwaveletFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_frame_len(s : TimeseriesdecompwaveletFrame) -> Int { s.size }

pub fn timeseries_decomp_wavelet_frame_get(s : TimeseriesdecompwaveletFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_frame_set(s : TimeseriesdecompwaveletFrame, i : Int, v : Double) -> TimeseriesdecompwaveletFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_frame_sum(s : TimeseriesdecompwaveletFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_frame_mean(s : TimeseriesdecompwaveletFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_frame_scale(s : TimeseriesdecompwaveletFrame, f : Double) -> TimeseriesdecompwaveletFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_frame_add(a : TimeseriesdecompwaveletFrame, b : TimeseriesdecompwaveletFrame) -> TimeseriesdecompwaveletFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_frame_copy(s : TimeseriesdecompwaveletFrame) -> TimeseriesdecompwaveletFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_frame_fill(s : TimeseriesdecompwaveletFrame, v : Double) -> TimeseriesdecompwaveletFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_frame_min(s : TimeseriesdecompwaveletFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_frame_max(s : TimeseriesdecompwaveletFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_frame_to_string(s : TimeseriesdecompwaveletFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_table_make(size : Int) -> TimeseriesdecompwaveletTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_table_len(s : TimeseriesdecompwaveletTable) -> Int { s.size }

pub fn timeseries_decomp_wavelet_table_get(s : TimeseriesdecompwaveletTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_table_set(s : TimeseriesdecompwaveletTable, i : Int, v : Double) -> TimeseriesdecompwaveletTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_table_sum(s : TimeseriesdecompwaveletTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_table_mean(s : TimeseriesdecompwaveletTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_table_scale(s : TimeseriesdecompwaveletTable, f : Double) -> TimeseriesdecompwaveletTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_table_add(a : TimeseriesdecompwaveletTable, b : TimeseriesdecompwaveletTable) -> TimeseriesdecompwaveletTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_table_copy(s : TimeseriesdecompwaveletTable) -> TimeseriesdecompwaveletTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_table_fill(s : TimeseriesdecompwaveletTable, v : Double) -> TimeseriesdecompwaveletTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_table_min(s : TimeseriesdecompwaveletTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_table_max(s : TimeseriesdecompwaveletTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_table_to_string(s : TimeseriesdecompwaveletTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_graphn_make(size : Int) -> TimeseriesdecompwaveletGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_graphn_len(s : TimeseriesdecompwaveletGraphN) -> Int { s.size }

pub fn timeseries_decomp_wavelet_graphn_get(s : TimeseriesdecompwaveletGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_graphn_set(s : TimeseriesdecompwaveletGraphN, i : Int, v : Double) -> TimeseriesdecompwaveletGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_graphn_sum(s : TimeseriesdecompwaveletGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_graphn_mean(s : TimeseriesdecompwaveletGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_graphn_scale(s : TimeseriesdecompwaveletGraphN, f : Double) -> TimeseriesdecompwaveletGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_graphn_add(a : TimeseriesdecompwaveletGraphN, b : TimeseriesdecompwaveletGraphN) -> TimeseriesdecompwaveletGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_graphn_copy(s : TimeseriesdecompwaveletGraphN) -> TimeseriesdecompwaveletGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_graphn_fill(s : TimeseriesdecompwaveletGraphN, v : Double) -> TimeseriesdecompwaveletGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_graphn_min(s : TimeseriesdecompwaveletGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_graphn_max(s : TimeseriesdecompwaveletGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_graphn_to_string(s : TimeseriesdecompwaveletGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_node_make(size : Int) -> TimeseriesdecompwaveletNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_node_len(s : TimeseriesdecompwaveletNode) -> Int { s.size }

pub fn timeseries_decomp_wavelet_node_get(s : TimeseriesdecompwaveletNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_node_set(s : TimeseriesdecompwaveletNode, i : Int, v : Double) -> TimeseriesdecompwaveletNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_node_sum(s : TimeseriesdecompwaveletNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_node_mean(s : TimeseriesdecompwaveletNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_node_scale(s : TimeseriesdecompwaveletNode, f : Double) -> TimeseriesdecompwaveletNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_node_add(a : TimeseriesdecompwaveletNode, b : TimeseriesdecompwaveletNode) -> TimeseriesdecompwaveletNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_node_copy(s : TimeseriesdecompwaveletNode) -> TimeseriesdecompwaveletNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_node_fill(s : TimeseriesdecompwaveletNode, v : Double) -> TimeseriesdecompwaveletNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_node_min(s : TimeseriesdecompwaveletNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_node_max(s : TimeseriesdecompwaveletNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_node_to_string(s : TimeseriesdecompwaveletNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_edge_make(size : Int) -> TimeseriesdecompwaveletEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_edge_len(s : TimeseriesdecompwaveletEdge) -> Int { s.size }

pub fn timeseries_decomp_wavelet_edge_get(s : TimeseriesdecompwaveletEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_edge_set(s : TimeseriesdecompwaveletEdge, i : Int, v : Double) -> TimeseriesdecompwaveletEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_edge_sum(s : TimeseriesdecompwaveletEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_edge_mean(s : TimeseriesdecompwaveletEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_edge_scale(s : TimeseriesdecompwaveletEdge, f : Double) -> TimeseriesdecompwaveletEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_edge_add(a : TimeseriesdecompwaveletEdge, b : TimeseriesdecompwaveletEdge) -> TimeseriesdecompwaveletEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_edge_copy(s : TimeseriesdecompwaveletEdge) -> TimeseriesdecompwaveletEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_edge_fill(s : TimeseriesdecompwaveletEdge, v : Double) -> TimeseriesdecompwaveletEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_edge_min(s : TimeseriesdecompwaveletEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_edge_max(s : TimeseriesdecompwaveletEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_edge_to_string(s : TimeseriesdecompwaveletEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_path_make(size : Int) -> TimeseriesdecompwaveletPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_path_len(s : TimeseriesdecompwaveletPath) -> Int { s.size }

pub fn timeseries_decomp_wavelet_path_get(s : TimeseriesdecompwaveletPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_path_set(s : TimeseriesdecompwaveletPath, i : Int, v : Double) -> TimeseriesdecompwaveletPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_path_sum(s : TimeseriesdecompwaveletPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_path_mean(s : TimeseriesdecompwaveletPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_path_scale(s : TimeseriesdecompwaveletPath, f : Double) -> TimeseriesdecompwaveletPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_path_add(a : TimeseriesdecompwaveletPath, b : TimeseriesdecompwaveletPath) -> TimeseriesdecompwaveletPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_path_copy(s : TimeseriesdecompwaveletPath) -> TimeseriesdecompwaveletPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_path_fill(s : TimeseriesdecompwaveletPath, v : Double) -> TimeseriesdecompwaveletPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_path_min(s : TimeseriesdecompwaveletPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_path_max(s : TimeseriesdecompwaveletPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_path_to_string(s : TimeseriesdecompwaveletPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_cluster_make(size : Int) -> TimeseriesdecompwaveletCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_cluster_len(s : TimeseriesdecompwaveletCluster) -> Int { s.size }

pub fn timeseries_decomp_wavelet_cluster_get(s : TimeseriesdecompwaveletCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_cluster_set(s : TimeseriesdecompwaveletCluster, i : Int, v : Double) -> TimeseriesdecompwaveletCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cluster_sum(s : TimeseriesdecompwaveletCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_cluster_mean(s : TimeseriesdecompwaveletCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_cluster_scale(s : TimeseriesdecompwaveletCluster, f : Double) -> TimeseriesdecompwaveletCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cluster_add(a : TimeseriesdecompwaveletCluster, b : TimeseriesdecompwaveletCluster) -> TimeseriesdecompwaveletCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_cluster_copy(s : TimeseriesdecompwaveletCluster) -> TimeseriesdecompwaveletCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cluster_fill(s : TimeseriesdecompwaveletCluster, v : Double) -> TimeseriesdecompwaveletCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cluster_min(s : TimeseriesdecompwaveletCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_cluster_max(s : TimeseriesdecompwaveletCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_cluster_to_string(s : TimeseriesdecompwaveletCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_model_make(size : Int) -> TimeseriesdecompwaveletModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_model_len(s : TimeseriesdecompwaveletModel) -> Int { s.size }

pub fn timeseries_decomp_wavelet_model_get(s : TimeseriesdecompwaveletModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_model_set(s : TimeseriesdecompwaveletModel, i : Int, v : Double) -> TimeseriesdecompwaveletModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_model_sum(s : TimeseriesdecompwaveletModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_model_mean(s : TimeseriesdecompwaveletModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_model_scale(s : TimeseriesdecompwaveletModel, f : Double) -> TimeseriesdecompwaveletModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_model_add(a : TimeseriesdecompwaveletModel, b : TimeseriesdecompwaveletModel) -> TimeseriesdecompwaveletModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_model_copy(s : TimeseriesdecompwaveletModel) -> TimeseriesdecompwaveletModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_model_fill(s : TimeseriesdecompwaveletModel, v : Double) -> TimeseriesdecompwaveletModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_model_min(s : TimeseriesdecompwaveletModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_model_max(s : TimeseriesdecompwaveletModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_model_to_string(s : TimeseriesdecompwaveletModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_layer_make(size : Int) -> TimeseriesdecompwaveletLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_layer_len(s : TimeseriesdecompwaveletLayer) -> Int { s.size }

pub fn timeseries_decomp_wavelet_layer_get(s : TimeseriesdecompwaveletLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_layer_set(s : TimeseriesdecompwaveletLayer, i : Int, v : Double) -> TimeseriesdecompwaveletLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_layer_sum(s : TimeseriesdecompwaveletLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_layer_mean(s : TimeseriesdecompwaveletLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_layer_scale(s : TimeseriesdecompwaveletLayer, f : Double) -> TimeseriesdecompwaveletLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_layer_add(a : TimeseriesdecompwaveletLayer, b : TimeseriesdecompwaveletLayer) -> TimeseriesdecompwaveletLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_layer_copy(s : TimeseriesdecompwaveletLayer) -> TimeseriesdecompwaveletLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_layer_fill(s : TimeseriesdecompwaveletLayer, v : Double) -> TimeseriesdecompwaveletLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_layer_min(s : TimeseriesdecompwaveletLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_layer_max(s : TimeseriesdecompwaveletLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_layer_to_string(s : TimeseriesdecompwaveletLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_buffer_make(size : Int) -> TimeseriesdecompwaveletBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_buffer_len(s : TimeseriesdecompwaveletBuffer) -> Int { s.size }

pub fn timeseries_decomp_wavelet_buffer_get(s : TimeseriesdecompwaveletBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_buffer_set(s : TimeseriesdecompwaveletBuffer, i : Int, v : Double) -> TimeseriesdecompwaveletBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_buffer_sum(s : TimeseriesdecompwaveletBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_buffer_mean(s : TimeseriesdecompwaveletBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_buffer_scale(s : TimeseriesdecompwaveletBuffer, f : Double) -> TimeseriesdecompwaveletBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_buffer_add(a : TimeseriesdecompwaveletBuffer, b : TimeseriesdecompwaveletBuffer) -> TimeseriesdecompwaveletBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_buffer_copy(s : TimeseriesdecompwaveletBuffer) -> TimeseriesdecompwaveletBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_buffer_fill(s : TimeseriesdecompwaveletBuffer, v : Double) -> TimeseriesdecompwaveletBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_buffer_min(s : TimeseriesdecompwaveletBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_buffer_max(s : TimeseriesdecompwaveletBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_buffer_to_string(s : TimeseriesdecompwaveletBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_cursor_make(size : Int) -> TimeseriesdecompwaveletCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_cursor_len(s : TimeseriesdecompwaveletCursor) -> Int { s.size }

pub fn timeseries_decomp_wavelet_cursor_get(s : TimeseriesdecompwaveletCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_cursor_set(s : TimeseriesdecompwaveletCursor, i : Int, v : Double) -> TimeseriesdecompwaveletCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cursor_sum(s : TimeseriesdecompwaveletCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_cursor_mean(s : TimeseriesdecompwaveletCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_cursor_scale(s : TimeseriesdecompwaveletCursor, f : Double) -> TimeseriesdecompwaveletCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cursor_add(a : TimeseriesdecompwaveletCursor, b : TimeseriesdecompwaveletCursor) -> TimeseriesdecompwaveletCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_cursor_copy(s : TimeseriesdecompwaveletCursor) -> TimeseriesdecompwaveletCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cursor_fill(s : TimeseriesdecompwaveletCursor, v : Double) -> TimeseriesdecompwaveletCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_cursor_min(s : TimeseriesdecompwaveletCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_cursor_max(s : TimeseriesdecompwaveletCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_cursor_to_string(s : TimeseriesdecompwaveletCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_view_make(size : Int) -> TimeseriesdecompwaveletView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_view_len(s : TimeseriesdecompwaveletView) -> Int { s.size }

pub fn timeseries_decomp_wavelet_view_get(s : TimeseriesdecompwaveletView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_view_set(s : TimeseriesdecompwaveletView, i : Int, v : Double) -> TimeseriesdecompwaveletView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_view_sum(s : TimeseriesdecompwaveletView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_view_mean(s : TimeseriesdecompwaveletView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_view_scale(s : TimeseriesdecompwaveletView, f : Double) -> TimeseriesdecompwaveletView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_view_add(a : TimeseriesdecompwaveletView, b : TimeseriesdecompwaveletView) -> TimeseriesdecompwaveletView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_view_copy(s : TimeseriesdecompwaveletView) -> TimeseriesdecompwaveletView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_view_fill(s : TimeseriesdecompwaveletView, v : Double) -> TimeseriesdecompwaveletView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_view_min(s : TimeseriesdecompwaveletView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_view_max(s : TimeseriesdecompwaveletView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_view_to_string(s : TimeseriesdecompwaveletView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_range_make(size : Int) -> TimeseriesdecompwaveletRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_range_len(s : TimeseriesdecompwaveletRange) -> Int { s.size }

pub fn timeseries_decomp_wavelet_range_get(s : TimeseriesdecompwaveletRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_range_set(s : TimeseriesdecompwaveletRange, i : Int, v : Double) -> TimeseriesdecompwaveletRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_range_sum(s : TimeseriesdecompwaveletRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_range_mean(s : TimeseriesdecompwaveletRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_range_scale(s : TimeseriesdecompwaveletRange, f : Double) -> TimeseriesdecompwaveletRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_range_add(a : TimeseriesdecompwaveletRange, b : TimeseriesdecompwaveletRange) -> TimeseriesdecompwaveletRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_range_copy(s : TimeseriesdecompwaveletRange) -> TimeseriesdecompwaveletRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_range_fill(s : TimeseriesdecompwaveletRange, v : Double) -> TimeseriesdecompwaveletRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_range_min(s : TimeseriesdecompwaveletRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_range_max(s : TimeseriesdecompwaveletRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_range_to_string(s : TimeseriesdecompwaveletRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompwaveletSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_wavelet_slice_make(size : Int) -> TimeseriesdecompwaveletSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_wavelet_slice_len(s : TimeseriesdecompwaveletSlice) -> Int { s.size }

pub fn timeseries_decomp_wavelet_slice_get(s : TimeseriesdecompwaveletSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_wavelet_slice_set(s : TimeseriesdecompwaveletSlice, i : Int, v : Double) -> TimeseriesdecompwaveletSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_slice_sum(s : TimeseriesdecompwaveletSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_wavelet_slice_mean(s : TimeseriesdecompwaveletSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_wavelet_slice_scale(s : TimeseriesdecompwaveletSlice, f : Double) -> TimeseriesdecompwaveletSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_slice_add(a : TimeseriesdecompwaveletSlice, b : TimeseriesdecompwaveletSlice) -> TimeseriesdecompwaveletSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_wavelet_slice_copy(s : TimeseriesdecompwaveletSlice) -> TimeseriesdecompwaveletSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_slice_fill(s : TimeseriesdecompwaveletSlice, v : Double) -> TimeseriesdecompwaveletSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_wavelet_slice_min(s : TimeseriesdecompwaveletSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_wavelet_slice_max(s : TimeseriesdecompwaveletSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_wavelet_slice_to_string(s : TimeseriesdecompwaveletSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

