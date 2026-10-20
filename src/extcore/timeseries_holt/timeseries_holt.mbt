///===
/// extcore/timeseries_holt

pub(all) struct TimeseriesholtPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_holt_make_point(x : Double, y : Double) -> TimeseriesholtPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_holt_make_point3(x : Double, y : Double, z : Double) -> TimeseriesholtPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesholtPoint::x(self : TimeseriesholtPoint) -> Double { self.x }

pub fn TimeseriesholtPoint::y(self : TimeseriesholtPoint) -> Double { self.y }

pub fn TimeseriesholtPoint::z(self : TimeseriesholtPoint) -> Double { self.z }

pub fn TimeseriesholtPoint::label(self : TimeseriesholtPoint) -> Int { self.label }

pub fn TimeseriesholtPoint::dist(self : TimeseriesholtPoint, other : TimeseriesholtPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesholtPoint::add(self : TimeseriesholtPoint, other : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesholtPoint::sub(self : TimeseriesholtPoint, other : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesholtPoint::scale(self : TimeseriesholtPoint, s : Double) -> TimeseriesholtPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesholtPoint::dot(self : TimeseriesholtPoint, other : TimeseriesholtPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesholtPoint::cross(self : TimeseriesholtPoint, other : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesholtPoint::norm(self : TimeseriesholtPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesholtPoint::normalize(self : TimeseriesholtPoint) -> TimeseriesholtPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesholtPoint::negate(self : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesholtPoint::mid(self : TimeseriesholtPoint, other : TimeseriesholtPoint) -> TimeseriesholtPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesholtPoint::lerp(self : TimeseriesholtPoint, other : TimeseriesholtPoint, t : Double) -> TimeseriesholtPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesholtPoint::to_string(self : TimeseriesholtPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesholtSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_holt_make_series(vals : Array[Double], name : String) -> TimeseriesholtSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesholtSeries::len(self : TimeseriesholtSeries) -> Int { self.vals.length() }

pub fn TimeseriesholtSeries::sum(self : TimeseriesholtSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesholtSeries::mean(self : TimeseriesholtSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesholtSeries::min(self : TimeseriesholtSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesholtSeries::max(self : TimeseriesholtSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesholtSeries::range(self : TimeseriesholtSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesholtSeries::variance(self : TimeseriesholtSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesholtSeries::std(self : TimeseriesholtSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesholtSeries::median(self : TimeseriesholtSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesholtSeries::scale(self : TimeseriesholtSeries, f : Double) -> TimeseriesholtSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesholtSeries::add(self : TimeseriesholtSeries, other : TimeseriesholtSeries) -> TimeseriesholtSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesholtSeries::sub(self : TimeseriesholtSeries, other : TimeseriesholtSeries) -> TimeseriesholtSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesholtSeries::normalize(self : TimeseriesholtSeries) -> TimeseriesholtSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesholtSeries::cumsum(self : TimeseriesholtSeries) -> TimeseriesholtSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesholtSeries::to_string(self : TimeseriesholtSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesholtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_holt_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesholtMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_holt_matrix_identity(n : Int) -> TimeseriesholtMatrix {
  let m = timeseries_holt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesholtMatrix::get(self : TimeseriesholtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesholtMatrix::transpose(self : TimeseriesholtMatrix) -> TimeseriesholtMatrix {
  let result = timeseries_holt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesholtMatrix::add(self : TimeseriesholtMatrix, other : TimeseriesholtMatrix) -> TimeseriesholtMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_holt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesholtMatrix::scale(self : TimeseriesholtMatrix, s : Double) -> TimeseriesholtMatrix {
  let result = timeseries_holt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesholtMatrix::multiply(self : TimeseriesholtMatrix, other : TimeseriesholtMatrix) -> TimeseriesholtMatrix {
  if self.cols != other.rows { return timeseries_holt_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_holt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesholtMatrix::trace(self : TimeseriesholtMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesholtMatrix::det(self : TimeseriesholtMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesholtMatrix::norm(self : TimeseriesholtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesholtMatrix::to_string(self : TimeseriesholtMatrix) -> String {
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

pub(all) struct TimeseriesholtVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_holt_make_vector(comps : Array[Double]) -> TimeseriesholtVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_holt_vector_zero(dim : Int) -> TimeseriesholtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesholtVector::add(self : TimeseriesholtVector, other : TimeseriesholtVector) -> TimeseriesholtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesholtVector::sub(self : TimeseriesholtVector, other : TimeseriesholtVector) -> TimeseriesholtVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesholtVector::scale(self : TimeseriesholtVector, s : Double) -> TimeseriesholtVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesholtVector::dot(self : TimeseriesholtVector, other : TimeseriesholtVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesholtVector::norm(self : TimeseriesholtVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesholtVector::normalize(self : TimeseriesholtVector) -> TimeseriesholtVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesholtVector::dist(self : TimeseriesholtVector, other : TimeseriesholtVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesholtVector::to_string(self : TimeseriesholtVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_holt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_holt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_holt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_holt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_holt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_holt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_holt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_holt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_holt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_holt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_holt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_holt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_holt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_holt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_holt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_holt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_holt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_holt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_holt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_holt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_holt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_holt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_holt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_holt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_holt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_holt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_holt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_holt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_holt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesholtFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_frame_make(size : Int) -> TimeseriesholtFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_frame_len(s : TimeseriesholtFrame) -> Int { s.size }

pub fn timeseries_holt_frame_get(s : TimeseriesholtFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_frame_set(s : TimeseriesholtFrame, i : Int, v : Double) -> TimeseriesholtFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_sum(s : TimeseriesholtFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_frame_mean(s : TimeseriesholtFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_frame_scale(s : TimeseriesholtFrame, f : Double) -> TimeseriesholtFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_add(a : TimeseriesholtFrame, b : TimeseriesholtFrame) -> TimeseriesholtFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_frame_copy(s : TimeseriesholtFrame) -> TimeseriesholtFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_fill(s : TimeseriesholtFrame, v : Double) -> TimeseriesholtFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_frame_min(s : TimeseriesholtFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_frame_max(s : TimeseriesholtFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_frame_to_string(s : TimeseriesholtFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_table_make(size : Int) -> TimeseriesholtTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_table_len(s : TimeseriesholtTable) -> Int { s.size }

pub fn timeseries_holt_table_get(s : TimeseriesholtTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_table_set(s : TimeseriesholtTable, i : Int, v : Double) -> TimeseriesholtTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_sum(s : TimeseriesholtTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_table_mean(s : TimeseriesholtTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_table_scale(s : TimeseriesholtTable, f : Double) -> TimeseriesholtTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_add(a : TimeseriesholtTable, b : TimeseriesholtTable) -> TimeseriesholtTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_table_copy(s : TimeseriesholtTable) -> TimeseriesholtTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_fill(s : TimeseriesholtTable, v : Double) -> TimeseriesholtTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_table_min(s : TimeseriesholtTable) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_table_max(s : TimeseriesholtTable) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_table_to_string(s : TimeseriesholtTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_graphn_make(size : Int) -> TimeseriesholtGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_graphn_len(s : TimeseriesholtGraphN) -> Int { s.size }

pub fn timeseries_holt_graphn_get(s : TimeseriesholtGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_graphn_set(s : TimeseriesholtGraphN, i : Int, v : Double) -> TimeseriesholtGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_sum(s : TimeseriesholtGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_graphn_mean(s : TimeseriesholtGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_graphn_scale(s : TimeseriesholtGraphN, f : Double) -> TimeseriesholtGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_add(a : TimeseriesholtGraphN, b : TimeseriesholtGraphN) -> TimeseriesholtGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_graphn_copy(s : TimeseriesholtGraphN) -> TimeseriesholtGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_fill(s : TimeseriesholtGraphN, v : Double) -> TimeseriesholtGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_graphn_min(s : TimeseriesholtGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_graphn_max(s : TimeseriesholtGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_graphn_to_string(s : TimeseriesholtGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_node_make(size : Int) -> TimeseriesholtNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_node_len(s : TimeseriesholtNode) -> Int { s.size }

pub fn timeseries_holt_node_get(s : TimeseriesholtNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_node_set(s : TimeseriesholtNode, i : Int, v : Double) -> TimeseriesholtNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_sum(s : TimeseriesholtNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_node_mean(s : TimeseriesholtNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_node_scale(s : TimeseriesholtNode, f : Double) -> TimeseriesholtNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_add(a : TimeseriesholtNode, b : TimeseriesholtNode) -> TimeseriesholtNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_node_copy(s : TimeseriesholtNode) -> TimeseriesholtNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_fill(s : TimeseriesholtNode, v : Double) -> TimeseriesholtNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_node_min(s : TimeseriesholtNode) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_node_max(s : TimeseriesholtNode) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_node_to_string(s : TimeseriesholtNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_edge_make(size : Int) -> TimeseriesholtEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_edge_len(s : TimeseriesholtEdge) -> Int { s.size }

pub fn timeseries_holt_edge_get(s : TimeseriesholtEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_edge_set(s : TimeseriesholtEdge, i : Int, v : Double) -> TimeseriesholtEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_sum(s : TimeseriesholtEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_edge_mean(s : TimeseriesholtEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_edge_scale(s : TimeseriesholtEdge, f : Double) -> TimeseriesholtEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_add(a : TimeseriesholtEdge, b : TimeseriesholtEdge) -> TimeseriesholtEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_edge_copy(s : TimeseriesholtEdge) -> TimeseriesholtEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_fill(s : TimeseriesholtEdge, v : Double) -> TimeseriesholtEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_edge_min(s : TimeseriesholtEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_edge_max(s : TimeseriesholtEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_edge_to_string(s : TimeseriesholtEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_path_make(size : Int) -> TimeseriesholtPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_path_len(s : TimeseriesholtPath) -> Int { s.size }

pub fn timeseries_holt_path_get(s : TimeseriesholtPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_path_set(s : TimeseriesholtPath, i : Int, v : Double) -> TimeseriesholtPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_sum(s : TimeseriesholtPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_path_mean(s : TimeseriesholtPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_path_scale(s : TimeseriesholtPath, f : Double) -> TimeseriesholtPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_add(a : TimeseriesholtPath, b : TimeseriesholtPath) -> TimeseriesholtPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_path_copy(s : TimeseriesholtPath) -> TimeseriesholtPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_fill(s : TimeseriesholtPath, v : Double) -> TimeseriesholtPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_path_min(s : TimeseriesholtPath) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_path_max(s : TimeseriesholtPath) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_path_to_string(s : TimeseriesholtPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_cluster_make(size : Int) -> TimeseriesholtCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_cluster_len(s : TimeseriesholtCluster) -> Int { s.size }

pub fn timeseries_holt_cluster_get(s : TimeseriesholtCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_cluster_set(s : TimeseriesholtCluster, i : Int, v : Double) -> TimeseriesholtCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_sum(s : TimeseriesholtCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_cluster_mean(s : TimeseriesholtCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_cluster_scale(s : TimeseriesholtCluster, f : Double) -> TimeseriesholtCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_add(a : TimeseriesholtCluster, b : TimeseriesholtCluster) -> TimeseriesholtCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_cluster_copy(s : TimeseriesholtCluster) -> TimeseriesholtCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_fill(s : TimeseriesholtCluster, v : Double) -> TimeseriesholtCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cluster_min(s : TimeseriesholtCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_cluster_max(s : TimeseriesholtCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_cluster_to_string(s : TimeseriesholtCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_model_make(size : Int) -> TimeseriesholtModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_model_len(s : TimeseriesholtModel) -> Int { s.size }

pub fn timeseries_holt_model_get(s : TimeseriesholtModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_model_set(s : TimeseriesholtModel, i : Int, v : Double) -> TimeseriesholtModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_sum(s : TimeseriesholtModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_model_mean(s : TimeseriesholtModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_model_scale(s : TimeseriesholtModel, f : Double) -> TimeseriesholtModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_add(a : TimeseriesholtModel, b : TimeseriesholtModel) -> TimeseriesholtModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_model_copy(s : TimeseriesholtModel) -> TimeseriesholtModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_fill(s : TimeseriesholtModel, v : Double) -> TimeseriesholtModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_model_min(s : TimeseriesholtModel) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_model_max(s : TimeseriesholtModel) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_model_to_string(s : TimeseriesholtModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_layer_make(size : Int) -> TimeseriesholtLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_layer_len(s : TimeseriesholtLayer) -> Int { s.size }

pub fn timeseries_holt_layer_get(s : TimeseriesholtLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_layer_set(s : TimeseriesholtLayer, i : Int, v : Double) -> TimeseriesholtLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_sum(s : TimeseriesholtLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_layer_mean(s : TimeseriesholtLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_layer_scale(s : TimeseriesholtLayer, f : Double) -> TimeseriesholtLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_add(a : TimeseriesholtLayer, b : TimeseriesholtLayer) -> TimeseriesholtLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_layer_copy(s : TimeseriesholtLayer) -> TimeseriesholtLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_fill(s : TimeseriesholtLayer, v : Double) -> TimeseriesholtLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_layer_min(s : TimeseriesholtLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_layer_max(s : TimeseriesholtLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_layer_to_string(s : TimeseriesholtLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_buffer_make(size : Int) -> TimeseriesholtBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_buffer_len(s : TimeseriesholtBuffer) -> Int { s.size }

pub fn timeseries_holt_buffer_get(s : TimeseriesholtBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_buffer_set(s : TimeseriesholtBuffer, i : Int, v : Double) -> TimeseriesholtBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_sum(s : TimeseriesholtBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_buffer_mean(s : TimeseriesholtBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_buffer_scale(s : TimeseriesholtBuffer, f : Double) -> TimeseriesholtBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_add(a : TimeseriesholtBuffer, b : TimeseriesholtBuffer) -> TimeseriesholtBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_buffer_copy(s : TimeseriesholtBuffer) -> TimeseriesholtBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_fill(s : TimeseriesholtBuffer, v : Double) -> TimeseriesholtBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_buffer_min(s : TimeseriesholtBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_buffer_max(s : TimeseriesholtBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_buffer_to_string(s : TimeseriesholtBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_cursor_make(size : Int) -> TimeseriesholtCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_cursor_len(s : TimeseriesholtCursor) -> Int { s.size }

pub fn timeseries_holt_cursor_get(s : TimeseriesholtCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_cursor_set(s : TimeseriesholtCursor, i : Int, v : Double) -> TimeseriesholtCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_sum(s : TimeseriesholtCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_cursor_mean(s : TimeseriesholtCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_cursor_scale(s : TimeseriesholtCursor, f : Double) -> TimeseriesholtCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_add(a : TimeseriesholtCursor, b : TimeseriesholtCursor) -> TimeseriesholtCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_cursor_copy(s : TimeseriesholtCursor) -> TimeseriesholtCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_fill(s : TimeseriesholtCursor, v : Double) -> TimeseriesholtCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_cursor_min(s : TimeseriesholtCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_cursor_max(s : TimeseriesholtCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_cursor_to_string(s : TimeseriesholtCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_view_make(size : Int) -> TimeseriesholtView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_view_len(s : TimeseriesholtView) -> Int { s.size }

pub fn timeseries_holt_view_get(s : TimeseriesholtView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_view_set(s : TimeseriesholtView, i : Int, v : Double) -> TimeseriesholtView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_sum(s : TimeseriesholtView) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_view_mean(s : TimeseriesholtView) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_view_scale(s : TimeseriesholtView, f : Double) -> TimeseriesholtView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_add(a : TimeseriesholtView, b : TimeseriesholtView) -> TimeseriesholtView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_view_copy(s : TimeseriesholtView) -> TimeseriesholtView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_fill(s : TimeseriesholtView, v : Double) -> TimeseriesholtView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_view_min(s : TimeseriesholtView) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_view_max(s : TimeseriesholtView) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_view_to_string(s : TimeseriesholtView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_range_make(size : Int) -> TimeseriesholtRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_range_len(s : TimeseriesholtRange) -> Int { s.size }

pub fn timeseries_holt_range_get(s : TimeseriesholtRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_range_set(s : TimeseriesholtRange, i : Int, v : Double) -> TimeseriesholtRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_sum(s : TimeseriesholtRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_range_mean(s : TimeseriesholtRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_range_scale(s : TimeseriesholtRange, f : Double) -> TimeseriesholtRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_add(a : TimeseriesholtRange, b : TimeseriesholtRange) -> TimeseriesholtRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_range_copy(s : TimeseriesholtRange) -> TimeseriesholtRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_fill(s : TimeseriesholtRange, v : Double) -> TimeseriesholtRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_range_min(s : TimeseriesholtRange) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_range_max(s : TimeseriesholtRange) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_range_to_string(s : TimeseriesholtRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesholtSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_holt_slice_make(size : Int) -> TimeseriesholtSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_holt_slice_len(s : TimeseriesholtSlice) -> Int { s.size }

pub fn timeseries_holt_slice_get(s : TimeseriesholtSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_holt_slice_set(s : TimeseriesholtSlice, i : Int, v : Double) -> TimeseriesholtSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_sum(s : TimeseriesholtSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_holt_slice_mean(s : TimeseriesholtSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_holt_slice_scale(s : TimeseriesholtSlice, f : Double) -> TimeseriesholtSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_add(a : TimeseriesholtSlice, b : TimeseriesholtSlice) -> TimeseriesholtSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_holt_slice_copy(s : TimeseriesholtSlice) -> TimeseriesholtSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_fill(s : TimeseriesholtSlice, v : Double) -> TimeseriesholtSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_holt_slice_min(s : TimeseriesholtSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_holt_slice_max(s : TimeseriesholtSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_holt_slice_to_string(s : TimeseriesholtSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

