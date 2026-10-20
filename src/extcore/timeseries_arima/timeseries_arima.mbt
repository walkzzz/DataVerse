///===
/// extcore/timeseries_arima

pub(all) struct TimeseriesarimaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_arima_make_point(x : Double, y : Double) -> TimeseriesarimaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_arima_make_point3(x : Double, y : Double, z : Double) -> TimeseriesarimaPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesarimaPoint::x(self : TimeseriesarimaPoint) -> Double { self.x }

pub fn TimeseriesarimaPoint::y(self : TimeseriesarimaPoint) -> Double { self.y }

pub fn TimeseriesarimaPoint::z(self : TimeseriesarimaPoint) -> Double { self.z }

pub fn TimeseriesarimaPoint::label(self : TimeseriesarimaPoint) -> Int { self.label }

pub fn TimeseriesarimaPoint::dist(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesarimaPoint::add(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesarimaPoint::sub(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesarimaPoint::scale(self : TimeseriesarimaPoint, s : Double) -> TimeseriesarimaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesarimaPoint::dot(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesarimaPoint::cross(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesarimaPoint::norm(self : TimeseriesarimaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesarimaPoint::normalize(self : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesarimaPoint::negate(self : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesarimaPoint::mid(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesarimaPoint::lerp(self : TimeseriesarimaPoint, other : TimeseriesarimaPoint, t : Double) -> TimeseriesarimaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesarimaPoint::to_string(self : TimeseriesarimaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesarimaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_arima_make_series(vals : Array[Double], name : String) -> TimeseriesarimaSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesarimaSeries::len(self : TimeseriesarimaSeries) -> Int { self.vals.length() }

pub fn TimeseriesarimaSeries::sum(self : TimeseriesarimaSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesarimaSeries::mean(self : TimeseriesarimaSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesarimaSeries::min(self : TimeseriesarimaSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesarimaSeries::max(self : TimeseriesarimaSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesarimaSeries::range(self : TimeseriesarimaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesarimaSeries::variance(self : TimeseriesarimaSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesarimaSeries::std(self : TimeseriesarimaSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesarimaSeries::median(self : TimeseriesarimaSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesarimaSeries::scale(self : TimeseriesarimaSeries, f : Double) -> TimeseriesarimaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesarimaSeries::add(self : TimeseriesarimaSeries, other : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesarimaSeries::sub(self : TimeseriesarimaSeries, other : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesarimaSeries::normalize(self : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesarimaSeries::cumsum(self : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesarimaSeries::to_string(self : TimeseriesarimaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesarimaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_arima_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesarimaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_arima_matrix_identity(n : Int) -> TimeseriesarimaMatrix {
  let m = timeseries_arima_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesarimaMatrix::get(self : TimeseriesarimaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesarimaMatrix::transpose(self : TimeseriesarimaMatrix) -> TimeseriesarimaMatrix {
  let result = timeseries_arima_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesarimaMatrix::add(self : TimeseriesarimaMatrix, other : TimeseriesarimaMatrix) -> TimeseriesarimaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_arima_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesarimaMatrix::scale(self : TimeseriesarimaMatrix, s : Double) -> TimeseriesarimaMatrix {
  let result = timeseries_arima_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesarimaMatrix::multiply(self : TimeseriesarimaMatrix, other : TimeseriesarimaMatrix) -> TimeseriesarimaMatrix {
  if self.cols != other.rows { return timeseries_arima_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_arima_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesarimaMatrix::trace(self : TimeseriesarimaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesarimaMatrix::det(self : TimeseriesarimaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesarimaMatrix::norm(self : TimeseriesarimaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesarimaMatrix::to_string(self : TimeseriesarimaMatrix) -> String {
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

pub(all) struct TimeseriesarimaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_arima_make_vector(comps : Array[Double]) -> TimeseriesarimaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_arima_vector_zero(dim : Int) -> TimeseriesarimaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesarimaVector::add(self : TimeseriesarimaVector, other : TimeseriesarimaVector) -> TimeseriesarimaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesarimaVector::sub(self : TimeseriesarimaVector, other : TimeseriesarimaVector) -> TimeseriesarimaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesarimaVector::scale(self : TimeseriesarimaVector, s : Double) -> TimeseriesarimaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesarimaVector::dot(self : TimeseriesarimaVector, other : TimeseriesarimaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesarimaVector::norm(self : TimeseriesarimaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesarimaVector::normalize(self : TimeseriesarimaVector) -> TimeseriesarimaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesarimaVector::dist(self : TimeseriesarimaVector, other : TimeseriesarimaVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesarimaVector::to_string(self : TimeseriesarimaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_arima_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_arima_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_arima_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_arima_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_arima_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_arima_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_arima_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_arima_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_arima_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_arima_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_arima_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_arima_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_arima_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_arima_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_arima_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_arima_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_arima_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_arima_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_arima_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_arima_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_arima_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_arima_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_arima_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_arima_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_arima_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_arima_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_arima_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_arima_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_arima_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesarimaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_frame_make(size : Int) -> TimeseriesarimaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaFrame::len(self : TimeseriesarimaFrame) -> Int { self.size }

pub fn TimeseriesarimaFrame::get(self : TimeseriesarimaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaFrame::set(self : TimeseriesarimaFrame, i : Int, v : Double) -> TimeseriesarimaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaFrame::sum(self : TimeseriesarimaFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaFrame::mean(self : TimeseriesarimaFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaFrame::scale(self : TimeseriesarimaFrame, f : Double) -> TimeseriesarimaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaFrame::add(self : TimeseriesarimaFrame, other : TimeseriesarimaFrame) -> TimeseriesarimaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaFrame::copy(self : TimeseriesarimaFrame) -> TimeseriesarimaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaFrame::fill(self : TimeseriesarimaFrame, v : Double) -> TimeseriesarimaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaFrame::min(self : TimeseriesarimaFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaFrame::max(self : TimeseriesarimaFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaFrame::to_string(self : TimeseriesarimaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_table_make(size : Int) -> TimeseriesarimaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaTable::len(self : TimeseriesarimaTable) -> Int { self.size }

pub fn TimeseriesarimaTable::get(self : TimeseriesarimaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaTable::set(self : TimeseriesarimaTable, i : Int, v : Double) -> TimeseriesarimaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaTable::sum(self : TimeseriesarimaTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaTable::mean(self : TimeseriesarimaTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaTable::scale(self : TimeseriesarimaTable, f : Double) -> TimeseriesarimaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaTable::add(self : TimeseriesarimaTable, other : TimeseriesarimaTable) -> TimeseriesarimaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaTable::copy(self : TimeseriesarimaTable) -> TimeseriesarimaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaTable::fill(self : TimeseriesarimaTable, v : Double) -> TimeseriesarimaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaTable::min(self : TimeseriesarimaTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaTable::max(self : TimeseriesarimaTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaTable::to_string(self : TimeseriesarimaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_graphn_make(size : Int) -> TimeseriesarimaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaGraphN::len(self : TimeseriesarimaGraphN) -> Int { self.size }

pub fn TimeseriesarimaGraphN::get(self : TimeseriesarimaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaGraphN::set(self : TimeseriesarimaGraphN, i : Int, v : Double) -> TimeseriesarimaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaGraphN::sum(self : TimeseriesarimaGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaGraphN::mean(self : TimeseriesarimaGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaGraphN::scale(self : TimeseriesarimaGraphN, f : Double) -> TimeseriesarimaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaGraphN::add(self : TimeseriesarimaGraphN, other : TimeseriesarimaGraphN) -> TimeseriesarimaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaGraphN::copy(self : TimeseriesarimaGraphN) -> TimeseriesarimaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaGraphN::fill(self : TimeseriesarimaGraphN, v : Double) -> TimeseriesarimaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaGraphN::min(self : TimeseriesarimaGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaGraphN::max(self : TimeseriesarimaGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaGraphN::to_string(self : TimeseriesarimaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_node_make(size : Int) -> TimeseriesarimaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaNode::len(self : TimeseriesarimaNode) -> Int { self.size }

pub fn TimeseriesarimaNode::get(self : TimeseriesarimaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaNode::set(self : TimeseriesarimaNode, i : Int, v : Double) -> TimeseriesarimaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaNode::sum(self : TimeseriesarimaNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaNode::mean(self : TimeseriesarimaNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaNode::scale(self : TimeseriesarimaNode, f : Double) -> TimeseriesarimaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaNode::add(self : TimeseriesarimaNode, other : TimeseriesarimaNode) -> TimeseriesarimaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaNode::copy(self : TimeseriesarimaNode) -> TimeseriesarimaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaNode::fill(self : TimeseriesarimaNode, v : Double) -> TimeseriesarimaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaNode::min(self : TimeseriesarimaNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaNode::max(self : TimeseriesarimaNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaNode::to_string(self : TimeseriesarimaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_edge_make(size : Int) -> TimeseriesarimaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaEdge::len(self : TimeseriesarimaEdge) -> Int { self.size }

pub fn TimeseriesarimaEdge::get(self : TimeseriesarimaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaEdge::set(self : TimeseriesarimaEdge, i : Int, v : Double) -> TimeseriesarimaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaEdge::sum(self : TimeseriesarimaEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaEdge::mean(self : TimeseriesarimaEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaEdge::scale(self : TimeseriesarimaEdge, f : Double) -> TimeseriesarimaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaEdge::add(self : TimeseriesarimaEdge, other : TimeseriesarimaEdge) -> TimeseriesarimaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaEdge::copy(self : TimeseriesarimaEdge) -> TimeseriesarimaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaEdge::fill(self : TimeseriesarimaEdge, v : Double) -> TimeseriesarimaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaEdge::min(self : TimeseriesarimaEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaEdge::max(self : TimeseriesarimaEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaEdge::to_string(self : TimeseriesarimaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_path_make(size : Int) -> TimeseriesarimaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaPath::len(self : TimeseriesarimaPath) -> Int { self.size }

pub fn TimeseriesarimaPath::get(self : TimeseriesarimaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaPath::set(self : TimeseriesarimaPath, i : Int, v : Double) -> TimeseriesarimaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaPath::sum(self : TimeseriesarimaPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaPath::mean(self : TimeseriesarimaPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaPath::scale(self : TimeseriesarimaPath, f : Double) -> TimeseriesarimaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaPath::add(self : TimeseriesarimaPath, other : TimeseriesarimaPath) -> TimeseriesarimaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaPath::copy(self : TimeseriesarimaPath) -> TimeseriesarimaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaPath::fill(self : TimeseriesarimaPath, v : Double) -> TimeseriesarimaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaPath::min(self : TimeseriesarimaPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaPath::max(self : TimeseriesarimaPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaPath::to_string(self : TimeseriesarimaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_cluster_make(size : Int) -> TimeseriesarimaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaCluster::len(self : TimeseriesarimaCluster) -> Int { self.size }

pub fn TimeseriesarimaCluster::get(self : TimeseriesarimaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaCluster::set(self : TimeseriesarimaCluster, i : Int, v : Double) -> TimeseriesarimaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCluster::sum(self : TimeseriesarimaCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaCluster::mean(self : TimeseriesarimaCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaCluster::scale(self : TimeseriesarimaCluster, f : Double) -> TimeseriesarimaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCluster::add(self : TimeseriesarimaCluster, other : TimeseriesarimaCluster) -> TimeseriesarimaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaCluster::copy(self : TimeseriesarimaCluster) -> TimeseriesarimaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCluster::fill(self : TimeseriesarimaCluster, v : Double) -> TimeseriesarimaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCluster::min(self : TimeseriesarimaCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaCluster::max(self : TimeseriesarimaCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaCluster::to_string(self : TimeseriesarimaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_model_make(size : Int) -> TimeseriesarimaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaModel::len(self : TimeseriesarimaModel) -> Int { self.size }

pub fn TimeseriesarimaModel::get(self : TimeseriesarimaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaModel::set(self : TimeseriesarimaModel, i : Int, v : Double) -> TimeseriesarimaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaModel::sum(self : TimeseriesarimaModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaModel::mean(self : TimeseriesarimaModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaModel::scale(self : TimeseriesarimaModel, f : Double) -> TimeseriesarimaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaModel::add(self : TimeseriesarimaModel, other : TimeseriesarimaModel) -> TimeseriesarimaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaModel::copy(self : TimeseriesarimaModel) -> TimeseriesarimaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaModel::fill(self : TimeseriesarimaModel, v : Double) -> TimeseriesarimaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaModel::min(self : TimeseriesarimaModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaModel::max(self : TimeseriesarimaModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaModel::to_string(self : TimeseriesarimaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_layer_make(size : Int) -> TimeseriesarimaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaLayer::len(self : TimeseriesarimaLayer) -> Int { self.size }

pub fn TimeseriesarimaLayer::get(self : TimeseriesarimaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaLayer::set(self : TimeseriesarimaLayer, i : Int, v : Double) -> TimeseriesarimaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaLayer::sum(self : TimeseriesarimaLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaLayer::mean(self : TimeseriesarimaLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaLayer::scale(self : TimeseriesarimaLayer, f : Double) -> TimeseriesarimaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaLayer::add(self : TimeseriesarimaLayer, other : TimeseriesarimaLayer) -> TimeseriesarimaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaLayer::copy(self : TimeseriesarimaLayer) -> TimeseriesarimaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaLayer::fill(self : TimeseriesarimaLayer, v : Double) -> TimeseriesarimaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaLayer::min(self : TimeseriesarimaLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaLayer::max(self : TimeseriesarimaLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaLayer::to_string(self : TimeseriesarimaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_buffer_make(size : Int) -> TimeseriesarimaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaBuffer::len(self : TimeseriesarimaBuffer) -> Int { self.size }

pub fn TimeseriesarimaBuffer::get(self : TimeseriesarimaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaBuffer::set(self : TimeseriesarimaBuffer, i : Int, v : Double) -> TimeseriesarimaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaBuffer::sum(self : TimeseriesarimaBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaBuffer::mean(self : TimeseriesarimaBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaBuffer::scale(self : TimeseriesarimaBuffer, f : Double) -> TimeseriesarimaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaBuffer::add(self : TimeseriesarimaBuffer, other : TimeseriesarimaBuffer) -> TimeseriesarimaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaBuffer::copy(self : TimeseriesarimaBuffer) -> TimeseriesarimaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaBuffer::fill(self : TimeseriesarimaBuffer, v : Double) -> TimeseriesarimaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaBuffer::min(self : TimeseriesarimaBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaBuffer::max(self : TimeseriesarimaBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaBuffer::to_string(self : TimeseriesarimaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_cursor_make(size : Int) -> TimeseriesarimaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaCursor::len(self : TimeseriesarimaCursor) -> Int { self.size }

pub fn TimeseriesarimaCursor::get(self : TimeseriesarimaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaCursor::set(self : TimeseriesarimaCursor, i : Int, v : Double) -> TimeseriesarimaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCursor::sum(self : TimeseriesarimaCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaCursor::mean(self : TimeseriesarimaCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaCursor::scale(self : TimeseriesarimaCursor, f : Double) -> TimeseriesarimaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCursor::add(self : TimeseriesarimaCursor, other : TimeseriesarimaCursor) -> TimeseriesarimaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaCursor::copy(self : TimeseriesarimaCursor) -> TimeseriesarimaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCursor::fill(self : TimeseriesarimaCursor, v : Double) -> TimeseriesarimaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaCursor::min(self : TimeseriesarimaCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaCursor::max(self : TimeseriesarimaCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaCursor::to_string(self : TimeseriesarimaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_view_make(size : Int) -> TimeseriesarimaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaView::len(self : TimeseriesarimaView) -> Int { self.size }

pub fn TimeseriesarimaView::get(self : TimeseriesarimaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaView::set(self : TimeseriesarimaView, i : Int, v : Double) -> TimeseriesarimaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaView::sum(self : TimeseriesarimaView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaView::mean(self : TimeseriesarimaView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaView::scale(self : TimeseriesarimaView, f : Double) -> TimeseriesarimaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaView::add(self : TimeseriesarimaView, other : TimeseriesarimaView) -> TimeseriesarimaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaView::copy(self : TimeseriesarimaView) -> TimeseriesarimaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaView::fill(self : TimeseriesarimaView, v : Double) -> TimeseriesarimaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaView::min(self : TimeseriesarimaView) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaView::max(self : TimeseriesarimaView) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaView::to_string(self : TimeseriesarimaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_range_make(size : Int) -> TimeseriesarimaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaRange::len(self : TimeseriesarimaRange) -> Int { self.size }

pub fn TimeseriesarimaRange::get(self : TimeseriesarimaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaRange::set(self : TimeseriesarimaRange, i : Int, v : Double) -> TimeseriesarimaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaRange::sum(self : TimeseriesarimaRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaRange::mean(self : TimeseriesarimaRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaRange::scale(self : TimeseriesarimaRange, f : Double) -> TimeseriesarimaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaRange::add(self : TimeseriesarimaRange, other : TimeseriesarimaRange) -> TimeseriesarimaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaRange::copy(self : TimeseriesarimaRange) -> TimeseriesarimaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaRange::fill(self : TimeseriesarimaRange, v : Double) -> TimeseriesarimaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaRange::min(self : TimeseriesarimaRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaRange::max(self : TimeseriesarimaRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaRange::to_string(self : TimeseriesarimaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_slice_make(size : Int) -> TimeseriesarimaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarimaSlice::len(self : TimeseriesarimaSlice) -> Int { self.size }

pub fn TimeseriesarimaSlice::get(self : TimeseriesarimaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarimaSlice::set(self : TimeseriesarimaSlice, i : Int, v : Double) -> TimeseriesarimaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaSlice::sum(self : TimeseriesarimaSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarimaSlice::mean(self : TimeseriesarimaSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarimaSlice::scale(self : TimeseriesarimaSlice, f : Double) -> TimeseriesarimaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaSlice::add(self : TimeseriesarimaSlice, other : TimeseriesarimaSlice) -> TimeseriesarimaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarimaSlice::copy(self : TimeseriesarimaSlice) -> TimeseriesarimaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaSlice::fill(self : TimeseriesarimaSlice, v : Double) -> TimeseriesarimaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarimaSlice::min(self : TimeseriesarimaSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesarimaSlice::max(self : TimeseriesarimaSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesarimaSlice::to_string(self : TimeseriesarimaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

