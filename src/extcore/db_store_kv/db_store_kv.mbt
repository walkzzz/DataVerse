///===
/// extcore/db_store_kv

pub(all) struct DbstorekvPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_kv_make_point(x : Double, y : Double) -> DbstorekvPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_kv_make_point3(x : Double, y : Double, z : Double) -> DbstorekvPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorekvPoint::x(self : DbstorekvPoint) -> Double { self.x }

pub fn DbstorekvPoint::y(self : DbstorekvPoint) -> Double { self.y }

pub fn DbstorekvPoint::z(self : DbstorekvPoint) -> Double { self.z }

pub fn DbstorekvPoint::label(self : DbstorekvPoint) -> Int { self.label }

pub fn DbstorekvPoint::dist(self : DbstorekvPoint, other : DbstorekvPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorekvPoint::add(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorekvPoint::sub(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorekvPoint::scale(self : DbstorekvPoint, s : Double) -> DbstorekvPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorekvPoint::dot(self : DbstorekvPoint, other : DbstorekvPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorekvPoint::cross(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorekvPoint::norm(self : DbstorekvPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorekvPoint::normalize(self : DbstorekvPoint) -> DbstorekvPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorekvPoint::negate(self : DbstorekvPoint) -> DbstorekvPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorekvPoint::mid(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorekvPoint::lerp(self : DbstorekvPoint, other : DbstorekvPoint, t : Double) -> DbstorekvPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorekvPoint::to_string(self : DbstorekvPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorekvSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_kv_make_series(vals : Array[Double], name : String) -> DbstorekvSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorekvSeries::len(self : DbstorekvSeries) -> Int { self.vals.length() }

pub fn DbstorekvSeries::sum(self : DbstorekvSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorekvSeries::mean(self : DbstorekvSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorekvSeries::min(self : DbstorekvSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorekvSeries::max(self : DbstorekvSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorekvSeries::range(self : DbstorekvSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorekvSeries::variance(self : DbstorekvSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorekvSeries::std(self : DbstorekvSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorekvSeries::median(self : DbstorekvSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorekvSeries::scale(self : DbstorekvSeries, f : Double) -> DbstorekvSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorekvSeries::add(self : DbstorekvSeries, other : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorekvSeries::sub(self : DbstorekvSeries, other : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorekvSeries::normalize(self : DbstorekvSeries) -> DbstorekvSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorekvSeries::cumsum(self : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorekvSeries::to_string(self : DbstorekvSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorekvMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_kv_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorekvMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_kv_matrix_identity(n : Int) -> DbstorekvMatrix {
  let m = db_store_kv_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorekvMatrix::get(self : DbstorekvMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorekvMatrix::transpose(self : DbstorekvMatrix) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorekvMatrix::add(self : DbstorekvMatrix, other : DbstorekvMatrix) -> DbstorekvMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_kv_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorekvMatrix::scale(self : DbstorekvMatrix, s : Double) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorekvMatrix::multiply(self : DbstorekvMatrix, other : DbstorekvMatrix) -> DbstorekvMatrix {
  if self.cols != other.rows { return db_store_kv_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_kv_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorekvMatrix::trace(self : DbstorekvMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorekvMatrix::det(self : DbstorekvMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorekvMatrix::norm(self : DbstorekvMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorekvMatrix::to_string(self : DbstorekvMatrix) -> String {
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

pub(all) struct DbstorekvVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_kv_make_vector(comps : Array[Double]) -> DbstorekvVector {
  { comps, dim: comps.length() }
}

pub fn db_store_kv_vector_zero(dim : Int) -> DbstorekvVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorekvVector::add(self : DbstorekvVector, other : DbstorekvVector) -> DbstorekvVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorekvVector::sub(self : DbstorekvVector, other : DbstorekvVector) -> DbstorekvVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorekvVector::scale(self : DbstorekvVector, s : Double) -> DbstorekvVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorekvVector::dot(self : DbstorekvVector, other : DbstorekvVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorekvVector::norm(self : DbstorekvVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorekvVector::normalize(self : DbstorekvVector) -> DbstorekvVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorekvVector::dist(self : DbstorekvVector, other : DbstorekvVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorekvVector::to_string(self : DbstorekvVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_kv_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_kv_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_kv_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_kv_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_kv_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_kv_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_kv_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_kv_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_kv_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_kv_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_kv_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_kv_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_kv_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_kv_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_kv_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_kv_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_kv_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_kv_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_kv_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_kv_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_kv_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_kv_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_kv_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_kv_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_kv_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_kv_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_kv_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_kv_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_kv_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorekvFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_frame_make(size : Int) -> DbstorekvFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_frame_len(s : DbstorekvFrame) -> Int { s.size }

pub fn db_store_kv_frame_get(s : DbstorekvFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_frame_set(s : DbstorekvFrame, i : Int, v : Double) -> DbstorekvFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_sum(s : DbstorekvFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_frame_mean(s : DbstorekvFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_frame_scale(s : DbstorekvFrame, f : Double) -> DbstorekvFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_add(a : DbstorekvFrame, b : DbstorekvFrame) -> DbstorekvFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_frame_copy(s : DbstorekvFrame) -> DbstorekvFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_fill(s : DbstorekvFrame, v : Double) -> DbstorekvFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_min(s : DbstorekvFrame) -> Double { @_common.min(s.data) }

pub fn db_store_kv_frame_max(s : DbstorekvFrame) -> Double { @_common.max(s.data) }

pub fn db_store_kv_frame_to_string(s : DbstorekvFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_table_make(size : Int) -> DbstorekvTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_table_len(s : DbstorekvTable) -> Int { s.size }

pub fn db_store_kv_table_get(s : DbstorekvTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_table_set(s : DbstorekvTable, i : Int, v : Double) -> DbstorekvTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_sum(s : DbstorekvTable) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_table_mean(s : DbstorekvTable) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_table_scale(s : DbstorekvTable, f : Double) -> DbstorekvTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_add(a : DbstorekvTable, b : DbstorekvTable) -> DbstorekvTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_table_copy(s : DbstorekvTable) -> DbstorekvTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_fill(s : DbstorekvTable, v : Double) -> DbstorekvTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_min(s : DbstorekvTable) -> Double { @_common.min(s.data) }

pub fn db_store_kv_table_max(s : DbstorekvTable) -> Double { @_common.max(s.data) }

pub fn db_store_kv_table_to_string(s : DbstorekvTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_graphn_make(size : Int) -> DbstorekvGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_graphn_len(s : DbstorekvGraphN) -> Int { s.size }

pub fn db_store_kv_graphn_get(s : DbstorekvGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_graphn_set(s : DbstorekvGraphN, i : Int, v : Double) -> DbstorekvGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_sum(s : DbstorekvGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_graphn_mean(s : DbstorekvGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_graphn_scale(s : DbstorekvGraphN, f : Double) -> DbstorekvGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_add(a : DbstorekvGraphN, b : DbstorekvGraphN) -> DbstorekvGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_graphn_copy(s : DbstorekvGraphN) -> DbstorekvGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_fill(s : DbstorekvGraphN, v : Double) -> DbstorekvGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_min(s : DbstorekvGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_kv_graphn_max(s : DbstorekvGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_kv_graphn_to_string(s : DbstorekvGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_node_make(size : Int) -> DbstorekvNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_node_len(s : DbstorekvNode) -> Int { s.size }

pub fn db_store_kv_node_get(s : DbstorekvNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_node_set(s : DbstorekvNode, i : Int, v : Double) -> DbstorekvNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_sum(s : DbstorekvNode) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_node_mean(s : DbstorekvNode) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_node_scale(s : DbstorekvNode, f : Double) -> DbstorekvNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_add(a : DbstorekvNode, b : DbstorekvNode) -> DbstorekvNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_node_copy(s : DbstorekvNode) -> DbstorekvNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_fill(s : DbstorekvNode, v : Double) -> DbstorekvNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_min(s : DbstorekvNode) -> Double { @_common.min(s.data) }

pub fn db_store_kv_node_max(s : DbstorekvNode) -> Double { @_common.max(s.data) }

pub fn db_store_kv_node_to_string(s : DbstorekvNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_edge_make(size : Int) -> DbstorekvEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_edge_len(s : DbstorekvEdge) -> Int { s.size }

pub fn db_store_kv_edge_get(s : DbstorekvEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_edge_set(s : DbstorekvEdge, i : Int, v : Double) -> DbstorekvEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_sum(s : DbstorekvEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_edge_mean(s : DbstorekvEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_edge_scale(s : DbstorekvEdge, f : Double) -> DbstorekvEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_add(a : DbstorekvEdge, b : DbstorekvEdge) -> DbstorekvEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_edge_copy(s : DbstorekvEdge) -> DbstorekvEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_fill(s : DbstorekvEdge, v : Double) -> DbstorekvEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_min(s : DbstorekvEdge) -> Double { @_common.min(s.data) }

pub fn db_store_kv_edge_max(s : DbstorekvEdge) -> Double { @_common.max(s.data) }

pub fn db_store_kv_edge_to_string(s : DbstorekvEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_path_make(size : Int) -> DbstorekvPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_path_len(s : DbstorekvPath) -> Int { s.size }

pub fn db_store_kv_path_get(s : DbstorekvPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_path_set(s : DbstorekvPath, i : Int, v : Double) -> DbstorekvPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_sum(s : DbstorekvPath) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_path_mean(s : DbstorekvPath) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_path_scale(s : DbstorekvPath, f : Double) -> DbstorekvPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_add(a : DbstorekvPath, b : DbstorekvPath) -> DbstorekvPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_path_copy(s : DbstorekvPath) -> DbstorekvPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_fill(s : DbstorekvPath, v : Double) -> DbstorekvPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_min(s : DbstorekvPath) -> Double { @_common.min(s.data) }

pub fn db_store_kv_path_max(s : DbstorekvPath) -> Double { @_common.max(s.data) }

pub fn db_store_kv_path_to_string(s : DbstorekvPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cluster_make(size : Int) -> DbstorekvCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_cluster_len(s : DbstorekvCluster) -> Int { s.size }

pub fn db_store_kv_cluster_get(s : DbstorekvCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_cluster_set(s : DbstorekvCluster, i : Int, v : Double) -> DbstorekvCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_sum(s : DbstorekvCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_cluster_mean(s : DbstorekvCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_cluster_scale(s : DbstorekvCluster, f : Double) -> DbstorekvCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_add(a : DbstorekvCluster, b : DbstorekvCluster) -> DbstorekvCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_cluster_copy(s : DbstorekvCluster) -> DbstorekvCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_fill(s : DbstorekvCluster, v : Double) -> DbstorekvCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_min(s : DbstorekvCluster) -> Double { @_common.min(s.data) }

pub fn db_store_kv_cluster_max(s : DbstorekvCluster) -> Double { @_common.max(s.data) }

pub fn db_store_kv_cluster_to_string(s : DbstorekvCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_model_make(size : Int) -> DbstorekvModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_model_len(s : DbstorekvModel) -> Int { s.size }

pub fn db_store_kv_model_get(s : DbstorekvModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_model_set(s : DbstorekvModel, i : Int, v : Double) -> DbstorekvModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_sum(s : DbstorekvModel) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_model_mean(s : DbstorekvModel) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_model_scale(s : DbstorekvModel, f : Double) -> DbstorekvModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_add(a : DbstorekvModel, b : DbstorekvModel) -> DbstorekvModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_model_copy(s : DbstorekvModel) -> DbstorekvModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_fill(s : DbstorekvModel, v : Double) -> DbstorekvModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_min(s : DbstorekvModel) -> Double { @_common.min(s.data) }

pub fn db_store_kv_model_max(s : DbstorekvModel) -> Double { @_common.max(s.data) }

pub fn db_store_kv_model_to_string(s : DbstorekvModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_layer_make(size : Int) -> DbstorekvLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_layer_len(s : DbstorekvLayer) -> Int { s.size }

pub fn db_store_kv_layer_get(s : DbstorekvLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_layer_set(s : DbstorekvLayer, i : Int, v : Double) -> DbstorekvLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_sum(s : DbstorekvLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_layer_mean(s : DbstorekvLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_layer_scale(s : DbstorekvLayer, f : Double) -> DbstorekvLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_add(a : DbstorekvLayer, b : DbstorekvLayer) -> DbstorekvLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_layer_copy(s : DbstorekvLayer) -> DbstorekvLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_fill(s : DbstorekvLayer, v : Double) -> DbstorekvLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_min(s : DbstorekvLayer) -> Double { @_common.min(s.data) }

pub fn db_store_kv_layer_max(s : DbstorekvLayer) -> Double { @_common.max(s.data) }

pub fn db_store_kv_layer_to_string(s : DbstorekvLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_buffer_make(size : Int) -> DbstorekvBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_buffer_len(s : DbstorekvBuffer) -> Int { s.size }

pub fn db_store_kv_buffer_get(s : DbstorekvBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_buffer_set(s : DbstorekvBuffer, i : Int, v : Double) -> DbstorekvBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_sum(s : DbstorekvBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_buffer_mean(s : DbstorekvBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_buffer_scale(s : DbstorekvBuffer, f : Double) -> DbstorekvBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_add(a : DbstorekvBuffer, b : DbstorekvBuffer) -> DbstorekvBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_buffer_copy(s : DbstorekvBuffer) -> DbstorekvBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_fill(s : DbstorekvBuffer, v : Double) -> DbstorekvBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_min(s : DbstorekvBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_kv_buffer_max(s : DbstorekvBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_kv_buffer_to_string(s : DbstorekvBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cursor_make(size : Int) -> DbstorekvCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_cursor_len(s : DbstorekvCursor) -> Int { s.size }

pub fn db_store_kv_cursor_get(s : DbstorekvCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_cursor_set(s : DbstorekvCursor, i : Int, v : Double) -> DbstorekvCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_sum(s : DbstorekvCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_cursor_mean(s : DbstorekvCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_cursor_scale(s : DbstorekvCursor, f : Double) -> DbstorekvCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_add(a : DbstorekvCursor, b : DbstorekvCursor) -> DbstorekvCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_cursor_copy(s : DbstorekvCursor) -> DbstorekvCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_fill(s : DbstorekvCursor, v : Double) -> DbstorekvCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_min(s : DbstorekvCursor) -> Double { @_common.min(s.data) }

pub fn db_store_kv_cursor_max(s : DbstorekvCursor) -> Double { @_common.max(s.data) }

pub fn db_store_kv_cursor_to_string(s : DbstorekvCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_view_make(size : Int) -> DbstorekvView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_view_len(s : DbstorekvView) -> Int { s.size }

pub fn db_store_kv_view_get(s : DbstorekvView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_view_set(s : DbstorekvView, i : Int, v : Double) -> DbstorekvView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_sum(s : DbstorekvView) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_view_mean(s : DbstorekvView) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_view_scale(s : DbstorekvView, f : Double) -> DbstorekvView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_add(a : DbstorekvView, b : DbstorekvView) -> DbstorekvView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_view_copy(s : DbstorekvView) -> DbstorekvView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_fill(s : DbstorekvView, v : Double) -> DbstorekvView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_min(s : DbstorekvView) -> Double { @_common.min(s.data) }

pub fn db_store_kv_view_max(s : DbstorekvView) -> Double { @_common.max(s.data) }

pub fn db_store_kv_view_to_string(s : DbstorekvView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_range_make(size : Int) -> DbstorekvRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_range_len(s : DbstorekvRange) -> Int { s.size }

pub fn db_store_kv_range_get(s : DbstorekvRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_range_set(s : DbstorekvRange, i : Int, v : Double) -> DbstorekvRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_sum(s : DbstorekvRange) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_range_mean(s : DbstorekvRange) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_range_scale(s : DbstorekvRange, f : Double) -> DbstorekvRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_add(a : DbstorekvRange, b : DbstorekvRange) -> DbstorekvRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_range_copy(s : DbstorekvRange) -> DbstorekvRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_fill(s : DbstorekvRange, v : Double) -> DbstorekvRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_min(s : DbstorekvRange) -> Double { @_common.min(s.data) }

pub fn db_store_kv_range_max(s : DbstorekvRange) -> Double { @_common.max(s.data) }

pub fn db_store_kv_range_to_string(s : DbstorekvRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_slice_make(size : Int) -> DbstorekvSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_slice_len(s : DbstorekvSlice) -> Int { s.size }

pub fn db_store_kv_slice_get(s : DbstorekvSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_slice_set(s : DbstorekvSlice, i : Int, v : Double) -> DbstorekvSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_sum(s : DbstorekvSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_slice_mean(s : DbstorekvSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_slice_scale(s : DbstorekvSlice, f : Double) -> DbstorekvSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_add(a : DbstorekvSlice, b : DbstorekvSlice) -> DbstorekvSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_slice_copy(s : DbstorekvSlice) -> DbstorekvSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_fill(s : DbstorekvSlice, v : Double) -> DbstorekvSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_min(s : DbstorekvSlice) -> Double { @_common.min(s.data) }

pub fn db_store_kv_slice_max(s : DbstorekvSlice) -> Double { @_common.max(s.data) }

pub fn db_store_kv_slice_to_string(s : DbstorekvSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

