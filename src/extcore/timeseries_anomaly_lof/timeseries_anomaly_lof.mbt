///===
/// extcore/timeseries_anomaly_lof

pub(all) struct TimeseriesanomalylofPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_lof_make_point(x : Double, y : Double) -> TimeseriesanomalylofPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_lof_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalylofPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalylofPoint::x(self : TimeseriesanomalylofPoint) -> Double { self.x }

pub fn TimeseriesanomalylofPoint::y(self : TimeseriesanomalylofPoint) -> Double { self.y }

pub fn TimeseriesanomalylofPoint::z(self : TimeseriesanomalylofPoint) -> Double { self.z }

pub fn TimeseriesanomalylofPoint::label(self : TimeseriesanomalylofPoint) -> Int { self.label }

pub fn TimeseriesanomalylofPoint::dist(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalylofPoint::add(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalylofPoint::sub(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalylofPoint::scale(self : TimeseriesanomalylofPoint, s : Double) -> TimeseriesanomalylofPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalylofPoint::dot(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalylofPoint::cross(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalylofPoint::norm(self : TimeseriesanomalylofPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalylofPoint::normalize(self : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalylofPoint::negate(self : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalylofPoint::mid(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint) -> TimeseriesanomalylofPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalylofPoint::lerp(self : TimeseriesanomalylofPoint, other : TimeseriesanomalylofPoint, t : Double) -> TimeseriesanomalylofPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalylofPoint::to_string(self : TimeseriesanomalylofPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_lof_make_series(vals : Array[Double], name : String) -> TimeseriesanomalylofSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalylofSeries::len(self : TimeseriesanomalylofSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalylofSeries::sum(self : TimeseriesanomalylofSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalylofSeries::mean(self : TimeseriesanomalylofSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalylofSeries::min(self : TimeseriesanomalylofSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalylofSeries::max(self : TimeseriesanomalylofSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalylofSeries::range(self : TimeseriesanomalylofSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalylofSeries::variance(self : TimeseriesanomalylofSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalylofSeries::std(self : TimeseriesanomalylofSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalylofSeries::median(self : TimeseriesanomalylofSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalylofSeries::scale(self : TimeseriesanomalylofSeries, f : Double) -> TimeseriesanomalylofSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalylofSeries::add(self : TimeseriesanomalylofSeries, other : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalylofSeries::sub(self : TimeseriesanomalylofSeries, other : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalylofSeries::normalize(self : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalylofSeries::cumsum(self : TimeseriesanomalylofSeries) -> TimeseriesanomalylofSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalylofSeries::to_string(self : TimeseriesanomalylofSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalylofMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_lof_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalylofMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_lof_matrix_identity(n : Int) -> TimeseriesanomalylofMatrix {
  let m = timeseries_anomaly_lof_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalylofMatrix::get(self : TimeseriesanomalylofMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalylofMatrix::transpose(self : TimeseriesanomalylofMatrix) -> TimeseriesanomalylofMatrix {
  let result = timeseries_anomaly_lof_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalylofMatrix::add(self : TimeseriesanomalylofMatrix, other : TimeseriesanomalylofMatrix) -> TimeseriesanomalylofMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_lof_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalylofMatrix::scale(self : TimeseriesanomalylofMatrix, s : Double) -> TimeseriesanomalylofMatrix {
  let result = timeseries_anomaly_lof_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalylofMatrix::multiply(self : TimeseriesanomalylofMatrix, other : TimeseriesanomalylofMatrix) -> TimeseriesanomalylofMatrix {
  if self.cols != other.rows { return timeseries_anomaly_lof_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_lof_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalylofMatrix::trace(self : TimeseriesanomalylofMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalylofMatrix::det(self : TimeseriesanomalylofMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalylofMatrix::norm(self : TimeseriesanomalylofMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalylofMatrix::to_string(self : TimeseriesanomalylofMatrix) -> String {
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

pub(all) struct TimeseriesanomalylofVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_lof_make_vector(comps : Array[Double]) -> TimeseriesanomalylofVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_lof_vector_zero(dim : Int) -> TimeseriesanomalylofVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalylofVector::add(self : TimeseriesanomalylofVector, other : TimeseriesanomalylofVector) -> TimeseriesanomalylofVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalylofVector::sub(self : TimeseriesanomalylofVector, other : TimeseriesanomalylofVector) -> TimeseriesanomalylofVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalylofVector::scale(self : TimeseriesanomalylofVector, s : Double) -> TimeseriesanomalylofVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalylofVector::dot(self : TimeseriesanomalylofVector, other : TimeseriesanomalylofVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalylofVector::norm(self : TimeseriesanomalylofVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalylofVector::normalize(self : TimeseriesanomalylofVector) -> TimeseriesanomalylofVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalylofVector::dist(self : TimeseriesanomalylofVector, other : TimeseriesanomalylofVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalylofVector::to_string(self : TimeseriesanomalylofVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_lof_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_lof_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_lof_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_lof_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_lof_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_lof_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_lof_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_lof_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_lof_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_lof_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_lof_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_lof_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_lof_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_lof_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_lof_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_lof_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_lof_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_lof_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_lof_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_lof_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_lof_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_lof_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_lof_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_lof_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_lof_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_lof_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_lof_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_lof_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_lof_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalylofFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_frame_make(size : Int) -> TimeseriesanomalylofFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_frame_len(s : TimeseriesanomalylofFrame) -> Int { s.size }

pub fn timeseries_anomaly_lof_frame_get(s : TimeseriesanomalylofFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_frame_set(s : TimeseriesanomalylofFrame, i : Int, v : Double) -> TimeseriesanomalylofFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_frame_sum(s : TimeseriesanomalylofFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_frame_mean(s : TimeseriesanomalylofFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_frame_scale(s : TimeseriesanomalylofFrame, f : Double) -> TimeseriesanomalylofFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_frame_add(a : TimeseriesanomalylofFrame, b : TimeseriesanomalylofFrame) -> TimeseriesanomalylofFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_frame_copy(s : TimeseriesanomalylofFrame) -> TimeseriesanomalylofFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_frame_fill(s : TimeseriesanomalylofFrame, v : Double) -> TimeseriesanomalylofFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_frame_min(s : TimeseriesanomalylofFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_frame_max(s : TimeseriesanomalylofFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_frame_to_string(s : TimeseriesanomalylofFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_table_make(size : Int) -> TimeseriesanomalylofTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_table_len(s : TimeseriesanomalylofTable) -> Int { s.size }

pub fn timeseries_anomaly_lof_table_get(s : TimeseriesanomalylofTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_table_set(s : TimeseriesanomalylofTable, i : Int, v : Double) -> TimeseriesanomalylofTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_table_sum(s : TimeseriesanomalylofTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_table_mean(s : TimeseriesanomalylofTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_table_scale(s : TimeseriesanomalylofTable, f : Double) -> TimeseriesanomalylofTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_table_add(a : TimeseriesanomalylofTable, b : TimeseriesanomalylofTable) -> TimeseriesanomalylofTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_table_copy(s : TimeseriesanomalylofTable) -> TimeseriesanomalylofTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_table_fill(s : TimeseriesanomalylofTable, v : Double) -> TimeseriesanomalylofTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_table_min(s : TimeseriesanomalylofTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_table_max(s : TimeseriesanomalylofTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_table_to_string(s : TimeseriesanomalylofTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_graphn_make(size : Int) -> TimeseriesanomalylofGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_graphn_len(s : TimeseriesanomalylofGraphN) -> Int { s.size }

pub fn timeseries_anomaly_lof_graphn_get(s : TimeseriesanomalylofGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_graphn_set(s : TimeseriesanomalylofGraphN, i : Int, v : Double) -> TimeseriesanomalylofGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_graphn_sum(s : TimeseriesanomalylofGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_graphn_mean(s : TimeseriesanomalylofGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_graphn_scale(s : TimeseriesanomalylofGraphN, f : Double) -> TimeseriesanomalylofGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_graphn_add(a : TimeseriesanomalylofGraphN, b : TimeseriesanomalylofGraphN) -> TimeseriesanomalylofGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_graphn_copy(s : TimeseriesanomalylofGraphN) -> TimeseriesanomalylofGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_graphn_fill(s : TimeseriesanomalylofGraphN, v : Double) -> TimeseriesanomalylofGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_graphn_min(s : TimeseriesanomalylofGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_graphn_max(s : TimeseriesanomalylofGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_graphn_to_string(s : TimeseriesanomalylofGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_node_make(size : Int) -> TimeseriesanomalylofNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_node_len(s : TimeseriesanomalylofNode) -> Int { s.size }

pub fn timeseries_anomaly_lof_node_get(s : TimeseriesanomalylofNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_node_set(s : TimeseriesanomalylofNode, i : Int, v : Double) -> TimeseriesanomalylofNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_node_sum(s : TimeseriesanomalylofNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_node_mean(s : TimeseriesanomalylofNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_node_scale(s : TimeseriesanomalylofNode, f : Double) -> TimeseriesanomalylofNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_node_add(a : TimeseriesanomalylofNode, b : TimeseriesanomalylofNode) -> TimeseriesanomalylofNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_node_copy(s : TimeseriesanomalylofNode) -> TimeseriesanomalylofNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_node_fill(s : TimeseriesanomalylofNode, v : Double) -> TimeseriesanomalylofNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_node_min(s : TimeseriesanomalylofNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_node_max(s : TimeseriesanomalylofNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_node_to_string(s : TimeseriesanomalylofNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_edge_make(size : Int) -> TimeseriesanomalylofEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_edge_len(s : TimeseriesanomalylofEdge) -> Int { s.size }

pub fn timeseries_anomaly_lof_edge_get(s : TimeseriesanomalylofEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_edge_set(s : TimeseriesanomalylofEdge, i : Int, v : Double) -> TimeseriesanomalylofEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_edge_sum(s : TimeseriesanomalylofEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_edge_mean(s : TimeseriesanomalylofEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_edge_scale(s : TimeseriesanomalylofEdge, f : Double) -> TimeseriesanomalylofEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_edge_add(a : TimeseriesanomalylofEdge, b : TimeseriesanomalylofEdge) -> TimeseriesanomalylofEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_edge_copy(s : TimeseriesanomalylofEdge) -> TimeseriesanomalylofEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_edge_fill(s : TimeseriesanomalylofEdge, v : Double) -> TimeseriesanomalylofEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_edge_min(s : TimeseriesanomalylofEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_edge_max(s : TimeseriesanomalylofEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_edge_to_string(s : TimeseriesanomalylofEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_path_make(size : Int) -> TimeseriesanomalylofPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_path_len(s : TimeseriesanomalylofPath) -> Int { s.size }

pub fn timeseries_anomaly_lof_path_get(s : TimeseriesanomalylofPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_path_set(s : TimeseriesanomalylofPath, i : Int, v : Double) -> TimeseriesanomalylofPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_path_sum(s : TimeseriesanomalylofPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_path_mean(s : TimeseriesanomalylofPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_path_scale(s : TimeseriesanomalylofPath, f : Double) -> TimeseriesanomalylofPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_path_add(a : TimeseriesanomalylofPath, b : TimeseriesanomalylofPath) -> TimeseriesanomalylofPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_path_copy(s : TimeseriesanomalylofPath) -> TimeseriesanomalylofPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_path_fill(s : TimeseriesanomalylofPath, v : Double) -> TimeseriesanomalylofPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_path_min(s : TimeseriesanomalylofPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_path_max(s : TimeseriesanomalylofPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_path_to_string(s : TimeseriesanomalylofPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_cluster_make(size : Int) -> TimeseriesanomalylofCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_cluster_len(s : TimeseriesanomalylofCluster) -> Int { s.size }

pub fn timeseries_anomaly_lof_cluster_get(s : TimeseriesanomalylofCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_cluster_set(s : TimeseriesanomalylofCluster, i : Int, v : Double) -> TimeseriesanomalylofCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cluster_sum(s : TimeseriesanomalylofCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_cluster_mean(s : TimeseriesanomalylofCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_cluster_scale(s : TimeseriesanomalylofCluster, f : Double) -> TimeseriesanomalylofCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cluster_add(a : TimeseriesanomalylofCluster, b : TimeseriesanomalylofCluster) -> TimeseriesanomalylofCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_cluster_copy(s : TimeseriesanomalylofCluster) -> TimeseriesanomalylofCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cluster_fill(s : TimeseriesanomalylofCluster, v : Double) -> TimeseriesanomalylofCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cluster_min(s : TimeseriesanomalylofCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_cluster_max(s : TimeseriesanomalylofCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_cluster_to_string(s : TimeseriesanomalylofCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_model_make(size : Int) -> TimeseriesanomalylofModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_model_len(s : TimeseriesanomalylofModel) -> Int { s.size }

pub fn timeseries_anomaly_lof_model_get(s : TimeseriesanomalylofModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_model_set(s : TimeseriesanomalylofModel, i : Int, v : Double) -> TimeseriesanomalylofModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_model_sum(s : TimeseriesanomalylofModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_model_mean(s : TimeseriesanomalylofModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_model_scale(s : TimeseriesanomalylofModel, f : Double) -> TimeseriesanomalylofModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_model_add(a : TimeseriesanomalylofModel, b : TimeseriesanomalylofModel) -> TimeseriesanomalylofModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_model_copy(s : TimeseriesanomalylofModel) -> TimeseriesanomalylofModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_model_fill(s : TimeseriesanomalylofModel, v : Double) -> TimeseriesanomalylofModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_model_min(s : TimeseriesanomalylofModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_model_max(s : TimeseriesanomalylofModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_model_to_string(s : TimeseriesanomalylofModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_layer_make(size : Int) -> TimeseriesanomalylofLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_layer_len(s : TimeseriesanomalylofLayer) -> Int { s.size }

pub fn timeseries_anomaly_lof_layer_get(s : TimeseriesanomalylofLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_layer_set(s : TimeseriesanomalylofLayer, i : Int, v : Double) -> TimeseriesanomalylofLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_layer_sum(s : TimeseriesanomalylofLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_layer_mean(s : TimeseriesanomalylofLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_layer_scale(s : TimeseriesanomalylofLayer, f : Double) -> TimeseriesanomalylofLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_layer_add(a : TimeseriesanomalylofLayer, b : TimeseriesanomalylofLayer) -> TimeseriesanomalylofLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_layer_copy(s : TimeseriesanomalylofLayer) -> TimeseriesanomalylofLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_layer_fill(s : TimeseriesanomalylofLayer, v : Double) -> TimeseriesanomalylofLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_layer_min(s : TimeseriesanomalylofLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_layer_max(s : TimeseriesanomalylofLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_layer_to_string(s : TimeseriesanomalylofLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_buffer_make(size : Int) -> TimeseriesanomalylofBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_buffer_len(s : TimeseriesanomalylofBuffer) -> Int { s.size }

pub fn timeseries_anomaly_lof_buffer_get(s : TimeseriesanomalylofBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_buffer_set(s : TimeseriesanomalylofBuffer, i : Int, v : Double) -> TimeseriesanomalylofBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_buffer_sum(s : TimeseriesanomalylofBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_buffer_mean(s : TimeseriesanomalylofBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_buffer_scale(s : TimeseriesanomalylofBuffer, f : Double) -> TimeseriesanomalylofBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_buffer_add(a : TimeseriesanomalylofBuffer, b : TimeseriesanomalylofBuffer) -> TimeseriesanomalylofBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_buffer_copy(s : TimeseriesanomalylofBuffer) -> TimeseriesanomalylofBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_buffer_fill(s : TimeseriesanomalylofBuffer, v : Double) -> TimeseriesanomalylofBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_buffer_min(s : TimeseriesanomalylofBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_buffer_max(s : TimeseriesanomalylofBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_buffer_to_string(s : TimeseriesanomalylofBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_cursor_make(size : Int) -> TimeseriesanomalylofCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_cursor_len(s : TimeseriesanomalylofCursor) -> Int { s.size }

pub fn timeseries_anomaly_lof_cursor_get(s : TimeseriesanomalylofCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_cursor_set(s : TimeseriesanomalylofCursor, i : Int, v : Double) -> TimeseriesanomalylofCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cursor_sum(s : TimeseriesanomalylofCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_cursor_mean(s : TimeseriesanomalylofCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_cursor_scale(s : TimeseriesanomalylofCursor, f : Double) -> TimeseriesanomalylofCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cursor_add(a : TimeseriesanomalylofCursor, b : TimeseriesanomalylofCursor) -> TimeseriesanomalylofCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_cursor_copy(s : TimeseriesanomalylofCursor) -> TimeseriesanomalylofCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cursor_fill(s : TimeseriesanomalylofCursor, v : Double) -> TimeseriesanomalylofCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_cursor_min(s : TimeseriesanomalylofCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_cursor_max(s : TimeseriesanomalylofCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_cursor_to_string(s : TimeseriesanomalylofCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_view_make(size : Int) -> TimeseriesanomalylofView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_view_len(s : TimeseriesanomalylofView) -> Int { s.size }

pub fn timeseries_anomaly_lof_view_get(s : TimeseriesanomalylofView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_view_set(s : TimeseriesanomalylofView, i : Int, v : Double) -> TimeseriesanomalylofView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_view_sum(s : TimeseriesanomalylofView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_view_mean(s : TimeseriesanomalylofView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_view_scale(s : TimeseriesanomalylofView, f : Double) -> TimeseriesanomalylofView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_view_add(a : TimeseriesanomalylofView, b : TimeseriesanomalylofView) -> TimeseriesanomalylofView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_view_copy(s : TimeseriesanomalylofView) -> TimeseriesanomalylofView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_view_fill(s : TimeseriesanomalylofView, v : Double) -> TimeseriesanomalylofView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_view_min(s : TimeseriesanomalylofView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_view_max(s : TimeseriesanomalylofView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_view_to_string(s : TimeseriesanomalylofView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_range_make(size : Int) -> TimeseriesanomalylofRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_range_len(s : TimeseriesanomalylofRange) -> Int { s.size }

pub fn timeseries_anomaly_lof_range_get(s : TimeseriesanomalylofRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_range_set(s : TimeseriesanomalylofRange, i : Int, v : Double) -> TimeseriesanomalylofRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_range_sum(s : TimeseriesanomalylofRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_range_mean(s : TimeseriesanomalylofRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_range_scale(s : TimeseriesanomalylofRange, f : Double) -> TimeseriesanomalylofRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_range_add(a : TimeseriesanomalylofRange, b : TimeseriesanomalylofRange) -> TimeseriesanomalylofRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_range_copy(s : TimeseriesanomalylofRange) -> TimeseriesanomalylofRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_range_fill(s : TimeseriesanomalylofRange, v : Double) -> TimeseriesanomalylofRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_range_min(s : TimeseriesanomalylofRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_range_max(s : TimeseriesanomalylofRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_range_to_string(s : TimeseriesanomalylofRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_slice_make(size : Int) -> TimeseriesanomalylofSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lof_slice_len(s : TimeseriesanomalylofSlice) -> Int { s.size }

pub fn timeseries_anomaly_lof_slice_get(s : TimeseriesanomalylofSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lof_slice_set(s : TimeseriesanomalylofSlice, i : Int, v : Double) -> TimeseriesanomalylofSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_slice_sum(s : TimeseriesanomalylofSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lof_slice_mean(s : TimeseriesanomalylofSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lof_slice_scale(s : TimeseriesanomalylofSlice, f : Double) -> TimeseriesanomalylofSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_slice_add(a : TimeseriesanomalylofSlice, b : TimeseriesanomalylofSlice) -> TimeseriesanomalylofSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lof_slice_copy(s : TimeseriesanomalylofSlice) -> TimeseriesanomalylofSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_slice_fill(s : TimeseriesanomalylofSlice, v : Double) -> TimeseriesanomalylofSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lof_slice_min(s : TimeseriesanomalylofSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lof_slice_max(s : TimeseriesanomalylofSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lof_slice_to_string(s : TimeseriesanomalylofSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

