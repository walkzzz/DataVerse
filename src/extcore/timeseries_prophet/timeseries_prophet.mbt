///===
/// extcore/timeseries_prophet

pub(all) struct TimeseriesprophetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_prophet_make_point(x : Double, y : Double) -> TimeseriesprophetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_prophet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesprophetPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesprophetPoint::x(self : TimeseriesprophetPoint) -> Double { self.x }

pub fn TimeseriesprophetPoint::y(self : TimeseriesprophetPoint) -> Double { self.y }

pub fn TimeseriesprophetPoint::z(self : TimeseriesprophetPoint) -> Double { self.z }

pub fn TimeseriesprophetPoint::label(self : TimeseriesprophetPoint) -> Int { self.label }

pub fn TimeseriesprophetPoint::dist(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesprophetPoint::add(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesprophetPoint::sub(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesprophetPoint::scale(self : TimeseriesprophetPoint, s : Double) -> TimeseriesprophetPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesprophetPoint::dot(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesprophetPoint::cross(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesprophetPoint::norm(self : TimeseriesprophetPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesprophetPoint::normalize(self : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesprophetPoint::negate(self : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesprophetPoint::mid(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesprophetPoint::lerp(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint, t : Double) -> TimeseriesprophetPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesprophetPoint::to_string(self : TimeseriesprophetPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesprophetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_prophet_make_series(vals : Array[Double], name : String) -> TimeseriesprophetSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesprophetSeries::len(self : TimeseriesprophetSeries) -> Int { self.vals.length() }

pub fn TimeseriesprophetSeries::sum(self : TimeseriesprophetSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesprophetSeries::mean(self : TimeseriesprophetSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesprophetSeries::min(self : TimeseriesprophetSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesprophetSeries::max(self : TimeseriesprophetSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesprophetSeries::range(self : TimeseriesprophetSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesprophetSeries::variance(self : TimeseriesprophetSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesprophetSeries::std(self : TimeseriesprophetSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesprophetSeries::median(self : TimeseriesprophetSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesprophetSeries::scale(self : TimeseriesprophetSeries, f : Double) -> TimeseriesprophetSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesprophetSeries::add(self : TimeseriesprophetSeries, other : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesprophetSeries::sub(self : TimeseriesprophetSeries, other : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesprophetSeries::normalize(self : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesprophetSeries::cumsum(self : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesprophetSeries::to_string(self : TimeseriesprophetSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesprophetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_prophet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesprophetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_prophet_matrix_identity(n : Int) -> TimeseriesprophetMatrix {
  let m = timeseries_prophet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesprophetMatrix::get(self : TimeseriesprophetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesprophetMatrix::transpose(self : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  let result = timeseries_prophet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesprophetMatrix::add(self : TimeseriesprophetMatrix, other : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_prophet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesprophetMatrix::scale(self : TimeseriesprophetMatrix, s : Double) -> TimeseriesprophetMatrix {
  let result = timeseries_prophet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesprophetMatrix::multiply(self : TimeseriesprophetMatrix, other : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  if self.cols != other.rows { return timeseries_prophet_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_prophet_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesprophetMatrix::trace(self : TimeseriesprophetMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesprophetMatrix::det(self : TimeseriesprophetMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesprophetMatrix::norm(self : TimeseriesprophetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesprophetMatrix::to_string(self : TimeseriesprophetMatrix) -> String {
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

pub(all) struct TimeseriesprophetVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_prophet_make_vector(comps : Array[Double]) -> TimeseriesprophetVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_prophet_vector_zero(dim : Int) -> TimeseriesprophetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesprophetVector::add(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesprophetVector::sub(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesprophetVector::scale(self : TimeseriesprophetVector, s : Double) -> TimeseriesprophetVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesprophetVector::dot(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesprophetVector::norm(self : TimeseriesprophetVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesprophetVector::normalize(self : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesprophetVector::dist(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesprophetVector::to_string(self : TimeseriesprophetVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_prophet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_prophet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_prophet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_prophet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_prophet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_prophet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_prophet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_prophet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_prophet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_prophet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_prophet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_prophet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_prophet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_prophet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_prophet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_prophet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_prophet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_prophet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_prophet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_prophet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_prophet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_prophet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_prophet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_prophet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_prophet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_prophet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_prophet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_prophet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_prophet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesprophetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_frame_make(size : Int) -> TimeseriesprophetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_frame_len(s : TimeseriesprophetFrame) -> Int { s.size }

pub fn timeseries_prophet_frame_get(s : TimeseriesprophetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_frame_set(s : TimeseriesprophetFrame, i : Int, v : Double) -> TimeseriesprophetFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_frame_sum(s : TimeseriesprophetFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_frame_mean(s : TimeseriesprophetFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_frame_scale(s : TimeseriesprophetFrame, f : Double) -> TimeseriesprophetFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_frame_add(a : TimeseriesprophetFrame, b : TimeseriesprophetFrame) -> TimeseriesprophetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_frame_copy(s : TimeseriesprophetFrame) -> TimeseriesprophetFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_frame_fill(s : TimeseriesprophetFrame, v : Double) -> TimeseriesprophetFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_frame_min(s : TimeseriesprophetFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_frame_max(s : TimeseriesprophetFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_frame_to_string(s : TimeseriesprophetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_table_make(size : Int) -> TimeseriesprophetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_table_len(s : TimeseriesprophetTable) -> Int { s.size }

pub fn timeseries_prophet_table_get(s : TimeseriesprophetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_table_set(s : TimeseriesprophetTable, i : Int, v : Double) -> TimeseriesprophetTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_table_sum(s : TimeseriesprophetTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_table_mean(s : TimeseriesprophetTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_table_scale(s : TimeseriesprophetTable, f : Double) -> TimeseriesprophetTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_table_add(a : TimeseriesprophetTable, b : TimeseriesprophetTable) -> TimeseriesprophetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_table_copy(s : TimeseriesprophetTable) -> TimeseriesprophetTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_table_fill(s : TimeseriesprophetTable, v : Double) -> TimeseriesprophetTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_table_min(s : TimeseriesprophetTable) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_table_max(s : TimeseriesprophetTable) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_table_to_string(s : TimeseriesprophetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_graphn_make(size : Int) -> TimeseriesprophetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_graphn_len(s : TimeseriesprophetGraphN) -> Int { s.size }

pub fn timeseries_prophet_graphn_get(s : TimeseriesprophetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_graphn_set(s : TimeseriesprophetGraphN, i : Int, v : Double) -> TimeseriesprophetGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_graphn_sum(s : TimeseriesprophetGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_graphn_mean(s : TimeseriesprophetGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_graphn_scale(s : TimeseriesprophetGraphN, f : Double) -> TimeseriesprophetGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_graphn_add(a : TimeseriesprophetGraphN, b : TimeseriesprophetGraphN) -> TimeseriesprophetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_graphn_copy(s : TimeseriesprophetGraphN) -> TimeseriesprophetGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_graphn_fill(s : TimeseriesprophetGraphN, v : Double) -> TimeseriesprophetGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_graphn_min(s : TimeseriesprophetGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_graphn_max(s : TimeseriesprophetGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_graphn_to_string(s : TimeseriesprophetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_node_make(size : Int) -> TimeseriesprophetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_node_len(s : TimeseriesprophetNode) -> Int { s.size }

pub fn timeseries_prophet_node_get(s : TimeseriesprophetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_node_set(s : TimeseriesprophetNode, i : Int, v : Double) -> TimeseriesprophetNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_node_sum(s : TimeseriesprophetNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_node_mean(s : TimeseriesprophetNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_node_scale(s : TimeseriesprophetNode, f : Double) -> TimeseriesprophetNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_node_add(a : TimeseriesprophetNode, b : TimeseriesprophetNode) -> TimeseriesprophetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_node_copy(s : TimeseriesprophetNode) -> TimeseriesprophetNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_node_fill(s : TimeseriesprophetNode, v : Double) -> TimeseriesprophetNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_node_min(s : TimeseriesprophetNode) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_node_max(s : TimeseriesprophetNode) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_node_to_string(s : TimeseriesprophetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_edge_make(size : Int) -> TimeseriesprophetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_edge_len(s : TimeseriesprophetEdge) -> Int { s.size }

pub fn timeseries_prophet_edge_get(s : TimeseriesprophetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_edge_set(s : TimeseriesprophetEdge, i : Int, v : Double) -> TimeseriesprophetEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_edge_sum(s : TimeseriesprophetEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_edge_mean(s : TimeseriesprophetEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_edge_scale(s : TimeseriesprophetEdge, f : Double) -> TimeseriesprophetEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_edge_add(a : TimeseriesprophetEdge, b : TimeseriesprophetEdge) -> TimeseriesprophetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_edge_copy(s : TimeseriesprophetEdge) -> TimeseriesprophetEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_edge_fill(s : TimeseriesprophetEdge, v : Double) -> TimeseriesprophetEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_edge_min(s : TimeseriesprophetEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_edge_max(s : TimeseriesprophetEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_edge_to_string(s : TimeseriesprophetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_path_make(size : Int) -> TimeseriesprophetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_path_len(s : TimeseriesprophetPath) -> Int { s.size }

pub fn timeseries_prophet_path_get(s : TimeseriesprophetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_path_set(s : TimeseriesprophetPath, i : Int, v : Double) -> TimeseriesprophetPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_path_sum(s : TimeseriesprophetPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_path_mean(s : TimeseriesprophetPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_path_scale(s : TimeseriesprophetPath, f : Double) -> TimeseriesprophetPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_path_add(a : TimeseriesprophetPath, b : TimeseriesprophetPath) -> TimeseriesprophetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_path_copy(s : TimeseriesprophetPath) -> TimeseriesprophetPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_path_fill(s : TimeseriesprophetPath, v : Double) -> TimeseriesprophetPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_path_min(s : TimeseriesprophetPath) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_path_max(s : TimeseriesprophetPath) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_path_to_string(s : TimeseriesprophetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_cluster_make(size : Int) -> TimeseriesprophetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_cluster_len(s : TimeseriesprophetCluster) -> Int { s.size }

pub fn timeseries_prophet_cluster_get(s : TimeseriesprophetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_cluster_set(s : TimeseriesprophetCluster, i : Int, v : Double) -> TimeseriesprophetCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cluster_sum(s : TimeseriesprophetCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_cluster_mean(s : TimeseriesprophetCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_cluster_scale(s : TimeseriesprophetCluster, f : Double) -> TimeseriesprophetCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cluster_add(a : TimeseriesprophetCluster, b : TimeseriesprophetCluster) -> TimeseriesprophetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_cluster_copy(s : TimeseriesprophetCluster) -> TimeseriesprophetCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cluster_fill(s : TimeseriesprophetCluster, v : Double) -> TimeseriesprophetCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cluster_min(s : TimeseriesprophetCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_cluster_max(s : TimeseriesprophetCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_cluster_to_string(s : TimeseriesprophetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_model_make(size : Int) -> TimeseriesprophetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_model_len(s : TimeseriesprophetModel) -> Int { s.size }

pub fn timeseries_prophet_model_get(s : TimeseriesprophetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_model_set(s : TimeseriesprophetModel, i : Int, v : Double) -> TimeseriesprophetModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_model_sum(s : TimeseriesprophetModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_model_mean(s : TimeseriesprophetModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_model_scale(s : TimeseriesprophetModel, f : Double) -> TimeseriesprophetModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_model_add(a : TimeseriesprophetModel, b : TimeseriesprophetModel) -> TimeseriesprophetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_model_copy(s : TimeseriesprophetModel) -> TimeseriesprophetModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_model_fill(s : TimeseriesprophetModel, v : Double) -> TimeseriesprophetModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_model_min(s : TimeseriesprophetModel) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_model_max(s : TimeseriesprophetModel) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_model_to_string(s : TimeseriesprophetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_layer_make(size : Int) -> TimeseriesprophetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_layer_len(s : TimeseriesprophetLayer) -> Int { s.size }

pub fn timeseries_prophet_layer_get(s : TimeseriesprophetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_layer_set(s : TimeseriesprophetLayer, i : Int, v : Double) -> TimeseriesprophetLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_layer_sum(s : TimeseriesprophetLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_layer_mean(s : TimeseriesprophetLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_layer_scale(s : TimeseriesprophetLayer, f : Double) -> TimeseriesprophetLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_layer_add(a : TimeseriesprophetLayer, b : TimeseriesprophetLayer) -> TimeseriesprophetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_layer_copy(s : TimeseriesprophetLayer) -> TimeseriesprophetLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_layer_fill(s : TimeseriesprophetLayer, v : Double) -> TimeseriesprophetLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_layer_min(s : TimeseriesprophetLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_layer_max(s : TimeseriesprophetLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_layer_to_string(s : TimeseriesprophetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_buffer_make(size : Int) -> TimeseriesprophetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_buffer_len(s : TimeseriesprophetBuffer) -> Int { s.size }

pub fn timeseries_prophet_buffer_get(s : TimeseriesprophetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_buffer_set(s : TimeseriesprophetBuffer, i : Int, v : Double) -> TimeseriesprophetBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_buffer_sum(s : TimeseriesprophetBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_buffer_mean(s : TimeseriesprophetBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_buffer_scale(s : TimeseriesprophetBuffer, f : Double) -> TimeseriesprophetBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_buffer_add(a : TimeseriesprophetBuffer, b : TimeseriesprophetBuffer) -> TimeseriesprophetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_buffer_copy(s : TimeseriesprophetBuffer) -> TimeseriesprophetBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_buffer_fill(s : TimeseriesprophetBuffer, v : Double) -> TimeseriesprophetBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_buffer_min(s : TimeseriesprophetBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_buffer_max(s : TimeseriesprophetBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_buffer_to_string(s : TimeseriesprophetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_cursor_make(size : Int) -> TimeseriesprophetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_cursor_len(s : TimeseriesprophetCursor) -> Int { s.size }

pub fn timeseries_prophet_cursor_get(s : TimeseriesprophetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_cursor_set(s : TimeseriesprophetCursor, i : Int, v : Double) -> TimeseriesprophetCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cursor_sum(s : TimeseriesprophetCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_cursor_mean(s : TimeseriesprophetCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_cursor_scale(s : TimeseriesprophetCursor, f : Double) -> TimeseriesprophetCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cursor_add(a : TimeseriesprophetCursor, b : TimeseriesprophetCursor) -> TimeseriesprophetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_cursor_copy(s : TimeseriesprophetCursor) -> TimeseriesprophetCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cursor_fill(s : TimeseriesprophetCursor, v : Double) -> TimeseriesprophetCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_cursor_min(s : TimeseriesprophetCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_cursor_max(s : TimeseriesprophetCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_cursor_to_string(s : TimeseriesprophetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_view_make(size : Int) -> TimeseriesprophetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_view_len(s : TimeseriesprophetView) -> Int { s.size }

pub fn timeseries_prophet_view_get(s : TimeseriesprophetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_view_set(s : TimeseriesprophetView, i : Int, v : Double) -> TimeseriesprophetView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_view_sum(s : TimeseriesprophetView) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_view_mean(s : TimeseriesprophetView) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_view_scale(s : TimeseriesprophetView, f : Double) -> TimeseriesprophetView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_view_add(a : TimeseriesprophetView, b : TimeseriesprophetView) -> TimeseriesprophetView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_view_copy(s : TimeseriesprophetView) -> TimeseriesprophetView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_view_fill(s : TimeseriesprophetView, v : Double) -> TimeseriesprophetView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_view_min(s : TimeseriesprophetView) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_view_max(s : TimeseriesprophetView) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_view_to_string(s : TimeseriesprophetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_range_make(size : Int) -> TimeseriesprophetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_range_len(s : TimeseriesprophetRange) -> Int { s.size }

pub fn timeseries_prophet_range_get(s : TimeseriesprophetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_range_set(s : TimeseriesprophetRange, i : Int, v : Double) -> TimeseriesprophetRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_range_sum(s : TimeseriesprophetRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_range_mean(s : TimeseriesprophetRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_range_scale(s : TimeseriesprophetRange, f : Double) -> TimeseriesprophetRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_range_add(a : TimeseriesprophetRange, b : TimeseriesprophetRange) -> TimeseriesprophetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_range_copy(s : TimeseriesprophetRange) -> TimeseriesprophetRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_range_fill(s : TimeseriesprophetRange, v : Double) -> TimeseriesprophetRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_range_min(s : TimeseriesprophetRange) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_range_max(s : TimeseriesprophetRange) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_range_to_string(s : TimeseriesprophetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_slice_make(size : Int) -> TimeseriesprophetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_prophet_slice_len(s : TimeseriesprophetSlice) -> Int { s.size }

pub fn timeseries_prophet_slice_get(s : TimeseriesprophetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_prophet_slice_set(s : TimeseriesprophetSlice, i : Int, v : Double) -> TimeseriesprophetSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_slice_sum(s : TimeseriesprophetSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_prophet_slice_mean(s : TimeseriesprophetSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_prophet_slice_scale(s : TimeseriesprophetSlice, f : Double) -> TimeseriesprophetSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_slice_add(a : TimeseriesprophetSlice, b : TimeseriesprophetSlice) -> TimeseriesprophetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_prophet_slice_copy(s : TimeseriesprophetSlice) -> TimeseriesprophetSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_slice_fill(s : TimeseriesprophetSlice, v : Double) -> TimeseriesprophetSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_prophet_slice_min(s : TimeseriesprophetSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_prophet_slice_max(s : TimeseriesprophetSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_prophet_slice_to_string(s : TimeseriesprophetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

