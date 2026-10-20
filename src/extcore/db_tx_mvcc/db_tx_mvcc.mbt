///===
/// extcore/db_tx_mvcc

pub(all) struct DbtxmvccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_mvcc_make_point(x : Double, y : Double) -> DbtxmvccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_mvcc_make_point3(x : Double, y : Double, z : Double) -> DbtxmvccPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxmvccPoint::x(self : DbtxmvccPoint) -> Double { self.x }

pub fn DbtxmvccPoint::y(self : DbtxmvccPoint) -> Double { self.y }

pub fn DbtxmvccPoint::z(self : DbtxmvccPoint) -> Double { self.z }

pub fn DbtxmvccPoint::label(self : DbtxmvccPoint) -> Int { self.label }

pub fn DbtxmvccPoint::dist(self : DbtxmvccPoint, other : DbtxmvccPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxmvccPoint::add(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxmvccPoint::sub(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxmvccPoint::scale(self : DbtxmvccPoint, s : Double) -> DbtxmvccPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxmvccPoint::dot(self : DbtxmvccPoint, other : DbtxmvccPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxmvccPoint::cross(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxmvccPoint::norm(self : DbtxmvccPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxmvccPoint::normalize(self : DbtxmvccPoint) -> DbtxmvccPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxmvccPoint::negate(self : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxmvccPoint::mid(self : DbtxmvccPoint, other : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxmvccPoint::lerp(self : DbtxmvccPoint, other : DbtxmvccPoint, t : Double) -> DbtxmvccPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxmvccPoint::to_string(self : DbtxmvccPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxmvccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_mvcc_make_series(vals : Array[Double], name : String) -> DbtxmvccSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxmvccSeries::len(self : DbtxmvccSeries) -> Int { self.vals.length() }

pub fn DbtxmvccSeries::sum(self : DbtxmvccSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxmvccSeries::mean(self : DbtxmvccSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxmvccSeries::min(self : DbtxmvccSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxmvccSeries::max(self : DbtxmvccSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxmvccSeries::range(self : DbtxmvccSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxmvccSeries::variance(self : DbtxmvccSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxmvccSeries::std(self : DbtxmvccSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxmvccSeries::median(self : DbtxmvccSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxmvccSeries::scale(self : DbtxmvccSeries, f : Double) -> DbtxmvccSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxmvccSeries::add(self : DbtxmvccSeries, other : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxmvccSeries::sub(self : DbtxmvccSeries, other : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxmvccSeries::normalize(self : DbtxmvccSeries) -> DbtxmvccSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxmvccSeries::cumsum(self : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxmvccSeries::to_string(self : DbtxmvccSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxmvccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_mvcc_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxmvccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_mvcc_matrix_identity(n : Int) -> DbtxmvccMatrix {
  let m = db_tx_mvcc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxmvccMatrix::get(self : DbtxmvccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxmvccMatrix::transpose(self : DbtxmvccMatrix) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxmvccMatrix::add(self : DbtxmvccMatrix, other : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_mvcc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxmvccMatrix::scale(self : DbtxmvccMatrix, s : Double) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxmvccMatrix::multiply(self : DbtxmvccMatrix, other : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if self.cols != other.rows { return db_tx_mvcc_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_mvcc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxmvccMatrix::trace(self : DbtxmvccMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxmvccMatrix::det(self : DbtxmvccMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxmvccMatrix::norm(self : DbtxmvccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxmvccMatrix::to_string(self : DbtxmvccMatrix) -> String {
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

pub(all) struct DbtxmvccVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_mvcc_make_vector(comps : Array[Double]) -> DbtxmvccVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_mvcc_vector_zero(dim : Int) -> DbtxmvccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxmvccVector::add(self : DbtxmvccVector, other : DbtxmvccVector) -> DbtxmvccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxmvccVector::sub(self : DbtxmvccVector, other : DbtxmvccVector) -> DbtxmvccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxmvccVector::scale(self : DbtxmvccVector, s : Double) -> DbtxmvccVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxmvccVector::dot(self : DbtxmvccVector, other : DbtxmvccVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxmvccVector::norm(self : DbtxmvccVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxmvccVector::normalize(self : DbtxmvccVector) -> DbtxmvccVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxmvccVector::dist(self : DbtxmvccVector, other : DbtxmvccVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxmvccVector::to_string(self : DbtxmvccVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_mvcc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_mvcc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_mvcc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_mvcc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_mvcc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_mvcc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_mvcc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_mvcc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_mvcc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_mvcc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_mvcc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_mvcc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_mvcc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_mvcc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_mvcc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_mvcc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_mvcc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_mvcc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_mvcc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_mvcc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_mvcc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_mvcc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_mvcc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_mvcc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_mvcc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_mvcc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_mvcc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_mvcc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_mvcc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxmvccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_frame_make(size : Int) -> DbtxmvccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_frame_len(s : DbtxmvccFrame) -> Int { s.size }

pub fn db_tx_mvcc_frame_get(s : DbtxmvccFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_frame_set(s : DbtxmvccFrame, i : Int, v : Double) -> DbtxmvccFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_sum(s : DbtxmvccFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_frame_mean(s : DbtxmvccFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_frame_scale(s : DbtxmvccFrame, f : Double) -> DbtxmvccFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_add(a : DbtxmvccFrame, b : DbtxmvccFrame) -> DbtxmvccFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_frame_copy(s : DbtxmvccFrame) -> DbtxmvccFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_fill(s : DbtxmvccFrame, v : Double) -> DbtxmvccFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_min(s : DbtxmvccFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_frame_max(s : DbtxmvccFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_frame_to_string(s : DbtxmvccFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_table_make(size : Int) -> DbtxmvccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_table_len(s : DbtxmvccTable) -> Int { s.size }

pub fn db_tx_mvcc_table_get(s : DbtxmvccTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_table_set(s : DbtxmvccTable, i : Int, v : Double) -> DbtxmvccTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_sum(s : DbtxmvccTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_table_mean(s : DbtxmvccTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_table_scale(s : DbtxmvccTable, f : Double) -> DbtxmvccTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_add(a : DbtxmvccTable, b : DbtxmvccTable) -> DbtxmvccTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_table_copy(s : DbtxmvccTable) -> DbtxmvccTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_fill(s : DbtxmvccTable, v : Double) -> DbtxmvccTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_min(s : DbtxmvccTable) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_table_max(s : DbtxmvccTable) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_table_to_string(s : DbtxmvccTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_graphn_make(size : Int) -> DbtxmvccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_graphn_len(s : DbtxmvccGraphN) -> Int { s.size }

pub fn db_tx_mvcc_graphn_get(s : DbtxmvccGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_graphn_set(s : DbtxmvccGraphN, i : Int, v : Double) -> DbtxmvccGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_sum(s : DbtxmvccGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_graphn_mean(s : DbtxmvccGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_graphn_scale(s : DbtxmvccGraphN, f : Double) -> DbtxmvccGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_add(a : DbtxmvccGraphN, b : DbtxmvccGraphN) -> DbtxmvccGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_graphn_copy(s : DbtxmvccGraphN) -> DbtxmvccGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_fill(s : DbtxmvccGraphN, v : Double) -> DbtxmvccGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_min(s : DbtxmvccGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_graphn_max(s : DbtxmvccGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_graphn_to_string(s : DbtxmvccGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_node_make(size : Int) -> DbtxmvccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_node_len(s : DbtxmvccNode) -> Int { s.size }

pub fn db_tx_mvcc_node_get(s : DbtxmvccNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_node_set(s : DbtxmvccNode, i : Int, v : Double) -> DbtxmvccNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_sum(s : DbtxmvccNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_node_mean(s : DbtxmvccNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_node_scale(s : DbtxmvccNode, f : Double) -> DbtxmvccNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_add(a : DbtxmvccNode, b : DbtxmvccNode) -> DbtxmvccNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_node_copy(s : DbtxmvccNode) -> DbtxmvccNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_fill(s : DbtxmvccNode, v : Double) -> DbtxmvccNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_min(s : DbtxmvccNode) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_node_max(s : DbtxmvccNode) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_node_to_string(s : DbtxmvccNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_edge_make(size : Int) -> DbtxmvccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_edge_len(s : DbtxmvccEdge) -> Int { s.size }

pub fn db_tx_mvcc_edge_get(s : DbtxmvccEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_edge_set(s : DbtxmvccEdge, i : Int, v : Double) -> DbtxmvccEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_sum(s : DbtxmvccEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_edge_mean(s : DbtxmvccEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_edge_scale(s : DbtxmvccEdge, f : Double) -> DbtxmvccEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_add(a : DbtxmvccEdge, b : DbtxmvccEdge) -> DbtxmvccEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_edge_copy(s : DbtxmvccEdge) -> DbtxmvccEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_fill(s : DbtxmvccEdge, v : Double) -> DbtxmvccEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_min(s : DbtxmvccEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_edge_max(s : DbtxmvccEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_edge_to_string(s : DbtxmvccEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_path_make(size : Int) -> DbtxmvccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_path_len(s : DbtxmvccPath) -> Int { s.size }

pub fn db_tx_mvcc_path_get(s : DbtxmvccPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_path_set(s : DbtxmvccPath, i : Int, v : Double) -> DbtxmvccPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_sum(s : DbtxmvccPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_path_mean(s : DbtxmvccPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_path_scale(s : DbtxmvccPath, f : Double) -> DbtxmvccPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_add(a : DbtxmvccPath, b : DbtxmvccPath) -> DbtxmvccPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_path_copy(s : DbtxmvccPath) -> DbtxmvccPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_fill(s : DbtxmvccPath, v : Double) -> DbtxmvccPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_min(s : DbtxmvccPath) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_path_max(s : DbtxmvccPath) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_path_to_string(s : DbtxmvccPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cluster_make(size : Int) -> DbtxmvccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_cluster_len(s : DbtxmvccCluster) -> Int { s.size }

pub fn db_tx_mvcc_cluster_get(s : DbtxmvccCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_cluster_set(s : DbtxmvccCluster, i : Int, v : Double) -> DbtxmvccCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_sum(s : DbtxmvccCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_cluster_mean(s : DbtxmvccCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_cluster_scale(s : DbtxmvccCluster, f : Double) -> DbtxmvccCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_add(a : DbtxmvccCluster, b : DbtxmvccCluster) -> DbtxmvccCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_cluster_copy(s : DbtxmvccCluster) -> DbtxmvccCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_fill(s : DbtxmvccCluster, v : Double) -> DbtxmvccCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_min(s : DbtxmvccCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_cluster_max(s : DbtxmvccCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_cluster_to_string(s : DbtxmvccCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_model_make(size : Int) -> DbtxmvccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_model_len(s : DbtxmvccModel) -> Int { s.size }

pub fn db_tx_mvcc_model_get(s : DbtxmvccModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_model_set(s : DbtxmvccModel, i : Int, v : Double) -> DbtxmvccModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_sum(s : DbtxmvccModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_model_mean(s : DbtxmvccModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_model_scale(s : DbtxmvccModel, f : Double) -> DbtxmvccModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_add(a : DbtxmvccModel, b : DbtxmvccModel) -> DbtxmvccModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_model_copy(s : DbtxmvccModel) -> DbtxmvccModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_fill(s : DbtxmvccModel, v : Double) -> DbtxmvccModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_min(s : DbtxmvccModel) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_model_max(s : DbtxmvccModel) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_model_to_string(s : DbtxmvccModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_layer_make(size : Int) -> DbtxmvccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_layer_len(s : DbtxmvccLayer) -> Int { s.size }

pub fn db_tx_mvcc_layer_get(s : DbtxmvccLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_layer_set(s : DbtxmvccLayer, i : Int, v : Double) -> DbtxmvccLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_sum(s : DbtxmvccLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_layer_mean(s : DbtxmvccLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_layer_scale(s : DbtxmvccLayer, f : Double) -> DbtxmvccLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_add(a : DbtxmvccLayer, b : DbtxmvccLayer) -> DbtxmvccLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_layer_copy(s : DbtxmvccLayer) -> DbtxmvccLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_fill(s : DbtxmvccLayer, v : Double) -> DbtxmvccLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_min(s : DbtxmvccLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_layer_max(s : DbtxmvccLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_layer_to_string(s : DbtxmvccLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_buffer_make(size : Int) -> DbtxmvccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_buffer_len(s : DbtxmvccBuffer) -> Int { s.size }

pub fn db_tx_mvcc_buffer_get(s : DbtxmvccBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_buffer_set(s : DbtxmvccBuffer, i : Int, v : Double) -> DbtxmvccBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_sum(s : DbtxmvccBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_buffer_mean(s : DbtxmvccBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_buffer_scale(s : DbtxmvccBuffer, f : Double) -> DbtxmvccBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_add(a : DbtxmvccBuffer, b : DbtxmvccBuffer) -> DbtxmvccBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_buffer_copy(s : DbtxmvccBuffer) -> DbtxmvccBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_fill(s : DbtxmvccBuffer, v : Double) -> DbtxmvccBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_min(s : DbtxmvccBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_buffer_max(s : DbtxmvccBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_buffer_to_string(s : DbtxmvccBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cursor_make(size : Int) -> DbtxmvccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_cursor_len(s : DbtxmvccCursor) -> Int { s.size }

pub fn db_tx_mvcc_cursor_get(s : DbtxmvccCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_cursor_set(s : DbtxmvccCursor, i : Int, v : Double) -> DbtxmvccCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_sum(s : DbtxmvccCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_cursor_mean(s : DbtxmvccCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_cursor_scale(s : DbtxmvccCursor, f : Double) -> DbtxmvccCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_add(a : DbtxmvccCursor, b : DbtxmvccCursor) -> DbtxmvccCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_cursor_copy(s : DbtxmvccCursor) -> DbtxmvccCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_fill(s : DbtxmvccCursor, v : Double) -> DbtxmvccCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_min(s : DbtxmvccCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_cursor_max(s : DbtxmvccCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_cursor_to_string(s : DbtxmvccCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_view_make(size : Int) -> DbtxmvccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_view_len(s : DbtxmvccView) -> Int { s.size }

pub fn db_tx_mvcc_view_get(s : DbtxmvccView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_view_set(s : DbtxmvccView, i : Int, v : Double) -> DbtxmvccView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_sum(s : DbtxmvccView) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_view_mean(s : DbtxmvccView) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_view_scale(s : DbtxmvccView, f : Double) -> DbtxmvccView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_add(a : DbtxmvccView, b : DbtxmvccView) -> DbtxmvccView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_view_copy(s : DbtxmvccView) -> DbtxmvccView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_fill(s : DbtxmvccView, v : Double) -> DbtxmvccView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_min(s : DbtxmvccView) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_view_max(s : DbtxmvccView) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_view_to_string(s : DbtxmvccView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_range_make(size : Int) -> DbtxmvccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_range_len(s : DbtxmvccRange) -> Int { s.size }

pub fn db_tx_mvcc_range_get(s : DbtxmvccRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_range_set(s : DbtxmvccRange, i : Int, v : Double) -> DbtxmvccRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_sum(s : DbtxmvccRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_range_mean(s : DbtxmvccRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_range_scale(s : DbtxmvccRange, f : Double) -> DbtxmvccRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_add(a : DbtxmvccRange, b : DbtxmvccRange) -> DbtxmvccRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_range_copy(s : DbtxmvccRange) -> DbtxmvccRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_fill(s : DbtxmvccRange, v : Double) -> DbtxmvccRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_min(s : DbtxmvccRange) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_range_max(s : DbtxmvccRange) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_range_to_string(s : DbtxmvccRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_slice_make(size : Int) -> DbtxmvccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_slice_len(s : DbtxmvccSlice) -> Int { s.size }

pub fn db_tx_mvcc_slice_get(s : DbtxmvccSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_slice_set(s : DbtxmvccSlice, i : Int, v : Double) -> DbtxmvccSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_sum(s : DbtxmvccSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_slice_mean(s : DbtxmvccSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_slice_scale(s : DbtxmvccSlice, f : Double) -> DbtxmvccSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_add(a : DbtxmvccSlice, b : DbtxmvccSlice) -> DbtxmvccSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_slice_copy(s : DbtxmvccSlice) -> DbtxmvccSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_fill(s : DbtxmvccSlice, v : Double) -> DbtxmvccSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_min(s : DbtxmvccSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_slice_max(s : DbtxmvccSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_slice_to_string(s : DbtxmvccSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

