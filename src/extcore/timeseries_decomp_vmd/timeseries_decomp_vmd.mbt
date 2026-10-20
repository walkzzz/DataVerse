///===
/// extcore/timeseries_decomp_vmd

pub(all) struct TimeseriesdecompvmdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_vmd_make_point(x : Double, y : Double) -> TimeseriesdecompvmdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_vmd_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompvmdPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompvmdPoint::x(self : TimeseriesdecompvmdPoint) -> Double { self.x }

pub fn TimeseriesdecompvmdPoint::y(self : TimeseriesdecompvmdPoint) -> Double { self.y }

pub fn TimeseriesdecompvmdPoint::z(self : TimeseriesdecompvmdPoint) -> Double { self.z }

pub fn TimeseriesdecompvmdPoint::label(self : TimeseriesdecompvmdPoint) -> Int { self.label }

pub fn TimeseriesdecompvmdPoint::dist(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompvmdPoint::add(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::sub(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::scale(self : TimeseriesdecompvmdPoint, s : Double) -> TimeseriesdecompvmdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::dot(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompvmdPoint::cross(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompvmdPoint::norm(self : TimeseriesdecompvmdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompvmdPoint::normalize(self : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompvmdPoint::negate(self : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::mid(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint) -> TimeseriesdecompvmdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::lerp(self : TimeseriesdecompvmdPoint, other : TimeseriesdecompvmdPoint, t : Double) -> TimeseriesdecompvmdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompvmdPoint::to_string(self : TimeseriesdecompvmdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_vmd_make_series(vals : Array[Double], name : String) -> TimeseriesdecompvmdSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompvmdSeries::len(self : TimeseriesdecompvmdSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompvmdSeries::sum(self : TimeseriesdecompvmdSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompvmdSeries::mean(self : TimeseriesdecompvmdSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompvmdSeries::min(self : TimeseriesdecompvmdSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompvmdSeries::max(self : TimeseriesdecompvmdSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompvmdSeries::range(self : TimeseriesdecompvmdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompvmdSeries::variance(self : TimeseriesdecompvmdSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompvmdSeries::std(self : TimeseriesdecompvmdSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompvmdSeries::median(self : TimeseriesdecompvmdSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompvmdSeries::scale(self : TimeseriesdecompvmdSeries, f : Double) -> TimeseriesdecompvmdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::add(self : TimeseriesdecompvmdSeries, other : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::sub(self : TimeseriesdecompvmdSeries, other : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::normalize(self : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompvmdSeries::cumsum(self : TimeseriesdecompvmdSeries) -> TimeseriesdecompvmdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompvmdSeries::to_string(self : TimeseriesdecompvmdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompvmdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_vmd_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompvmdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_vmd_matrix_identity(n : Int) -> TimeseriesdecompvmdMatrix {
  let m = timeseries_decomp_vmd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompvmdMatrix::get(self : TimeseriesdecompvmdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompvmdMatrix::transpose(self : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  let result = timeseries_decomp_vmd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompvmdMatrix::add(self : TimeseriesdecompvmdMatrix, other : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_vmd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompvmdMatrix::scale(self : TimeseriesdecompvmdMatrix, s : Double) -> TimeseriesdecompvmdMatrix {
  let result = timeseries_decomp_vmd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompvmdMatrix::multiply(self : TimeseriesdecompvmdMatrix, other : TimeseriesdecompvmdMatrix) -> TimeseriesdecompvmdMatrix {
  if self.cols != other.rows { return timeseries_decomp_vmd_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_vmd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompvmdMatrix::trace(self : TimeseriesdecompvmdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompvmdMatrix::det(self : TimeseriesdecompvmdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompvmdMatrix::norm(self : TimeseriesdecompvmdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompvmdMatrix::to_string(self : TimeseriesdecompvmdMatrix) -> String {
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

pub(all) struct TimeseriesdecompvmdVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_vmd_make_vector(comps : Array[Double]) -> TimeseriesdecompvmdVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_vmd_vector_zero(dim : Int) -> TimeseriesdecompvmdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompvmdVector::add(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompvmdVector::sub(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompvmdVector::scale(self : TimeseriesdecompvmdVector, s : Double) -> TimeseriesdecompvmdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompvmdVector::dot(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompvmdVector::norm(self : TimeseriesdecompvmdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompvmdVector::normalize(self : TimeseriesdecompvmdVector) -> TimeseriesdecompvmdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompvmdVector::dist(self : TimeseriesdecompvmdVector, other : TimeseriesdecompvmdVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompvmdVector::to_string(self : TimeseriesdecompvmdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_vmd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_vmd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_vmd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_vmd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_vmd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_vmd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_vmd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_vmd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_vmd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_vmd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_vmd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_vmd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_vmd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_vmd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_vmd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_vmd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_vmd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_vmd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_vmd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_vmd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_vmd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_vmd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_vmd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_vmd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_vmd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_vmd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_vmd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_vmd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_vmd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompvmdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_frame_make(size : Int) -> TimeseriesdecompvmdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_frame_len(s : TimeseriesdecompvmdFrame) -> Int { s.size }

pub fn timeseries_decomp_vmd_frame_get(s : TimeseriesdecompvmdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_frame_set(s : TimeseriesdecompvmdFrame, i : Int, v : Double) -> TimeseriesdecompvmdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_frame_sum(s : TimeseriesdecompvmdFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_frame_mean(s : TimeseriesdecompvmdFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_frame_scale(s : TimeseriesdecompvmdFrame, f : Double) -> TimeseriesdecompvmdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_frame_add(a : TimeseriesdecompvmdFrame, b : TimeseriesdecompvmdFrame) -> TimeseriesdecompvmdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_frame_copy(s : TimeseriesdecompvmdFrame) -> TimeseriesdecompvmdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_frame_fill(s : TimeseriesdecompvmdFrame, v : Double) -> TimeseriesdecompvmdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_frame_min(s : TimeseriesdecompvmdFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_frame_max(s : TimeseriesdecompvmdFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_frame_to_string(s : TimeseriesdecompvmdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_table_make(size : Int) -> TimeseriesdecompvmdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_table_len(s : TimeseriesdecompvmdTable) -> Int { s.size }

pub fn timeseries_decomp_vmd_table_get(s : TimeseriesdecompvmdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_table_set(s : TimeseriesdecompvmdTable, i : Int, v : Double) -> TimeseriesdecompvmdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_table_sum(s : TimeseriesdecompvmdTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_table_mean(s : TimeseriesdecompvmdTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_table_scale(s : TimeseriesdecompvmdTable, f : Double) -> TimeseriesdecompvmdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_table_add(a : TimeseriesdecompvmdTable, b : TimeseriesdecompvmdTable) -> TimeseriesdecompvmdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_table_copy(s : TimeseriesdecompvmdTable) -> TimeseriesdecompvmdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_table_fill(s : TimeseriesdecompvmdTable, v : Double) -> TimeseriesdecompvmdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_table_min(s : TimeseriesdecompvmdTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_table_max(s : TimeseriesdecompvmdTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_table_to_string(s : TimeseriesdecompvmdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_graphn_make(size : Int) -> TimeseriesdecompvmdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_graphn_len(s : TimeseriesdecompvmdGraphN) -> Int { s.size }

pub fn timeseries_decomp_vmd_graphn_get(s : TimeseriesdecompvmdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_graphn_set(s : TimeseriesdecompvmdGraphN, i : Int, v : Double) -> TimeseriesdecompvmdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_graphn_sum(s : TimeseriesdecompvmdGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_graphn_mean(s : TimeseriesdecompvmdGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_graphn_scale(s : TimeseriesdecompvmdGraphN, f : Double) -> TimeseriesdecompvmdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_graphn_add(a : TimeseriesdecompvmdGraphN, b : TimeseriesdecompvmdGraphN) -> TimeseriesdecompvmdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_graphn_copy(s : TimeseriesdecompvmdGraphN) -> TimeseriesdecompvmdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_graphn_fill(s : TimeseriesdecompvmdGraphN, v : Double) -> TimeseriesdecompvmdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_graphn_min(s : TimeseriesdecompvmdGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_graphn_max(s : TimeseriesdecompvmdGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_graphn_to_string(s : TimeseriesdecompvmdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_node_make(size : Int) -> TimeseriesdecompvmdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_node_len(s : TimeseriesdecompvmdNode) -> Int { s.size }

pub fn timeseries_decomp_vmd_node_get(s : TimeseriesdecompvmdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_node_set(s : TimeseriesdecompvmdNode, i : Int, v : Double) -> TimeseriesdecompvmdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_node_sum(s : TimeseriesdecompvmdNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_node_mean(s : TimeseriesdecompvmdNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_node_scale(s : TimeseriesdecompvmdNode, f : Double) -> TimeseriesdecompvmdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_node_add(a : TimeseriesdecompvmdNode, b : TimeseriesdecompvmdNode) -> TimeseriesdecompvmdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_node_copy(s : TimeseriesdecompvmdNode) -> TimeseriesdecompvmdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_node_fill(s : TimeseriesdecompvmdNode, v : Double) -> TimeseriesdecompvmdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_node_min(s : TimeseriesdecompvmdNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_node_max(s : TimeseriesdecompvmdNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_node_to_string(s : TimeseriesdecompvmdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_edge_make(size : Int) -> TimeseriesdecompvmdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_edge_len(s : TimeseriesdecompvmdEdge) -> Int { s.size }

pub fn timeseries_decomp_vmd_edge_get(s : TimeseriesdecompvmdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_edge_set(s : TimeseriesdecompvmdEdge, i : Int, v : Double) -> TimeseriesdecompvmdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_edge_sum(s : TimeseriesdecompvmdEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_edge_mean(s : TimeseriesdecompvmdEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_edge_scale(s : TimeseriesdecompvmdEdge, f : Double) -> TimeseriesdecompvmdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_edge_add(a : TimeseriesdecompvmdEdge, b : TimeseriesdecompvmdEdge) -> TimeseriesdecompvmdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_edge_copy(s : TimeseriesdecompvmdEdge) -> TimeseriesdecompvmdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_edge_fill(s : TimeseriesdecompvmdEdge, v : Double) -> TimeseriesdecompvmdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_edge_min(s : TimeseriesdecompvmdEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_edge_max(s : TimeseriesdecompvmdEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_edge_to_string(s : TimeseriesdecompvmdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_path_make(size : Int) -> TimeseriesdecompvmdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_path_len(s : TimeseriesdecompvmdPath) -> Int { s.size }

pub fn timeseries_decomp_vmd_path_get(s : TimeseriesdecompvmdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_path_set(s : TimeseriesdecompvmdPath, i : Int, v : Double) -> TimeseriesdecompvmdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_path_sum(s : TimeseriesdecompvmdPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_path_mean(s : TimeseriesdecompvmdPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_path_scale(s : TimeseriesdecompvmdPath, f : Double) -> TimeseriesdecompvmdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_path_add(a : TimeseriesdecompvmdPath, b : TimeseriesdecompvmdPath) -> TimeseriesdecompvmdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_path_copy(s : TimeseriesdecompvmdPath) -> TimeseriesdecompvmdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_path_fill(s : TimeseriesdecompvmdPath, v : Double) -> TimeseriesdecompvmdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_path_min(s : TimeseriesdecompvmdPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_path_max(s : TimeseriesdecompvmdPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_path_to_string(s : TimeseriesdecompvmdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_cluster_make(size : Int) -> TimeseriesdecompvmdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_cluster_len(s : TimeseriesdecompvmdCluster) -> Int { s.size }

pub fn timeseries_decomp_vmd_cluster_get(s : TimeseriesdecompvmdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_cluster_set(s : TimeseriesdecompvmdCluster, i : Int, v : Double) -> TimeseriesdecompvmdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cluster_sum(s : TimeseriesdecompvmdCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_cluster_mean(s : TimeseriesdecompvmdCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_cluster_scale(s : TimeseriesdecompvmdCluster, f : Double) -> TimeseriesdecompvmdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cluster_add(a : TimeseriesdecompvmdCluster, b : TimeseriesdecompvmdCluster) -> TimeseriesdecompvmdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_cluster_copy(s : TimeseriesdecompvmdCluster) -> TimeseriesdecompvmdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cluster_fill(s : TimeseriesdecompvmdCluster, v : Double) -> TimeseriesdecompvmdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cluster_min(s : TimeseriesdecompvmdCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_cluster_max(s : TimeseriesdecompvmdCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_cluster_to_string(s : TimeseriesdecompvmdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_model_make(size : Int) -> TimeseriesdecompvmdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_model_len(s : TimeseriesdecompvmdModel) -> Int { s.size }

pub fn timeseries_decomp_vmd_model_get(s : TimeseriesdecompvmdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_model_set(s : TimeseriesdecompvmdModel, i : Int, v : Double) -> TimeseriesdecompvmdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_model_sum(s : TimeseriesdecompvmdModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_model_mean(s : TimeseriesdecompvmdModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_model_scale(s : TimeseriesdecompvmdModel, f : Double) -> TimeseriesdecompvmdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_model_add(a : TimeseriesdecompvmdModel, b : TimeseriesdecompvmdModel) -> TimeseriesdecompvmdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_model_copy(s : TimeseriesdecompvmdModel) -> TimeseriesdecompvmdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_model_fill(s : TimeseriesdecompvmdModel, v : Double) -> TimeseriesdecompvmdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_model_min(s : TimeseriesdecompvmdModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_model_max(s : TimeseriesdecompvmdModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_model_to_string(s : TimeseriesdecompvmdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_layer_make(size : Int) -> TimeseriesdecompvmdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_layer_len(s : TimeseriesdecompvmdLayer) -> Int { s.size }

pub fn timeseries_decomp_vmd_layer_get(s : TimeseriesdecompvmdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_layer_set(s : TimeseriesdecompvmdLayer, i : Int, v : Double) -> TimeseriesdecompvmdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_layer_sum(s : TimeseriesdecompvmdLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_layer_mean(s : TimeseriesdecompvmdLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_layer_scale(s : TimeseriesdecompvmdLayer, f : Double) -> TimeseriesdecompvmdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_layer_add(a : TimeseriesdecompvmdLayer, b : TimeseriesdecompvmdLayer) -> TimeseriesdecompvmdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_layer_copy(s : TimeseriesdecompvmdLayer) -> TimeseriesdecompvmdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_layer_fill(s : TimeseriesdecompvmdLayer, v : Double) -> TimeseriesdecompvmdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_layer_min(s : TimeseriesdecompvmdLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_layer_max(s : TimeseriesdecompvmdLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_layer_to_string(s : TimeseriesdecompvmdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_buffer_make(size : Int) -> TimeseriesdecompvmdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_buffer_len(s : TimeseriesdecompvmdBuffer) -> Int { s.size }

pub fn timeseries_decomp_vmd_buffer_get(s : TimeseriesdecompvmdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_buffer_set(s : TimeseriesdecompvmdBuffer, i : Int, v : Double) -> TimeseriesdecompvmdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_buffer_sum(s : TimeseriesdecompvmdBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_buffer_mean(s : TimeseriesdecompvmdBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_buffer_scale(s : TimeseriesdecompvmdBuffer, f : Double) -> TimeseriesdecompvmdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_buffer_add(a : TimeseriesdecompvmdBuffer, b : TimeseriesdecompvmdBuffer) -> TimeseriesdecompvmdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_buffer_copy(s : TimeseriesdecompvmdBuffer) -> TimeseriesdecompvmdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_buffer_fill(s : TimeseriesdecompvmdBuffer, v : Double) -> TimeseriesdecompvmdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_buffer_min(s : TimeseriesdecompvmdBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_buffer_max(s : TimeseriesdecompvmdBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_buffer_to_string(s : TimeseriesdecompvmdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_cursor_make(size : Int) -> TimeseriesdecompvmdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_cursor_len(s : TimeseriesdecompvmdCursor) -> Int { s.size }

pub fn timeseries_decomp_vmd_cursor_get(s : TimeseriesdecompvmdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_cursor_set(s : TimeseriesdecompvmdCursor, i : Int, v : Double) -> TimeseriesdecompvmdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cursor_sum(s : TimeseriesdecompvmdCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_cursor_mean(s : TimeseriesdecompvmdCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_cursor_scale(s : TimeseriesdecompvmdCursor, f : Double) -> TimeseriesdecompvmdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cursor_add(a : TimeseriesdecompvmdCursor, b : TimeseriesdecompvmdCursor) -> TimeseriesdecompvmdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_cursor_copy(s : TimeseriesdecompvmdCursor) -> TimeseriesdecompvmdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cursor_fill(s : TimeseriesdecompvmdCursor, v : Double) -> TimeseriesdecompvmdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_cursor_min(s : TimeseriesdecompvmdCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_cursor_max(s : TimeseriesdecompvmdCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_cursor_to_string(s : TimeseriesdecompvmdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_view_make(size : Int) -> TimeseriesdecompvmdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_view_len(s : TimeseriesdecompvmdView) -> Int { s.size }

pub fn timeseries_decomp_vmd_view_get(s : TimeseriesdecompvmdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_view_set(s : TimeseriesdecompvmdView, i : Int, v : Double) -> TimeseriesdecompvmdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_view_sum(s : TimeseriesdecompvmdView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_view_mean(s : TimeseriesdecompvmdView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_view_scale(s : TimeseriesdecompvmdView, f : Double) -> TimeseriesdecompvmdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_view_add(a : TimeseriesdecompvmdView, b : TimeseriesdecompvmdView) -> TimeseriesdecompvmdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_view_copy(s : TimeseriesdecompvmdView) -> TimeseriesdecompvmdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_view_fill(s : TimeseriesdecompvmdView, v : Double) -> TimeseriesdecompvmdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_view_min(s : TimeseriesdecompvmdView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_view_max(s : TimeseriesdecompvmdView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_view_to_string(s : TimeseriesdecompvmdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_range_make(size : Int) -> TimeseriesdecompvmdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_range_len(s : TimeseriesdecompvmdRange) -> Int { s.size }

pub fn timeseries_decomp_vmd_range_get(s : TimeseriesdecompvmdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_range_set(s : TimeseriesdecompvmdRange, i : Int, v : Double) -> TimeseriesdecompvmdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_range_sum(s : TimeseriesdecompvmdRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_range_mean(s : TimeseriesdecompvmdRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_range_scale(s : TimeseriesdecompvmdRange, f : Double) -> TimeseriesdecompvmdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_range_add(a : TimeseriesdecompvmdRange, b : TimeseriesdecompvmdRange) -> TimeseriesdecompvmdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_range_copy(s : TimeseriesdecompvmdRange) -> TimeseriesdecompvmdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_range_fill(s : TimeseriesdecompvmdRange, v : Double) -> TimeseriesdecompvmdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_range_min(s : TimeseriesdecompvmdRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_range_max(s : TimeseriesdecompvmdRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_range_to_string(s : TimeseriesdecompvmdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompvmdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_vmd_slice_make(size : Int) -> TimeseriesdecompvmdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_vmd_slice_len(s : TimeseriesdecompvmdSlice) -> Int { s.size }

pub fn timeseries_decomp_vmd_slice_get(s : TimeseriesdecompvmdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_vmd_slice_set(s : TimeseriesdecompvmdSlice, i : Int, v : Double) -> TimeseriesdecompvmdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_slice_sum(s : TimeseriesdecompvmdSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_vmd_slice_mean(s : TimeseriesdecompvmdSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_vmd_slice_scale(s : TimeseriesdecompvmdSlice, f : Double) -> TimeseriesdecompvmdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_slice_add(a : TimeseriesdecompvmdSlice, b : TimeseriesdecompvmdSlice) -> TimeseriesdecompvmdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_vmd_slice_copy(s : TimeseriesdecompvmdSlice) -> TimeseriesdecompvmdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_slice_fill(s : TimeseriesdecompvmdSlice, v : Double) -> TimeseriesdecompvmdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_vmd_slice_min(s : TimeseriesdecompvmdSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_vmd_slice_max(s : TimeseriesdecompvmdSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_vmd_slice_to_string(s : TimeseriesdecompvmdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

