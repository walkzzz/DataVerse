///===
/// extcore/timeseries_anomaly_isolation

pub(all) struct TimeseriesanomalyisolationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_isolation_make_point(x : Double, y : Double) -> TimeseriesanomalyisolationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_isolation_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyisolationPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyisolationPoint::x(self : TimeseriesanomalyisolationPoint) -> Double { self.x }

pub fn TimeseriesanomalyisolationPoint::y(self : TimeseriesanomalyisolationPoint) -> Double { self.y }

pub fn TimeseriesanomalyisolationPoint::z(self : TimeseriesanomalyisolationPoint) -> Double { self.z }

pub fn TimeseriesanomalyisolationPoint::label(self : TimeseriesanomalyisolationPoint) -> Int { self.label }

pub fn TimeseriesanomalyisolationPoint::dist(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyisolationPoint::add(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::sub(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::scale(self : TimeseriesanomalyisolationPoint, s : Double) -> TimeseriesanomalyisolationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::dot(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyisolationPoint::cross(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyisolationPoint::norm(self : TimeseriesanomalyisolationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyisolationPoint::normalize(self : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyisolationPoint::negate(self : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::mid(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::lerp(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint, t : Double) -> TimeseriesanomalyisolationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::to_string(self : TimeseriesanomalyisolationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_isolation_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyisolationSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyisolationSeries::len(self : TimeseriesanomalyisolationSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyisolationSeries::sum(self : TimeseriesanomalyisolationSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyisolationSeries::mean(self : TimeseriesanomalyisolationSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyisolationSeries::min(self : TimeseriesanomalyisolationSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyisolationSeries::max(self : TimeseriesanomalyisolationSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyisolationSeries::range(self : TimeseriesanomalyisolationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyisolationSeries::variance(self : TimeseriesanomalyisolationSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyisolationSeries::std(self : TimeseriesanomalyisolationSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyisolationSeries::median(self : TimeseriesanomalyisolationSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyisolationSeries::scale(self : TimeseriesanomalyisolationSeries, f : Double) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::add(self : TimeseriesanomalyisolationSeries, other : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::sub(self : TimeseriesanomalyisolationSeries, other : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::normalize(self : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyisolationSeries::cumsum(self : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::to_string(self : TimeseriesanomalyisolationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyisolationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_isolation_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyisolationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_isolation_matrix_identity(n : Int) -> TimeseriesanomalyisolationMatrix {
  let m = timeseries_anomaly_isolation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyisolationMatrix::get(self : TimeseriesanomalyisolationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyisolationMatrix::transpose(self : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  let result = timeseries_anomaly_isolation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyisolationMatrix::add(self : TimeseriesanomalyisolationMatrix, other : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_isolation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyisolationMatrix::scale(self : TimeseriesanomalyisolationMatrix, s : Double) -> TimeseriesanomalyisolationMatrix {
  let result = timeseries_anomaly_isolation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyisolationMatrix::multiply(self : TimeseriesanomalyisolationMatrix, other : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  if self.cols != other.rows { return timeseries_anomaly_isolation_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_isolation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyisolationMatrix::trace(self : TimeseriesanomalyisolationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyisolationMatrix::det(self : TimeseriesanomalyisolationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyisolationMatrix::norm(self : TimeseriesanomalyisolationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyisolationMatrix::to_string(self : TimeseriesanomalyisolationMatrix) -> String {
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

pub(all) struct TimeseriesanomalyisolationVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_isolation_make_vector(comps : Array[Double]) -> TimeseriesanomalyisolationVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_isolation_vector_zero(dim : Int) -> TimeseriesanomalyisolationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyisolationVector::add(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyisolationVector::sub(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyisolationVector::scale(self : TimeseriesanomalyisolationVector, s : Double) -> TimeseriesanomalyisolationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyisolationVector::dot(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyisolationVector::norm(self : TimeseriesanomalyisolationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyisolationVector::normalize(self : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyisolationVector::dist(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyisolationVector::to_string(self : TimeseriesanomalyisolationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_isolation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_isolation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_isolation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_isolation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_isolation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_isolation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_isolation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_isolation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_isolation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_isolation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_isolation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_isolation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_isolation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_isolation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_isolation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_isolation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_isolation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_isolation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_isolation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_isolation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_isolation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_isolation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_isolation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_isolation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_isolation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_isolation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_isolation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_isolation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_isolation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyisolationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_frame_make(size : Int) -> TimeseriesanomalyisolationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_frame_len(s : TimeseriesanomalyisolationFrame) -> Int { s.size }

pub fn timeseries_anomaly_isolation_frame_get(s : TimeseriesanomalyisolationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_frame_set(s : TimeseriesanomalyisolationFrame, i : Int, v : Double) -> TimeseriesanomalyisolationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_frame_sum(s : TimeseriesanomalyisolationFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_frame_mean(s : TimeseriesanomalyisolationFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_frame_scale(s : TimeseriesanomalyisolationFrame, f : Double) -> TimeseriesanomalyisolationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_frame_add(a : TimeseriesanomalyisolationFrame, b : TimeseriesanomalyisolationFrame) -> TimeseriesanomalyisolationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_frame_copy(s : TimeseriesanomalyisolationFrame) -> TimeseriesanomalyisolationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_frame_fill(s : TimeseriesanomalyisolationFrame, v : Double) -> TimeseriesanomalyisolationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_frame_min(s : TimeseriesanomalyisolationFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_frame_max(s : TimeseriesanomalyisolationFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_frame_to_string(s : TimeseriesanomalyisolationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_table_make(size : Int) -> TimeseriesanomalyisolationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_table_len(s : TimeseriesanomalyisolationTable) -> Int { s.size }

pub fn timeseries_anomaly_isolation_table_get(s : TimeseriesanomalyisolationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_table_set(s : TimeseriesanomalyisolationTable, i : Int, v : Double) -> TimeseriesanomalyisolationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_table_sum(s : TimeseriesanomalyisolationTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_table_mean(s : TimeseriesanomalyisolationTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_table_scale(s : TimeseriesanomalyisolationTable, f : Double) -> TimeseriesanomalyisolationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_table_add(a : TimeseriesanomalyisolationTable, b : TimeseriesanomalyisolationTable) -> TimeseriesanomalyisolationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_table_copy(s : TimeseriesanomalyisolationTable) -> TimeseriesanomalyisolationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_table_fill(s : TimeseriesanomalyisolationTable, v : Double) -> TimeseriesanomalyisolationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_table_min(s : TimeseriesanomalyisolationTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_table_max(s : TimeseriesanomalyisolationTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_table_to_string(s : TimeseriesanomalyisolationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_graphn_make(size : Int) -> TimeseriesanomalyisolationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_graphn_len(s : TimeseriesanomalyisolationGraphN) -> Int { s.size }

pub fn timeseries_anomaly_isolation_graphn_get(s : TimeseriesanomalyisolationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_graphn_set(s : TimeseriesanomalyisolationGraphN, i : Int, v : Double) -> TimeseriesanomalyisolationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_graphn_sum(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_graphn_mean(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_graphn_scale(s : TimeseriesanomalyisolationGraphN, f : Double) -> TimeseriesanomalyisolationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_graphn_add(a : TimeseriesanomalyisolationGraphN, b : TimeseriesanomalyisolationGraphN) -> TimeseriesanomalyisolationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_graphn_copy(s : TimeseriesanomalyisolationGraphN) -> TimeseriesanomalyisolationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_graphn_fill(s : TimeseriesanomalyisolationGraphN, v : Double) -> TimeseriesanomalyisolationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_graphn_min(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_graphn_max(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_graphn_to_string(s : TimeseriesanomalyisolationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_node_make(size : Int) -> TimeseriesanomalyisolationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_node_len(s : TimeseriesanomalyisolationNode) -> Int { s.size }

pub fn timeseries_anomaly_isolation_node_get(s : TimeseriesanomalyisolationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_node_set(s : TimeseriesanomalyisolationNode, i : Int, v : Double) -> TimeseriesanomalyisolationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_node_sum(s : TimeseriesanomalyisolationNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_node_mean(s : TimeseriesanomalyisolationNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_node_scale(s : TimeseriesanomalyisolationNode, f : Double) -> TimeseriesanomalyisolationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_node_add(a : TimeseriesanomalyisolationNode, b : TimeseriesanomalyisolationNode) -> TimeseriesanomalyisolationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_node_copy(s : TimeseriesanomalyisolationNode) -> TimeseriesanomalyisolationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_node_fill(s : TimeseriesanomalyisolationNode, v : Double) -> TimeseriesanomalyisolationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_node_min(s : TimeseriesanomalyisolationNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_node_max(s : TimeseriesanomalyisolationNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_node_to_string(s : TimeseriesanomalyisolationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_edge_make(size : Int) -> TimeseriesanomalyisolationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_edge_len(s : TimeseriesanomalyisolationEdge) -> Int { s.size }

pub fn timeseries_anomaly_isolation_edge_get(s : TimeseriesanomalyisolationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_edge_set(s : TimeseriesanomalyisolationEdge, i : Int, v : Double) -> TimeseriesanomalyisolationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_edge_sum(s : TimeseriesanomalyisolationEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_edge_mean(s : TimeseriesanomalyisolationEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_edge_scale(s : TimeseriesanomalyisolationEdge, f : Double) -> TimeseriesanomalyisolationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_edge_add(a : TimeseriesanomalyisolationEdge, b : TimeseriesanomalyisolationEdge) -> TimeseriesanomalyisolationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_edge_copy(s : TimeseriesanomalyisolationEdge) -> TimeseriesanomalyisolationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_edge_fill(s : TimeseriesanomalyisolationEdge, v : Double) -> TimeseriesanomalyisolationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_edge_min(s : TimeseriesanomalyisolationEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_edge_max(s : TimeseriesanomalyisolationEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_edge_to_string(s : TimeseriesanomalyisolationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_path_make(size : Int) -> TimeseriesanomalyisolationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_path_len(s : TimeseriesanomalyisolationPath) -> Int { s.size }

pub fn timeseries_anomaly_isolation_path_get(s : TimeseriesanomalyisolationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_path_set(s : TimeseriesanomalyisolationPath, i : Int, v : Double) -> TimeseriesanomalyisolationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_path_sum(s : TimeseriesanomalyisolationPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_path_mean(s : TimeseriesanomalyisolationPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_path_scale(s : TimeseriesanomalyisolationPath, f : Double) -> TimeseriesanomalyisolationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_path_add(a : TimeseriesanomalyisolationPath, b : TimeseriesanomalyisolationPath) -> TimeseriesanomalyisolationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_path_copy(s : TimeseriesanomalyisolationPath) -> TimeseriesanomalyisolationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_path_fill(s : TimeseriesanomalyisolationPath, v : Double) -> TimeseriesanomalyisolationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_path_min(s : TimeseriesanomalyisolationPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_path_max(s : TimeseriesanomalyisolationPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_path_to_string(s : TimeseriesanomalyisolationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_cluster_make(size : Int) -> TimeseriesanomalyisolationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_cluster_len(s : TimeseriesanomalyisolationCluster) -> Int { s.size }

pub fn timeseries_anomaly_isolation_cluster_get(s : TimeseriesanomalyisolationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_cluster_set(s : TimeseriesanomalyisolationCluster, i : Int, v : Double) -> TimeseriesanomalyisolationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cluster_sum(s : TimeseriesanomalyisolationCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_cluster_mean(s : TimeseriesanomalyisolationCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_cluster_scale(s : TimeseriesanomalyisolationCluster, f : Double) -> TimeseriesanomalyisolationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cluster_add(a : TimeseriesanomalyisolationCluster, b : TimeseriesanomalyisolationCluster) -> TimeseriesanomalyisolationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_cluster_copy(s : TimeseriesanomalyisolationCluster) -> TimeseriesanomalyisolationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cluster_fill(s : TimeseriesanomalyisolationCluster, v : Double) -> TimeseriesanomalyisolationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cluster_min(s : TimeseriesanomalyisolationCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_cluster_max(s : TimeseriesanomalyisolationCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_cluster_to_string(s : TimeseriesanomalyisolationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_model_make(size : Int) -> TimeseriesanomalyisolationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_model_len(s : TimeseriesanomalyisolationModel) -> Int { s.size }

pub fn timeseries_anomaly_isolation_model_get(s : TimeseriesanomalyisolationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_model_set(s : TimeseriesanomalyisolationModel, i : Int, v : Double) -> TimeseriesanomalyisolationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_model_sum(s : TimeseriesanomalyisolationModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_model_mean(s : TimeseriesanomalyisolationModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_model_scale(s : TimeseriesanomalyisolationModel, f : Double) -> TimeseriesanomalyisolationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_model_add(a : TimeseriesanomalyisolationModel, b : TimeseriesanomalyisolationModel) -> TimeseriesanomalyisolationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_model_copy(s : TimeseriesanomalyisolationModel) -> TimeseriesanomalyisolationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_model_fill(s : TimeseriesanomalyisolationModel, v : Double) -> TimeseriesanomalyisolationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_model_min(s : TimeseriesanomalyisolationModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_model_max(s : TimeseriesanomalyisolationModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_model_to_string(s : TimeseriesanomalyisolationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_layer_make(size : Int) -> TimeseriesanomalyisolationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_layer_len(s : TimeseriesanomalyisolationLayer) -> Int { s.size }

pub fn timeseries_anomaly_isolation_layer_get(s : TimeseriesanomalyisolationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_layer_set(s : TimeseriesanomalyisolationLayer, i : Int, v : Double) -> TimeseriesanomalyisolationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_layer_sum(s : TimeseriesanomalyisolationLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_layer_mean(s : TimeseriesanomalyisolationLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_layer_scale(s : TimeseriesanomalyisolationLayer, f : Double) -> TimeseriesanomalyisolationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_layer_add(a : TimeseriesanomalyisolationLayer, b : TimeseriesanomalyisolationLayer) -> TimeseriesanomalyisolationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_layer_copy(s : TimeseriesanomalyisolationLayer) -> TimeseriesanomalyisolationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_layer_fill(s : TimeseriesanomalyisolationLayer, v : Double) -> TimeseriesanomalyisolationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_layer_min(s : TimeseriesanomalyisolationLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_layer_max(s : TimeseriesanomalyisolationLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_layer_to_string(s : TimeseriesanomalyisolationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_buffer_make(size : Int) -> TimeseriesanomalyisolationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_buffer_len(s : TimeseriesanomalyisolationBuffer) -> Int { s.size }

pub fn timeseries_anomaly_isolation_buffer_get(s : TimeseriesanomalyisolationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_buffer_set(s : TimeseriesanomalyisolationBuffer, i : Int, v : Double) -> TimeseriesanomalyisolationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_buffer_sum(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_buffer_mean(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_buffer_scale(s : TimeseriesanomalyisolationBuffer, f : Double) -> TimeseriesanomalyisolationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_buffer_add(a : TimeseriesanomalyisolationBuffer, b : TimeseriesanomalyisolationBuffer) -> TimeseriesanomalyisolationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_buffer_copy(s : TimeseriesanomalyisolationBuffer) -> TimeseriesanomalyisolationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_buffer_fill(s : TimeseriesanomalyisolationBuffer, v : Double) -> TimeseriesanomalyisolationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_buffer_min(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_buffer_max(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_buffer_to_string(s : TimeseriesanomalyisolationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_cursor_make(size : Int) -> TimeseriesanomalyisolationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_cursor_len(s : TimeseriesanomalyisolationCursor) -> Int { s.size }

pub fn timeseries_anomaly_isolation_cursor_get(s : TimeseriesanomalyisolationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_cursor_set(s : TimeseriesanomalyisolationCursor, i : Int, v : Double) -> TimeseriesanomalyisolationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cursor_sum(s : TimeseriesanomalyisolationCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_cursor_mean(s : TimeseriesanomalyisolationCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_cursor_scale(s : TimeseriesanomalyisolationCursor, f : Double) -> TimeseriesanomalyisolationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cursor_add(a : TimeseriesanomalyisolationCursor, b : TimeseriesanomalyisolationCursor) -> TimeseriesanomalyisolationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_cursor_copy(s : TimeseriesanomalyisolationCursor) -> TimeseriesanomalyisolationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cursor_fill(s : TimeseriesanomalyisolationCursor, v : Double) -> TimeseriesanomalyisolationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_cursor_min(s : TimeseriesanomalyisolationCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_cursor_max(s : TimeseriesanomalyisolationCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_cursor_to_string(s : TimeseriesanomalyisolationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_view_make(size : Int) -> TimeseriesanomalyisolationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_view_len(s : TimeseriesanomalyisolationView) -> Int { s.size }

pub fn timeseries_anomaly_isolation_view_get(s : TimeseriesanomalyisolationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_view_set(s : TimeseriesanomalyisolationView, i : Int, v : Double) -> TimeseriesanomalyisolationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_view_sum(s : TimeseriesanomalyisolationView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_view_mean(s : TimeseriesanomalyisolationView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_view_scale(s : TimeseriesanomalyisolationView, f : Double) -> TimeseriesanomalyisolationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_view_add(a : TimeseriesanomalyisolationView, b : TimeseriesanomalyisolationView) -> TimeseriesanomalyisolationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_view_copy(s : TimeseriesanomalyisolationView) -> TimeseriesanomalyisolationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_view_fill(s : TimeseriesanomalyisolationView, v : Double) -> TimeseriesanomalyisolationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_view_min(s : TimeseriesanomalyisolationView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_view_max(s : TimeseriesanomalyisolationView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_view_to_string(s : TimeseriesanomalyisolationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_range_make(size : Int) -> TimeseriesanomalyisolationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_range_len(s : TimeseriesanomalyisolationRange) -> Int { s.size }

pub fn timeseries_anomaly_isolation_range_get(s : TimeseriesanomalyisolationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_range_set(s : TimeseriesanomalyisolationRange, i : Int, v : Double) -> TimeseriesanomalyisolationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_range_sum(s : TimeseriesanomalyisolationRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_range_mean(s : TimeseriesanomalyisolationRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_range_scale(s : TimeseriesanomalyisolationRange, f : Double) -> TimeseriesanomalyisolationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_range_add(a : TimeseriesanomalyisolationRange, b : TimeseriesanomalyisolationRange) -> TimeseriesanomalyisolationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_range_copy(s : TimeseriesanomalyisolationRange) -> TimeseriesanomalyisolationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_range_fill(s : TimeseriesanomalyisolationRange, v : Double) -> TimeseriesanomalyisolationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_range_min(s : TimeseriesanomalyisolationRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_range_max(s : TimeseriesanomalyisolationRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_range_to_string(s : TimeseriesanomalyisolationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_slice_make(size : Int) -> TimeseriesanomalyisolationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_slice_len(s : TimeseriesanomalyisolationSlice) -> Int { s.size }

pub fn timeseries_anomaly_isolation_slice_get(s : TimeseriesanomalyisolationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_slice_set(s : TimeseriesanomalyisolationSlice, i : Int, v : Double) -> TimeseriesanomalyisolationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_slice_sum(s : TimeseriesanomalyisolationSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_slice_mean(s : TimeseriesanomalyisolationSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_slice_scale(s : TimeseriesanomalyisolationSlice, f : Double) -> TimeseriesanomalyisolationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_slice_add(a : TimeseriesanomalyisolationSlice, b : TimeseriesanomalyisolationSlice) -> TimeseriesanomalyisolationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_isolation_slice_copy(s : TimeseriesanomalyisolationSlice) -> TimeseriesanomalyisolationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_slice_fill(s : TimeseriesanomalyisolationSlice, v : Double) -> TimeseriesanomalyisolationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_isolation_slice_min(s : TimeseriesanomalyisolationSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_slice_max(s : TimeseriesanomalyisolationSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_slice_to_string(s : TimeseriesanomalyisolationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

