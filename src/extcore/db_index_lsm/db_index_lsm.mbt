///===
/// extcore/db_index_lsm

pub(all) struct DbindexlsmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_lsm_make_point(x : Double, y : Double) -> DbindexlsmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_lsm_make_point3(x : Double, y : Double, z : Double) -> DbindexlsmPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexlsmPoint::x(self : DbindexlsmPoint) -> Double { self.x }

pub fn DbindexlsmPoint::y(self : DbindexlsmPoint) -> Double { self.y }

pub fn DbindexlsmPoint::z(self : DbindexlsmPoint) -> Double { self.z }

pub fn DbindexlsmPoint::label(self : DbindexlsmPoint) -> Int { self.label }

pub fn DbindexlsmPoint::dist(self : DbindexlsmPoint, other : DbindexlsmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexlsmPoint::add(self : DbindexlsmPoint, other : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexlsmPoint::sub(self : DbindexlsmPoint, other : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexlsmPoint::scale(self : DbindexlsmPoint, s : Double) -> DbindexlsmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexlsmPoint::dot(self : DbindexlsmPoint, other : DbindexlsmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexlsmPoint::cross(self : DbindexlsmPoint, other : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexlsmPoint::norm(self : DbindexlsmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexlsmPoint::normalize(self : DbindexlsmPoint) -> DbindexlsmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexlsmPoint::negate(self : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexlsmPoint::mid(self : DbindexlsmPoint, other : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexlsmPoint::lerp(self : DbindexlsmPoint, other : DbindexlsmPoint, t : Double) -> DbindexlsmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexlsmPoint::to_string(self : DbindexlsmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexlsmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_lsm_make_series(vals : Array[Double], name : String) -> DbindexlsmSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexlsmSeries::len(self : DbindexlsmSeries) -> Int { self.vals.length() }

pub fn DbindexlsmSeries::sum(self : DbindexlsmSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexlsmSeries::mean(self : DbindexlsmSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexlsmSeries::min(self : DbindexlsmSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexlsmSeries::max(self : DbindexlsmSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexlsmSeries::range(self : DbindexlsmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexlsmSeries::variance(self : DbindexlsmSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexlsmSeries::std(self : DbindexlsmSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexlsmSeries::median(self : DbindexlsmSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexlsmSeries::scale(self : DbindexlsmSeries, f : Double) -> DbindexlsmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexlsmSeries::add(self : DbindexlsmSeries, other : DbindexlsmSeries) -> DbindexlsmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexlsmSeries::sub(self : DbindexlsmSeries, other : DbindexlsmSeries) -> DbindexlsmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexlsmSeries::normalize(self : DbindexlsmSeries) -> DbindexlsmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexlsmSeries::cumsum(self : DbindexlsmSeries) -> DbindexlsmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexlsmSeries::to_string(self : DbindexlsmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexlsmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_lsm_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexlsmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_lsm_matrix_identity(n : Int) -> DbindexlsmMatrix {
  let m = db_index_lsm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexlsmMatrix::get(self : DbindexlsmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexlsmMatrix::transpose(self : DbindexlsmMatrix) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexlsmMatrix::add(self : DbindexlsmMatrix, other : DbindexlsmMatrix) -> DbindexlsmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_lsm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexlsmMatrix::scale(self : DbindexlsmMatrix, s : Double) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexlsmMatrix::multiply(self : DbindexlsmMatrix, other : DbindexlsmMatrix) -> DbindexlsmMatrix {
  if self.cols != other.rows { return db_index_lsm_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_lsm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexlsmMatrix::trace(self : DbindexlsmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexlsmMatrix::det(self : DbindexlsmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexlsmMatrix::norm(self : DbindexlsmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexlsmMatrix::to_string(self : DbindexlsmMatrix) -> String {
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

pub(all) struct DbindexlsmVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_lsm_make_vector(comps : Array[Double]) -> DbindexlsmVector {
  { comps, dim: comps.length() }
}

pub fn db_index_lsm_vector_zero(dim : Int) -> DbindexlsmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexlsmVector::add(self : DbindexlsmVector, other : DbindexlsmVector) -> DbindexlsmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexlsmVector::sub(self : DbindexlsmVector, other : DbindexlsmVector) -> DbindexlsmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexlsmVector::scale(self : DbindexlsmVector, s : Double) -> DbindexlsmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexlsmVector::dot(self : DbindexlsmVector, other : DbindexlsmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexlsmVector::norm(self : DbindexlsmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexlsmVector::normalize(self : DbindexlsmVector) -> DbindexlsmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexlsmVector::dist(self : DbindexlsmVector, other : DbindexlsmVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexlsmVector::to_string(self : DbindexlsmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_lsm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_lsm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_lsm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_lsm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_lsm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_lsm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_lsm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_lsm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_lsm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_lsm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_lsm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_lsm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_lsm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_lsm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_lsm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_lsm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_lsm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_lsm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_lsm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_lsm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_lsm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_lsm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_lsm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_lsm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_lsm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_lsm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_lsm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_lsm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_lsm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexlsmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_frame_make(size : Int) -> DbindexlsmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_frame_len(s : DbindexlsmFrame) -> Int { s.size }

pub fn db_index_lsm_frame_get(s : DbindexlsmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_frame_set(s : DbindexlsmFrame, i : Int, v : Double) -> DbindexlsmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_frame_sum(s : DbindexlsmFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_frame_mean(s : DbindexlsmFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_frame_scale(s : DbindexlsmFrame, f : Double) -> DbindexlsmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_frame_add(a : DbindexlsmFrame, b : DbindexlsmFrame) -> DbindexlsmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_frame_copy(s : DbindexlsmFrame) -> DbindexlsmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_frame_fill(s : DbindexlsmFrame, v : Double) -> DbindexlsmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_frame_min(s : DbindexlsmFrame) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_frame_max(s : DbindexlsmFrame) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_frame_to_string(s : DbindexlsmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_table_make(size : Int) -> DbindexlsmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_table_len(s : DbindexlsmTable) -> Int { s.size }

pub fn db_index_lsm_table_get(s : DbindexlsmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_table_set(s : DbindexlsmTable, i : Int, v : Double) -> DbindexlsmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_table_sum(s : DbindexlsmTable) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_table_mean(s : DbindexlsmTable) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_table_scale(s : DbindexlsmTable, f : Double) -> DbindexlsmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_table_add(a : DbindexlsmTable, b : DbindexlsmTable) -> DbindexlsmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_table_copy(s : DbindexlsmTable) -> DbindexlsmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_table_fill(s : DbindexlsmTable, v : Double) -> DbindexlsmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_table_min(s : DbindexlsmTable) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_table_max(s : DbindexlsmTable) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_table_to_string(s : DbindexlsmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_graphn_make(size : Int) -> DbindexlsmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_graphn_len(s : DbindexlsmGraphN) -> Int { s.size }

pub fn db_index_lsm_graphn_get(s : DbindexlsmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_graphn_set(s : DbindexlsmGraphN, i : Int, v : Double) -> DbindexlsmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_graphn_sum(s : DbindexlsmGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_graphn_mean(s : DbindexlsmGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_graphn_scale(s : DbindexlsmGraphN, f : Double) -> DbindexlsmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_graphn_add(a : DbindexlsmGraphN, b : DbindexlsmGraphN) -> DbindexlsmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_graphn_copy(s : DbindexlsmGraphN) -> DbindexlsmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_graphn_fill(s : DbindexlsmGraphN, v : Double) -> DbindexlsmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_graphn_min(s : DbindexlsmGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_graphn_max(s : DbindexlsmGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_graphn_to_string(s : DbindexlsmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_node_make(size : Int) -> DbindexlsmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_node_len(s : DbindexlsmNode) -> Int { s.size }

pub fn db_index_lsm_node_get(s : DbindexlsmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_node_set(s : DbindexlsmNode, i : Int, v : Double) -> DbindexlsmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_node_sum(s : DbindexlsmNode) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_node_mean(s : DbindexlsmNode) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_node_scale(s : DbindexlsmNode, f : Double) -> DbindexlsmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_node_add(a : DbindexlsmNode, b : DbindexlsmNode) -> DbindexlsmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_node_copy(s : DbindexlsmNode) -> DbindexlsmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_node_fill(s : DbindexlsmNode, v : Double) -> DbindexlsmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_node_min(s : DbindexlsmNode) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_node_max(s : DbindexlsmNode) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_node_to_string(s : DbindexlsmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_edge_make(size : Int) -> DbindexlsmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_edge_len(s : DbindexlsmEdge) -> Int { s.size }

pub fn db_index_lsm_edge_get(s : DbindexlsmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_edge_set(s : DbindexlsmEdge, i : Int, v : Double) -> DbindexlsmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_edge_sum(s : DbindexlsmEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_edge_mean(s : DbindexlsmEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_edge_scale(s : DbindexlsmEdge, f : Double) -> DbindexlsmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_edge_add(a : DbindexlsmEdge, b : DbindexlsmEdge) -> DbindexlsmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_edge_copy(s : DbindexlsmEdge) -> DbindexlsmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_edge_fill(s : DbindexlsmEdge, v : Double) -> DbindexlsmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_edge_min(s : DbindexlsmEdge) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_edge_max(s : DbindexlsmEdge) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_edge_to_string(s : DbindexlsmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_path_make(size : Int) -> DbindexlsmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_path_len(s : DbindexlsmPath) -> Int { s.size }

pub fn db_index_lsm_path_get(s : DbindexlsmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_path_set(s : DbindexlsmPath, i : Int, v : Double) -> DbindexlsmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_path_sum(s : DbindexlsmPath) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_path_mean(s : DbindexlsmPath) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_path_scale(s : DbindexlsmPath, f : Double) -> DbindexlsmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_path_add(a : DbindexlsmPath, b : DbindexlsmPath) -> DbindexlsmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_path_copy(s : DbindexlsmPath) -> DbindexlsmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_path_fill(s : DbindexlsmPath, v : Double) -> DbindexlsmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_path_min(s : DbindexlsmPath) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_path_max(s : DbindexlsmPath) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_path_to_string(s : DbindexlsmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_cluster_make(size : Int) -> DbindexlsmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_cluster_len(s : DbindexlsmCluster) -> Int { s.size }

pub fn db_index_lsm_cluster_get(s : DbindexlsmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_cluster_set(s : DbindexlsmCluster, i : Int, v : Double) -> DbindexlsmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cluster_sum(s : DbindexlsmCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_cluster_mean(s : DbindexlsmCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_cluster_scale(s : DbindexlsmCluster, f : Double) -> DbindexlsmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cluster_add(a : DbindexlsmCluster, b : DbindexlsmCluster) -> DbindexlsmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_cluster_copy(s : DbindexlsmCluster) -> DbindexlsmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cluster_fill(s : DbindexlsmCluster, v : Double) -> DbindexlsmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cluster_min(s : DbindexlsmCluster) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_cluster_max(s : DbindexlsmCluster) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_cluster_to_string(s : DbindexlsmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_model_make(size : Int) -> DbindexlsmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_model_len(s : DbindexlsmModel) -> Int { s.size }

pub fn db_index_lsm_model_get(s : DbindexlsmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_model_set(s : DbindexlsmModel, i : Int, v : Double) -> DbindexlsmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_model_sum(s : DbindexlsmModel) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_model_mean(s : DbindexlsmModel) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_model_scale(s : DbindexlsmModel, f : Double) -> DbindexlsmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_model_add(a : DbindexlsmModel, b : DbindexlsmModel) -> DbindexlsmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_model_copy(s : DbindexlsmModel) -> DbindexlsmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_model_fill(s : DbindexlsmModel, v : Double) -> DbindexlsmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_model_min(s : DbindexlsmModel) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_model_max(s : DbindexlsmModel) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_model_to_string(s : DbindexlsmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_layer_make(size : Int) -> DbindexlsmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_layer_len(s : DbindexlsmLayer) -> Int { s.size }

pub fn db_index_lsm_layer_get(s : DbindexlsmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_layer_set(s : DbindexlsmLayer, i : Int, v : Double) -> DbindexlsmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_layer_sum(s : DbindexlsmLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_layer_mean(s : DbindexlsmLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_layer_scale(s : DbindexlsmLayer, f : Double) -> DbindexlsmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_layer_add(a : DbindexlsmLayer, b : DbindexlsmLayer) -> DbindexlsmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_layer_copy(s : DbindexlsmLayer) -> DbindexlsmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_layer_fill(s : DbindexlsmLayer, v : Double) -> DbindexlsmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_layer_min(s : DbindexlsmLayer) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_layer_max(s : DbindexlsmLayer) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_layer_to_string(s : DbindexlsmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_buffer_make(size : Int) -> DbindexlsmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_buffer_len(s : DbindexlsmBuffer) -> Int { s.size }

pub fn db_index_lsm_buffer_get(s : DbindexlsmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_buffer_set(s : DbindexlsmBuffer, i : Int, v : Double) -> DbindexlsmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_buffer_sum(s : DbindexlsmBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_buffer_mean(s : DbindexlsmBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_buffer_scale(s : DbindexlsmBuffer, f : Double) -> DbindexlsmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_buffer_add(a : DbindexlsmBuffer, b : DbindexlsmBuffer) -> DbindexlsmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_buffer_copy(s : DbindexlsmBuffer) -> DbindexlsmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_buffer_fill(s : DbindexlsmBuffer, v : Double) -> DbindexlsmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_buffer_min(s : DbindexlsmBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_buffer_max(s : DbindexlsmBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_buffer_to_string(s : DbindexlsmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_cursor_make(size : Int) -> DbindexlsmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_cursor_len(s : DbindexlsmCursor) -> Int { s.size }

pub fn db_index_lsm_cursor_get(s : DbindexlsmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_cursor_set(s : DbindexlsmCursor, i : Int, v : Double) -> DbindexlsmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cursor_sum(s : DbindexlsmCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_cursor_mean(s : DbindexlsmCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_cursor_scale(s : DbindexlsmCursor, f : Double) -> DbindexlsmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cursor_add(a : DbindexlsmCursor, b : DbindexlsmCursor) -> DbindexlsmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_cursor_copy(s : DbindexlsmCursor) -> DbindexlsmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cursor_fill(s : DbindexlsmCursor, v : Double) -> DbindexlsmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_cursor_min(s : DbindexlsmCursor) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_cursor_max(s : DbindexlsmCursor) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_cursor_to_string(s : DbindexlsmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_view_make(size : Int) -> DbindexlsmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_view_len(s : DbindexlsmView) -> Int { s.size }

pub fn db_index_lsm_view_get(s : DbindexlsmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_view_set(s : DbindexlsmView, i : Int, v : Double) -> DbindexlsmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_view_sum(s : DbindexlsmView) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_view_mean(s : DbindexlsmView) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_view_scale(s : DbindexlsmView, f : Double) -> DbindexlsmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_view_add(a : DbindexlsmView, b : DbindexlsmView) -> DbindexlsmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_view_copy(s : DbindexlsmView) -> DbindexlsmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_view_fill(s : DbindexlsmView, v : Double) -> DbindexlsmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_view_min(s : DbindexlsmView) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_view_max(s : DbindexlsmView) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_view_to_string(s : DbindexlsmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_range_make(size : Int) -> DbindexlsmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_range_len(s : DbindexlsmRange) -> Int { s.size }

pub fn db_index_lsm_range_get(s : DbindexlsmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_range_set(s : DbindexlsmRange, i : Int, v : Double) -> DbindexlsmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_range_sum(s : DbindexlsmRange) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_range_mean(s : DbindexlsmRange) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_range_scale(s : DbindexlsmRange, f : Double) -> DbindexlsmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_range_add(a : DbindexlsmRange, b : DbindexlsmRange) -> DbindexlsmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_range_copy(s : DbindexlsmRange) -> DbindexlsmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_range_fill(s : DbindexlsmRange, v : Double) -> DbindexlsmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_range_min(s : DbindexlsmRange) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_range_max(s : DbindexlsmRange) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_range_to_string(s : DbindexlsmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_slice_make(size : Int) -> DbindexlsmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_slice_len(s : DbindexlsmSlice) -> Int { s.size }

pub fn db_index_lsm_slice_get(s : DbindexlsmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_slice_set(s : DbindexlsmSlice, i : Int, v : Double) -> DbindexlsmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_lsm_slice_sum(s : DbindexlsmSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_slice_mean(s : DbindexlsmSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_slice_scale(s : DbindexlsmSlice, f : Double) -> DbindexlsmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_slice_add(a : DbindexlsmSlice, b : DbindexlsmSlice) -> DbindexlsmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_lsm_slice_copy(s : DbindexlsmSlice) -> DbindexlsmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_slice_fill(s : DbindexlsmSlice, v : Double) -> DbindexlsmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_lsm_slice_min(s : DbindexlsmSlice) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_slice_max(s : DbindexlsmSlice) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_slice_to_string(s : DbindexlsmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

