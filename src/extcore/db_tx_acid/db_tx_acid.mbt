///===
/// extcore/db_tx_acid

pub(all) struct DbtxacidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_acid_make_point(x : Double, y : Double) -> DbtxacidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_acid_make_point3(x : Double, y : Double, z : Double) -> DbtxacidPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxacidPoint::x(self : DbtxacidPoint) -> Double { self.x }

pub fn DbtxacidPoint::y(self : DbtxacidPoint) -> Double { self.y }

pub fn DbtxacidPoint::z(self : DbtxacidPoint) -> Double { self.z }

pub fn DbtxacidPoint::label(self : DbtxacidPoint) -> Int { self.label }

pub fn DbtxacidPoint::dist(self : DbtxacidPoint, other : DbtxacidPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxacidPoint::add(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxacidPoint::sub(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxacidPoint::scale(self : DbtxacidPoint, s : Double) -> DbtxacidPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxacidPoint::dot(self : DbtxacidPoint, other : DbtxacidPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxacidPoint::cross(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxacidPoint::norm(self : DbtxacidPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxacidPoint::normalize(self : DbtxacidPoint) -> DbtxacidPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxacidPoint::negate(self : DbtxacidPoint) -> DbtxacidPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxacidPoint::mid(self : DbtxacidPoint, other : DbtxacidPoint) -> DbtxacidPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxacidPoint::lerp(self : DbtxacidPoint, other : DbtxacidPoint, t : Double) -> DbtxacidPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxacidPoint::to_string(self : DbtxacidPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxacidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_acid_make_series(vals : Array[Double], name : String) -> DbtxacidSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxacidSeries::len(self : DbtxacidSeries) -> Int { self.vals.length() }

pub fn DbtxacidSeries::sum(self : DbtxacidSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxacidSeries::mean(self : DbtxacidSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxacidSeries::min(self : DbtxacidSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxacidSeries::max(self : DbtxacidSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxacidSeries::range(self : DbtxacidSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxacidSeries::variance(self : DbtxacidSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxacidSeries::std(self : DbtxacidSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxacidSeries::median(self : DbtxacidSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxacidSeries::scale(self : DbtxacidSeries, f : Double) -> DbtxacidSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxacidSeries::add(self : DbtxacidSeries, other : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxacidSeries::sub(self : DbtxacidSeries, other : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxacidSeries::normalize(self : DbtxacidSeries) -> DbtxacidSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxacidSeries::cumsum(self : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxacidSeries::to_string(self : DbtxacidSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxacidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_acid_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxacidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_acid_matrix_identity(n : Int) -> DbtxacidMatrix {
  let m = db_tx_acid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxacidMatrix::get(self : DbtxacidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxacidMatrix::transpose(self : DbtxacidMatrix) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxacidMatrix::add(self : DbtxacidMatrix, other : DbtxacidMatrix) -> DbtxacidMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_acid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxacidMatrix::scale(self : DbtxacidMatrix, s : Double) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxacidMatrix::multiply(self : DbtxacidMatrix, other : DbtxacidMatrix) -> DbtxacidMatrix {
  if self.cols != other.rows { return db_tx_acid_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_acid_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxacidMatrix::trace(self : DbtxacidMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxacidMatrix::det(self : DbtxacidMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxacidMatrix::norm(self : DbtxacidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxacidMatrix::to_string(self : DbtxacidMatrix) -> String {
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

pub(all) struct DbtxacidVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_acid_make_vector(comps : Array[Double]) -> DbtxacidVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_acid_vector_zero(dim : Int) -> DbtxacidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxacidVector::add(self : DbtxacidVector, other : DbtxacidVector) -> DbtxacidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxacidVector::sub(self : DbtxacidVector, other : DbtxacidVector) -> DbtxacidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxacidVector::scale(self : DbtxacidVector, s : Double) -> DbtxacidVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxacidVector::dot(self : DbtxacidVector, other : DbtxacidVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxacidVector::norm(self : DbtxacidVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxacidVector::normalize(self : DbtxacidVector) -> DbtxacidVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxacidVector::dist(self : DbtxacidVector, other : DbtxacidVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxacidVector::to_string(self : DbtxacidVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_acid_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_acid_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_acid_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_acid_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_acid_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_acid_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_acid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_acid_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_acid_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_acid_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_acid_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_acid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_acid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_acid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_acid_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_acid_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_acid_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_acid_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_acid_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_acid_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_acid_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_acid_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_acid_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_acid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_acid_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_acid_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_acid_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_acid_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_acid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxacidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_frame_make(size : Int) -> DbtxacidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_frame_len(s : DbtxacidFrame) -> Int { s.size }

pub fn db_tx_acid_frame_get(s : DbtxacidFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_frame_set(s : DbtxacidFrame, i : Int, v : Double) -> DbtxacidFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_sum(s : DbtxacidFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_frame_mean(s : DbtxacidFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_frame_scale(s : DbtxacidFrame, f : Double) -> DbtxacidFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_add(a : DbtxacidFrame, b : DbtxacidFrame) -> DbtxacidFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_frame_copy(s : DbtxacidFrame) -> DbtxacidFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_fill(s : DbtxacidFrame, v : Double) -> DbtxacidFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_min(s : DbtxacidFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_frame_max(s : DbtxacidFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_frame_to_string(s : DbtxacidFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_table_make(size : Int) -> DbtxacidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_table_len(s : DbtxacidTable) -> Int { s.size }

pub fn db_tx_acid_table_get(s : DbtxacidTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_table_set(s : DbtxacidTable, i : Int, v : Double) -> DbtxacidTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_sum(s : DbtxacidTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_table_mean(s : DbtxacidTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_table_scale(s : DbtxacidTable, f : Double) -> DbtxacidTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_add(a : DbtxacidTable, b : DbtxacidTable) -> DbtxacidTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_table_copy(s : DbtxacidTable) -> DbtxacidTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_fill(s : DbtxacidTable, v : Double) -> DbtxacidTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_min(s : DbtxacidTable) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_table_max(s : DbtxacidTable) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_table_to_string(s : DbtxacidTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_graphn_make(size : Int) -> DbtxacidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_graphn_len(s : DbtxacidGraphN) -> Int { s.size }

pub fn db_tx_acid_graphn_get(s : DbtxacidGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_graphn_set(s : DbtxacidGraphN, i : Int, v : Double) -> DbtxacidGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_sum(s : DbtxacidGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_graphn_mean(s : DbtxacidGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_graphn_scale(s : DbtxacidGraphN, f : Double) -> DbtxacidGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_add(a : DbtxacidGraphN, b : DbtxacidGraphN) -> DbtxacidGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_graphn_copy(s : DbtxacidGraphN) -> DbtxacidGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_fill(s : DbtxacidGraphN, v : Double) -> DbtxacidGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_min(s : DbtxacidGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_graphn_max(s : DbtxacidGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_graphn_to_string(s : DbtxacidGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_node_make(size : Int) -> DbtxacidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_node_len(s : DbtxacidNode) -> Int { s.size }

pub fn db_tx_acid_node_get(s : DbtxacidNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_node_set(s : DbtxacidNode, i : Int, v : Double) -> DbtxacidNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_sum(s : DbtxacidNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_node_mean(s : DbtxacidNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_node_scale(s : DbtxacidNode, f : Double) -> DbtxacidNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_add(a : DbtxacidNode, b : DbtxacidNode) -> DbtxacidNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_node_copy(s : DbtxacidNode) -> DbtxacidNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_fill(s : DbtxacidNode, v : Double) -> DbtxacidNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_min(s : DbtxacidNode) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_node_max(s : DbtxacidNode) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_node_to_string(s : DbtxacidNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_edge_make(size : Int) -> DbtxacidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_edge_len(s : DbtxacidEdge) -> Int { s.size }

pub fn db_tx_acid_edge_get(s : DbtxacidEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_edge_set(s : DbtxacidEdge, i : Int, v : Double) -> DbtxacidEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_sum(s : DbtxacidEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_edge_mean(s : DbtxacidEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_edge_scale(s : DbtxacidEdge, f : Double) -> DbtxacidEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_add(a : DbtxacidEdge, b : DbtxacidEdge) -> DbtxacidEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_edge_copy(s : DbtxacidEdge) -> DbtxacidEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_fill(s : DbtxacidEdge, v : Double) -> DbtxacidEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_min(s : DbtxacidEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_edge_max(s : DbtxacidEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_edge_to_string(s : DbtxacidEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_path_make(size : Int) -> DbtxacidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_path_len(s : DbtxacidPath) -> Int { s.size }

pub fn db_tx_acid_path_get(s : DbtxacidPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_path_set(s : DbtxacidPath, i : Int, v : Double) -> DbtxacidPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_sum(s : DbtxacidPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_path_mean(s : DbtxacidPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_path_scale(s : DbtxacidPath, f : Double) -> DbtxacidPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_add(a : DbtxacidPath, b : DbtxacidPath) -> DbtxacidPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_path_copy(s : DbtxacidPath) -> DbtxacidPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_fill(s : DbtxacidPath, v : Double) -> DbtxacidPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_min(s : DbtxacidPath) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_path_max(s : DbtxacidPath) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_path_to_string(s : DbtxacidPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cluster_make(size : Int) -> DbtxacidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_cluster_len(s : DbtxacidCluster) -> Int { s.size }

pub fn db_tx_acid_cluster_get(s : DbtxacidCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_cluster_set(s : DbtxacidCluster, i : Int, v : Double) -> DbtxacidCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_sum(s : DbtxacidCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_cluster_mean(s : DbtxacidCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_cluster_scale(s : DbtxacidCluster, f : Double) -> DbtxacidCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_add(a : DbtxacidCluster, b : DbtxacidCluster) -> DbtxacidCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_cluster_copy(s : DbtxacidCluster) -> DbtxacidCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_fill(s : DbtxacidCluster, v : Double) -> DbtxacidCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_min(s : DbtxacidCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_cluster_max(s : DbtxacidCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_cluster_to_string(s : DbtxacidCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_model_make(size : Int) -> DbtxacidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_model_len(s : DbtxacidModel) -> Int { s.size }

pub fn db_tx_acid_model_get(s : DbtxacidModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_model_set(s : DbtxacidModel, i : Int, v : Double) -> DbtxacidModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_sum(s : DbtxacidModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_model_mean(s : DbtxacidModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_model_scale(s : DbtxacidModel, f : Double) -> DbtxacidModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_add(a : DbtxacidModel, b : DbtxacidModel) -> DbtxacidModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_model_copy(s : DbtxacidModel) -> DbtxacidModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_fill(s : DbtxacidModel, v : Double) -> DbtxacidModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_min(s : DbtxacidModel) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_model_max(s : DbtxacidModel) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_model_to_string(s : DbtxacidModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_layer_make(size : Int) -> DbtxacidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_layer_len(s : DbtxacidLayer) -> Int { s.size }

pub fn db_tx_acid_layer_get(s : DbtxacidLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_layer_set(s : DbtxacidLayer, i : Int, v : Double) -> DbtxacidLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_sum(s : DbtxacidLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_layer_mean(s : DbtxacidLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_layer_scale(s : DbtxacidLayer, f : Double) -> DbtxacidLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_add(a : DbtxacidLayer, b : DbtxacidLayer) -> DbtxacidLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_layer_copy(s : DbtxacidLayer) -> DbtxacidLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_fill(s : DbtxacidLayer, v : Double) -> DbtxacidLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_min(s : DbtxacidLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_layer_max(s : DbtxacidLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_layer_to_string(s : DbtxacidLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_buffer_make(size : Int) -> DbtxacidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_buffer_len(s : DbtxacidBuffer) -> Int { s.size }

pub fn db_tx_acid_buffer_get(s : DbtxacidBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_buffer_set(s : DbtxacidBuffer, i : Int, v : Double) -> DbtxacidBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_sum(s : DbtxacidBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_buffer_mean(s : DbtxacidBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_buffer_scale(s : DbtxacidBuffer, f : Double) -> DbtxacidBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_add(a : DbtxacidBuffer, b : DbtxacidBuffer) -> DbtxacidBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_buffer_copy(s : DbtxacidBuffer) -> DbtxacidBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_fill(s : DbtxacidBuffer, v : Double) -> DbtxacidBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_min(s : DbtxacidBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_buffer_max(s : DbtxacidBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_buffer_to_string(s : DbtxacidBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cursor_make(size : Int) -> DbtxacidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_cursor_len(s : DbtxacidCursor) -> Int { s.size }

pub fn db_tx_acid_cursor_get(s : DbtxacidCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_cursor_set(s : DbtxacidCursor, i : Int, v : Double) -> DbtxacidCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_sum(s : DbtxacidCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_cursor_mean(s : DbtxacidCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_cursor_scale(s : DbtxacidCursor, f : Double) -> DbtxacidCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_add(a : DbtxacidCursor, b : DbtxacidCursor) -> DbtxacidCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_cursor_copy(s : DbtxacidCursor) -> DbtxacidCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_fill(s : DbtxacidCursor, v : Double) -> DbtxacidCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_min(s : DbtxacidCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_cursor_max(s : DbtxacidCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_cursor_to_string(s : DbtxacidCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_view_make(size : Int) -> DbtxacidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_view_len(s : DbtxacidView) -> Int { s.size }

pub fn db_tx_acid_view_get(s : DbtxacidView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_view_set(s : DbtxacidView, i : Int, v : Double) -> DbtxacidView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_sum(s : DbtxacidView) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_view_mean(s : DbtxacidView) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_view_scale(s : DbtxacidView, f : Double) -> DbtxacidView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_add(a : DbtxacidView, b : DbtxacidView) -> DbtxacidView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_view_copy(s : DbtxacidView) -> DbtxacidView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_fill(s : DbtxacidView, v : Double) -> DbtxacidView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_min(s : DbtxacidView) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_view_max(s : DbtxacidView) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_view_to_string(s : DbtxacidView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_range_make(size : Int) -> DbtxacidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_range_len(s : DbtxacidRange) -> Int { s.size }

pub fn db_tx_acid_range_get(s : DbtxacidRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_range_set(s : DbtxacidRange, i : Int, v : Double) -> DbtxacidRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_sum(s : DbtxacidRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_range_mean(s : DbtxacidRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_range_scale(s : DbtxacidRange, f : Double) -> DbtxacidRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_add(a : DbtxacidRange, b : DbtxacidRange) -> DbtxacidRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_range_copy(s : DbtxacidRange) -> DbtxacidRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_fill(s : DbtxacidRange, v : Double) -> DbtxacidRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_min(s : DbtxacidRange) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_range_max(s : DbtxacidRange) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_range_to_string(s : DbtxacidRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_slice_make(size : Int) -> DbtxacidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_slice_len(s : DbtxacidSlice) -> Int { s.size }

pub fn db_tx_acid_slice_get(s : DbtxacidSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_slice_set(s : DbtxacidSlice, i : Int, v : Double) -> DbtxacidSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_sum(s : DbtxacidSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_slice_mean(s : DbtxacidSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_slice_scale(s : DbtxacidSlice, f : Double) -> DbtxacidSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_add(a : DbtxacidSlice, b : DbtxacidSlice) -> DbtxacidSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_slice_copy(s : DbtxacidSlice) -> DbtxacidSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_fill(s : DbtxacidSlice, v : Double) -> DbtxacidSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_min(s : DbtxacidSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_slice_max(s : DbtxacidSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_slice_to_string(s : DbtxacidSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

