///===
/// extcore/db_tx_saga

pub(all) struct DbtxsagaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_saga_make_point(x : Double, y : Double) -> DbtxsagaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_saga_make_point3(x : Double, y : Double, z : Double) -> DbtxsagaPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxsagaPoint::x(self : DbtxsagaPoint) -> Double { self.x }

pub fn DbtxsagaPoint::y(self : DbtxsagaPoint) -> Double { self.y }

pub fn DbtxsagaPoint::z(self : DbtxsagaPoint) -> Double { self.z }

pub fn DbtxsagaPoint::label(self : DbtxsagaPoint) -> Int { self.label }

pub fn DbtxsagaPoint::dist(self : DbtxsagaPoint, other : DbtxsagaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxsagaPoint::add(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxsagaPoint::sub(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxsagaPoint::scale(self : DbtxsagaPoint, s : Double) -> DbtxsagaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxsagaPoint::dot(self : DbtxsagaPoint, other : DbtxsagaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxsagaPoint::cross(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxsagaPoint::norm(self : DbtxsagaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxsagaPoint::normalize(self : DbtxsagaPoint) -> DbtxsagaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxsagaPoint::negate(self : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxsagaPoint::mid(self : DbtxsagaPoint, other : DbtxsagaPoint) -> DbtxsagaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxsagaPoint::lerp(self : DbtxsagaPoint, other : DbtxsagaPoint, t : Double) -> DbtxsagaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxsagaPoint::to_string(self : DbtxsagaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxsagaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_saga_make_series(vals : Array[Double], name : String) -> DbtxsagaSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxsagaSeries::len(self : DbtxsagaSeries) -> Int { self.vals.length() }

pub fn DbtxsagaSeries::sum(self : DbtxsagaSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxsagaSeries::mean(self : DbtxsagaSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxsagaSeries::min(self : DbtxsagaSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxsagaSeries::max(self : DbtxsagaSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxsagaSeries::range(self : DbtxsagaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxsagaSeries::variance(self : DbtxsagaSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxsagaSeries::std(self : DbtxsagaSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxsagaSeries::median(self : DbtxsagaSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxsagaSeries::scale(self : DbtxsagaSeries, f : Double) -> DbtxsagaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxsagaSeries::add(self : DbtxsagaSeries, other : DbtxsagaSeries) -> DbtxsagaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxsagaSeries::sub(self : DbtxsagaSeries, other : DbtxsagaSeries) -> DbtxsagaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxsagaSeries::normalize(self : DbtxsagaSeries) -> DbtxsagaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxsagaSeries::cumsum(self : DbtxsagaSeries) -> DbtxsagaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxsagaSeries::to_string(self : DbtxsagaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxsagaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_saga_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxsagaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_saga_matrix_identity(n : Int) -> DbtxsagaMatrix {
  let m = db_tx_saga_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxsagaMatrix::get(self : DbtxsagaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxsagaMatrix::transpose(self : DbtxsagaMatrix) -> DbtxsagaMatrix {
  let result = db_tx_saga_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxsagaMatrix::add(self : DbtxsagaMatrix, other : DbtxsagaMatrix) -> DbtxsagaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_saga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxsagaMatrix::scale(self : DbtxsagaMatrix, s : Double) -> DbtxsagaMatrix {
  let result = db_tx_saga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxsagaMatrix::multiply(self : DbtxsagaMatrix, other : DbtxsagaMatrix) -> DbtxsagaMatrix {
  if self.cols != other.rows { return db_tx_saga_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_saga_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxsagaMatrix::trace(self : DbtxsagaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxsagaMatrix::det(self : DbtxsagaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxsagaMatrix::norm(self : DbtxsagaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxsagaMatrix::to_string(self : DbtxsagaMatrix) -> String {
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

pub(all) struct DbtxsagaVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_saga_make_vector(comps : Array[Double]) -> DbtxsagaVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_saga_vector_zero(dim : Int) -> DbtxsagaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxsagaVector::add(self : DbtxsagaVector, other : DbtxsagaVector) -> DbtxsagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxsagaVector::sub(self : DbtxsagaVector, other : DbtxsagaVector) -> DbtxsagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxsagaVector::scale(self : DbtxsagaVector, s : Double) -> DbtxsagaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxsagaVector::dot(self : DbtxsagaVector, other : DbtxsagaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxsagaVector::norm(self : DbtxsagaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxsagaVector::normalize(self : DbtxsagaVector) -> DbtxsagaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxsagaVector::dist(self : DbtxsagaVector, other : DbtxsagaVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxsagaVector::to_string(self : DbtxsagaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_saga_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_saga_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_saga_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_saga_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_saga_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_saga_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_saga_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_saga_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_saga_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_saga_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_saga_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_saga_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_saga_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_saga_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_saga_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_saga_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_saga_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_saga_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_saga_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_saga_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_saga_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_saga_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_saga_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_saga_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_saga_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_saga_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_saga_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_saga_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_saga_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxsagaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_frame_make(size : Int) -> DbtxsagaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_frame_len(s : DbtxsagaFrame) -> Int { s.size }

pub fn db_tx_saga_frame_get(s : DbtxsagaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_frame_set(s : DbtxsagaFrame, i : Int, v : Double) -> DbtxsagaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_frame_sum(s : DbtxsagaFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_frame_mean(s : DbtxsagaFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_frame_scale(s : DbtxsagaFrame, f : Double) -> DbtxsagaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_frame_add(a : DbtxsagaFrame, b : DbtxsagaFrame) -> DbtxsagaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_frame_copy(s : DbtxsagaFrame) -> DbtxsagaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_frame_fill(s : DbtxsagaFrame, v : Double) -> DbtxsagaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_frame_min(s : DbtxsagaFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_frame_max(s : DbtxsagaFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_frame_to_string(s : DbtxsagaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_table_make(size : Int) -> DbtxsagaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_table_len(s : DbtxsagaTable) -> Int { s.size }

pub fn db_tx_saga_table_get(s : DbtxsagaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_table_set(s : DbtxsagaTable, i : Int, v : Double) -> DbtxsagaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_table_sum(s : DbtxsagaTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_table_mean(s : DbtxsagaTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_table_scale(s : DbtxsagaTable, f : Double) -> DbtxsagaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_table_add(a : DbtxsagaTable, b : DbtxsagaTable) -> DbtxsagaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_table_copy(s : DbtxsagaTable) -> DbtxsagaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_table_fill(s : DbtxsagaTable, v : Double) -> DbtxsagaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_table_min(s : DbtxsagaTable) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_table_max(s : DbtxsagaTable) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_table_to_string(s : DbtxsagaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_graphn_make(size : Int) -> DbtxsagaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_graphn_len(s : DbtxsagaGraphN) -> Int { s.size }

pub fn db_tx_saga_graphn_get(s : DbtxsagaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_graphn_set(s : DbtxsagaGraphN, i : Int, v : Double) -> DbtxsagaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_graphn_sum(s : DbtxsagaGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_graphn_mean(s : DbtxsagaGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_graphn_scale(s : DbtxsagaGraphN, f : Double) -> DbtxsagaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_graphn_add(a : DbtxsagaGraphN, b : DbtxsagaGraphN) -> DbtxsagaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_graphn_copy(s : DbtxsagaGraphN) -> DbtxsagaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_graphn_fill(s : DbtxsagaGraphN, v : Double) -> DbtxsagaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_graphn_min(s : DbtxsagaGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_graphn_max(s : DbtxsagaGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_graphn_to_string(s : DbtxsagaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_node_make(size : Int) -> DbtxsagaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_node_len(s : DbtxsagaNode) -> Int { s.size }

pub fn db_tx_saga_node_get(s : DbtxsagaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_node_set(s : DbtxsagaNode, i : Int, v : Double) -> DbtxsagaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_node_sum(s : DbtxsagaNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_node_mean(s : DbtxsagaNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_node_scale(s : DbtxsagaNode, f : Double) -> DbtxsagaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_node_add(a : DbtxsagaNode, b : DbtxsagaNode) -> DbtxsagaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_node_copy(s : DbtxsagaNode) -> DbtxsagaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_node_fill(s : DbtxsagaNode, v : Double) -> DbtxsagaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_node_min(s : DbtxsagaNode) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_node_max(s : DbtxsagaNode) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_node_to_string(s : DbtxsagaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_edge_make(size : Int) -> DbtxsagaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_edge_len(s : DbtxsagaEdge) -> Int { s.size }

pub fn db_tx_saga_edge_get(s : DbtxsagaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_edge_set(s : DbtxsagaEdge, i : Int, v : Double) -> DbtxsagaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_edge_sum(s : DbtxsagaEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_edge_mean(s : DbtxsagaEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_edge_scale(s : DbtxsagaEdge, f : Double) -> DbtxsagaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_edge_add(a : DbtxsagaEdge, b : DbtxsagaEdge) -> DbtxsagaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_edge_copy(s : DbtxsagaEdge) -> DbtxsagaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_edge_fill(s : DbtxsagaEdge, v : Double) -> DbtxsagaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_edge_min(s : DbtxsagaEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_edge_max(s : DbtxsagaEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_edge_to_string(s : DbtxsagaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_path_make(size : Int) -> DbtxsagaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_path_len(s : DbtxsagaPath) -> Int { s.size }

pub fn db_tx_saga_path_get(s : DbtxsagaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_path_set(s : DbtxsagaPath, i : Int, v : Double) -> DbtxsagaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_path_sum(s : DbtxsagaPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_path_mean(s : DbtxsagaPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_path_scale(s : DbtxsagaPath, f : Double) -> DbtxsagaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_path_add(a : DbtxsagaPath, b : DbtxsagaPath) -> DbtxsagaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_path_copy(s : DbtxsagaPath) -> DbtxsagaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_path_fill(s : DbtxsagaPath, v : Double) -> DbtxsagaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_path_min(s : DbtxsagaPath) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_path_max(s : DbtxsagaPath) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_path_to_string(s : DbtxsagaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_cluster_make(size : Int) -> DbtxsagaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_cluster_len(s : DbtxsagaCluster) -> Int { s.size }

pub fn db_tx_saga_cluster_get(s : DbtxsagaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_cluster_set(s : DbtxsagaCluster, i : Int, v : Double) -> DbtxsagaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cluster_sum(s : DbtxsagaCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_cluster_mean(s : DbtxsagaCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_cluster_scale(s : DbtxsagaCluster, f : Double) -> DbtxsagaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cluster_add(a : DbtxsagaCluster, b : DbtxsagaCluster) -> DbtxsagaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_cluster_copy(s : DbtxsagaCluster) -> DbtxsagaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cluster_fill(s : DbtxsagaCluster, v : Double) -> DbtxsagaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cluster_min(s : DbtxsagaCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_cluster_max(s : DbtxsagaCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_cluster_to_string(s : DbtxsagaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_model_make(size : Int) -> DbtxsagaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_model_len(s : DbtxsagaModel) -> Int { s.size }

pub fn db_tx_saga_model_get(s : DbtxsagaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_model_set(s : DbtxsagaModel, i : Int, v : Double) -> DbtxsagaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_model_sum(s : DbtxsagaModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_model_mean(s : DbtxsagaModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_model_scale(s : DbtxsagaModel, f : Double) -> DbtxsagaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_model_add(a : DbtxsagaModel, b : DbtxsagaModel) -> DbtxsagaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_model_copy(s : DbtxsagaModel) -> DbtxsagaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_model_fill(s : DbtxsagaModel, v : Double) -> DbtxsagaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_model_min(s : DbtxsagaModel) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_model_max(s : DbtxsagaModel) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_model_to_string(s : DbtxsagaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_layer_make(size : Int) -> DbtxsagaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_layer_len(s : DbtxsagaLayer) -> Int { s.size }

pub fn db_tx_saga_layer_get(s : DbtxsagaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_layer_set(s : DbtxsagaLayer, i : Int, v : Double) -> DbtxsagaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_layer_sum(s : DbtxsagaLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_layer_mean(s : DbtxsagaLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_layer_scale(s : DbtxsagaLayer, f : Double) -> DbtxsagaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_layer_add(a : DbtxsagaLayer, b : DbtxsagaLayer) -> DbtxsagaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_layer_copy(s : DbtxsagaLayer) -> DbtxsagaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_layer_fill(s : DbtxsagaLayer, v : Double) -> DbtxsagaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_layer_min(s : DbtxsagaLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_layer_max(s : DbtxsagaLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_layer_to_string(s : DbtxsagaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_buffer_make(size : Int) -> DbtxsagaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_buffer_len(s : DbtxsagaBuffer) -> Int { s.size }

pub fn db_tx_saga_buffer_get(s : DbtxsagaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_buffer_set(s : DbtxsagaBuffer, i : Int, v : Double) -> DbtxsagaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_buffer_sum(s : DbtxsagaBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_buffer_mean(s : DbtxsagaBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_buffer_scale(s : DbtxsagaBuffer, f : Double) -> DbtxsagaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_buffer_add(a : DbtxsagaBuffer, b : DbtxsagaBuffer) -> DbtxsagaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_buffer_copy(s : DbtxsagaBuffer) -> DbtxsagaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_buffer_fill(s : DbtxsagaBuffer, v : Double) -> DbtxsagaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_buffer_min(s : DbtxsagaBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_buffer_max(s : DbtxsagaBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_buffer_to_string(s : DbtxsagaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_cursor_make(size : Int) -> DbtxsagaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_cursor_len(s : DbtxsagaCursor) -> Int { s.size }

pub fn db_tx_saga_cursor_get(s : DbtxsagaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_cursor_set(s : DbtxsagaCursor, i : Int, v : Double) -> DbtxsagaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cursor_sum(s : DbtxsagaCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_cursor_mean(s : DbtxsagaCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_cursor_scale(s : DbtxsagaCursor, f : Double) -> DbtxsagaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cursor_add(a : DbtxsagaCursor, b : DbtxsagaCursor) -> DbtxsagaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_cursor_copy(s : DbtxsagaCursor) -> DbtxsagaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cursor_fill(s : DbtxsagaCursor, v : Double) -> DbtxsagaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_cursor_min(s : DbtxsagaCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_cursor_max(s : DbtxsagaCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_cursor_to_string(s : DbtxsagaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_view_make(size : Int) -> DbtxsagaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_view_len(s : DbtxsagaView) -> Int { s.size }

pub fn db_tx_saga_view_get(s : DbtxsagaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_view_set(s : DbtxsagaView, i : Int, v : Double) -> DbtxsagaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_view_sum(s : DbtxsagaView) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_view_mean(s : DbtxsagaView) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_view_scale(s : DbtxsagaView, f : Double) -> DbtxsagaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_view_add(a : DbtxsagaView, b : DbtxsagaView) -> DbtxsagaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_view_copy(s : DbtxsagaView) -> DbtxsagaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_view_fill(s : DbtxsagaView, v : Double) -> DbtxsagaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_view_min(s : DbtxsagaView) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_view_max(s : DbtxsagaView) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_view_to_string(s : DbtxsagaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_range_make(size : Int) -> DbtxsagaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_range_len(s : DbtxsagaRange) -> Int { s.size }

pub fn db_tx_saga_range_get(s : DbtxsagaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_range_set(s : DbtxsagaRange, i : Int, v : Double) -> DbtxsagaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_range_sum(s : DbtxsagaRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_range_mean(s : DbtxsagaRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_range_scale(s : DbtxsagaRange, f : Double) -> DbtxsagaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_range_add(a : DbtxsagaRange, b : DbtxsagaRange) -> DbtxsagaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_range_copy(s : DbtxsagaRange) -> DbtxsagaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_range_fill(s : DbtxsagaRange, v : Double) -> DbtxsagaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_range_min(s : DbtxsagaRange) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_range_max(s : DbtxsagaRange) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_range_to_string(s : DbtxsagaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxsagaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_saga_slice_make(size : Int) -> DbtxsagaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_saga_slice_len(s : DbtxsagaSlice) -> Int { s.size }

pub fn db_tx_saga_slice_get(s : DbtxsagaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_saga_slice_set(s : DbtxsagaSlice, i : Int, v : Double) -> DbtxsagaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_saga_slice_sum(s : DbtxsagaSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_saga_slice_mean(s : DbtxsagaSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_saga_slice_scale(s : DbtxsagaSlice, f : Double) -> DbtxsagaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_slice_add(a : DbtxsagaSlice, b : DbtxsagaSlice) -> DbtxsagaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_saga_slice_copy(s : DbtxsagaSlice) -> DbtxsagaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_slice_fill(s : DbtxsagaSlice, v : Double) -> DbtxsagaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_saga_slice_min(s : DbtxsagaSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_saga_slice_max(s : DbtxsagaSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_saga_slice_to_string(s : DbtxsagaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

