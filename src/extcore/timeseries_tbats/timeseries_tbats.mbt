///===
/// extcore/timeseries_tbats

pub(all) struct TimeseriestbatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_tbats_make_point(x : Double, y : Double) -> TimeseriestbatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_tbats_make_point3(x : Double, y : Double, z : Double) -> TimeseriestbatsPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriestbatsPoint::x(self : TimeseriestbatsPoint) -> Double { self.x }

pub fn TimeseriestbatsPoint::y(self : TimeseriestbatsPoint) -> Double { self.y }

pub fn TimeseriestbatsPoint::z(self : TimeseriestbatsPoint) -> Double { self.z }

pub fn TimeseriestbatsPoint::label(self : TimeseriestbatsPoint) -> Int { self.label }

pub fn TimeseriestbatsPoint::dist(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriestbatsPoint::add(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriestbatsPoint::sub(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriestbatsPoint::scale(self : TimeseriestbatsPoint, s : Double) -> TimeseriestbatsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriestbatsPoint::dot(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriestbatsPoint::cross(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriestbatsPoint::norm(self : TimeseriestbatsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriestbatsPoint::normalize(self : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriestbatsPoint::negate(self : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriestbatsPoint::mid(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint) -> TimeseriestbatsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriestbatsPoint::lerp(self : TimeseriestbatsPoint, other : TimeseriestbatsPoint, t : Double) -> TimeseriestbatsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriestbatsPoint::to_string(self : TimeseriestbatsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriestbatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_tbats_make_series(vals : Array[Double], name : String) -> TimeseriestbatsSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriestbatsSeries::len(self : TimeseriestbatsSeries) -> Int { self.vals.length() }

pub fn TimeseriestbatsSeries::sum(self : TimeseriestbatsSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriestbatsSeries::mean(self : TimeseriestbatsSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriestbatsSeries::min(self : TimeseriestbatsSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriestbatsSeries::max(self : TimeseriestbatsSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriestbatsSeries::range(self : TimeseriestbatsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriestbatsSeries::variance(self : TimeseriestbatsSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriestbatsSeries::std(self : TimeseriestbatsSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriestbatsSeries::median(self : TimeseriestbatsSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriestbatsSeries::scale(self : TimeseriestbatsSeries, f : Double) -> TimeseriestbatsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriestbatsSeries::add(self : TimeseriestbatsSeries, other : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriestbatsSeries::sub(self : TimeseriestbatsSeries, other : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriestbatsSeries::normalize(self : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriestbatsSeries::cumsum(self : TimeseriestbatsSeries) -> TimeseriestbatsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriestbatsSeries::to_string(self : TimeseriestbatsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriestbatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_tbats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriestbatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_tbats_matrix_identity(n : Int) -> TimeseriestbatsMatrix {
  let m = timeseries_tbats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriestbatsMatrix::get(self : TimeseriestbatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriestbatsMatrix::transpose(self : TimeseriestbatsMatrix) -> TimeseriestbatsMatrix {
  let result = timeseries_tbats_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriestbatsMatrix::add(self : TimeseriestbatsMatrix, other : TimeseriestbatsMatrix) -> TimeseriestbatsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_tbats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriestbatsMatrix::scale(self : TimeseriestbatsMatrix, s : Double) -> TimeseriestbatsMatrix {
  let result = timeseries_tbats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriestbatsMatrix::multiply(self : TimeseriestbatsMatrix, other : TimeseriestbatsMatrix) -> TimeseriestbatsMatrix {
  if self.cols != other.rows { return timeseries_tbats_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_tbats_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriestbatsMatrix::trace(self : TimeseriestbatsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriestbatsMatrix::det(self : TimeseriestbatsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriestbatsMatrix::norm(self : TimeseriestbatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriestbatsMatrix::to_string(self : TimeseriestbatsMatrix) -> String {
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

pub(all) struct TimeseriestbatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_tbats_make_vector(comps : Array[Double]) -> TimeseriestbatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_tbats_vector_zero(dim : Int) -> TimeseriestbatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriestbatsVector::add(self : TimeseriestbatsVector, other : TimeseriestbatsVector) -> TimeseriestbatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriestbatsVector::sub(self : TimeseriestbatsVector, other : TimeseriestbatsVector) -> TimeseriestbatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriestbatsVector::scale(self : TimeseriestbatsVector, s : Double) -> TimeseriestbatsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriestbatsVector::dot(self : TimeseriestbatsVector, other : TimeseriestbatsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriestbatsVector::norm(self : TimeseriestbatsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriestbatsVector::normalize(self : TimeseriestbatsVector) -> TimeseriestbatsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriestbatsVector::dist(self : TimeseriestbatsVector, other : TimeseriestbatsVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriestbatsVector::to_string(self : TimeseriestbatsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_tbats_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_tbats_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_tbats_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_tbats_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_tbats_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_tbats_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_tbats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_tbats_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_tbats_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_tbats_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_tbats_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_tbats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_tbats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_tbats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_tbats_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_tbats_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_tbats_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_tbats_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_tbats_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_tbats_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_tbats_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_tbats_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_tbats_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_tbats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_tbats_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_tbats_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_tbats_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_tbats_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_tbats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriestbatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_frame_make(size : Int) -> TimeseriestbatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_frame_len(s : TimeseriestbatsFrame) -> Int { s.size }

pub fn timeseries_tbats_frame_get(s : TimeseriestbatsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_frame_set(s : TimeseriestbatsFrame, i : Int, v : Double) -> TimeseriestbatsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_frame_sum(s : TimeseriestbatsFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_frame_mean(s : TimeseriestbatsFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_frame_scale(s : TimeseriestbatsFrame, f : Double) -> TimeseriestbatsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_frame_add(a : TimeseriestbatsFrame, b : TimeseriestbatsFrame) -> TimeseriestbatsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_frame_copy(s : TimeseriestbatsFrame) -> TimeseriestbatsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_frame_fill(s : TimeseriestbatsFrame, v : Double) -> TimeseriestbatsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_frame_min(s : TimeseriestbatsFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_frame_max(s : TimeseriestbatsFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_frame_to_string(s : TimeseriestbatsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_table_make(size : Int) -> TimeseriestbatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_table_len(s : TimeseriestbatsTable) -> Int { s.size }

pub fn timeseries_tbats_table_get(s : TimeseriestbatsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_table_set(s : TimeseriestbatsTable, i : Int, v : Double) -> TimeseriestbatsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_table_sum(s : TimeseriestbatsTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_table_mean(s : TimeseriestbatsTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_table_scale(s : TimeseriestbatsTable, f : Double) -> TimeseriestbatsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_table_add(a : TimeseriestbatsTable, b : TimeseriestbatsTable) -> TimeseriestbatsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_table_copy(s : TimeseriestbatsTable) -> TimeseriestbatsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_table_fill(s : TimeseriestbatsTable, v : Double) -> TimeseriestbatsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_table_min(s : TimeseriestbatsTable) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_table_max(s : TimeseriestbatsTable) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_table_to_string(s : TimeseriestbatsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_graphn_make(size : Int) -> TimeseriestbatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_graphn_len(s : TimeseriestbatsGraphN) -> Int { s.size }

pub fn timeseries_tbats_graphn_get(s : TimeseriestbatsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_graphn_set(s : TimeseriestbatsGraphN, i : Int, v : Double) -> TimeseriestbatsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_graphn_sum(s : TimeseriestbatsGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_graphn_mean(s : TimeseriestbatsGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_graphn_scale(s : TimeseriestbatsGraphN, f : Double) -> TimeseriestbatsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_graphn_add(a : TimeseriestbatsGraphN, b : TimeseriestbatsGraphN) -> TimeseriestbatsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_graphn_copy(s : TimeseriestbatsGraphN) -> TimeseriestbatsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_graphn_fill(s : TimeseriestbatsGraphN, v : Double) -> TimeseriestbatsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_graphn_min(s : TimeseriestbatsGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_graphn_max(s : TimeseriestbatsGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_graphn_to_string(s : TimeseriestbatsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_node_make(size : Int) -> TimeseriestbatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_node_len(s : TimeseriestbatsNode) -> Int { s.size }

pub fn timeseries_tbats_node_get(s : TimeseriestbatsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_node_set(s : TimeseriestbatsNode, i : Int, v : Double) -> TimeseriestbatsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_node_sum(s : TimeseriestbatsNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_node_mean(s : TimeseriestbatsNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_node_scale(s : TimeseriestbatsNode, f : Double) -> TimeseriestbatsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_node_add(a : TimeseriestbatsNode, b : TimeseriestbatsNode) -> TimeseriestbatsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_node_copy(s : TimeseriestbatsNode) -> TimeseriestbatsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_node_fill(s : TimeseriestbatsNode, v : Double) -> TimeseriestbatsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_node_min(s : TimeseriestbatsNode) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_node_max(s : TimeseriestbatsNode) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_node_to_string(s : TimeseriestbatsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_edge_make(size : Int) -> TimeseriestbatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_edge_len(s : TimeseriestbatsEdge) -> Int { s.size }

pub fn timeseries_tbats_edge_get(s : TimeseriestbatsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_edge_set(s : TimeseriestbatsEdge, i : Int, v : Double) -> TimeseriestbatsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_edge_sum(s : TimeseriestbatsEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_edge_mean(s : TimeseriestbatsEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_edge_scale(s : TimeseriestbatsEdge, f : Double) -> TimeseriestbatsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_edge_add(a : TimeseriestbatsEdge, b : TimeseriestbatsEdge) -> TimeseriestbatsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_edge_copy(s : TimeseriestbatsEdge) -> TimeseriestbatsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_edge_fill(s : TimeseriestbatsEdge, v : Double) -> TimeseriestbatsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_edge_min(s : TimeseriestbatsEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_edge_max(s : TimeseriestbatsEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_edge_to_string(s : TimeseriestbatsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_path_make(size : Int) -> TimeseriestbatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_path_len(s : TimeseriestbatsPath) -> Int { s.size }

pub fn timeseries_tbats_path_get(s : TimeseriestbatsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_path_set(s : TimeseriestbatsPath, i : Int, v : Double) -> TimeseriestbatsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_path_sum(s : TimeseriestbatsPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_path_mean(s : TimeseriestbatsPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_path_scale(s : TimeseriestbatsPath, f : Double) -> TimeseriestbatsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_path_add(a : TimeseriestbatsPath, b : TimeseriestbatsPath) -> TimeseriestbatsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_path_copy(s : TimeseriestbatsPath) -> TimeseriestbatsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_path_fill(s : TimeseriestbatsPath, v : Double) -> TimeseriestbatsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_path_min(s : TimeseriestbatsPath) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_path_max(s : TimeseriestbatsPath) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_path_to_string(s : TimeseriestbatsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_cluster_make(size : Int) -> TimeseriestbatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_cluster_len(s : TimeseriestbatsCluster) -> Int { s.size }

pub fn timeseries_tbats_cluster_get(s : TimeseriestbatsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_cluster_set(s : TimeseriestbatsCluster, i : Int, v : Double) -> TimeseriestbatsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cluster_sum(s : TimeseriestbatsCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_cluster_mean(s : TimeseriestbatsCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_cluster_scale(s : TimeseriestbatsCluster, f : Double) -> TimeseriestbatsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cluster_add(a : TimeseriestbatsCluster, b : TimeseriestbatsCluster) -> TimeseriestbatsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_cluster_copy(s : TimeseriestbatsCluster) -> TimeseriestbatsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cluster_fill(s : TimeseriestbatsCluster, v : Double) -> TimeseriestbatsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cluster_min(s : TimeseriestbatsCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_cluster_max(s : TimeseriestbatsCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_cluster_to_string(s : TimeseriestbatsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_model_make(size : Int) -> TimeseriestbatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_model_len(s : TimeseriestbatsModel) -> Int { s.size }

pub fn timeseries_tbats_model_get(s : TimeseriestbatsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_model_set(s : TimeseriestbatsModel, i : Int, v : Double) -> TimeseriestbatsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_model_sum(s : TimeseriestbatsModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_model_mean(s : TimeseriestbatsModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_model_scale(s : TimeseriestbatsModel, f : Double) -> TimeseriestbatsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_model_add(a : TimeseriestbatsModel, b : TimeseriestbatsModel) -> TimeseriestbatsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_model_copy(s : TimeseriestbatsModel) -> TimeseriestbatsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_model_fill(s : TimeseriestbatsModel, v : Double) -> TimeseriestbatsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_model_min(s : TimeseriestbatsModel) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_model_max(s : TimeseriestbatsModel) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_model_to_string(s : TimeseriestbatsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_layer_make(size : Int) -> TimeseriestbatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_layer_len(s : TimeseriestbatsLayer) -> Int { s.size }

pub fn timeseries_tbats_layer_get(s : TimeseriestbatsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_layer_set(s : TimeseriestbatsLayer, i : Int, v : Double) -> TimeseriestbatsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_layer_sum(s : TimeseriestbatsLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_layer_mean(s : TimeseriestbatsLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_layer_scale(s : TimeseriestbatsLayer, f : Double) -> TimeseriestbatsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_layer_add(a : TimeseriestbatsLayer, b : TimeseriestbatsLayer) -> TimeseriestbatsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_layer_copy(s : TimeseriestbatsLayer) -> TimeseriestbatsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_layer_fill(s : TimeseriestbatsLayer, v : Double) -> TimeseriestbatsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_layer_min(s : TimeseriestbatsLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_layer_max(s : TimeseriestbatsLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_layer_to_string(s : TimeseriestbatsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_buffer_make(size : Int) -> TimeseriestbatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_buffer_len(s : TimeseriestbatsBuffer) -> Int { s.size }

pub fn timeseries_tbats_buffer_get(s : TimeseriestbatsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_buffer_set(s : TimeseriestbatsBuffer, i : Int, v : Double) -> TimeseriestbatsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_buffer_sum(s : TimeseriestbatsBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_buffer_mean(s : TimeseriestbatsBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_buffer_scale(s : TimeseriestbatsBuffer, f : Double) -> TimeseriestbatsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_buffer_add(a : TimeseriestbatsBuffer, b : TimeseriestbatsBuffer) -> TimeseriestbatsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_buffer_copy(s : TimeseriestbatsBuffer) -> TimeseriestbatsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_buffer_fill(s : TimeseriestbatsBuffer, v : Double) -> TimeseriestbatsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_buffer_min(s : TimeseriestbatsBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_buffer_max(s : TimeseriestbatsBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_buffer_to_string(s : TimeseriestbatsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_cursor_make(size : Int) -> TimeseriestbatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_cursor_len(s : TimeseriestbatsCursor) -> Int { s.size }

pub fn timeseries_tbats_cursor_get(s : TimeseriestbatsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_cursor_set(s : TimeseriestbatsCursor, i : Int, v : Double) -> TimeseriestbatsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cursor_sum(s : TimeseriestbatsCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_cursor_mean(s : TimeseriestbatsCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_cursor_scale(s : TimeseriestbatsCursor, f : Double) -> TimeseriestbatsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cursor_add(a : TimeseriestbatsCursor, b : TimeseriestbatsCursor) -> TimeseriestbatsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_cursor_copy(s : TimeseriestbatsCursor) -> TimeseriestbatsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cursor_fill(s : TimeseriestbatsCursor, v : Double) -> TimeseriestbatsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_cursor_min(s : TimeseriestbatsCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_cursor_max(s : TimeseriestbatsCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_cursor_to_string(s : TimeseriestbatsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_view_make(size : Int) -> TimeseriestbatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_view_len(s : TimeseriestbatsView) -> Int { s.size }

pub fn timeseries_tbats_view_get(s : TimeseriestbatsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_view_set(s : TimeseriestbatsView, i : Int, v : Double) -> TimeseriestbatsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_view_sum(s : TimeseriestbatsView) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_view_mean(s : TimeseriestbatsView) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_view_scale(s : TimeseriestbatsView, f : Double) -> TimeseriestbatsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_view_add(a : TimeseriestbatsView, b : TimeseriestbatsView) -> TimeseriestbatsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_view_copy(s : TimeseriestbatsView) -> TimeseriestbatsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_view_fill(s : TimeseriestbatsView, v : Double) -> TimeseriestbatsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_view_min(s : TimeseriestbatsView) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_view_max(s : TimeseriestbatsView) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_view_to_string(s : TimeseriestbatsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_range_make(size : Int) -> TimeseriestbatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_range_len(s : TimeseriestbatsRange) -> Int { s.size }

pub fn timeseries_tbats_range_get(s : TimeseriestbatsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_range_set(s : TimeseriestbatsRange, i : Int, v : Double) -> TimeseriestbatsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_range_sum(s : TimeseriestbatsRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_range_mean(s : TimeseriestbatsRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_range_scale(s : TimeseriestbatsRange, f : Double) -> TimeseriestbatsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_range_add(a : TimeseriestbatsRange, b : TimeseriestbatsRange) -> TimeseriestbatsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_range_copy(s : TimeseriestbatsRange) -> TimeseriestbatsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_range_fill(s : TimeseriestbatsRange, v : Double) -> TimeseriestbatsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_range_min(s : TimeseriestbatsRange) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_range_max(s : TimeseriestbatsRange) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_range_to_string(s : TimeseriestbatsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_slice_make(size : Int) -> TimeseriestbatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_tbats_slice_len(s : TimeseriestbatsSlice) -> Int { s.size }

pub fn timeseries_tbats_slice_get(s : TimeseriestbatsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_tbats_slice_set(s : TimeseriestbatsSlice, i : Int, v : Double) -> TimeseriestbatsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_slice_sum(s : TimeseriestbatsSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_tbats_slice_mean(s : TimeseriestbatsSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_tbats_slice_scale(s : TimeseriestbatsSlice, f : Double) -> TimeseriestbatsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_slice_add(a : TimeseriestbatsSlice, b : TimeseriestbatsSlice) -> TimeseriestbatsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_tbats_slice_copy(s : TimeseriestbatsSlice) -> TimeseriestbatsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_slice_fill(s : TimeseriestbatsSlice, v : Double) -> TimeseriestbatsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_tbats_slice_min(s : TimeseriestbatsSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_tbats_slice_max(s : TimeseriestbatsSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_tbats_slice_to_string(s : TimeseriestbatsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

