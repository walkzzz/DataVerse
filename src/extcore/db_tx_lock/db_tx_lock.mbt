///===
/// extcore/db_tx_lock

pub(all) struct DbtxlockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_lock_make_point(x : Double, y : Double) -> DbtxlockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_lock_make_point3(x : Double, y : Double, z : Double) -> DbtxlockPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxlockPoint::x(self : DbtxlockPoint) -> Double { self.x }

pub fn DbtxlockPoint::y(self : DbtxlockPoint) -> Double { self.y }

pub fn DbtxlockPoint::z(self : DbtxlockPoint) -> Double { self.z }

pub fn DbtxlockPoint::label(self : DbtxlockPoint) -> Int { self.label }

pub fn DbtxlockPoint::dist(self : DbtxlockPoint, other : DbtxlockPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxlockPoint::add(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxlockPoint::sub(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxlockPoint::scale(self : DbtxlockPoint, s : Double) -> DbtxlockPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxlockPoint::dot(self : DbtxlockPoint, other : DbtxlockPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxlockPoint::cross(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxlockPoint::norm(self : DbtxlockPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxlockPoint::normalize(self : DbtxlockPoint) -> DbtxlockPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxlockPoint::negate(self : DbtxlockPoint) -> DbtxlockPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxlockPoint::mid(self : DbtxlockPoint, other : DbtxlockPoint) -> DbtxlockPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxlockPoint::lerp(self : DbtxlockPoint, other : DbtxlockPoint, t : Double) -> DbtxlockPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxlockPoint::to_string(self : DbtxlockPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxlockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_lock_make_series(vals : Array[Double], name : String) -> DbtxlockSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxlockSeries::len(self : DbtxlockSeries) -> Int { self.vals.length() }

pub fn DbtxlockSeries::sum(self : DbtxlockSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxlockSeries::mean(self : DbtxlockSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxlockSeries::min(self : DbtxlockSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxlockSeries::max(self : DbtxlockSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxlockSeries::range(self : DbtxlockSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxlockSeries::variance(self : DbtxlockSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxlockSeries::std(self : DbtxlockSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxlockSeries::median(self : DbtxlockSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxlockSeries::scale(self : DbtxlockSeries, f : Double) -> DbtxlockSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxlockSeries::add(self : DbtxlockSeries, other : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxlockSeries::sub(self : DbtxlockSeries, other : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxlockSeries::normalize(self : DbtxlockSeries) -> DbtxlockSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxlockSeries::cumsum(self : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxlockSeries::to_string(self : DbtxlockSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxlockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_lock_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxlockMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_lock_matrix_identity(n : Int) -> DbtxlockMatrix {
  let m = db_tx_lock_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxlockMatrix::get(self : DbtxlockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxlockMatrix::transpose(self : DbtxlockMatrix) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxlockMatrix::add(self : DbtxlockMatrix, other : DbtxlockMatrix) -> DbtxlockMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_lock_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxlockMatrix::scale(self : DbtxlockMatrix, s : Double) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxlockMatrix::multiply(self : DbtxlockMatrix, other : DbtxlockMatrix) -> DbtxlockMatrix {
  if self.cols != other.rows { return db_tx_lock_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_lock_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxlockMatrix::trace(self : DbtxlockMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxlockMatrix::det(self : DbtxlockMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxlockMatrix::norm(self : DbtxlockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxlockMatrix::to_string(self : DbtxlockMatrix) -> String {
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

pub(all) struct DbtxlockVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_lock_make_vector(comps : Array[Double]) -> DbtxlockVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_lock_vector_zero(dim : Int) -> DbtxlockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxlockVector::add(self : DbtxlockVector, other : DbtxlockVector) -> DbtxlockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxlockVector::sub(self : DbtxlockVector, other : DbtxlockVector) -> DbtxlockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxlockVector::scale(self : DbtxlockVector, s : Double) -> DbtxlockVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxlockVector::dot(self : DbtxlockVector, other : DbtxlockVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxlockVector::norm(self : DbtxlockVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxlockVector::normalize(self : DbtxlockVector) -> DbtxlockVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxlockVector::dist(self : DbtxlockVector, other : DbtxlockVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxlockVector::to_string(self : DbtxlockVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_lock_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_lock_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_lock_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_lock_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_lock_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_lock_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_lock_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_lock_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_lock_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_lock_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_lock_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_lock_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_lock_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_lock_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_lock_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_lock_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_lock_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_lock_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_lock_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_lock_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_lock_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_lock_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_lock_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_lock_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_lock_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_lock_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_lock_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_lock_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_lock_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxlockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_frame_make(size : Int) -> DbtxlockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_frame_len(s : DbtxlockFrame) -> Int { s.size }

pub fn db_tx_lock_frame_get(s : DbtxlockFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_frame_set(s : DbtxlockFrame, i : Int, v : Double) -> DbtxlockFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_sum(s : DbtxlockFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_frame_mean(s : DbtxlockFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_frame_scale(s : DbtxlockFrame, f : Double) -> DbtxlockFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_add(a : DbtxlockFrame, b : DbtxlockFrame) -> DbtxlockFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_frame_copy(s : DbtxlockFrame) -> DbtxlockFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_fill(s : DbtxlockFrame, v : Double) -> DbtxlockFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_min(s : DbtxlockFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_frame_max(s : DbtxlockFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_frame_to_string(s : DbtxlockFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_table_make(size : Int) -> DbtxlockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_table_len(s : DbtxlockTable) -> Int { s.size }

pub fn db_tx_lock_table_get(s : DbtxlockTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_table_set(s : DbtxlockTable, i : Int, v : Double) -> DbtxlockTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_sum(s : DbtxlockTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_table_mean(s : DbtxlockTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_table_scale(s : DbtxlockTable, f : Double) -> DbtxlockTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_add(a : DbtxlockTable, b : DbtxlockTable) -> DbtxlockTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_table_copy(s : DbtxlockTable) -> DbtxlockTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_fill(s : DbtxlockTable, v : Double) -> DbtxlockTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_min(s : DbtxlockTable) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_table_max(s : DbtxlockTable) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_table_to_string(s : DbtxlockTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_graphn_make(size : Int) -> DbtxlockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_graphn_len(s : DbtxlockGraphN) -> Int { s.size }

pub fn db_tx_lock_graphn_get(s : DbtxlockGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_graphn_set(s : DbtxlockGraphN, i : Int, v : Double) -> DbtxlockGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_sum(s : DbtxlockGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_graphn_mean(s : DbtxlockGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_graphn_scale(s : DbtxlockGraphN, f : Double) -> DbtxlockGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_add(a : DbtxlockGraphN, b : DbtxlockGraphN) -> DbtxlockGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_graphn_copy(s : DbtxlockGraphN) -> DbtxlockGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_fill(s : DbtxlockGraphN, v : Double) -> DbtxlockGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_min(s : DbtxlockGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_graphn_max(s : DbtxlockGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_graphn_to_string(s : DbtxlockGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_node_make(size : Int) -> DbtxlockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_node_len(s : DbtxlockNode) -> Int { s.size }

pub fn db_tx_lock_node_get(s : DbtxlockNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_node_set(s : DbtxlockNode, i : Int, v : Double) -> DbtxlockNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_sum(s : DbtxlockNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_node_mean(s : DbtxlockNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_node_scale(s : DbtxlockNode, f : Double) -> DbtxlockNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_add(a : DbtxlockNode, b : DbtxlockNode) -> DbtxlockNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_node_copy(s : DbtxlockNode) -> DbtxlockNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_fill(s : DbtxlockNode, v : Double) -> DbtxlockNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_min(s : DbtxlockNode) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_node_max(s : DbtxlockNode) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_node_to_string(s : DbtxlockNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_edge_make(size : Int) -> DbtxlockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_edge_len(s : DbtxlockEdge) -> Int { s.size }

pub fn db_tx_lock_edge_get(s : DbtxlockEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_edge_set(s : DbtxlockEdge, i : Int, v : Double) -> DbtxlockEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_sum(s : DbtxlockEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_edge_mean(s : DbtxlockEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_edge_scale(s : DbtxlockEdge, f : Double) -> DbtxlockEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_add(a : DbtxlockEdge, b : DbtxlockEdge) -> DbtxlockEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_edge_copy(s : DbtxlockEdge) -> DbtxlockEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_fill(s : DbtxlockEdge, v : Double) -> DbtxlockEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_min(s : DbtxlockEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_edge_max(s : DbtxlockEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_edge_to_string(s : DbtxlockEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_path_make(size : Int) -> DbtxlockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_path_len(s : DbtxlockPath) -> Int { s.size }

pub fn db_tx_lock_path_get(s : DbtxlockPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_path_set(s : DbtxlockPath, i : Int, v : Double) -> DbtxlockPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_sum(s : DbtxlockPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_path_mean(s : DbtxlockPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_path_scale(s : DbtxlockPath, f : Double) -> DbtxlockPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_add(a : DbtxlockPath, b : DbtxlockPath) -> DbtxlockPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_path_copy(s : DbtxlockPath) -> DbtxlockPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_fill(s : DbtxlockPath, v : Double) -> DbtxlockPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_min(s : DbtxlockPath) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_path_max(s : DbtxlockPath) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_path_to_string(s : DbtxlockPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cluster_make(size : Int) -> DbtxlockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_cluster_len(s : DbtxlockCluster) -> Int { s.size }

pub fn db_tx_lock_cluster_get(s : DbtxlockCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_cluster_set(s : DbtxlockCluster, i : Int, v : Double) -> DbtxlockCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_sum(s : DbtxlockCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_cluster_mean(s : DbtxlockCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_cluster_scale(s : DbtxlockCluster, f : Double) -> DbtxlockCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_add(a : DbtxlockCluster, b : DbtxlockCluster) -> DbtxlockCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_cluster_copy(s : DbtxlockCluster) -> DbtxlockCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_fill(s : DbtxlockCluster, v : Double) -> DbtxlockCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_min(s : DbtxlockCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_cluster_max(s : DbtxlockCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_cluster_to_string(s : DbtxlockCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_model_make(size : Int) -> DbtxlockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_model_len(s : DbtxlockModel) -> Int { s.size }

pub fn db_tx_lock_model_get(s : DbtxlockModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_model_set(s : DbtxlockModel, i : Int, v : Double) -> DbtxlockModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_sum(s : DbtxlockModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_model_mean(s : DbtxlockModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_model_scale(s : DbtxlockModel, f : Double) -> DbtxlockModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_add(a : DbtxlockModel, b : DbtxlockModel) -> DbtxlockModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_model_copy(s : DbtxlockModel) -> DbtxlockModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_fill(s : DbtxlockModel, v : Double) -> DbtxlockModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_min(s : DbtxlockModel) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_model_max(s : DbtxlockModel) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_model_to_string(s : DbtxlockModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_layer_make(size : Int) -> DbtxlockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_layer_len(s : DbtxlockLayer) -> Int { s.size }

pub fn db_tx_lock_layer_get(s : DbtxlockLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_layer_set(s : DbtxlockLayer, i : Int, v : Double) -> DbtxlockLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_sum(s : DbtxlockLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_layer_mean(s : DbtxlockLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_layer_scale(s : DbtxlockLayer, f : Double) -> DbtxlockLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_add(a : DbtxlockLayer, b : DbtxlockLayer) -> DbtxlockLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_layer_copy(s : DbtxlockLayer) -> DbtxlockLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_fill(s : DbtxlockLayer, v : Double) -> DbtxlockLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_min(s : DbtxlockLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_layer_max(s : DbtxlockLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_layer_to_string(s : DbtxlockLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_buffer_make(size : Int) -> DbtxlockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_buffer_len(s : DbtxlockBuffer) -> Int { s.size }

pub fn db_tx_lock_buffer_get(s : DbtxlockBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_buffer_set(s : DbtxlockBuffer, i : Int, v : Double) -> DbtxlockBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_sum(s : DbtxlockBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_buffer_mean(s : DbtxlockBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_buffer_scale(s : DbtxlockBuffer, f : Double) -> DbtxlockBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_add(a : DbtxlockBuffer, b : DbtxlockBuffer) -> DbtxlockBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_buffer_copy(s : DbtxlockBuffer) -> DbtxlockBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_fill(s : DbtxlockBuffer, v : Double) -> DbtxlockBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_min(s : DbtxlockBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_buffer_max(s : DbtxlockBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_buffer_to_string(s : DbtxlockBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cursor_make(size : Int) -> DbtxlockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_cursor_len(s : DbtxlockCursor) -> Int { s.size }

pub fn db_tx_lock_cursor_get(s : DbtxlockCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_cursor_set(s : DbtxlockCursor, i : Int, v : Double) -> DbtxlockCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_sum(s : DbtxlockCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_cursor_mean(s : DbtxlockCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_cursor_scale(s : DbtxlockCursor, f : Double) -> DbtxlockCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_add(a : DbtxlockCursor, b : DbtxlockCursor) -> DbtxlockCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_cursor_copy(s : DbtxlockCursor) -> DbtxlockCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_fill(s : DbtxlockCursor, v : Double) -> DbtxlockCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_min(s : DbtxlockCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_cursor_max(s : DbtxlockCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_cursor_to_string(s : DbtxlockCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_view_make(size : Int) -> DbtxlockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_view_len(s : DbtxlockView) -> Int { s.size }

pub fn db_tx_lock_view_get(s : DbtxlockView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_view_set(s : DbtxlockView, i : Int, v : Double) -> DbtxlockView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_sum(s : DbtxlockView) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_view_mean(s : DbtxlockView) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_view_scale(s : DbtxlockView, f : Double) -> DbtxlockView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_add(a : DbtxlockView, b : DbtxlockView) -> DbtxlockView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_view_copy(s : DbtxlockView) -> DbtxlockView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_fill(s : DbtxlockView, v : Double) -> DbtxlockView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_min(s : DbtxlockView) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_view_max(s : DbtxlockView) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_view_to_string(s : DbtxlockView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_range_make(size : Int) -> DbtxlockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_range_len(s : DbtxlockRange) -> Int { s.size }

pub fn db_tx_lock_range_get(s : DbtxlockRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_range_set(s : DbtxlockRange, i : Int, v : Double) -> DbtxlockRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_sum(s : DbtxlockRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_range_mean(s : DbtxlockRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_range_scale(s : DbtxlockRange, f : Double) -> DbtxlockRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_add(a : DbtxlockRange, b : DbtxlockRange) -> DbtxlockRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_range_copy(s : DbtxlockRange) -> DbtxlockRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_fill(s : DbtxlockRange, v : Double) -> DbtxlockRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_min(s : DbtxlockRange) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_range_max(s : DbtxlockRange) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_range_to_string(s : DbtxlockRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_slice_make(size : Int) -> DbtxlockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_slice_len(s : DbtxlockSlice) -> Int { s.size }

pub fn db_tx_lock_slice_get(s : DbtxlockSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_slice_set(s : DbtxlockSlice, i : Int, v : Double) -> DbtxlockSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_sum(s : DbtxlockSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_slice_mean(s : DbtxlockSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_slice_scale(s : DbtxlockSlice, f : Double) -> DbtxlockSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_add(a : DbtxlockSlice, b : DbtxlockSlice) -> DbtxlockSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_slice_copy(s : DbtxlockSlice) -> DbtxlockSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_fill(s : DbtxlockSlice, v : Double) -> DbtxlockSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_min(s : DbtxlockSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_slice_max(s : DbtxlockSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_slice_to_string(s : DbtxlockSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

