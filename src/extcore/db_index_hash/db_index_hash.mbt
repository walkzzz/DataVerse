///===
/// extcore/db_index_hash

pub(all) struct DbindexhashPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_hash_make_point(x : Double, y : Double) -> DbindexhashPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_hash_make_point3(x : Double, y : Double, z : Double) -> DbindexhashPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexhashPoint::x(self : DbindexhashPoint) -> Double { self.x }

pub fn DbindexhashPoint::y(self : DbindexhashPoint) -> Double { self.y }

pub fn DbindexhashPoint::z(self : DbindexhashPoint) -> Double { self.z }

pub fn DbindexhashPoint::label(self : DbindexhashPoint) -> Int { self.label }

pub fn DbindexhashPoint::dist(self : DbindexhashPoint, other : DbindexhashPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexhashPoint::add(self : DbindexhashPoint, other : DbindexhashPoint) -> DbindexhashPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexhashPoint::sub(self : DbindexhashPoint, other : DbindexhashPoint) -> DbindexhashPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexhashPoint::scale(self : DbindexhashPoint, s : Double) -> DbindexhashPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexhashPoint::dot(self : DbindexhashPoint, other : DbindexhashPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexhashPoint::cross(self : DbindexhashPoint, other : DbindexhashPoint) -> DbindexhashPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexhashPoint::norm(self : DbindexhashPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexhashPoint::normalize(self : DbindexhashPoint) -> DbindexhashPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexhashPoint::negate(self : DbindexhashPoint) -> DbindexhashPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexhashPoint::mid(self : DbindexhashPoint, other : DbindexhashPoint) -> DbindexhashPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexhashPoint::lerp(self : DbindexhashPoint, other : DbindexhashPoint, t : Double) -> DbindexhashPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexhashPoint::to_string(self : DbindexhashPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexhashSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_hash_make_series(vals : Array[Double], name : String) -> DbindexhashSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexhashSeries::len(self : DbindexhashSeries) -> Int { self.vals.length() }

pub fn DbindexhashSeries::sum(self : DbindexhashSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexhashSeries::mean(self : DbindexhashSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexhashSeries::min(self : DbindexhashSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexhashSeries::max(self : DbindexhashSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexhashSeries::range(self : DbindexhashSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexhashSeries::variance(self : DbindexhashSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexhashSeries::std(self : DbindexhashSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexhashSeries::median(self : DbindexhashSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexhashSeries::scale(self : DbindexhashSeries, f : Double) -> DbindexhashSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexhashSeries::add(self : DbindexhashSeries, other : DbindexhashSeries) -> DbindexhashSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexhashSeries::sub(self : DbindexhashSeries, other : DbindexhashSeries) -> DbindexhashSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexhashSeries::normalize(self : DbindexhashSeries) -> DbindexhashSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexhashSeries::cumsum(self : DbindexhashSeries) -> DbindexhashSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexhashSeries::to_string(self : DbindexhashSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexhashMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_hash_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexhashMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_hash_matrix_identity(n : Int) -> DbindexhashMatrix {
  let m = db_index_hash_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexhashMatrix::get(self : DbindexhashMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexhashMatrix::transpose(self : DbindexhashMatrix) -> DbindexhashMatrix {
  let result = db_index_hash_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexhashMatrix::add(self : DbindexhashMatrix, other : DbindexhashMatrix) -> DbindexhashMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_hash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexhashMatrix::scale(self : DbindexhashMatrix, s : Double) -> DbindexhashMatrix {
  let result = db_index_hash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexhashMatrix::multiply(self : DbindexhashMatrix, other : DbindexhashMatrix) -> DbindexhashMatrix {
  if self.cols != other.rows { return db_index_hash_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_hash_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexhashMatrix::trace(self : DbindexhashMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexhashMatrix::det(self : DbindexhashMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexhashMatrix::norm(self : DbindexhashMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexhashMatrix::to_string(self : DbindexhashMatrix) -> String {
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

pub(all) struct DbindexhashVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_hash_make_vector(comps : Array[Double]) -> DbindexhashVector {
  { comps, dim: comps.length() }
}

pub fn db_index_hash_vector_zero(dim : Int) -> DbindexhashVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexhashVector::add(self : DbindexhashVector, other : DbindexhashVector) -> DbindexhashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexhashVector::sub(self : DbindexhashVector, other : DbindexhashVector) -> DbindexhashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexhashVector::scale(self : DbindexhashVector, s : Double) -> DbindexhashVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexhashVector::dot(self : DbindexhashVector, other : DbindexhashVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexhashVector::norm(self : DbindexhashVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexhashVector::normalize(self : DbindexhashVector) -> DbindexhashVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexhashVector::dist(self : DbindexhashVector, other : DbindexhashVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexhashVector::to_string(self : DbindexhashVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_hash_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_hash_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_hash_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_hash_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_hash_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_hash_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_hash_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_hash_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_hash_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_hash_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_hash_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_hash_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_hash_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_hash_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_hash_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_hash_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_hash_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_hash_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_hash_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_hash_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_hash_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_hash_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_hash_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_hash_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_hash_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_hash_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_hash_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_hash_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_hash_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexhashFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_frame_make(size : Int) -> DbindexhashFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_frame_len(s : DbindexhashFrame) -> Int { s.size }

pub fn db_index_hash_frame_get(s : DbindexhashFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_frame_set(s : DbindexhashFrame, i : Int, v : Double) -> DbindexhashFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_frame_sum(s : DbindexhashFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_frame_mean(s : DbindexhashFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_frame_scale(s : DbindexhashFrame, f : Double) -> DbindexhashFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_frame_add(a : DbindexhashFrame, b : DbindexhashFrame) -> DbindexhashFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_frame_copy(s : DbindexhashFrame) -> DbindexhashFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_frame_fill(s : DbindexhashFrame, v : Double) -> DbindexhashFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_frame_min(s : DbindexhashFrame) -> Double { @_common.min(s.data) }

pub fn db_index_hash_frame_max(s : DbindexhashFrame) -> Double { @_common.max(s.data) }

pub fn db_index_hash_frame_to_string(s : DbindexhashFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_table_make(size : Int) -> DbindexhashTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_table_len(s : DbindexhashTable) -> Int { s.size }

pub fn db_index_hash_table_get(s : DbindexhashTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_table_set(s : DbindexhashTable, i : Int, v : Double) -> DbindexhashTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_table_sum(s : DbindexhashTable) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_table_mean(s : DbindexhashTable) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_table_scale(s : DbindexhashTable, f : Double) -> DbindexhashTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_table_add(a : DbindexhashTable, b : DbindexhashTable) -> DbindexhashTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_table_copy(s : DbindexhashTable) -> DbindexhashTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_table_fill(s : DbindexhashTable, v : Double) -> DbindexhashTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_table_min(s : DbindexhashTable) -> Double { @_common.min(s.data) }

pub fn db_index_hash_table_max(s : DbindexhashTable) -> Double { @_common.max(s.data) }

pub fn db_index_hash_table_to_string(s : DbindexhashTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_graphn_make(size : Int) -> DbindexhashGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_graphn_len(s : DbindexhashGraphN) -> Int { s.size }

pub fn db_index_hash_graphn_get(s : DbindexhashGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_graphn_set(s : DbindexhashGraphN, i : Int, v : Double) -> DbindexhashGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_graphn_sum(s : DbindexhashGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_graphn_mean(s : DbindexhashGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_graphn_scale(s : DbindexhashGraphN, f : Double) -> DbindexhashGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_graphn_add(a : DbindexhashGraphN, b : DbindexhashGraphN) -> DbindexhashGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_graphn_copy(s : DbindexhashGraphN) -> DbindexhashGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_graphn_fill(s : DbindexhashGraphN, v : Double) -> DbindexhashGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_graphn_min(s : DbindexhashGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_hash_graphn_max(s : DbindexhashGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_hash_graphn_to_string(s : DbindexhashGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_node_make(size : Int) -> DbindexhashNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_node_len(s : DbindexhashNode) -> Int { s.size }

pub fn db_index_hash_node_get(s : DbindexhashNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_node_set(s : DbindexhashNode, i : Int, v : Double) -> DbindexhashNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_node_sum(s : DbindexhashNode) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_node_mean(s : DbindexhashNode) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_node_scale(s : DbindexhashNode, f : Double) -> DbindexhashNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_node_add(a : DbindexhashNode, b : DbindexhashNode) -> DbindexhashNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_node_copy(s : DbindexhashNode) -> DbindexhashNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_node_fill(s : DbindexhashNode, v : Double) -> DbindexhashNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_node_min(s : DbindexhashNode) -> Double { @_common.min(s.data) }

pub fn db_index_hash_node_max(s : DbindexhashNode) -> Double { @_common.max(s.data) }

pub fn db_index_hash_node_to_string(s : DbindexhashNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_edge_make(size : Int) -> DbindexhashEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_edge_len(s : DbindexhashEdge) -> Int { s.size }

pub fn db_index_hash_edge_get(s : DbindexhashEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_edge_set(s : DbindexhashEdge, i : Int, v : Double) -> DbindexhashEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_edge_sum(s : DbindexhashEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_edge_mean(s : DbindexhashEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_edge_scale(s : DbindexhashEdge, f : Double) -> DbindexhashEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_edge_add(a : DbindexhashEdge, b : DbindexhashEdge) -> DbindexhashEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_edge_copy(s : DbindexhashEdge) -> DbindexhashEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_edge_fill(s : DbindexhashEdge, v : Double) -> DbindexhashEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_edge_min(s : DbindexhashEdge) -> Double { @_common.min(s.data) }

pub fn db_index_hash_edge_max(s : DbindexhashEdge) -> Double { @_common.max(s.data) }

pub fn db_index_hash_edge_to_string(s : DbindexhashEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_path_make(size : Int) -> DbindexhashPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_path_len(s : DbindexhashPath) -> Int { s.size }

pub fn db_index_hash_path_get(s : DbindexhashPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_path_set(s : DbindexhashPath, i : Int, v : Double) -> DbindexhashPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_path_sum(s : DbindexhashPath) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_path_mean(s : DbindexhashPath) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_path_scale(s : DbindexhashPath, f : Double) -> DbindexhashPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_path_add(a : DbindexhashPath, b : DbindexhashPath) -> DbindexhashPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_path_copy(s : DbindexhashPath) -> DbindexhashPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_path_fill(s : DbindexhashPath, v : Double) -> DbindexhashPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_path_min(s : DbindexhashPath) -> Double { @_common.min(s.data) }

pub fn db_index_hash_path_max(s : DbindexhashPath) -> Double { @_common.max(s.data) }

pub fn db_index_hash_path_to_string(s : DbindexhashPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_cluster_make(size : Int) -> DbindexhashCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_cluster_len(s : DbindexhashCluster) -> Int { s.size }

pub fn db_index_hash_cluster_get(s : DbindexhashCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_cluster_set(s : DbindexhashCluster, i : Int, v : Double) -> DbindexhashCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_cluster_sum(s : DbindexhashCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_cluster_mean(s : DbindexhashCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_cluster_scale(s : DbindexhashCluster, f : Double) -> DbindexhashCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_cluster_add(a : DbindexhashCluster, b : DbindexhashCluster) -> DbindexhashCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_cluster_copy(s : DbindexhashCluster) -> DbindexhashCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_cluster_fill(s : DbindexhashCluster, v : Double) -> DbindexhashCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_cluster_min(s : DbindexhashCluster) -> Double { @_common.min(s.data) }

pub fn db_index_hash_cluster_max(s : DbindexhashCluster) -> Double { @_common.max(s.data) }

pub fn db_index_hash_cluster_to_string(s : DbindexhashCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_model_make(size : Int) -> DbindexhashModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_model_len(s : DbindexhashModel) -> Int { s.size }

pub fn db_index_hash_model_get(s : DbindexhashModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_model_set(s : DbindexhashModel, i : Int, v : Double) -> DbindexhashModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_model_sum(s : DbindexhashModel) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_model_mean(s : DbindexhashModel) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_model_scale(s : DbindexhashModel, f : Double) -> DbindexhashModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_model_add(a : DbindexhashModel, b : DbindexhashModel) -> DbindexhashModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_model_copy(s : DbindexhashModel) -> DbindexhashModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_model_fill(s : DbindexhashModel, v : Double) -> DbindexhashModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_model_min(s : DbindexhashModel) -> Double { @_common.min(s.data) }

pub fn db_index_hash_model_max(s : DbindexhashModel) -> Double { @_common.max(s.data) }

pub fn db_index_hash_model_to_string(s : DbindexhashModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_layer_make(size : Int) -> DbindexhashLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_layer_len(s : DbindexhashLayer) -> Int { s.size }

pub fn db_index_hash_layer_get(s : DbindexhashLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_layer_set(s : DbindexhashLayer, i : Int, v : Double) -> DbindexhashLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_layer_sum(s : DbindexhashLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_layer_mean(s : DbindexhashLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_layer_scale(s : DbindexhashLayer, f : Double) -> DbindexhashLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_layer_add(a : DbindexhashLayer, b : DbindexhashLayer) -> DbindexhashLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_layer_copy(s : DbindexhashLayer) -> DbindexhashLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_layer_fill(s : DbindexhashLayer, v : Double) -> DbindexhashLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_layer_min(s : DbindexhashLayer) -> Double { @_common.min(s.data) }

pub fn db_index_hash_layer_max(s : DbindexhashLayer) -> Double { @_common.max(s.data) }

pub fn db_index_hash_layer_to_string(s : DbindexhashLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_buffer_make(size : Int) -> DbindexhashBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_buffer_len(s : DbindexhashBuffer) -> Int { s.size }

pub fn db_index_hash_buffer_get(s : DbindexhashBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_buffer_set(s : DbindexhashBuffer, i : Int, v : Double) -> DbindexhashBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_buffer_sum(s : DbindexhashBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_buffer_mean(s : DbindexhashBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_buffer_scale(s : DbindexhashBuffer, f : Double) -> DbindexhashBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_buffer_add(a : DbindexhashBuffer, b : DbindexhashBuffer) -> DbindexhashBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_buffer_copy(s : DbindexhashBuffer) -> DbindexhashBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_buffer_fill(s : DbindexhashBuffer, v : Double) -> DbindexhashBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_buffer_min(s : DbindexhashBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_hash_buffer_max(s : DbindexhashBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_hash_buffer_to_string(s : DbindexhashBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_cursor_make(size : Int) -> DbindexhashCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_cursor_len(s : DbindexhashCursor) -> Int { s.size }

pub fn db_index_hash_cursor_get(s : DbindexhashCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_cursor_set(s : DbindexhashCursor, i : Int, v : Double) -> DbindexhashCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_cursor_sum(s : DbindexhashCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_cursor_mean(s : DbindexhashCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_cursor_scale(s : DbindexhashCursor, f : Double) -> DbindexhashCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_cursor_add(a : DbindexhashCursor, b : DbindexhashCursor) -> DbindexhashCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_cursor_copy(s : DbindexhashCursor) -> DbindexhashCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_cursor_fill(s : DbindexhashCursor, v : Double) -> DbindexhashCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_cursor_min(s : DbindexhashCursor) -> Double { @_common.min(s.data) }

pub fn db_index_hash_cursor_max(s : DbindexhashCursor) -> Double { @_common.max(s.data) }

pub fn db_index_hash_cursor_to_string(s : DbindexhashCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_view_make(size : Int) -> DbindexhashView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_view_len(s : DbindexhashView) -> Int { s.size }

pub fn db_index_hash_view_get(s : DbindexhashView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_view_set(s : DbindexhashView, i : Int, v : Double) -> DbindexhashView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_view_sum(s : DbindexhashView) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_view_mean(s : DbindexhashView) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_view_scale(s : DbindexhashView, f : Double) -> DbindexhashView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_view_add(a : DbindexhashView, b : DbindexhashView) -> DbindexhashView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_view_copy(s : DbindexhashView) -> DbindexhashView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_view_fill(s : DbindexhashView, v : Double) -> DbindexhashView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_view_min(s : DbindexhashView) -> Double { @_common.min(s.data) }

pub fn db_index_hash_view_max(s : DbindexhashView) -> Double { @_common.max(s.data) }

pub fn db_index_hash_view_to_string(s : DbindexhashView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_range_make(size : Int) -> DbindexhashRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_range_len(s : DbindexhashRange) -> Int { s.size }

pub fn db_index_hash_range_get(s : DbindexhashRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_range_set(s : DbindexhashRange, i : Int, v : Double) -> DbindexhashRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_range_sum(s : DbindexhashRange) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_range_mean(s : DbindexhashRange) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_range_scale(s : DbindexhashRange, f : Double) -> DbindexhashRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_range_add(a : DbindexhashRange, b : DbindexhashRange) -> DbindexhashRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_range_copy(s : DbindexhashRange) -> DbindexhashRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_range_fill(s : DbindexhashRange, v : Double) -> DbindexhashRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_range_min(s : DbindexhashRange) -> Double { @_common.min(s.data) }

pub fn db_index_hash_range_max(s : DbindexhashRange) -> Double { @_common.max(s.data) }

pub fn db_index_hash_range_to_string(s : DbindexhashRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_slice_make(size : Int) -> DbindexhashSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_slice_len(s : DbindexhashSlice) -> Int { s.size }

pub fn db_index_hash_slice_get(s : DbindexhashSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_slice_set(s : DbindexhashSlice, i : Int, v : Double) -> DbindexhashSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_hash_slice_sum(s : DbindexhashSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_hash_slice_mean(s : DbindexhashSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_hash_slice_scale(s : DbindexhashSlice, f : Double) -> DbindexhashSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_hash_slice_add(a : DbindexhashSlice, b : DbindexhashSlice) -> DbindexhashSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_hash_slice_copy(s : DbindexhashSlice) -> DbindexhashSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_hash_slice_fill(s : DbindexhashSlice, v : Double) -> DbindexhashSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_hash_slice_min(s : DbindexhashSlice) -> Double { @_common.min(s.data) }

pub fn db_index_hash_slice_max(s : DbindexhashSlice) -> Double { @_common.max(s.data) }

pub fn db_index_hash_slice_to_string(s : DbindexhashSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

