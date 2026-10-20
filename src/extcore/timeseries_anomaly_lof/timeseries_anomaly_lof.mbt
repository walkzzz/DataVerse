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

pub fn TimeseriesanomalylofFrame::len(self : TimeseriesanomalylofFrame) -> Int { self.size }

pub fn TimeseriesanomalylofFrame::get(self : TimeseriesanomalylofFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofFrame::set(self : TimeseriesanomalylofFrame, i : Int, v : Double) -> TimeseriesanomalylofFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofFrame::sum(self : TimeseriesanomalylofFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofFrame::mean(self : TimeseriesanomalylofFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofFrame::scale(self : TimeseriesanomalylofFrame, f : Double) -> TimeseriesanomalylofFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofFrame::add(self : TimeseriesanomalylofFrame, other : TimeseriesanomalylofFrame) -> TimeseriesanomalylofFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofFrame::copy(self : TimeseriesanomalylofFrame) -> TimeseriesanomalylofFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofFrame::fill(self : TimeseriesanomalylofFrame, v : Double) -> TimeseriesanomalylofFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofFrame::min(self : TimeseriesanomalylofFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofFrame::max(self : TimeseriesanomalylofFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofFrame::to_string(self : TimeseriesanomalylofFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_table_make(size : Int) -> TimeseriesanomalylofTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofTable::len(self : TimeseriesanomalylofTable) -> Int { self.size }

pub fn TimeseriesanomalylofTable::get(self : TimeseriesanomalylofTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofTable::set(self : TimeseriesanomalylofTable, i : Int, v : Double) -> TimeseriesanomalylofTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofTable::sum(self : TimeseriesanomalylofTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofTable::mean(self : TimeseriesanomalylofTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofTable::scale(self : TimeseriesanomalylofTable, f : Double) -> TimeseriesanomalylofTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofTable::add(self : TimeseriesanomalylofTable, other : TimeseriesanomalylofTable) -> TimeseriesanomalylofTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofTable::copy(self : TimeseriesanomalylofTable) -> TimeseriesanomalylofTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofTable::fill(self : TimeseriesanomalylofTable, v : Double) -> TimeseriesanomalylofTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofTable::min(self : TimeseriesanomalylofTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofTable::max(self : TimeseriesanomalylofTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofTable::to_string(self : TimeseriesanomalylofTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_graphn_make(size : Int) -> TimeseriesanomalylofGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofGraphN::len(self : TimeseriesanomalylofGraphN) -> Int { self.size }

pub fn TimeseriesanomalylofGraphN::get(self : TimeseriesanomalylofGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofGraphN::set(self : TimeseriesanomalylofGraphN, i : Int, v : Double) -> TimeseriesanomalylofGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofGraphN::sum(self : TimeseriesanomalylofGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofGraphN::mean(self : TimeseriesanomalylofGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofGraphN::scale(self : TimeseriesanomalylofGraphN, f : Double) -> TimeseriesanomalylofGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofGraphN::add(self : TimeseriesanomalylofGraphN, other : TimeseriesanomalylofGraphN) -> TimeseriesanomalylofGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofGraphN::copy(self : TimeseriesanomalylofGraphN) -> TimeseriesanomalylofGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofGraphN::fill(self : TimeseriesanomalylofGraphN, v : Double) -> TimeseriesanomalylofGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofGraphN::min(self : TimeseriesanomalylofGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofGraphN::max(self : TimeseriesanomalylofGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofGraphN::to_string(self : TimeseriesanomalylofGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_node_make(size : Int) -> TimeseriesanomalylofNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofNode::len(self : TimeseriesanomalylofNode) -> Int { self.size }

pub fn TimeseriesanomalylofNode::get(self : TimeseriesanomalylofNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofNode::set(self : TimeseriesanomalylofNode, i : Int, v : Double) -> TimeseriesanomalylofNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofNode::sum(self : TimeseriesanomalylofNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofNode::mean(self : TimeseriesanomalylofNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofNode::scale(self : TimeseriesanomalylofNode, f : Double) -> TimeseriesanomalylofNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofNode::add(self : TimeseriesanomalylofNode, other : TimeseriesanomalylofNode) -> TimeseriesanomalylofNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofNode::copy(self : TimeseriesanomalylofNode) -> TimeseriesanomalylofNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofNode::fill(self : TimeseriesanomalylofNode, v : Double) -> TimeseriesanomalylofNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofNode::min(self : TimeseriesanomalylofNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofNode::max(self : TimeseriesanomalylofNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofNode::to_string(self : TimeseriesanomalylofNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_edge_make(size : Int) -> TimeseriesanomalylofEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofEdge::len(self : TimeseriesanomalylofEdge) -> Int { self.size }

pub fn TimeseriesanomalylofEdge::get(self : TimeseriesanomalylofEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofEdge::set(self : TimeseriesanomalylofEdge, i : Int, v : Double) -> TimeseriesanomalylofEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofEdge::sum(self : TimeseriesanomalylofEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofEdge::mean(self : TimeseriesanomalylofEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofEdge::scale(self : TimeseriesanomalylofEdge, f : Double) -> TimeseriesanomalylofEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofEdge::add(self : TimeseriesanomalylofEdge, other : TimeseriesanomalylofEdge) -> TimeseriesanomalylofEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofEdge::copy(self : TimeseriesanomalylofEdge) -> TimeseriesanomalylofEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofEdge::fill(self : TimeseriesanomalylofEdge, v : Double) -> TimeseriesanomalylofEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofEdge::min(self : TimeseriesanomalylofEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofEdge::max(self : TimeseriesanomalylofEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofEdge::to_string(self : TimeseriesanomalylofEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_path_make(size : Int) -> TimeseriesanomalylofPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofPath::len(self : TimeseriesanomalylofPath) -> Int { self.size }

pub fn TimeseriesanomalylofPath::get(self : TimeseriesanomalylofPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofPath::set(self : TimeseriesanomalylofPath, i : Int, v : Double) -> TimeseriesanomalylofPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofPath::sum(self : TimeseriesanomalylofPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofPath::mean(self : TimeseriesanomalylofPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofPath::scale(self : TimeseriesanomalylofPath, f : Double) -> TimeseriesanomalylofPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofPath::add(self : TimeseriesanomalylofPath, other : TimeseriesanomalylofPath) -> TimeseriesanomalylofPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofPath::copy(self : TimeseriesanomalylofPath) -> TimeseriesanomalylofPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofPath::fill(self : TimeseriesanomalylofPath, v : Double) -> TimeseriesanomalylofPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofPath::min(self : TimeseriesanomalylofPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofPath::max(self : TimeseriesanomalylofPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofPath::to_string(self : TimeseriesanomalylofPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_cluster_make(size : Int) -> TimeseriesanomalylofCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofCluster::len(self : TimeseriesanomalylofCluster) -> Int { self.size }

pub fn TimeseriesanomalylofCluster::get(self : TimeseriesanomalylofCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofCluster::set(self : TimeseriesanomalylofCluster, i : Int, v : Double) -> TimeseriesanomalylofCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCluster::sum(self : TimeseriesanomalylofCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofCluster::mean(self : TimeseriesanomalylofCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofCluster::scale(self : TimeseriesanomalylofCluster, f : Double) -> TimeseriesanomalylofCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCluster::add(self : TimeseriesanomalylofCluster, other : TimeseriesanomalylofCluster) -> TimeseriesanomalylofCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofCluster::copy(self : TimeseriesanomalylofCluster) -> TimeseriesanomalylofCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCluster::fill(self : TimeseriesanomalylofCluster, v : Double) -> TimeseriesanomalylofCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCluster::min(self : TimeseriesanomalylofCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofCluster::max(self : TimeseriesanomalylofCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofCluster::to_string(self : TimeseriesanomalylofCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_model_make(size : Int) -> TimeseriesanomalylofModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofModel::len(self : TimeseriesanomalylofModel) -> Int { self.size }

pub fn TimeseriesanomalylofModel::get(self : TimeseriesanomalylofModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofModel::set(self : TimeseriesanomalylofModel, i : Int, v : Double) -> TimeseriesanomalylofModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofModel::sum(self : TimeseriesanomalylofModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofModel::mean(self : TimeseriesanomalylofModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofModel::scale(self : TimeseriesanomalylofModel, f : Double) -> TimeseriesanomalylofModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofModel::add(self : TimeseriesanomalylofModel, other : TimeseriesanomalylofModel) -> TimeseriesanomalylofModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofModel::copy(self : TimeseriesanomalylofModel) -> TimeseriesanomalylofModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofModel::fill(self : TimeseriesanomalylofModel, v : Double) -> TimeseriesanomalylofModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofModel::min(self : TimeseriesanomalylofModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofModel::max(self : TimeseriesanomalylofModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofModel::to_string(self : TimeseriesanomalylofModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_layer_make(size : Int) -> TimeseriesanomalylofLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofLayer::len(self : TimeseriesanomalylofLayer) -> Int { self.size }

pub fn TimeseriesanomalylofLayer::get(self : TimeseriesanomalylofLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofLayer::set(self : TimeseriesanomalylofLayer, i : Int, v : Double) -> TimeseriesanomalylofLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofLayer::sum(self : TimeseriesanomalylofLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofLayer::mean(self : TimeseriesanomalylofLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofLayer::scale(self : TimeseriesanomalylofLayer, f : Double) -> TimeseriesanomalylofLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofLayer::add(self : TimeseriesanomalylofLayer, other : TimeseriesanomalylofLayer) -> TimeseriesanomalylofLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofLayer::copy(self : TimeseriesanomalylofLayer) -> TimeseriesanomalylofLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofLayer::fill(self : TimeseriesanomalylofLayer, v : Double) -> TimeseriesanomalylofLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofLayer::min(self : TimeseriesanomalylofLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofLayer::max(self : TimeseriesanomalylofLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofLayer::to_string(self : TimeseriesanomalylofLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_buffer_make(size : Int) -> TimeseriesanomalylofBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofBuffer::len(self : TimeseriesanomalylofBuffer) -> Int { self.size }

pub fn TimeseriesanomalylofBuffer::get(self : TimeseriesanomalylofBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofBuffer::set(self : TimeseriesanomalylofBuffer, i : Int, v : Double) -> TimeseriesanomalylofBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofBuffer::sum(self : TimeseriesanomalylofBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofBuffer::mean(self : TimeseriesanomalylofBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofBuffer::scale(self : TimeseriesanomalylofBuffer, f : Double) -> TimeseriesanomalylofBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofBuffer::add(self : TimeseriesanomalylofBuffer, other : TimeseriesanomalylofBuffer) -> TimeseriesanomalylofBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofBuffer::copy(self : TimeseriesanomalylofBuffer) -> TimeseriesanomalylofBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofBuffer::fill(self : TimeseriesanomalylofBuffer, v : Double) -> TimeseriesanomalylofBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofBuffer::min(self : TimeseriesanomalylofBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofBuffer::max(self : TimeseriesanomalylofBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofBuffer::to_string(self : TimeseriesanomalylofBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_cursor_make(size : Int) -> TimeseriesanomalylofCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofCursor::len(self : TimeseriesanomalylofCursor) -> Int { self.size }

pub fn TimeseriesanomalylofCursor::get(self : TimeseriesanomalylofCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofCursor::set(self : TimeseriesanomalylofCursor, i : Int, v : Double) -> TimeseriesanomalylofCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCursor::sum(self : TimeseriesanomalylofCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofCursor::mean(self : TimeseriesanomalylofCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofCursor::scale(self : TimeseriesanomalylofCursor, f : Double) -> TimeseriesanomalylofCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCursor::add(self : TimeseriesanomalylofCursor, other : TimeseriesanomalylofCursor) -> TimeseriesanomalylofCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofCursor::copy(self : TimeseriesanomalylofCursor) -> TimeseriesanomalylofCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCursor::fill(self : TimeseriesanomalylofCursor, v : Double) -> TimeseriesanomalylofCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofCursor::min(self : TimeseriesanomalylofCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofCursor::max(self : TimeseriesanomalylofCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofCursor::to_string(self : TimeseriesanomalylofCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_view_make(size : Int) -> TimeseriesanomalylofView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofView::len(self : TimeseriesanomalylofView) -> Int { self.size }

pub fn TimeseriesanomalylofView::get(self : TimeseriesanomalylofView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofView::set(self : TimeseriesanomalylofView, i : Int, v : Double) -> TimeseriesanomalylofView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofView::sum(self : TimeseriesanomalylofView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofView::mean(self : TimeseriesanomalylofView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofView::scale(self : TimeseriesanomalylofView, f : Double) -> TimeseriesanomalylofView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofView::add(self : TimeseriesanomalylofView, other : TimeseriesanomalylofView) -> TimeseriesanomalylofView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofView::copy(self : TimeseriesanomalylofView) -> TimeseriesanomalylofView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofView::fill(self : TimeseriesanomalylofView, v : Double) -> TimeseriesanomalylofView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofView::min(self : TimeseriesanomalylofView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofView::max(self : TimeseriesanomalylofView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofView::to_string(self : TimeseriesanomalylofView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_range_make(size : Int) -> TimeseriesanomalylofRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofRange::len(self : TimeseriesanomalylofRange) -> Int { self.size }

pub fn TimeseriesanomalylofRange::get(self : TimeseriesanomalylofRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofRange::set(self : TimeseriesanomalylofRange, i : Int, v : Double) -> TimeseriesanomalylofRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofRange::sum(self : TimeseriesanomalylofRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofRange::mean(self : TimeseriesanomalylofRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofRange::scale(self : TimeseriesanomalylofRange, f : Double) -> TimeseriesanomalylofRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofRange::add(self : TimeseriesanomalylofRange, other : TimeseriesanomalylofRange) -> TimeseriesanomalylofRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofRange::copy(self : TimeseriesanomalylofRange) -> TimeseriesanomalylofRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofRange::fill(self : TimeseriesanomalylofRange, v : Double) -> TimeseriesanomalylofRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofRange::min(self : TimeseriesanomalylofRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofRange::max(self : TimeseriesanomalylofRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofRange::to_string(self : TimeseriesanomalylofRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylofSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lof_slice_make(size : Int) -> TimeseriesanomalylofSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylofSlice::len(self : TimeseriesanomalylofSlice) -> Int { self.size }

pub fn TimeseriesanomalylofSlice::get(self : TimeseriesanomalylofSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylofSlice::set(self : TimeseriesanomalylofSlice, i : Int, v : Double) -> TimeseriesanomalylofSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofSlice::sum(self : TimeseriesanomalylofSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylofSlice::mean(self : TimeseriesanomalylofSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylofSlice::scale(self : TimeseriesanomalylofSlice, f : Double) -> TimeseriesanomalylofSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofSlice::add(self : TimeseriesanomalylofSlice, other : TimeseriesanomalylofSlice) -> TimeseriesanomalylofSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylofSlice::copy(self : TimeseriesanomalylofSlice) -> TimeseriesanomalylofSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofSlice::fill(self : TimeseriesanomalylofSlice, v : Double) -> TimeseriesanomalylofSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylofSlice::min(self : TimeseriesanomalylofSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylofSlice::max(self : TimeseriesanomalylofSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylofSlice::to_string(self : TimeseriesanomalylofSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

