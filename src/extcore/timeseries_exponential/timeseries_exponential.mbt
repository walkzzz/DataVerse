///===
/// extcore/timeseries_exponential

pub(all) struct TimeseriesexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_exponential_make_point(x : Double, y : Double) -> TimeseriesexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_exponential_make_point3(x : Double, y : Double, z : Double) -> TimeseriesexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesexponentialPoint::x(self : TimeseriesexponentialPoint) -> Double { self.x }

pub fn TimeseriesexponentialPoint::y(self : TimeseriesexponentialPoint) -> Double { self.y }

pub fn TimeseriesexponentialPoint::z(self : TimeseriesexponentialPoint) -> Double { self.z }

pub fn TimeseriesexponentialPoint::label(self : TimeseriesexponentialPoint) -> Int { self.label }

pub fn TimeseriesexponentialPoint::dist(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesexponentialPoint::add(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesexponentialPoint::sub(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesexponentialPoint::scale(self : TimeseriesexponentialPoint, s : Double) -> TimeseriesexponentialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesexponentialPoint::dot(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesexponentialPoint::cross(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesexponentialPoint::norm(self : TimeseriesexponentialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesexponentialPoint::normalize(self : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesexponentialPoint::negate(self : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesexponentialPoint::mid(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesexponentialPoint::lerp(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint, t : Double) -> TimeseriesexponentialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesexponentialPoint::to_string(self : TimeseriesexponentialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_exponential_make_series(vals : Array[Double], name : String) -> TimeseriesexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesexponentialSeries::len(self : TimeseriesexponentialSeries) -> Int { self.vals.length() }

pub fn TimeseriesexponentialSeries::sum(self : TimeseriesexponentialSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesexponentialSeries::mean(self : TimeseriesexponentialSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesexponentialSeries::min(self : TimeseriesexponentialSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesexponentialSeries::max(self : TimeseriesexponentialSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesexponentialSeries::range(self : TimeseriesexponentialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesexponentialSeries::variance(self : TimeseriesexponentialSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesexponentialSeries::std(self : TimeseriesexponentialSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesexponentialSeries::median(self : TimeseriesexponentialSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesexponentialSeries::scale(self : TimeseriesexponentialSeries, f : Double) -> TimeseriesexponentialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesexponentialSeries::add(self : TimeseriesexponentialSeries, other : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesexponentialSeries::sub(self : TimeseriesexponentialSeries, other : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesexponentialSeries::normalize(self : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesexponentialSeries::cumsum(self : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesexponentialSeries::to_string(self : TimeseriesexponentialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_exponential_matrix_identity(n : Int) -> TimeseriesexponentialMatrix {
  let m = timeseries_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesexponentialMatrix::get(self : TimeseriesexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesexponentialMatrix::transpose(self : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  let result = timeseries_exponential_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesexponentialMatrix::add(self : TimeseriesexponentialMatrix, other : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesexponentialMatrix::scale(self : TimeseriesexponentialMatrix, s : Double) -> TimeseriesexponentialMatrix {
  let result = timeseries_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesexponentialMatrix::multiply(self : TimeseriesexponentialMatrix, other : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  if self.cols != other.rows { return timeseries_exponential_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_exponential_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesexponentialMatrix::trace(self : TimeseriesexponentialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesexponentialMatrix::det(self : TimeseriesexponentialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesexponentialMatrix::norm(self : TimeseriesexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesexponentialMatrix::to_string(self : TimeseriesexponentialMatrix) -> String {
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

pub(all) struct TimeseriesexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_exponential_make_vector(comps : Array[Double]) -> TimeseriesexponentialVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_exponential_vector_zero(dim : Int) -> TimeseriesexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesexponentialVector::add(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesexponentialVector::sub(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesexponentialVector::scale(self : TimeseriesexponentialVector, s : Double) -> TimeseriesexponentialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesexponentialVector::dot(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesexponentialVector::norm(self : TimeseriesexponentialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesexponentialVector::normalize(self : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesexponentialVector::dist(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesexponentialVector::to_string(self : TimeseriesexponentialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_exponential_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_exponential_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_exponential_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_exponential_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_exponential_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_exponential_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_exponential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_exponential_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_exponential_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_exponential_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_exponential_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_exponential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_exponential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_exponential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_exponential_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_exponential_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_exponential_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_exponential_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_exponential_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_exponential_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_exponential_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_exponential_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_exponential_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_exponential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_exponential_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_exponential_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_exponential_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_exponential_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_exponential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_frame_make(size : Int) -> TimeseriesexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialFrame::len(self : TimeseriesexponentialFrame) -> Int { self.size }

pub fn TimeseriesexponentialFrame::get(self : TimeseriesexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialFrame::set(self : TimeseriesexponentialFrame, i : Int, v : Double) -> TimeseriesexponentialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialFrame::sum(self : TimeseriesexponentialFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialFrame::mean(self : TimeseriesexponentialFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialFrame::scale(self : TimeseriesexponentialFrame, f : Double) -> TimeseriesexponentialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialFrame::add(self : TimeseriesexponentialFrame, other : TimeseriesexponentialFrame) -> TimeseriesexponentialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialFrame::copy(self : TimeseriesexponentialFrame) -> TimeseriesexponentialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialFrame::fill(self : TimeseriesexponentialFrame, v : Double) -> TimeseriesexponentialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialFrame::min(self : TimeseriesexponentialFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialFrame::max(self : TimeseriesexponentialFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialFrame::to_string(self : TimeseriesexponentialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_table_make(size : Int) -> TimeseriesexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialTable::len(self : TimeseriesexponentialTable) -> Int { self.size }

pub fn TimeseriesexponentialTable::get(self : TimeseriesexponentialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialTable::set(self : TimeseriesexponentialTable, i : Int, v : Double) -> TimeseriesexponentialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialTable::sum(self : TimeseriesexponentialTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialTable::mean(self : TimeseriesexponentialTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialTable::scale(self : TimeseriesexponentialTable, f : Double) -> TimeseriesexponentialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialTable::add(self : TimeseriesexponentialTable, other : TimeseriesexponentialTable) -> TimeseriesexponentialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialTable::copy(self : TimeseriesexponentialTable) -> TimeseriesexponentialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialTable::fill(self : TimeseriesexponentialTable, v : Double) -> TimeseriesexponentialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialTable::min(self : TimeseriesexponentialTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialTable::max(self : TimeseriesexponentialTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialTable::to_string(self : TimeseriesexponentialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_graphn_make(size : Int) -> TimeseriesexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialGraphN::len(self : TimeseriesexponentialGraphN) -> Int { self.size }

pub fn TimeseriesexponentialGraphN::get(self : TimeseriesexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialGraphN::set(self : TimeseriesexponentialGraphN, i : Int, v : Double) -> TimeseriesexponentialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialGraphN::sum(self : TimeseriesexponentialGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialGraphN::mean(self : TimeseriesexponentialGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialGraphN::scale(self : TimeseriesexponentialGraphN, f : Double) -> TimeseriesexponentialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialGraphN::add(self : TimeseriesexponentialGraphN, other : TimeseriesexponentialGraphN) -> TimeseriesexponentialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialGraphN::copy(self : TimeseriesexponentialGraphN) -> TimeseriesexponentialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialGraphN::fill(self : TimeseriesexponentialGraphN, v : Double) -> TimeseriesexponentialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialGraphN::min(self : TimeseriesexponentialGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialGraphN::max(self : TimeseriesexponentialGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialGraphN::to_string(self : TimeseriesexponentialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_node_make(size : Int) -> TimeseriesexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialNode::len(self : TimeseriesexponentialNode) -> Int { self.size }

pub fn TimeseriesexponentialNode::get(self : TimeseriesexponentialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialNode::set(self : TimeseriesexponentialNode, i : Int, v : Double) -> TimeseriesexponentialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialNode::sum(self : TimeseriesexponentialNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialNode::mean(self : TimeseriesexponentialNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialNode::scale(self : TimeseriesexponentialNode, f : Double) -> TimeseriesexponentialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialNode::add(self : TimeseriesexponentialNode, other : TimeseriesexponentialNode) -> TimeseriesexponentialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialNode::copy(self : TimeseriesexponentialNode) -> TimeseriesexponentialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialNode::fill(self : TimeseriesexponentialNode, v : Double) -> TimeseriesexponentialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialNode::min(self : TimeseriesexponentialNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialNode::max(self : TimeseriesexponentialNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialNode::to_string(self : TimeseriesexponentialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_edge_make(size : Int) -> TimeseriesexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialEdge::len(self : TimeseriesexponentialEdge) -> Int { self.size }

pub fn TimeseriesexponentialEdge::get(self : TimeseriesexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialEdge::set(self : TimeseriesexponentialEdge, i : Int, v : Double) -> TimeseriesexponentialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialEdge::sum(self : TimeseriesexponentialEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialEdge::mean(self : TimeseriesexponentialEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialEdge::scale(self : TimeseriesexponentialEdge, f : Double) -> TimeseriesexponentialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialEdge::add(self : TimeseriesexponentialEdge, other : TimeseriesexponentialEdge) -> TimeseriesexponentialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialEdge::copy(self : TimeseriesexponentialEdge) -> TimeseriesexponentialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialEdge::fill(self : TimeseriesexponentialEdge, v : Double) -> TimeseriesexponentialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialEdge::min(self : TimeseriesexponentialEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialEdge::max(self : TimeseriesexponentialEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialEdge::to_string(self : TimeseriesexponentialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_path_make(size : Int) -> TimeseriesexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialPath::len(self : TimeseriesexponentialPath) -> Int { self.size }

pub fn TimeseriesexponentialPath::get(self : TimeseriesexponentialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialPath::set(self : TimeseriesexponentialPath, i : Int, v : Double) -> TimeseriesexponentialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialPath::sum(self : TimeseriesexponentialPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialPath::mean(self : TimeseriesexponentialPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialPath::scale(self : TimeseriesexponentialPath, f : Double) -> TimeseriesexponentialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialPath::add(self : TimeseriesexponentialPath, other : TimeseriesexponentialPath) -> TimeseriesexponentialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialPath::copy(self : TimeseriesexponentialPath) -> TimeseriesexponentialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialPath::fill(self : TimeseriesexponentialPath, v : Double) -> TimeseriesexponentialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialPath::min(self : TimeseriesexponentialPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialPath::max(self : TimeseriesexponentialPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialPath::to_string(self : TimeseriesexponentialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_cluster_make(size : Int) -> TimeseriesexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialCluster::len(self : TimeseriesexponentialCluster) -> Int { self.size }

pub fn TimeseriesexponentialCluster::get(self : TimeseriesexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialCluster::set(self : TimeseriesexponentialCluster, i : Int, v : Double) -> TimeseriesexponentialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCluster::sum(self : TimeseriesexponentialCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialCluster::mean(self : TimeseriesexponentialCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialCluster::scale(self : TimeseriesexponentialCluster, f : Double) -> TimeseriesexponentialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCluster::add(self : TimeseriesexponentialCluster, other : TimeseriesexponentialCluster) -> TimeseriesexponentialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialCluster::copy(self : TimeseriesexponentialCluster) -> TimeseriesexponentialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCluster::fill(self : TimeseriesexponentialCluster, v : Double) -> TimeseriesexponentialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCluster::min(self : TimeseriesexponentialCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialCluster::max(self : TimeseriesexponentialCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialCluster::to_string(self : TimeseriesexponentialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_model_make(size : Int) -> TimeseriesexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialModel::len(self : TimeseriesexponentialModel) -> Int { self.size }

pub fn TimeseriesexponentialModel::get(self : TimeseriesexponentialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialModel::set(self : TimeseriesexponentialModel, i : Int, v : Double) -> TimeseriesexponentialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialModel::sum(self : TimeseriesexponentialModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialModel::mean(self : TimeseriesexponentialModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialModel::scale(self : TimeseriesexponentialModel, f : Double) -> TimeseriesexponentialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialModel::add(self : TimeseriesexponentialModel, other : TimeseriesexponentialModel) -> TimeseriesexponentialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialModel::copy(self : TimeseriesexponentialModel) -> TimeseriesexponentialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialModel::fill(self : TimeseriesexponentialModel, v : Double) -> TimeseriesexponentialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialModel::min(self : TimeseriesexponentialModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialModel::max(self : TimeseriesexponentialModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialModel::to_string(self : TimeseriesexponentialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_layer_make(size : Int) -> TimeseriesexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialLayer::len(self : TimeseriesexponentialLayer) -> Int { self.size }

pub fn TimeseriesexponentialLayer::get(self : TimeseriesexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialLayer::set(self : TimeseriesexponentialLayer, i : Int, v : Double) -> TimeseriesexponentialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialLayer::sum(self : TimeseriesexponentialLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialLayer::mean(self : TimeseriesexponentialLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialLayer::scale(self : TimeseriesexponentialLayer, f : Double) -> TimeseriesexponentialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialLayer::add(self : TimeseriesexponentialLayer, other : TimeseriesexponentialLayer) -> TimeseriesexponentialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialLayer::copy(self : TimeseriesexponentialLayer) -> TimeseriesexponentialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialLayer::fill(self : TimeseriesexponentialLayer, v : Double) -> TimeseriesexponentialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialLayer::min(self : TimeseriesexponentialLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialLayer::max(self : TimeseriesexponentialLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialLayer::to_string(self : TimeseriesexponentialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_buffer_make(size : Int) -> TimeseriesexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialBuffer::len(self : TimeseriesexponentialBuffer) -> Int { self.size }

pub fn TimeseriesexponentialBuffer::get(self : TimeseriesexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialBuffer::set(self : TimeseriesexponentialBuffer, i : Int, v : Double) -> TimeseriesexponentialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialBuffer::sum(self : TimeseriesexponentialBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialBuffer::mean(self : TimeseriesexponentialBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialBuffer::scale(self : TimeseriesexponentialBuffer, f : Double) -> TimeseriesexponentialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialBuffer::add(self : TimeseriesexponentialBuffer, other : TimeseriesexponentialBuffer) -> TimeseriesexponentialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialBuffer::copy(self : TimeseriesexponentialBuffer) -> TimeseriesexponentialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialBuffer::fill(self : TimeseriesexponentialBuffer, v : Double) -> TimeseriesexponentialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialBuffer::min(self : TimeseriesexponentialBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialBuffer::max(self : TimeseriesexponentialBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialBuffer::to_string(self : TimeseriesexponentialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_cursor_make(size : Int) -> TimeseriesexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialCursor::len(self : TimeseriesexponentialCursor) -> Int { self.size }

pub fn TimeseriesexponentialCursor::get(self : TimeseriesexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialCursor::set(self : TimeseriesexponentialCursor, i : Int, v : Double) -> TimeseriesexponentialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCursor::sum(self : TimeseriesexponentialCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialCursor::mean(self : TimeseriesexponentialCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialCursor::scale(self : TimeseriesexponentialCursor, f : Double) -> TimeseriesexponentialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCursor::add(self : TimeseriesexponentialCursor, other : TimeseriesexponentialCursor) -> TimeseriesexponentialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialCursor::copy(self : TimeseriesexponentialCursor) -> TimeseriesexponentialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCursor::fill(self : TimeseriesexponentialCursor, v : Double) -> TimeseriesexponentialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialCursor::min(self : TimeseriesexponentialCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialCursor::max(self : TimeseriesexponentialCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialCursor::to_string(self : TimeseriesexponentialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_view_make(size : Int) -> TimeseriesexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialView::len(self : TimeseriesexponentialView) -> Int { self.size }

pub fn TimeseriesexponentialView::get(self : TimeseriesexponentialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialView::set(self : TimeseriesexponentialView, i : Int, v : Double) -> TimeseriesexponentialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialView::sum(self : TimeseriesexponentialView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialView::mean(self : TimeseriesexponentialView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialView::scale(self : TimeseriesexponentialView, f : Double) -> TimeseriesexponentialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialView::add(self : TimeseriesexponentialView, other : TimeseriesexponentialView) -> TimeseriesexponentialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialView::copy(self : TimeseriesexponentialView) -> TimeseriesexponentialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialView::fill(self : TimeseriesexponentialView, v : Double) -> TimeseriesexponentialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialView::min(self : TimeseriesexponentialView) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialView::max(self : TimeseriesexponentialView) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialView::to_string(self : TimeseriesexponentialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_range_make(size : Int) -> TimeseriesexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialRange::len(self : TimeseriesexponentialRange) -> Int { self.size }

pub fn TimeseriesexponentialRange::get(self : TimeseriesexponentialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialRange::set(self : TimeseriesexponentialRange, i : Int, v : Double) -> TimeseriesexponentialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialRange::sum(self : TimeseriesexponentialRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialRange::mean(self : TimeseriesexponentialRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialRange::scale(self : TimeseriesexponentialRange, f : Double) -> TimeseriesexponentialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialRange::add(self : TimeseriesexponentialRange, other : TimeseriesexponentialRange) -> TimeseriesexponentialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialRange::copy(self : TimeseriesexponentialRange) -> TimeseriesexponentialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialRange::fill(self : TimeseriesexponentialRange, v : Double) -> TimeseriesexponentialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialRange::min(self : TimeseriesexponentialRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialRange::max(self : TimeseriesexponentialRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialRange::to_string(self : TimeseriesexponentialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_slice_make(size : Int) -> TimeseriesexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesexponentialSlice::len(self : TimeseriesexponentialSlice) -> Int { self.size }

pub fn TimeseriesexponentialSlice::get(self : TimeseriesexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesexponentialSlice::set(self : TimeseriesexponentialSlice, i : Int, v : Double) -> TimeseriesexponentialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialSlice::sum(self : TimeseriesexponentialSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesexponentialSlice::mean(self : TimeseriesexponentialSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesexponentialSlice::scale(self : TimeseriesexponentialSlice, f : Double) -> TimeseriesexponentialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialSlice::add(self : TimeseriesexponentialSlice, other : TimeseriesexponentialSlice) -> TimeseriesexponentialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesexponentialSlice::copy(self : TimeseriesexponentialSlice) -> TimeseriesexponentialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialSlice::fill(self : TimeseriesexponentialSlice, v : Double) -> TimeseriesexponentialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesexponentialSlice::min(self : TimeseriesexponentialSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesexponentialSlice::max(self : TimeseriesexponentialSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesexponentialSlice::to_string(self : TimeseriesexponentialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

