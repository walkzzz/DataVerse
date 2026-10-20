///===
/// extcore/db_tx_timestamp

pub(all) struct DbtxtimestampPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_timestamp_make_point(x : Double, y : Double) -> DbtxtimestampPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_timestamp_make_point3(x : Double, y : Double, z : Double) -> DbtxtimestampPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxtimestampPoint::x(self : DbtxtimestampPoint) -> Double { self.x }

pub fn DbtxtimestampPoint::y(self : DbtxtimestampPoint) -> Double { self.y }

pub fn DbtxtimestampPoint::z(self : DbtxtimestampPoint) -> Double { self.z }

pub fn DbtxtimestampPoint::label(self : DbtxtimestampPoint) -> Int { self.label }

pub fn DbtxtimestampPoint::dist(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxtimestampPoint::add(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxtimestampPoint::sub(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxtimestampPoint::scale(self : DbtxtimestampPoint, s : Double) -> DbtxtimestampPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxtimestampPoint::dot(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxtimestampPoint::cross(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxtimestampPoint::norm(self : DbtxtimestampPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxtimestampPoint::normalize(self : DbtxtimestampPoint) -> DbtxtimestampPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxtimestampPoint::negate(self : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxtimestampPoint::mid(self : DbtxtimestampPoint, other : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxtimestampPoint::lerp(self : DbtxtimestampPoint, other : DbtxtimestampPoint, t : Double) -> DbtxtimestampPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxtimestampPoint::to_string(self : DbtxtimestampPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxtimestampSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_timestamp_make_series(vals : Array[Double], name : String) -> DbtxtimestampSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxtimestampSeries::len(self : DbtxtimestampSeries) -> Int { self.vals.length() }

pub fn DbtxtimestampSeries::sum(self : DbtxtimestampSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxtimestampSeries::mean(self : DbtxtimestampSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxtimestampSeries::min(self : DbtxtimestampSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxtimestampSeries::max(self : DbtxtimestampSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxtimestampSeries::range(self : DbtxtimestampSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxtimestampSeries::variance(self : DbtxtimestampSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxtimestampSeries::std(self : DbtxtimestampSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxtimestampSeries::median(self : DbtxtimestampSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxtimestampSeries::scale(self : DbtxtimestampSeries, f : Double) -> DbtxtimestampSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxtimestampSeries::add(self : DbtxtimestampSeries, other : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxtimestampSeries::sub(self : DbtxtimestampSeries, other : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxtimestampSeries::normalize(self : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxtimestampSeries::cumsum(self : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxtimestampSeries::to_string(self : DbtxtimestampSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxtimestampMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_timestamp_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxtimestampMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_timestamp_matrix_identity(n : Int) -> DbtxtimestampMatrix {
  let m = db_tx_timestamp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxtimestampMatrix::get(self : DbtxtimestampMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxtimestampMatrix::transpose(self : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxtimestampMatrix::add(self : DbtxtimestampMatrix, other : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_timestamp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxtimestampMatrix::scale(self : DbtxtimestampMatrix, s : Double) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxtimestampMatrix::multiply(self : DbtxtimestampMatrix, other : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if self.cols != other.rows { return db_tx_timestamp_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_timestamp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxtimestampMatrix::trace(self : DbtxtimestampMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxtimestampMatrix::det(self : DbtxtimestampMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxtimestampMatrix::norm(self : DbtxtimestampMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxtimestampMatrix::to_string(self : DbtxtimestampMatrix) -> String {
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

pub(all) struct DbtxtimestampVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_timestamp_make_vector(comps : Array[Double]) -> DbtxtimestampVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_timestamp_vector_zero(dim : Int) -> DbtxtimestampVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxtimestampVector::add(self : DbtxtimestampVector, other : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxtimestampVector::sub(self : DbtxtimestampVector, other : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxtimestampVector::scale(self : DbtxtimestampVector, s : Double) -> DbtxtimestampVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxtimestampVector::dot(self : DbtxtimestampVector, other : DbtxtimestampVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxtimestampVector::norm(self : DbtxtimestampVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxtimestampVector::normalize(self : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxtimestampVector::dist(self : DbtxtimestampVector, other : DbtxtimestampVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxtimestampVector::to_string(self : DbtxtimestampVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_timestamp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_timestamp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_timestamp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_timestamp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_timestamp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_timestamp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_timestamp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_timestamp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_timestamp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_timestamp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_timestamp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_timestamp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_timestamp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_timestamp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_timestamp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_timestamp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_timestamp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_timestamp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_timestamp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_timestamp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_timestamp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_timestamp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_timestamp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_timestamp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_timestamp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_timestamp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_timestamp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_timestamp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_timestamp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxtimestampFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_frame_make(size : Int) -> DbtxtimestampFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_frame_len(s : DbtxtimestampFrame) -> Int { s.size }

pub fn db_tx_timestamp_frame_get(s : DbtxtimestampFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_frame_set(s : DbtxtimestampFrame, i : Int, v : Double) -> DbtxtimestampFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_frame_sum(s : DbtxtimestampFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_frame_mean(s : DbtxtimestampFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_frame_scale(s : DbtxtimestampFrame, f : Double) -> DbtxtimestampFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_frame_add(a : DbtxtimestampFrame, b : DbtxtimestampFrame) -> DbtxtimestampFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_frame_copy(s : DbtxtimestampFrame) -> DbtxtimestampFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_frame_fill(s : DbtxtimestampFrame, v : Double) -> DbtxtimestampFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_frame_min(s : DbtxtimestampFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_frame_max(s : DbtxtimestampFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_frame_to_string(s : DbtxtimestampFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_table_make(size : Int) -> DbtxtimestampTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_table_len(s : DbtxtimestampTable) -> Int { s.size }

pub fn db_tx_timestamp_table_get(s : DbtxtimestampTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_table_set(s : DbtxtimestampTable, i : Int, v : Double) -> DbtxtimestampTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_table_sum(s : DbtxtimestampTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_table_mean(s : DbtxtimestampTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_table_scale(s : DbtxtimestampTable, f : Double) -> DbtxtimestampTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_table_add(a : DbtxtimestampTable, b : DbtxtimestampTable) -> DbtxtimestampTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_table_copy(s : DbtxtimestampTable) -> DbtxtimestampTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_table_fill(s : DbtxtimestampTable, v : Double) -> DbtxtimestampTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_table_min(s : DbtxtimestampTable) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_table_max(s : DbtxtimestampTable) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_table_to_string(s : DbtxtimestampTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_graphn_make(size : Int) -> DbtxtimestampGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_graphn_len(s : DbtxtimestampGraphN) -> Int { s.size }

pub fn db_tx_timestamp_graphn_get(s : DbtxtimestampGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_graphn_set(s : DbtxtimestampGraphN, i : Int, v : Double) -> DbtxtimestampGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_graphn_sum(s : DbtxtimestampGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_graphn_mean(s : DbtxtimestampGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_graphn_scale(s : DbtxtimestampGraphN, f : Double) -> DbtxtimestampGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_graphn_add(a : DbtxtimestampGraphN, b : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_graphn_copy(s : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_graphn_fill(s : DbtxtimestampGraphN, v : Double) -> DbtxtimestampGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_graphn_min(s : DbtxtimestampGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_graphn_max(s : DbtxtimestampGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_graphn_to_string(s : DbtxtimestampGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_node_make(size : Int) -> DbtxtimestampNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_node_len(s : DbtxtimestampNode) -> Int { s.size }

pub fn db_tx_timestamp_node_get(s : DbtxtimestampNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_node_set(s : DbtxtimestampNode, i : Int, v : Double) -> DbtxtimestampNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_node_sum(s : DbtxtimestampNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_node_mean(s : DbtxtimestampNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_node_scale(s : DbtxtimestampNode, f : Double) -> DbtxtimestampNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_node_add(a : DbtxtimestampNode, b : DbtxtimestampNode) -> DbtxtimestampNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_node_copy(s : DbtxtimestampNode) -> DbtxtimestampNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_node_fill(s : DbtxtimestampNode, v : Double) -> DbtxtimestampNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_node_min(s : DbtxtimestampNode) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_node_max(s : DbtxtimestampNode) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_node_to_string(s : DbtxtimestampNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_edge_make(size : Int) -> DbtxtimestampEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_edge_len(s : DbtxtimestampEdge) -> Int { s.size }

pub fn db_tx_timestamp_edge_get(s : DbtxtimestampEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_edge_set(s : DbtxtimestampEdge, i : Int, v : Double) -> DbtxtimestampEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_edge_sum(s : DbtxtimestampEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_edge_mean(s : DbtxtimestampEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_edge_scale(s : DbtxtimestampEdge, f : Double) -> DbtxtimestampEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_edge_add(a : DbtxtimestampEdge, b : DbtxtimestampEdge) -> DbtxtimestampEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_edge_copy(s : DbtxtimestampEdge) -> DbtxtimestampEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_edge_fill(s : DbtxtimestampEdge, v : Double) -> DbtxtimestampEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_edge_min(s : DbtxtimestampEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_edge_max(s : DbtxtimestampEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_edge_to_string(s : DbtxtimestampEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_path_make(size : Int) -> DbtxtimestampPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_path_len(s : DbtxtimestampPath) -> Int { s.size }

pub fn db_tx_timestamp_path_get(s : DbtxtimestampPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_path_set(s : DbtxtimestampPath, i : Int, v : Double) -> DbtxtimestampPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_path_sum(s : DbtxtimestampPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_path_mean(s : DbtxtimestampPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_path_scale(s : DbtxtimestampPath, f : Double) -> DbtxtimestampPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_path_add(a : DbtxtimestampPath, b : DbtxtimestampPath) -> DbtxtimestampPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_path_copy(s : DbtxtimestampPath) -> DbtxtimestampPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_path_fill(s : DbtxtimestampPath, v : Double) -> DbtxtimestampPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_path_min(s : DbtxtimestampPath) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_path_max(s : DbtxtimestampPath) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_path_to_string(s : DbtxtimestampPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cluster_make(size : Int) -> DbtxtimestampCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_cluster_len(s : DbtxtimestampCluster) -> Int { s.size }

pub fn db_tx_timestamp_cluster_get(s : DbtxtimestampCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_cluster_set(s : DbtxtimestampCluster, i : Int, v : Double) -> DbtxtimestampCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cluster_sum(s : DbtxtimestampCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_cluster_mean(s : DbtxtimestampCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_cluster_scale(s : DbtxtimestampCluster, f : Double) -> DbtxtimestampCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cluster_add(a : DbtxtimestampCluster, b : DbtxtimestampCluster) -> DbtxtimestampCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_cluster_copy(s : DbtxtimestampCluster) -> DbtxtimestampCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cluster_fill(s : DbtxtimestampCluster, v : Double) -> DbtxtimestampCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cluster_min(s : DbtxtimestampCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_cluster_max(s : DbtxtimestampCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_cluster_to_string(s : DbtxtimestampCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_model_make(size : Int) -> DbtxtimestampModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_model_len(s : DbtxtimestampModel) -> Int { s.size }

pub fn db_tx_timestamp_model_get(s : DbtxtimestampModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_model_set(s : DbtxtimestampModel, i : Int, v : Double) -> DbtxtimestampModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_model_sum(s : DbtxtimestampModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_model_mean(s : DbtxtimestampModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_model_scale(s : DbtxtimestampModel, f : Double) -> DbtxtimestampModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_model_add(a : DbtxtimestampModel, b : DbtxtimestampModel) -> DbtxtimestampModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_model_copy(s : DbtxtimestampModel) -> DbtxtimestampModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_model_fill(s : DbtxtimestampModel, v : Double) -> DbtxtimestampModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_model_min(s : DbtxtimestampModel) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_model_max(s : DbtxtimestampModel) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_model_to_string(s : DbtxtimestampModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_layer_make(size : Int) -> DbtxtimestampLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_layer_len(s : DbtxtimestampLayer) -> Int { s.size }

pub fn db_tx_timestamp_layer_get(s : DbtxtimestampLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_layer_set(s : DbtxtimestampLayer, i : Int, v : Double) -> DbtxtimestampLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_layer_sum(s : DbtxtimestampLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_layer_mean(s : DbtxtimestampLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_layer_scale(s : DbtxtimestampLayer, f : Double) -> DbtxtimestampLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_layer_add(a : DbtxtimestampLayer, b : DbtxtimestampLayer) -> DbtxtimestampLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_layer_copy(s : DbtxtimestampLayer) -> DbtxtimestampLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_layer_fill(s : DbtxtimestampLayer, v : Double) -> DbtxtimestampLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_layer_min(s : DbtxtimestampLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_layer_max(s : DbtxtimestampLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_layer_to_string(s : DbtxtimestampLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_buffer_make(size : Int) -> DbtxtimestampBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_buffer_len(s : DbtxtimestampBuffer) -> Int { s.size }

pub fn db_tx_timestamp_buffer_get(s : DbtxtimestampBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_buffer_set(s : DbtxtimestampBuffer, i : Int, v : Double) -> DbtxtimestampBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_buffer_sum(s : DbtxtimestampBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_buffer_mean(s : DbtxtimestampBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_buffer_scale(s : DbtxtimestampBuffer, f : Double) -> DbtxtimestampBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_buffer_add(a : DbtxtimestampBuffer, b : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_buffer_copy(s : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_buffer_fill(s : DbtxtimestampBuffer, v : Double) -> DbtxtimestampBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_buffer_min(s : DbtxtimestampBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_buffer_max(s : DbtxtimestampBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_buffer_to_string(s : DbtxtimestampBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cursor_make(size : Int) -> DbtxtimestampCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_cursor_len(s : DbtxtimestampCursor) -> Int { s.size }

pub fn db_tx_timestamp_cursor_get(s : DbtxtimestampCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_cursor_set(s : DbtxtimestampCursor, i : Int, v : Double) -> DbtxtimestampCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cursor_sum(s : DbtxtimestampCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_cursor_mean(s : DbtxtimestampCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_cursor_scale(s : DbtxtimestampCursor, f : Double) -> DbtxtimestampCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cursor_add(a : DbtxtimestampCursor, b : DbtxtimestampCursor) -> DbtxtimestampCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_cursor_copy(s : DbtxtimestampCursor) -> DbtxtimestampCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cursor_fill(s : DbtxtimestampCursor, v : Double) -> DbtxtimestampCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_cursor_min(s : DbtxtimestampCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_cursor_max(s : DbtxtimestampCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_cursor_to_string(s : DbtxtimestampCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_view_make(size : Int) -> DbtxtimestampView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_view_len(s : DbtxtimestampView) -> Int { s.size }

pub fn db_tx_timestamp_view_get(s : DbtxtimestampView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_view_set(s : DbtxtimestampView, i : Int, v : Double) -> DbtxtimestampView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_view_sum(s : DbtxtimestampView) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_view_mean(s : DbtxtimestampView) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_view_scale(s : DbtxtimestampView, f : Double) -> DbtxtimestampView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_view_add(a : DbtxtimestampView, b : DbtxtimestampView) -> DbtxtimestampView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_view_copy(s : DbtxtimestampView) -> DbtxtimestampView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_view_fill(s : DbtxtimestampView, v : Double) -> DbtxtimestampView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_view_min(s : DbtxtimestampView) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_view_max(s : DbtxtimestampView) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_view_to_string(s : DbtxtimestampView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_range_make(size : Int) -> DbtxtimestampRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_range_len(s : DbtxtimestampRange) -> Int { s.size }

pub fn db_tx_timestamp_range_get(s : DbtxtimestampRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_range_set(s : DbtxtimestampRange, i : Int, v : Double) -> DbtxtimestampRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_range_sum(s : DbtxtimestampRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_range_mean(s : DbtxtimestampRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_range_scale(s : DbtxtimestampRange, f : Double) -> DbtxtimestampRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_range_add(a : DbtxtimestampRange, b : DbtxtimestampRange) -> DbtxtimestampRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_range_copy(s : DbtxtimestampRange) -> DbtxtimestampRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_range_fill(s : DbtxtimestampRange, v : Double) -> DbtxtimestampRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_range_min(s : DbtxtimestampRange) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_range_max(s : DbtxtimestampRange) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_range_to_string(s : DbtxtimestampRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_slice_make(size : Int) -> DbtxtimestampSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_slice_len(s : DbtxtimestampSlice) -> Int { s.size }

pub fn db_tx_timestamp_slice_get(s : DbtxtimestampSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_slice_set(s : DbtxtimestampSlice, i : Int, v : Double) -> DbtxtimestampSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_slice_sum(s : DbtxtimestampSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_slice_mean(s : DbtxtimestampSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_slice_scale(s : DbtxtimestampSlice, f : Double) -> DbtxtimestampSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_slice_add(a : DbtxtimestampSlice, b : DbtxtimestampSlice) -> DbtxtimestampSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_timestamp_slice_copy(s : DbtxtimestampSlice) -> DbtxtimestampSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_slice_fill(s : DbtxtimestampSlice, v : Double) -> DbtxtimestampSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_timestamp_slice_min(s : DbtxtimestampSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_slice_max(s : DbtxtimestampSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_slice_to_string(s : DbtxtimestampSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

