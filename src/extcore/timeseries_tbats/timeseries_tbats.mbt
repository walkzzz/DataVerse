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

pub fn TimeseriestbatsFrame::len(self : TimeseriestbatsFrame) -> Int { self.size }

pub fn TimeseriestbatsFrame::get(self : TimeseriestbatsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsFrame::set(self : TimeseriestbatsFrame, i : Int, v : Double) -> TimeseriestbatsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsFrame::sum(self : TimeseriestbatsFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsFrame::mean(self : TimeseriestbatsFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsFrame::scale(self : TimeseriestbatsFrame, f : Double) -> TimeseriestbatsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsFrame::add(self : TimeseriestbatsFrame, other : TimeseriestbatsFrame) -> TimeseriestbatsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsFrame::copy(self : TimeseriestbatsFrame) -> TimeseriestbatsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsFrame::fill(self : TimeseriestbatsFrame, v : Double) -> TimeseriestbatsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsFrame::min(self : TimeseriestbatsFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsFrame::max(self : TimeseriestbatsFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsFrame::to_string(self : TimeseriestbatsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_table_make(size : Int) -> TimeseriestbatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsTable::len(self : TimeseriestbatsTable) -> Int { self.size }

pub fn TimeseriestbatsTable::get(self : TimeseriestbatsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsTable::set(self : TimeseriestbatsTable, i : Int, v : Double) -> TimeseriestbatsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsTable::sum(self : TimeseriestbatsTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsTable::mean(self : TimeseriestbatsTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsTable::scale(self : TimeseriestbatsTable, f : Double) -> TimeseriestbatsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsTable::add(self : TimeseriestbatsTable, other : TimeseriestbatsTable) -> TimeseriestbatsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsTable::copy(self : TimeseriestbatsTable) -> TimeseriestbatsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsTable::fill(self : TimeseriestbatsTable, v : Double) -> TimeseriestbatsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsTable::min(self : TimeseriestbatsTable) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsTable::max(self : TimeseriestbatsTable) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsTable::to_string(self : TimeseriestbatsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_graphn_make(size : Int) -> TimeseriestbatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsGraphN::len(self : TimeseriestbatsGraphN) -> Int { self.size }

pub fn TimeseriestbatsGraphN::get(self : TimeseriestbatsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsGraphN::set(self : TimeseriestbatsGraphN, i : Int, v : Double) -> TimeseriestbatsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsGraphN::sum(self : TimeseriestbatsGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsGraphN::mean(self : TimeseriestbatsGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsGraphN::scale(self : TimeseriestbatsGraphN, f : Double) -> TimeseriestbatsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsGraphN::add(self : TimeseriestbatsGraphN, other : TimeseriestbatsGraphN) -> TimeseriestbatsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsGraphN::copy(self : TimeseriestbatsGraphN) -> TimeseriestbatsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsGraphN::fill(self : TimeseriestbatsGraphN, v : Double) -> TimeseriestbatsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsGraphN::min(self : TimeseriestbatsGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsGraphN::max(self : TimeseriestbatsGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsGraphN::to_string(self : TimeseriestbatsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_node_make(size : Int) -> TimeseriestbatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsNode::len(self : TimeseriestbatsNode) -> Int { self.size }

pub fn TimeseriestbatsNode::get(self : TimeseriestbatsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsNode::set(self : TimeseriestbatsNode, i : Int, v : Double) -> TimeseriestbatsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsNode::sum(self : TimeseriestbatsNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsNode::mean(self : TimeseriestbatsNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsNode::scale(self : TimeseriestbatsNode, f : Double) -> TimeseriestbatsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsNode::add(self : TimeseriestbatsNode, other : TimeseriestbatsNode) -> TimeseriestbatsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsNode::copy(self : TimeseriestbatsNode) -> TimeseriestbatsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsNode::fill(self : TimeseriestbatsNode, v : Double) -> TimeseriestbatsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsNode::min(self : TimeseriestbatsNode) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsNode::max(self : TimeseriestbatsNode) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsNode::to_string(self : TimeseriestbatsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_edge_make(size : Int) -> TimeseriestbatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsEdge::len(self : TimeseriestbatsEdge) -> Int { self.size }

pub fn TimeseriestbatsEdge::get(self : TimeseriestbatsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsEdge::set(self : TimeseriestbatsEdge, i : Int, v : Double) -> TimeseriestbatsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsEdge::sum(self : TimeseriestbatsEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsEdge::mean(self : TimeseriestbatsEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsEdge::scale(self : TimeseriestbatsEdge, f : Double) -> TimeseriestbatsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsEdge::add(self : TimeseriestbatsEdge, other : TimeseriestbatsEdge) -> TimeseriestbatsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsEdge::copy(self : TimeseriestbatsEdge) -> TimeseriestbatsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsEdge::fill(self : TimeseriestbatsEdge, v : Double) -> TimeseriestbatsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsEdge::min(self : TimeseriestbatsEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsEdge::max(self : TimeseriestbatsEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsEdge::to_string(self : TimeseriestbatsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_path_make(size : Int) -> TimeseriestbatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsPath::len(self : TimeseriestbatsPath) -> Int { self.size }

pub fn TimeseriestbatsPath::get(self : TimeseriestbatsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsPath::set(self : TimeseriestbatsPath, i : Int, v : Double) -> TimeseriestbatsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsPath::sum(self : TimeseriestbatsPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsPath::mean(self : TimeseriestbatsPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsPath::scale(self : TimeseriestbatsPath, f : Double) -> TimeseriestbatsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsPath::add(self : TimeseriestbatsPath, other : TimeseriestbatsPath) -> TimeseriestbatsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsPath::copy(self : TimeseriestbatsPath) -> TimeseriestbatsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsPath::fill(self : TimeseriestbatsPath, v : Double) -> TimeseriestbatsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsPath::min(self : TimeseriestbatsPath) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsPath::max(self : TimeseriestbatsPath) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsPath::to_string(self : TimeseriestbatsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_cluster_make(size : Int) -> TimeseriestbatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsCluster::len(self : TimeseriestbatsCluster) -> Int { self.size }

pub fn TimeseriestbatsCluster::get(self : TimeseriestbatsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsCluster::set(self : TimeseriestbatsCluster, i : Int, v : Double) -> TimeseriestbatsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCluster::sum(self : TimeseriestbatsCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsCluster::mean(self : TimeseriestbatsCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsCluster::scale(self : TimeseriestbatsCluster, f : Double) -> TimeseriestbatsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCluster::add(self : TimeseriestbatsCluster, other : TimeseriestbatsCluster) -> TimeseriestbatsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsCluster::copy(self : TimeseriestbatsCluster) -> TimeseriestbatsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCluster::fill(self : TimeseriestbatsCluster, v : Double) -> TimeseriestbatsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCluster::min(self : TimeseriestbatsCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsCluster::max(self : TimeseriestbatsCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsCluster::to_string(self : TimeseriestbatsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_model_make(size : Int) -> TimeseriestbatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsModel::len(self : TimeseriestbatsModel) -> Int { self.size }

pub fn TimeseriestbatsModel::get(self : TimeseriestbatsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsModel::set(self : TimeseriestbatsModel, i : Int, v : Double) -> TimeseriestbatsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsModel::sum(self : TimeseriestbatsModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsModel::mean(self : TimeseriestbatsModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsModel::scale(self : TimeseriestbatsModel, f : Double) -> TimeseriestbatsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsModel::add(self : TimeseriestbatsModel, other : TimeseriestbatsModel) -> TimeseriestbatsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsModel::copy(self : TimeseriestbatsModel) -> TimeseriestbatsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsModel::fill(self : TimeseriestbatsModel, v : Double) -> TimeseriestbatsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsModel::min(self : TimeseriestbatsModel) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsModel::max(self : TimeseriestbatsModel) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsModel::to_string(self : TimeseriestbatsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_layer_make(size : Int) -> TimeseriestbatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsLayer::len(self : TimeseriestbatsLayer) -> Int { self.size }

pub fn TimeseriestbatsLayer::get(self : TimeseriestbatsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsLayer::set(self : TimeseriestbatsLayer, i : Int, v : Double) -> TimeseriestbatsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsLayer::sum(self : TimeseriestbatsLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsLayer::mean(self : TimeseriestbatsLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsLayer::scale(self : TimeseriestbatsLayer, f : Double) -> TimeseriestbatsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsLayer::add(self : TimeseriestbatsLayer, other : TimeseriestbatsLayer) -> TimeseriestbatsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsLayer::copy(self : TimeseriestbatsLayer) -> TimeseriestbatsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsLayer::fill(self : TimeseriestbatsLayer, v : Double) -> TimeseriestbatsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsLayer::min(self : TimeseriestbatsLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsLayer::max(self : TimeseriestbatsLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsLayer::to_string(self : TimeseriestbatsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_buffer_make(size : Int) -> TimeseriestbatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsBuffer::len(self : TimeseriestbatsBuffer) -> Int { self.size }

pub fn TimeseriestbatsBuffer::get(self : TimeseriestbatsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsBuffer::set(self : TimeseriestbatsBuffer, i : Int, v : Double) -> TimeseriestbatsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsBuffer::sum(self : TimeseriestbatsBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsBuffer::mean(self : TimeseriestbatsBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsBuffer::scale(self : TimeseriestbatsBuffer, f : Double) -> TimeseriestbatsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsBuffer::add(self : TimeseriestbatsBuffer, other : TimeseriestbatsBuffer) -> TimeseriestbatsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsBuffer::copy(self : TimeseriestbatsBuffer) -> TimeseriestbatsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsBuffer::fill(self : TimeseriestbatsBuffer, v : Double) -> TimeseriestbatsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsBuffer::min(self : TimeseriestbatsBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsBuffer::max(self : TimeseriestbatsBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsBuffer::to_string(self : TimeseriestbatsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_cursor_make(size : Int) -> TimeseriestbatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsCursor::len(self : TimeseriestbatsCursor) -> Int { self.size }

pub fn TimeseriestbatsCursor::get(self : TimeseriestbatsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsCursor::set(self : TimeseriestbatsCursor, i : Int, v : Double) -> TimeseriestbatsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCursor::sum(self : TimeseriestbatsCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsCursor::mean(self : TimeseriestbatsCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsCursor::scale(self : TimeseriestbatsCursor, f : Double) -> TimeseriestbatsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCursor::add(self : TimeseriestbatsCursor, other : TimeseriestbatsCursor) -> TimeseriestbatsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsCursor::copy(self : TimeseriestbatsCursor) -> TimeseriestbatsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCursor::fill(self : TimeseriestbatsCursor, v : Double) -> TimeseriestbatsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsCursor::min(self : TimeseriestbatsCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsCursor::max(self : TimeseriestbatsCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsCursor::to_string(self : TimeseriestbatsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_view_make(size : Int) -> TimeseriestbatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsView::len(self : TimeseriestbatsView) -> Int { self.size }

pub fn TimeseriestbatsView::get(self : TimeseriestbatsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsView::set(self : TimeseriestbatsView, i : Int, v : Double) -> TimeseriestbatsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsView::sum(self : TimeseriestbatsView) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsView::mean(self : TimeseriestbatsView) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsView::scale(self : TimeseriestbatsView, f : Double) -> TimeseriestbatsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsView::add(self : TimeseriestbatsView, other : TimeseriestbatsView) -> TimeseriestbatsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsView::copy(self : TimeseriestbatsView) -> TimeseriestbatsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsView::fill(self : TimeseriestbatsView, v : Double) -> TimeseriestbatsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsView::min(self : TimeseriestbatsView) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsView::max(self : TimeseriestbatsView) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsView::to_string(self : TimeseriestbatsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_range_make(size : Int) -> TimeseriestbatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsRange::len(self : TimeseriestbatsRange) -> Int { self.size }

pub fn TimeseriestbatsRange::get(self : TimeseriestbatsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsRange::set(self : TimeseriestbatsRange, i : Int, v : Double) -> TimeseriestbatsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsRange::sum(self : TimeseriestbatsRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsRange::mean(self : TimeseriestbatsRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsRange::scale(self : TimeseriestbatsRange, f : Double) -> TimeseriestbatsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsRange::add(self : TimeseriestbatsRange, other : TimeseriestbatsRange) -> TimeseriestbatsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsRange::copy(self : TimeseriestbatsRange) -> TimeseriestbatsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsRange::fill(self : TimeseriestbatsRange, v : Double) -> TimeseriestbatsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsRange::min(self : TimeseriestbatsRange) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsRange::max(self : TimeseriestbatsRange) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsRange::to_string(self : TimeseriestbatsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriestbatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_tbats_slice_make(size : Int) -> TimeseriestbatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriestbatsSlice::len(self : TimeseriestbatsSlice) -> Int { self.size }

pub fn TimeseriestbatsSlice::get(self : TimeseriestbatsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriestbatsSlice::set(self : TimeseriestbatsSlice, i : Int, v : Double) -> TimeseriestbatsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsSlice::sum(self : TimeseriestbatsSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriestbatsSlice::mean(self : TimeseriestbatsSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriestbatsSlice::scale(self : TimeseriestbatsSlice, f : Double) -> TimeseriestbatsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsSlice::add(self : TimeseriestbatsSlice, other : TimeseriestbatsSlice) -> TimeseriestbatsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriestbatsSlice::copy(self : TimeseriestbatsSlice) -> TimeseriestbatsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsSlice::fill(self : TimeseriestbatsSlice, v : Double) -> TimeseriestbatsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriestbatsSlice::min(self : TimeseriestbatsSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriestbatsSlice::max(self : TimeseriestbatsSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriestbatsSlice::to_string(self : TimeseriestbatsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

