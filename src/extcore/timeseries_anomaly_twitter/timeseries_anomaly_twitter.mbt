///===
/// extcore/timeseries_anomaly_twitter

pub(all) struct TimeseriesanomalytwitterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_twitter_make_point(x : Double, y : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_twitter_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalytwitterPoint::x(self : TimeseriesanomalytwitterPoint) -> Double { self.x }

pub fn TimeseriesanomalytwitterPoint::y(self : TimeseriesanomalytwitterPoint) -> Double { self.y }

pub fn TimeseriesanomalytwitterPoint::z(self : TimeseriesanomalytwitterPoint) -> Double { self.z }

pub fn TimeseriesanomalytwitterPoint::label(self : TimeseriesanomalytwitterPoint) -> Int { self.label }

pub fn TimeseriesanomalytwitterPoint::dist(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalytwitterPoint::add(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::sub(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::scale(self : TimeseriesanomalytwitterPoint, s : Double) -> TimeseriesanomalytwitterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::dot(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalytwitterPoint::cross(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalytwitterPoint::norm(self : TimeseriesanomalytwitterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalytwitterPoint::normalize(self : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalytwitterPoint::negate(self : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::mid(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::lerp(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint, t : Double) -> TimeseriesanomalytwitterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::to_string(self : TimeseriesanomalytwitterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_twitter_make_series(vals : Array[Double], name : String) -> TimeseriesanomalytwitterSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalytwitterSeries::len(self : TimeseriesanomalytwitterSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalytwitterSeries::sum(self : TimeseriesanomalytwitterSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalytwitterSeries::mean(self : TimeseriesanomalytwitterSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalytwitterSeries::min(self : TimeseriesanomalytwitterSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalytwitterSeries::max(self : TimeseriesanomalytwitterSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalytwitterSeries::range(self : TimeseriesanomalytwitterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalytwitterSeries::variance(self : TimeseriesanomalytwitterSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalytwitterSeries::std(self : TimeseriesanomalytwitterSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalytwitterSeries::median(self : TimeseriesanomalytwitterSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalytwitterSeries::scale(self : TimeseriesanomalytwitterSeries, f : Double) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::add(self : TimeseriesanomalytwitterSeries, other : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::sub(self : TimeseriesanomalytwitterSeries, other : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::normalize(self : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalytwitterSeries::cumsum(self : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::to_string(self : TimeseriesanomalytwitterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalytwitterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_twitter_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalytwitterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_twitter_matrix_identity(n : Int) -> TimeseriesanomalytwitterMatrix {
  let m = timeseries_anomaly_twitter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalytwitterMatrix::get(self : TimeseriesanomalytwitterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalytwitterMatrix::transpose(self : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalytwitterMatrix::add(self : TimeseriesanomalytwitterMatrix, other : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_twitter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalytwitterMatrix::scale(self : TimeseriesanomalytwitterMatrix, s : Double) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalytwitterMatrix::multiply(self : TimeseriesanomalytwitterMatrix, other : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if self.cols != other.rows { return timeseries_anomaly_twitter_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_twitter_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalytwitterMatrix::trace(self : TimeseriesanomalytwitterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalytwitterMatrix::det(self : TimeseriesanomalytwitterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalytwitterMatrix::norm(self : TimeseriesanomalytwitterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalytwitterMatrix::to_string(self : TimeseriesanomalytwitterMatrix) -> String {
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

pub(all) struct TimeseriesanomalytwitterVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_twitter_make_vector(comps : Array[Double]) -> TimeseriesanomalytwitterVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_twitter_vector_zero(dim : Int) -> TimeseriesanomalytwitterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalytwitterVector::add(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalytwitterVector::sub(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalytwitterVector::scale(self : TimeseriesanomalytwitterVector, s : Double) -> TimeseriesanomalytwitterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalytwitterVector::dot(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalytwitterVector::norm(self : TimeseriesanomalytwitterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalytwitterVector::normalize(self : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalytwitterVector::dist(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalytwitterVector::to_string(self : TimeseriesanomalytwitterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_twitter_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_twitter_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_twitter_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_twitter_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_twitter_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_twitter_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_twitter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_twitter_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_twitter_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_twitter_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_twitter_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_twitter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_twitter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_twitter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_twitter_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_twitter_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_twitter_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_twitter_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_twitter_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_twitter_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_twitter_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_twitter_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_twitter_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_twitter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_twitter_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_twitter_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_twitter_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_twitter_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_twitter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalytwitterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_frame_make(size : Int) -> TimeseriesanomalytwitterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_frame_len(s : TimeseriesanomalytwitterFrame) -> Int { s.size }

pub fn timeseries_anomaly_twitter_frame_get(s : TimeseriesanomalytwitterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_frame_set(s : TimeseriesanomalytwitterFrame, i : Int, v : Double) -> TimeseriesanomalytwitterFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_sum(s : TimeseriesanomalytwitterFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_frame_mean(s : TimeseriesanomalytwitterFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_frame_scale(s : TimeseriesanomalytwitterFrame, f : Double) -> TimeseriesanomalytwitterFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_add(a : TimeseriesanomalytwitterFrame, b : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_frame_copy(s : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_fill(s : TimeseriesanomalytwitterFrame, v : Double) -> TimeseriesanomalytwitterFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_min(s : TimeseriesanomalytwitterFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_frame_max(s : TimeseriesanomalytwitterFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_frame_to_string(s : TimeseriesanomalytwitterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_table_make(size : Int) -> TimeseriesanomalytwitterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_table_len(s : TimeseriesanomalytwitterTable) -> Int { s.size }

pub fn timeseries_anomaly_twitter_table_get(s : TimeseriesanomalytwitterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_table_set(s : TimeseriesanomalytwitterTable, i : Int, v : Double) -> TimeseriesanomalytwitterTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_sum(s : TimeseriesanomalytwitterTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_table_mean(s : TimeseriesanomalytwitterTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_table_scale(s : TimeseriesanomalytwitterTable, f : Double) -> TimeseriesanomalytwitterTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_add(a : TimeseriesanomalytwitterTable, b : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_table_copy(s : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_fill(s : TimeseriesanomalytwitterTable, v : Double) -> TimeseriesanomalytwitterTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_min(s : TimeseriesanomalytwitterTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_table_max(s : TimeseriesanomalytwitterTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_table_to_string(s : TimeseriesanomalytwitterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_graphn_make(size : Int) -> TimeseriesanomalytwitterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_graphn_len(s : TimeseriesanomalytwitterGraphN) -> Int { s.size }

pub fn timeseries_anomaly_twitter_graphn_get(s : TimeseriesanomalytwitterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_graphn_set(s : TimeseriesanomalytwitterGraphN, i : Int, v : Double) -> TimeseriesanomalytwitterGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_sum(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_graphn_mean(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_graphn_scale(s : TimeseriesanomalytwitterGraphN, f : Double) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_add(a : TimeseriesanomalytwitterGraphN, b : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_graphn_copy(s : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_fill(s : TimeseriesanomalytwitterGraphN, v : Double) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_min(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_graphn_max(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_graphn_to_string(s : TimeseriesanomalytwitterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_node_make(size : Int) -> TimeseriesanomalytwitterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_node_len(s : TimeseriesanomalytwitterNode) -> Int { s.size }

pub fn timeseries_anomaly_twitter_node_get(s : TimeseriesanomalytwitterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_node_set(s : TimeseriesanomalytwitterNode, i : Int, v : Double) -> TimeseriesanomalytwitterNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_sum(s : TimeseriesanomalytwitterNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_node_mean(s : TimeseriesanomalytwitterNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_node_scale(s : TimeseriesanomalytwitterNode, f : Double) -> TimeseriesanomalytwitterNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_add(a : TimeseriesanomalytwitterNode, b : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_node_copy(s : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_fill(s : TimeseriesanomalytwitterNode, v : Double) -> TimeseriesanomalytwitterNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_min(s : TimeseriesanomalytwitterNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_node_max(s : TimeseriesanomalytwitterNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_node_to_string(s : TimeseriesanomalytwitterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_edge_make(size : Int) -> TimeseriesanomalytwitterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_edge_len(s : TimeseriesanomalytwitterEdge) -> Int { s.size }

pub fn timeseries_anomaly_twitter_edge_get(s : TimeseriesanomalytwitterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_edge_set(s : TimeseriesanomalytwitterEdge, i : Int, v : Double) -> TimeseriesanomalytwitterEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_sum(s : TimeseriesanomalytwitterEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_edge_mean(s : TimeseriesanomalytwitterEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_edge_scale(s : TimeseriesanomalytwitterEdge, f : Double) -> TimeseriesanomalytwitterEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_add(a : TimeseriesanomalytwitterEdge, b : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_edge_copy(s : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_fill(s : TimeseriesanomalytwitterEdge, v : Double) -> TimeseriesanomalytwitterEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_min(s : TimeseriesanomalytwitterEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_edge_max(s : TimeseriesanomalytwitterEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_edge_to_string(s : TimeseriesanomalytwitterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_path_make(size : Int) -> TimeseriesanomalytwitterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_path_len(s : TimeseriesanomalytwitterPath) -> Int { s.size }

pub fn timeseries_anomaly_twitter_path_get(s : TimeseriesanomalytwitterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_path_set(s : TimeseriesanomalytwitterPath, i : Int, v : Double) -> TimeseriesanomalytwitterPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_sum(s : TimeseriesanomalytwitterPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_path_mean(s : TimeseriesanomalytwitterPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_path_scale(s : TimeseriesanomalytwitterPath, f : Double) -> TimeseriesanomalytwitterPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_add(a : TimeseriesanomalytwitterPath, b : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_path_copy(s : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_fill(s : TimeseriesanomalytwitterPath, v : Double) -> TimeseriesanomalytwitterPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_min(s : TimeseriesanomalytwitterPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_path_max(s : TimeseriesanomalytwitterPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_path_to_string(s : TimeseriesanomalytwitterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cluster_make(size : Int) -> TimeseriesanomalytwitterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_cluster_len(s : TimeseriesanomalytwitterCluster) -> Int { s.size }

pub fn timeseries_anomaly_twitter_cluster_get(s : TimeseriesanomalytwitterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_cluster_set(s : TimeseriesanomalytwitterCluster, i : Int, v : Double) -> TimeseriesanomalytwitterCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_sum(s : TimeseriesanomalytwitterCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_cluster_mean(s : TimeseriesanomalytwitterCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_cluster_scale(s : TimeseriesanomalytwitterCluster, f : Double) -> TimeseriesanomalytwitterCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_add(a : TimeseriesanomalytwitterCluster, b : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_cluster_copy(s : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_fill(s : TimeseriesanomalytwitterCluster, v : Double) -> TimeseriesanomalytwitterCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_min(s : TimeseriesanomalytwitterCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_cluster_max(s : TimeseriesanomalytwitterCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_cluster_to_string(s : TimeseriesanomalytwitterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_model_make(size : Int) -> TimeseriesanomalytwitterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_model_len(s : TimeseriesanomalytwitterModel) -> Int { s.size }

pub fn timeseries_anomaly_twitter_model_get(s : TimeseriesanomalytwitterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_model_set(s : TimeseriesanomalytwitterModel, i : Int, v : Double) -> TimeseriesanomalytwitterModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_sum(s : TimeseriesanomalytwitterModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_model_mean(s : TimeseriesanomalytwitterModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_model_scale(s : TimeseriesanomalytwitterModel, f : Double) -> TimeseriesanomalytwitterModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_add(a : TimeseriesanomalytwitterModel, b : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_model_copy(s : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_fill(s : TimeseriesanomalytwitterModel, v : Double) -> TimeseriesanomalytwitterModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_min(s : TimeseriesanomalytwitterModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_model_max(s : TimeseriesanomalytwitterModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_model_to_string(s : TimeseriesanomalytwitterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_layer_make(size : Int) -> TimeseriesanomalytwitterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_layer_len(s : TimeseriesanomalytwitterLayer) -> Int { s.size }

pub fn timeseries_anomaly_twitter_layer_get(s : TimeseriesanomalytwitterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_layer_set(s : TimeseriesanomalytwitterLayer, i : Int, v : Double) -> TimeseriesanomalytwitterLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_sum(s : TimeseriesanomalytwitterLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_layer_mean(s : TimeseriesanomalytwitterLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_layer_scale(s : TimeseriesanomalytwitterLayer, f : Double) -> TimeseriesanomalytwitterLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_add(a : TimeseriesanomalytwitterLayer, b : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_layer_copy(s : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_fill(s : TimeseriesanomalytwitterLayer, v : Double) -> TimeseriesanomalytwitterLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_min(s : TimeseriesanomalytwitterLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_layer_max(s : TimeseriesanomalytwitterLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_layer_to_string(s : TimeseriesanomalytwitterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_buffer_make(size : Int) -> TimeseriesanomalytwitterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_buffer_len(s : TimeseriesanomalytwitterBuffer) -> Int { s.size }

pub fn timeseries_anomaly_twitter_buffer_get(s : TimeseriesanomalytwitterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_buffer_set(s : TimeseriesanomalytwitterBuffer, i : Int, v : Double) -> TimeseriesanomalytwitterBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_sum(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_buffer_mean(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_buffer_scale(s : TimeseriesanomalytwitterBuffer, f : Double) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_add(a : TimeseriesanomalytwitterBuffer, b : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_buffer_copy(s : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_fill(s : TimeseriesanomalytwitterBuffer, v : Double) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_min(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_buffer_max(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_buffer_to_string(s : TimeseriesanomalytwitterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cursor_make(size : Int) -> TimeseriesanomalytwitterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_cursor_len(s : TimeseriesanomalytwitterCursor) -> Int { s.size }

pub fn timeseries_anomaly_twitter_cursor_get(s : TimeseriesanomalytwitterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_cursor_set(s : TimeseriesanomalytwitterCursor, i : Int, v : Double) -> TimeseriesanomalytwitterCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_sum(s : TimeseriesanomalytwitterCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_cursor_mean(s : TimeseriesanomalytwitterCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_cursor_scale(s : TimeseriesanomalytwitterCursor, f : Double) -> TimeseriesanomalytwitterCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_add(a : TimeseriesanomalytwitterCursor, b : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_cursor_copy(s : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_fill(s : TimeseriesanomalytwitterCursor, v : Double) -> TimeseriesanomalytwitterCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_min(s : TimeseriesanomalytwitterCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_cursor_max(s : TimeseriesanomalytwitterCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_cursor_to_string(s : TimeseriesanomalytwitterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_view_make(size : Int) -> TimeseriesanomalytwitterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_view_len(s : TimeseriesanomalytwitterView) -> Int { s.size }

pub fn timeseries_anomaly_twitter_view_get(s : TimeseriesanomalytwitterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_view_set(s : TimeseriesanomalytwitterView, i : Int, v : Double) -> TimeseriesanomalytwitterView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_sum(s : TimeseriesanomalytwitterView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_view_mean(s : TimeseriesanomalytwitterView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_view_scale(s : TimeseriesanomalytwitterView, f : Double) -> TimeseriesanomalytwitterView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_add(a : TimeseriesanomalytwitterView, b : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_view_copy(s : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_fill(s : TimeseriesanomalytwitterView, v : Double) -> TimeseriesanomalytwitterView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_min(s : TimeseriesanomalytwitterView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_view_max(s : TimeseriesanomalytwitterView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_view_to_string(s : TimeseriesanomalytwitterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_range_make(size : Int) -> TimeseriesanomalytwitterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_range_len(s : TimeseriesanomalytwitterRange) -> Int { s.size }

pub fn timeseries_anomaly_twitter_range_get(s : TimeseriesanomalytwitterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_range_set(s : TimeseriesanomalytwitterRange, i : Int, v : Double) -> TimeseriesanomalytwitterRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_sum(s : TimeseriesanomalytwitterRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_range_mean(s : TimeseriesanomalytwitterRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_range_scale(s : TimeseriesanomalytwitterRange, f : Double) -> TimeseriesanomalytwitterRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_add(a : TimeseriesanomalytwitterRange, b : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_range_copy(s : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_fill(s : TimeseriesanomalytwitterRange, v : Double) -> TimeseriesanomalytwitterRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_min(s : TimeseriesanomalytwitterRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_range_max(s : TimeseriesanomalytwitterRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_range_to_string(s : TimeseriesanomalytwitterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_slice_make(size : Int) -> TimeseriesanomalytwitterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_slice_len(s : TimeseriesanomalytwitterSlice) -> Int { s.size }

pub fn timeseries_anomaly_twitter_slice_get(s : TimeseriesanomalytwitterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_slice_set(s : TimeseriesanomalytwitterSlice, i : Int, v : Double) -> TimeseriesanomalytwitterSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_sum(s : TimeseriesanomalytwitterSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_slice_mean(s : TimeseriesanomalytwitterSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_slice_scale(s : TimeseriesanomalytwitterSlice, f : Double) -> TimeseriesanomalytwitterSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_add(a : TimeseriesanomalytwitterSlice, b : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_slice_copy(s : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_fill(s : TimeseriesanomalytwitterSlice, v : Double) -> TimeseriesanomalytwitterSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_min(s : TimeseriesanomalytwitterSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_slice_max(s : TimeseriesanomalytwitterSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_slice_to_string(s : TimeseriesanomalytwitterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

