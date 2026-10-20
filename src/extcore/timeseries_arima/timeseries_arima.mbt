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

pub fn timeseries_arima_frame_len(s : TimeseriesarimaFrame) -> Int { s.size }

pub fn timeseries_arima_frame_get(s : TimeseriesarimaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_frame_set(s : TimeseriesarimaFrame, i : Int, v : Double) -> TimeseriesarimaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_frame_sum(s : TimeseriesarimaFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_frame_mean(s : TimeseriesarimaFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_frame_scale(s : TimeseriesarimaFrame, f : Double) -> TimeseriesarimaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_frame_add(a : TimeseriesarimaFrame, b : TimeseriesarimaFrame) -> TimeseriesarimaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_frame_copy(s : TimeseriesarimaFrame) -> TimeseriesarimaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_frame_fill(s : TimeseriesarimaFrame, v : Double) -> TimeseriesarimaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_frame_min(s : TimeseriesarimaFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_frame_max(s : TimeseriesarimaFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_frame_to_string(s : TimeseriesarimaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_table_make(size : Int) -> TimeseriesarimaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_table_len(s : TimeseriesarimaTable) -> Int { s.size }

pub fn timeseries_arima_table_get(s : TimeseriesarimaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_table_set(s : TimeseriesarimaTable, i : Int, v : Double) -> TimeseriesarimaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_table_sum(s : TimeseriesarimaTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_table_mean(s : TimeseriesarimaTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_table_scale(s : TimeseriesarimaTable, f : Double) -> TimeseriesarimaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_table_add(a : TimeseriesarimaTable, b : TimeseriesarimaTable) -> TimeseriesarimaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_table_copy(s : TimeseriesarimaTable) -> TimeseriesarimaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_table_fill(s : TimeseriesarimaTable, v : Double) -> TimeseriesarimaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_table_min(s : TimeseriesarimaTable) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_table_max(s : TimeseriesarimaTable) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_table_to_string(s : TimeseriesarimaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_graphn_make(size : Int) -> TimeseriesarimaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_graphn_len(s : TimeseriesarimaGraphN) -> Int { s.size }

pub fn timeseries_arima_graphn_get(s : TimeseriesarimaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_graphn_set(s : TimeseriesarimaGraphN, i : Int, v : Double) -> TimeseriesarimaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_graphn_sum(s : TimeseriesarimaGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_graphn_mean(s : TimeseriesarimaGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_graphn_scale(s : TimeseriesarimaGraphN, f : Double) -> TimeseriesarimaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_graphn_add(a : TimeseriesarimaGraphN, b : TimeseriesarimaGraphN) -> TimeseriesarimaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_graphn_copy(s : TimeseriesarimaGraphN) -> TimeseriesarimaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_graphn_fill(s : TimeseriesarimaGraphN, v : Double) -> TimeseriesarimaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_graphn_min(s : TimeseriesarimaGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_graphn_max(s : TimeseriesarimaGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_graphn_to_string(s : TimeseriesarimaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_node_make(size : Int) -> TimeseriesarimaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_node_len(s : TimeseriesarimaNode) -> Int { s.size }

pub fn timeseries_arima_node_get(s : TimeseriesarimaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_node_set(s : TimeseriesarimaNode, i : Int, v : Double) -> TimeseriesarimaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_node_sum(s : TimeseriesarimaNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_node_mean(s : TimeseriesarimaNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_node_scale(s : TimeseriesarimaNode, f : Double) -> TimeseriesarimaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_node_add(a : TimeseriesarimaNode, b : TimeseriesarimaNode) -> TimeseriesarimaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_node_copy(s : TimeseriesarimaNode) -> TimeseriesarimaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_node_fill(s : TimeseriesarimaNode, v : Double) -> TimeseriesarimaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_node_min(s : TimeseriesarimaNode) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_node_max(s : TimeseriesarimaNode) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_node_to_string(s : TimeseriesarimaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_edge_make(size : Int) -> TimeseriesarimaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_edge_len(s : TimeseriesarimaEdge) -> Int { s.size }

pub fn timeseries_arima_edge_get(s : TimeseriesarimaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_edge_set(s : TimeseriesarimaEdge, i : Int, v : Double) -> TimeseriesarimaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_edge_sum(s : TimeseriesarimaEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_edge_mean(s : TimeseriesarimaEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_edge_scale(s : TimeseriesarimaEdge, f : Double) -> TimeseriesarimaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_edge_add(a : TimeseriesarimaEdge, b : TimeseriesarimaEdge) -> TimeseriesarimaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_edge_copy(s : TimeseriesarimaEdge) -> TimeseriesarimaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_edge_fill(s : TimeseriesarimaEdge, v : Double) -> TimeseriesarimaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_edge_min(s : TimeseriesarimaEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_edge_max(s : TimeseriesarimaEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_edge_to_string(s : TimeseriesarimaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_path_make(size : Int) -> TimeseriesarimaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_path_len(s : TimeseriesarimaPath) -> Int { s.size }

pub fn timeseries_arima_path_get(s : TimeseriesarimaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_path_set(s : TimeseriesarimaPath, i : Int, v : Double) -> TimeseriesarimaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_path_sum(s : TimeseriesarimaPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_path_mean(s : TimeseriesarimaPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_path_scale(s : TimeseriesarimaPath, f : Double) -> TimeseriesarimaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_path_add(a : TimeseriesarimaPath, b : TimeseriesarimaPath) -> TimeseriesarimaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_path_copy(s : TimeseriesarimaPath) -> TimeseriesarimaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_path_fill(s : TimeseriesarimaPath, v : Double) -> TimeseriesarimaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_path_min(s : TimeseriesarimaPath) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_path_max(s : TimeseriesarimaPath) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_path_to_string(s : TimeseriesarimaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_cluster_make(size : Int) -> TimeseriesarimaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_cluster_len(s : TimeseriesarimaCluster) -> Int { s.size }

pub fn timeseries_arima_cluster_get(s : TimeseriesarimaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_cluster_set(s : TimeseriesarimaCluster, i : Int, v : Double) -> TimeseriesarimaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cluster_sum(s : TimeseriesarimaCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_cluster_mean(s : TimeseriesarimaCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_cluster_scale(s : TimeseriesarimaCluster, f : Double) -> TimeseriesarimaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cluster_add(a : TimeseriesarimaCluster, b : TimeseriesarimaCluster) -> TimeseriesarimaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_cluster_copy(s : TimeseriesarimaCluster) -> TimeseriesarimaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cluster_fill(s : TimeseriesarimaCluster, v : Double) -> TimeseriesarimaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cluster_min(s : TimeseriesarimaCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_cluster_max(s : TimeseriesarimaCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_cluster_to_string(s : TimeseriesarimaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_model_make(size : Int) -> TimeseriesarimaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_model_len(s : TimeseriesarimaModel) -> Int { s.size }

pub fn timeseries_arima_model_get(s : TimeseriesarimaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_model_set(s : TimeseriesarimaModel, i : Int, v : Double) -> TimeseriesarimaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_model_sum(s : TimeseriesarimaModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_model_mean(s : TimeseriesarimaModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_model_scale(s : TimeseriesarimaModel, f : Double) -> TimeseriesarimaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_model_add(a : TimeseriesarimaModel, b : TimeseriesarimaModel) -> TimeseriesarimaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_model_copy(s : TimeseriesarimaModel) -> TimeseriesarimaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_model_fill(s : TimeseriesarimaModel, v : Double) -> TimeseriesarimaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_model_min(s : TimeseriesarimaModel) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_model_max(s : TimeseriesarimaModel) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_model_to_string(s : TimeseriesarimaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_layer_make(size : Int) -> TimeseriesarimaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_layer_len(s : TimeseriesarimaLayer) -> Int { s.size }

pub fn timeseries_arima_layer_get(s : TimeseriesarimaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_layer_set(s : TimeseriesarimaLayer, i : Int, v : Double) -> TimeseriesarimaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_layer_sum(s : TimeseriesarimaLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_layer_mean(s : TimeseriesarimaLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_layer_scale(s : TimeseriesarimaLayer, f : Double) -> TimeseriesarimaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_layer_add(a : TimeseriesarimaLayer, b : TimeseriesarimaLayer) -> TimeseriesarimaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_layer_copy(s : TimeseriesarimaLayer) -> TimeseriesarimaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_layer_fill(s : TimeseriesarimaLayer, v : Double) -> TimeseriesarimaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_layer_min(s : TimeseriesarimaLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_layer_max(s : TimeseriesarimaLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_layer_to_string(s : TimeseriesarimaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_buffer_make(size : Int) -> TimeseriesarimaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_buffer_len(s : TimeseriesarimaBuffer) -> Int { s.size }

pub fn timeseries_arima_buffer_get(s : TimeseriesarimaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_buffer_set(s : TimeseriesarimaBuffer, i : Int, v : Double) -> TimeseriesarimaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_buffer_sum(s : TimeseriesarimaBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_buffer_mean(s : TimeseriesarimaBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_buffer_scale(s : TimeseriesarimaBuffer, f : Double) -> TimeseriesarimaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_buffer_add(a : TimeseriesarimaBuffer, b : TimeseriesarimaBuffer) -> TimeseriesarimaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_buffer_copy(s : TimeseriesarimaBuffer) -> TimeseriesarimaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_buffer_fill(s : TimeseriesarimaBuffer, v : Double) -> TimeseriesarimaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_buffer_min(s : TimeseriesarimaBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_buffer_max(s : TimeseriesarimaBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_buffer_to_string(s : TimeseriesarimaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_cursor_make(size : Int) -> TimeseriesarimaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_cursor_len(s : TimeseriesarimaCursor) -> Int { s.size }

pub fn timeseries_arima_cursor_get(s : TimeseriesarimaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_cursor_set(s : TimeseriesarimaCursor, i : Int, v : Double) -> TimeseriesarimaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cursor_sum(s : TimeseriesarimaCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_cursor_mean(s : TimeseriesarimaCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_cursor_scale(s : TimeseriesarimaCursor, f : Double) -> TimeseriesarimaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cursor_add(a : TimeseriesarimaCursor, b : TimeseriesarimaCursor) -> TimeseriesarimaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_cursor_copy(s : TimeseriesarimaCursor) -> TimeseriesarimaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cursor_fill(s : TimeseriesarimaCursor, v : Double) -> TimeseriesarimaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_cursor_min(s : TimeseriesarimaCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_cursor_max(s : TimeseriesarimaCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_cursor_to_string(s : TimeseriesarimaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_view_make(size : Int) -> TimeseriesarimaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_view_len(s : TimeseriesarimaView) -> Int { s.size }

pub fn timeseries_arima_view_get(s : TimeseriesarimaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_view_set(s : TimeseriesarimaView, i : Int, v : Double) -> TimeseriesarimaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_view_sum(s : TimeseriesarimaView) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_view_mean(s : TimeseriesarimaView) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_view_scale(s : TimeseriesarimaView, f : Double) -> TimeseriesarimaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_view_add(a : TimeseriesarimaView, b : TimeseriesarimaView) -> TimeseriesarimaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_view_copy(s : TimeseriesarimaView) -> TimeseriesarimaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_view_fill(s : TimeseriesarimaView, v : Double) -> TimeseriesarimaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_view_min(s : TimeseriesarimaView) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_view_max(s : TimeseriesarimaView) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_view_to_string(s : TimeseriesarimaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_range_make(size : Int) -> TimeseriesarimaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_range_len(s : TimeseriesarimaRange) -> Int { s.size }

pub fn timeseries_arima_range_get(s : TimeseriesarimaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_range_set(s : TimeseriesarimaRange, i : Int, v : Double) -> TimeseriesarimaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_range_sum(s : TimeseriesarimaRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_range_mean(s : TimeseriesarimaRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_range_scale(s : TimeseriesarimaRange, f : Double) -> TimeseriesarimaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_range_add(a : TimeseriesarimaRange, b : TimeseriesarimaRange) -> TimeseriesarimaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_range_copy(s : TimeseriesarimaRange) -> TimeseriesarimaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_range_fill(s : TimeseriesarimaRange, v : Double) -> TimeseriesarimaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_range_min(s : TimeseriesarimaRange) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_range_max(s : TimeseriesarimaRange) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_range_to_string(s : TimeseriesarimaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_slice_make(size : Int) -> TimeseriesarimaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_slice_len(s : TimeseriesarimaSlice) -> Int { s.size }

pub fn timeseries_arima_slice_get(s : TimeseriesarimaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_slice_set(s : TimeseriesarimaSlice, i : Int, v : Double) -> TimeseriesarimaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arima_slice_sum(s : TimeseriesarimaSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_slice_mean(s : TimeseriesarimaSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_slice_scale(s : TimeseriesarimaSlice, f : Double) -> TimeseriesarimaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_slice_add(a : TimeseriesarimaSlice, b : TimeseriesarimaSlice) -> TimeseriesarimaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arima_slice_copy(s : TimeseriesarimaSlice) -> TimeseriesarimaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_slice_fill(s : TimeseriesarimaSlice, v : Double) -> TimeseriesarimaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arima_slice_min(s : TimeseriesarimaSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_slice_max(s : TimeseriesarimaSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_slice_to_string(s : TimeseriesarimaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

