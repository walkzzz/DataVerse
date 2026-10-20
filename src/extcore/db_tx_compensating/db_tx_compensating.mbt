///===
/// extcore/db_tx_compensating

pub(all) struct DbtxcompensatingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_compensating_make_point(x : Double, y : Double) -> DbtxcompensatingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_compensating_make_point3(x : Double, y : Double, z : Double) -> DbtxcompensatingPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxcompensatingPoint::x(self : DbtxcompensatingPoint) -> Double { self.x }

pub fn DbtxcompensatingPoint::y(self : DbtxcompensatingPoint) -> Double { self.y }

pub fn DbtxcompensatingPoint::z(self : DbtxcompensatingPoint) -> Double { self.z }

pub fn DbtxcompensatingPoint::label(self : DbtxcompensatingPoint) -> Int { self.label }

pub fn DbtxcompensatingPoint::dist(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxcompensatingPoint::add(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxcompensatingPoint::sub(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxcompensatingPoint::scale(self : DbtxcompensatingPoint, s : Double) -> DbtxcompensatingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxcompensatingPoint::dot(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxcompensatingPoint::cross(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxcompensatingPoint::norm(self : DbtxcompensatingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxcompensatingPoint::normalize(self : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxcompensatingPoint::negate(self : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxcompensatingPoint::mid(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxcompensatingPoint::lerp(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint, t : Double) -> DbtxcompensatingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxcompensatingPoint::to_string(self : DbtxcompensatingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxcompensatingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_compensating_make_series(vals : Array[Double], name : String) -> DbtxcompensatingSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxcompensatingSeries::len(self : DbtxcompensatingSeries) -> Int { self.vals.length() }

pub fn DbtxcompensatingSeries::sum(self : DbtxcompensatingSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxcompensatingSeries::mean(self : DbtxcompensatingSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxcompensatingSeries::min(self : DbtxcompensatingSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxcompensatingSeries::max(self : DbtxcompensatingSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxcompensatingSeries::range(self : DbtxcompensatingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxcompensatingSeries::variance(self : DbtxcompensatingSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxcompensatingSeries::std(self : DbtxcompensatingSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxcompensatingSeries::median(self : DbtxcompensatingSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxcompensatingSeries::scale(self : DbtxcompensatingSeries, f : Double) -> DbtxcompensatingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxcompensatingSeries::add(self : DbtxcompensatingSeries, other : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxcompensatingSeries::sub(self : DbtxcompensatingSeries, other : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxcompensatingSeries::normalize(self : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxcompensatingSeries::cumsum(self : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxcompensatingSeries::to_string(self : DbtxcompensatingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxcompensatingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_compensating_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxcompensatingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_compensating_matrix_identity(n : Int) -> DbtxcompensatingMatrix {
  let m = db_tx_compensating_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxcompensatingMatrix::get(self : DbtxcompensatingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxcompensatingMatrix::transpose(self : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxcompensatingMatrix::add(self : DbtxcompensatingMatrix, other : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_compensating_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxcompensatingMatrix::scale(self : DbtxcompensatingMatrix, s : Double) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxcompensatingMatrix::multiply(self : DbtxcompensatingMatrix, other : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if self.cols != other.rows { return db_tx_compensating_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_compensating_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxcompensatingMatrix::trace(self : DbtxcompensatingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxcompensatingMatrix::det(self : DbtxcompensatingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxcompensatingMatrix::norm(self : DbtxcompensatingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxcompensatingMatrix::to_string(self : DbtxcompensatingMatrix) -> String {
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

pub(all) struct DbtxcompensatingVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_compensating_make_vector(comps : Array[Double]) -> DbtxcompensatingVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_compensating_vector_zero(dim : Int) -> DbtxcompensatingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxcompensatingVector::add(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxcompensatingVector::sub(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxcompensatingVector::scale(self : DbtxcompensatingVector, s : Double) -> DbtxcompensatingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxcompensatingVector::dot(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxcompensatingVector::norm(self : DbtxcompensatingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxcompensatingVector::normalize(self : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxcompensatingVector::dist(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxcompensatingVector::to_string(self : DbtxcompensatingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_compensating_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_compensating_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_compensating_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_compensating_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_compensating_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_compensating_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_compensating_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_compensating_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_compensating_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_compensating_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_compensating_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_compensating_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_compensating_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_compensating_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_compensating_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_compensating_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_compensating_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_compensating_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_compensating_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_compensating_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_compensating_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_compensating_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_compensating_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_compensating_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_compensating_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_compensating_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_compensating_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_compensating_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_compensating_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxcompensatingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_frame_make(size : Int) -> DbtxcompensatingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_frame_len(s : DbtxcompensatingFrame) -> Int { s.size }

pub fn db_tx_compensating_frame_get(s : DbtxcompensatingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_frame_set(s : DbtxcompensatingFrame, i : Int, v : Double) -> DbtxcompensatingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_frame_sum(s : DbtxcompensatingFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_frame_mean(s : DbtxcompensatingFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_frame_scale(s : DbtxcompensatingFrame, f : Double) -> DbtxcompensatingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_frame_add(a : DbtxcompensatingFrame, b : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_frame_copy(s : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_frame_fill(s : DbtxcompensatingFrame, v : Double) -> DbtxcompensatingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_frame_min(s : DbtxcompensatingFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_frame_max(s : DbtxcompensatingFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_frame_to_string(s : DbtxcompensatingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_table_make(size : Int) -> DbtxcompensatingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_table_len(s : DbtxcompensatingTable) -> Int { s.size }

pub fn db_tx_compensating_table_get(s : DbtxcompensatingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_table_set(s : DbtxcompensatingTable, i : Int, v : Double) -> DbtxcompensatingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_table_sum(s : DbtxcompensatingTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_table_mean(s : DbtxcompensatingTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_table_scale(s : DbtxcompensatingTable, f : Double) -> DbtxcompensatingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_table_add(a : DbtxcompensatingTable, b : DbtxcompensatingTable) -> DbtxcompensatingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_table_copy(s : DbtxcompensatingTable) -> DbtxcompensatingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_table_fill(s : DbtxcompensatingTable, v : Double) -> DbtxcompensatingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_table_min(s : DbtxcompensatingTable) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_table_max(s : DbtxcompensatingTable) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_table_to_string(s : DbtxcompensatingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_graphn_make(size : Int) -> DbtxcompensatingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_graphn_len(s : DbtxcompensatingGraphN) -> Int { s.size }

pub fn db_tx_compensating_graphn_get(s : DbtxcompensatingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_graphn_set(s : DbtxcompensatingGraphN, i : Int, v : Double) -> DbtxcompensatingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_graphn_sum(s : DbtxcompensatingGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_graphn_mean(s : DbtxcompensatingGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_graphn_scale(s : DbtxcompensatingGraphN, f : Double) -> DbtxcompensatingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_graphn_add(a : DbtxcompensatingGraphN, b : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_graphn_copy(s : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_graphn_fill(s : DbtxcompensatingGraphN, v : Double) -> DbtxcompensatingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_graphn_min(s : DbtxcompensatingGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_graphn_max(s : DbtxcompensatingGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_graphn_to_string(s : DbtxcompensatingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_node_make(size : Int) -> DbtxcompensatingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_node_len(s : DbtxcompensatingNode) -> Int { s.size }

pub fn db_tx_compensating_node_get(s : DbtxcompensatingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_node_set(s : DbtxcompensatingNode, i : Int, v : Double) -> DbtxcompensatingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_node_sum(s : DbtxcompensatingNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_node_mean(s : DbtxcompensatingNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_node_scale(s : DbtxcompensatingNode, f : Double) -> DbtxcompensatingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_node_add(a : DbtxcompensatingNode, b : DbtxcompensatingNode) -> DbtxcompensatingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_node_copy(s : DbtxcompensatingNode) -> DbtxcompensatingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_node_fill(s : DbtxcompensatingNode, v : Double) -> DbtxcompensatingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_node_min(s : DbtxcompensatingNode) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_node_max(s : DbtxcompensatingNode) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_node_to_string(s : DbtxcompensatingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_edge_make(size : Int) -> DbtxcompensatingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_edge_len(s : DbtxcompensatingEdge) -> Int { s.size }

pub fn db_tx_compensating_edge_get(s : DbtxcompensatingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_edge_set(s : DbtxcompensatingEdge, i : Int, v : Double) -> DbtxcompensatingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_edge_sum(s : DbtxcompensatingEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_edge_mean(s : DbtxcompensatingEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_edge_scale(s : DbtxcompensatingEdge, f : Double) -> DbtxcompensatingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_edge_add(a : DbtxcompensatingEdge, b : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_edge_copy(s : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_edge_fill(s : DbtxcompensatingEdge, v : Double) -> DbtxcompensatingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_edge_min(s : DbtxcompensatingEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_edge_max(s : DbtxcompensatingEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_edge_to_string(s : DbtxcompensatingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_path_make(size : Int) -> DbtxcompensatingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_path_len(s : DbtxcompensatingPath) -> Int { s.size }

pub fn db_tx_compensating_path_get(s : DbtxcompensatingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_path_set(s : DbtxcompensatingPath, i : Int, v : Double) -> DbtxcompensatingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_path_sum(s : DbtxcompensatingPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_path_mean(s : DbtxcompensatingPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_path_scale(s : DbtxcompensatingPath, f : Double) -> DbtxcompensatingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_path_add(a : DbtxcompensatingPath, b : DbtxcompensatingPath) -> DbtxcompensatingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_path_copy(s : DbtxcompensatingPath) -> DbtxcompensatingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_path_fill(s : DbtxcompensatingPath, v : Double) -> DbtxcompensatingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_path_min(s : DbtxcompensatingPath) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_path_max(s : DbtxcompensatingPath) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_path_to_string(s : DbtxcompensatingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cluster_make(size : Int) -> DbtxcompensatingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_cluster_len(s : DbtxcompensatingCluster) -> Int { s.size }

pub fn db_tx_compensating_cluster_get(s : DbtxcompensatingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_cluster_set(s : DbtxcompensatingCluster, i : Int, v : Double) -> DbtxcompensatingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cluster_sum(s : DbtxcompensatingCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_cluster_mean(s : DbtxcompensatingCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_cluster_scale(s : DbtxcompensatingCluster, f : Double) -> DbtxcompensatingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cluster_add(a : DbtxcompensatingCluster, b : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_cluster_copy(s : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cluster_fill(s : DbtxcompensatingCluster, v : Double) -> DbtxcompensatingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cluster_min(s : DbtxcompensatingCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_cluster_max(s : DbtxcompensatingCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_cluster_to_string(s : DbtxcompensatingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_model_make(size : Int) -> DbtxcompensatingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_model_len(s : DbtxcompensatingModel) -> Int { s.size }

pub fn db_tx_compensating_model_get(s : DbtxcompensatingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_model_set(s : DbtxcompensatingModel, i : Int, v : Double) -> DbtxcompensatingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_model_sum(s : DbtxcompensatingModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_model_mean(s : DbtxcompensatingModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_model_scale(s : DbtxcompensatingModel, f : Double) -> DbtxcompensatingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_model_add(a : DbtxcompensatingModel, b : DbtxcompensatingModel) -> DbtxcompensatingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_model_copy(s : DbtxcompensatingModel) -> DbtxcompensatingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_model_fill(s : DbtxcompensatingModel, v : Double) -> DbtxcompensatingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_model_min(s : DbtxcompensatingModel) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_model_max(s : DbtxcompensatingModel) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_model_to_string(s : DbtxcompensatingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_layer_make(size : Int) -> DbtxcompensatingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_layer_len(s : DbtxcompensatingLayer) -> Int { s.size }

pub fn db_tx_compensating_layer_get(s : DbtxcompensatingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_layer_set(s : DbtxcompensatingLayer, i : Int, v : Double) -> DbtxcompensatingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_layer_sum(s : DbtxcompensatingLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_layer_mean(s : DbtxcompensatingLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_layer_scale(s : DbtxcompensatingLayer, f : Double) -> DbtxcompensatingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_layer_add(a : DbtxcompensatingLayer, b : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_layer_copy(s : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_layer_fill(s : DbtxcompensatingLayer, v : Double) -> DbtxcompensatingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_layer_min(s : DbtxcompensatingLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_layer_max(s : DbtxcompensatingLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_layer_to_string(s : DbtxcompensatingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_buffer_make(size : Int) -> DbtxcompensatingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_buffer_len(s : DbtxcompensatingBuffer) -> Int { s.size }

pub fn db_tx_compensating_buffer_get(s : DbtxcompensatingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_buffer_set(s : DbtxcompensatingBuffer, i : Int, v : Double) -> DbtxcompensatingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_buffer_sum(s : DbtxcompensatingBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_buffer_mean(s : DbtxcompensatingBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_buffer_scale(s : DbtxcompensatingBuffer, f : Double) -> DbtxcompensatingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_buffer_add(a : DbtxcompensatingBuffer, b : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_buffer_copy(s : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_buffer_fill(s : DbtxcompensatingBuffer, v : Double) -> DbtxcompensatingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_buffer_min(s : DbtxcompensatingBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_buffer_max(s : DbtxcompensatingBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_buffer_to_string(s : DbtxcompensatingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cursor_make(size : Int) -> DbtxcompensatingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_cursor_len(s : DbtxcompensatingCursor) -> Int { s.size }

pub fn db_tx_compensating_cursor_get(s : DbtxcompensatingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_cursor_set(s : DbtxcompensatingCursor, i : Int, v : Double) -> DbtxcompensatingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cursor_sum(s : DbtxcompensatingCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_cursor_mean(s : DbtxcompensatingCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_cursor_scale(s : DbtxcompensatingCursor, f : Double) -> DbtxcompensatingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cursor_add(a : DbtxcompensatingCursor, b : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_cursor_copy(s : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cursor_fill(s : DbtxcompensatingCursor, v : Double) -> DbtxcompensatingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_cursor_min(s : DbtxcompensatingCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_cursor_max(s : DbtxcompensatingCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_cursor_to_string(s : DbtxcompensatingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_view_make(size : Int) -> DbtxcompensatingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_view_len(s : DbtxcompensatingView) -> Int { s.size }

pub fn db_tx_compensating_view_get(s : DbtxcompensatingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_view_set(s : DbtxcompensatingView, i : Int, v : Double) -> DbtxcompensatingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_view_sum(s : DbtxcompensatingView) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_view_mean(s : DbtxcompensatingView) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_view_scale(s : DbtxcompensatingView, f : Double) -> DbtxcompensatingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_view_add(a : DbtxcompensatingView, b : DbtxcompensatingView) -> DbtxcompensatingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_view_copy(s : DbtxcompensatingView) -> DbtxcompensatingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_view_fill(s : DbtxcompensatingView, v : Double) -> DbtxcompensatingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_view_min(s : DbtxcompensatingView) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_view_max(s : DbtxcompensatingView) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_view_to_string(s : DbtxcompensatingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_range_make(size : Int) -> DbtxcompensatingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_range_len(s : DbtxcompensatingRange) -> Int { s.size }

pub fn db_tx_compensating_range_get(s : DbtxcompensatingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_range_set(s : DbtxcompensatingRange, i : Int, v : Double) -> DbtxcompensatingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_range_sum(s : DbtxcompensatingRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_range_mean(s : DbtxcompensatingRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_range_scale(s : DbtxcompensatingRange, f : Double) -> DbtxcompensatingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_range_add(a : DbtxcompensatingRange, b : DbtxcompensatingRange) -> DbtxcompensatingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_range_copy(s : DbtxcompensatingRange) -> DbtxcompensatingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_range_fill(s : DbtxcompensatingRange, v : Double) -> DbtxcompensatingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_range_min(s : DbtxcompensatingRange) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_range_max(s : DbtxcompensatingRange) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_range_to_string(s : DbtxcompensatingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_slice_make(size : Int) -> DbtxcompensatingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_slice_len(s : DbtxcompensatingSlice) -> Int { s.size }

pub fn db_tx_compensating_slice_get(s : DbtxcompensatingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_slice_set(s : DbtxcompensatingSlice, i : Int, v : Double) -> DbtxcompensatingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_slice_sum(s : DbtxcompensatingSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_slice_mean(s : DbtxcompensatingSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_slice_scale(s : DbtxcompensatingSlice, f : Double) -> DbtxcompensatingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_slice_add(a : DbtxcompensatingSlice, b : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_compensating_slice_copy(s : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_slice_fill(s : DbtxcompensatingSlice, v : Double) -> DbtxcompensatingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_compensating_slice_min(s : DbtxcompensatingSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_slice_max(s : DbtxcompensatingSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_slice_to_string(s : DbtxcompensatingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

