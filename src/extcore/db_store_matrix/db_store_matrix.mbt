///===
/// extcore/db_store_matrix

pub(all) struct DbstorematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_matrix_make_point(x : Double, y : Double) -> DbstorematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_matrix_make_point3(x : Double, y : Double, z : Double) -> DbstorematrixPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorematrixPoint::x(self : DbstorematrixPoint) -> Double { self.x }

pub fn DbstorematrixPoint::y(self : DbstorematrixPoint) -> Double { self.y }

pub fn DbstorematrixPoint::z(self : DbstorematrixPoint) -> Double { self.z }

pub fn DbstorematrixPoint::label(self : DbstorematrixPoint) -> Int { self.label }

pub fn DbstorematrixPoint::dist(self : DbstorematrixPoint, other : DbstorematrixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorematrixPoint::add(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorematrixPoint::sub(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorematrixPoint::scale(self : DbstorematrixPoint, s : Double) -> DbstorematrixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorematrixPoint::dot(self : DbstorematrixPoint, other : DbstorematrixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorematrixPoint::cross(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorematrixPoint::norm(self : DbstorematrixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorematrixPoint::normalize(self : DbstorematrixPoint) -> DbstorematrixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorematrixPoint::negate(self : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorematrixPoint::mid(self : DbstorematrixPoint, other : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorematrixPoint::lerp(self : DbstorematrixPoint, other : DbstorematrixPoint, t : Double) -> DbstorematrixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorematrixPoint::to_string(self : DbstorematrixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_matrix_make_series(vals : Array[Double], name : String) -> DbstorematrixSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorematrixSeries::len(self : DbstorematrixSeries) -> Int { self.vals.length() }

pub fn DbstorematrixSeries::sum(self : DbstorematrixSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorematrixSeries::mean(self : DbstorematrixSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorematrixSeries::min(self : DbstorematrixSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorematrixSeries::max(self : DbstorematrixSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorematrixSeries::range(self : DbstorematrixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorematrixSeries::variance(self : DbstorematrixSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorematrixSeries::std(self : DbstorematrixSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorematrixSeries::median(self : DbstorematrixSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorematrixSeries::scale(self : DbstorematrixSeries, f : Double) -> DbstorematrixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorematrixSeries::add(self : DbstorematrixSeries, other : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorematrixSeries::sub(self : DbstorematrixSeries, other : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorematrixSeries::normalize(self : DbstorematrixSeries) -> DbstorematrixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorematrixSeries::cumsum(self : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorematrixSeries::to_string(self : DbstorematrixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_matrix_matrix_identity(n : Int) -> DbstorematrixMatrix {
  let m = db_store_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorematrixMatrix::get(self : DbstorematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorematrixMatrix::transpose(self : DbstorematrixMatrix) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorematrixMatrix::add(self : DbstorematrixMatrix, other : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorematrixMatrix::scale(self : DbstorematrixMatrix, s : Double) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorematrixMatrix::multiply(self : DbstorematrixMatrix, other : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if self.cols != other.rows { return db_store_matrix_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_matrix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorematrixMatrix::trace(self : DbstorematrixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorematrixMatrix::det(self : DbstorematrixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorematrixMatrix::norm(self : DbstorematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorematrixMatrix::to_string(self : DbstorematrixMatrix) -> String {
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

pub(all) struct DbstorematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_matrix_make_vector(comps : Array[Double]) -> DbstorematrixVector {
  { comps, dim: comps.length() }
}

pub fn db_store_matrix_vector_zero(dim : Int) -> DbstorematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorematrixVector::add(self : DbstorematrixVector, other : DbstorematrixVector) -> DbstorematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorematrixVector::sub(self : DbstorematrixVector, other : DbstorematrixVector) -> DbstorematrixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorematrixVector::scale(self : DbstorematrixVector, s : Double) -> DbstorematrixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorematrixVector::dot(self : DbstorematrixVector, other : DbstorematrixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorematrixVector::norm(self : DbstorematrixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorematrixVector::normalize(self : DbstorematrixVector) -> DbstorematrixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorematrixVector::dist(self : DbstorematrixVector, other : DbstorematrixVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorematrixVector::to_string(self : DbstorematrixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_matrix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_matrix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_matrix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_matrix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_matrix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_matrix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_matrix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_matrix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_matrix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_matrix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_matrix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_matrix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_matrix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_matrix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_matrix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_matrix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_matrix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_matrix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_matrix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_frame_make(size : Int) -> DbstorematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_frame_len(s : DbstorematrixFrame) -> Int { s.size }

pub fn db_store_matrix_frame_get(s : DbstorematrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_frame_set(s : DbstorematrixFrame, i : Int, v : Double) -> DbstorematrixFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_sum(s : DbstorematrixFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_frame_mean(s : DbstorematrixFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_frame_scale(s : DbstorematrixFrame, f : Double) -> DbstorematrixFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_add(a : DbstorematrixFrame, b : DbstorematrixFrame) -> DbstorematrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_frame_copy(s : DbstorematrixFrame) -> DbstorematrixFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_fill(s : DbstorematrixFrame, v : Double) -> DbstorematrixFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_min(s : DbstorematrixFrame) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_frame_max(s : DbstorematrixFrame) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_frame_to_string(s : DbstorematrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_table_make(size : Int) -> DbstorematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_table_len(s : DbstorematrixTable) -> Int { s.size }

pub fn db_store_matrix_table_get(s : DbstorematrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_table_set(s : DbstorematrixTable, i : Int, v : Double) -> DbstorematrixTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_sum(s : DbstorematrixTable) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_table_mean(s : DbstorematrixTable) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_table_scale(s : DbstorematrixTable, f : Double) -> DbstorematrixTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_add(a : DbstorematrixTable, b : DbstorematrixTable) -> DbstorematrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_table_copy(s : DbstorematrixTable) -> DbstorematrixTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_fill(s : DbstorematrixTable, v : Double) -> DbstorematrixTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_min(s : DbstorematrixTable) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_table_max(s : DbstorematrixTable) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_table_to_string(s : DbstorematrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_graphn_make(size : Int) -> DbstorematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_graphn_len(s : DbstorematrixGraphN) -> Int { s.size }

pub fn db_store_matrix_graphn_get(s : DbstorematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_graphn_set(s : DbstorematrixGraphN, i : Int, v : Double) -> DbstorematrixGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_sum(s : DbstorematrixGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_graphn_mean(s : DbstorematrixGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_graphn_scale(s : DbstorematrixGraphN, f : Double) -> DbstorematrixGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_add(a : DbstorematrixGraphN, b : DbstorematrixGraphN) -> DbstorematrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_graphn_copy(s : DbstorematrixGraphN) -> DbstorematrixGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_fill(s : DbstorematrixGraphN, v : Double) -> DbstorematrixGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_min(s : DbstorematrixGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_graphn_max(s : DbstorematrixGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_graphn_to_string(s : DbstorematrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_node_make(size : Int) -> DbstorematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_node_len(s : DbstorematrixNode) -> Int { s.size }

pub fn db_store_matrix_node_get(s : DbstorematrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_node_set(s : DbstorematrixNode, i : Int, v : Double) -> DbstorematrixNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_sum(s : DbstorematrixNode) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_node_mean(s : DbstorematrixNode) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_node_scale(s : DbstorematrixNode, f : Double) -> DbstorematrixNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_add(a : DbstorematrixNode, b : DbstorematrixNode) -> DbstorematrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_node_copy(s : DbstorematrixNode) -> DbstorematrixNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_fill(s : DbstorematrixNode, v : Double) -> DbstorematrixNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_min(s : DbstorematrixNode) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_node_max(s : DbstorematrixNode) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_node_to_string(s : DbstorematrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_edge_make(size : Int) -> DbstorematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_edge_len(s : DbstorematrixEdge) -> Int { s.size }

pub fn db_store_matrix_edge_get(s : DbstorematrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_edge_set(s : DbstorematrixEdge, i : Int, v : Double) -> DbstorematrixEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_sum(s : DbstorematrixEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_edge_mean(s : DbstorematrixEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_edge_scale(s : DbstorematrixEdge, f : Double) -> DbstorematrixEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_add(a : DbstorematrixEdge, b : DbstorematrixEdge) -> DbstorematrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_edge_copy(s : DbstorematrixEdge) -> DbstorematrixEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_fill(s : DbstorematrixEdge, v : Double) -> DbstorematrixEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_min(s : DbstorematrixEdge) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_edge_max(s : DbstorematrixEdge) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_edge_to_string(s : DbstorematrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_path_make(size : Int) -> DbstorematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_path_len(s : DbstorematrixPath) -> Int { s.size }

pub fn db_store_matrix_path_get(s : DbstorematrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_path_set(s : DbstorematrixPath, i : Int, v : Double) -> DbstorematrixPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_sum(s : DbstorematrixPath) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_path_mean(s : DbstorematrixPath) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_path_scale(s : DbstorematrixPath, f : Double) -> DbstorematrixPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_add(a : DbstorematrixPath, b : DbstorematrixPath) -> DbstorematrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_path_copy(s : DbstorematrixPath) -> DbstorematrixPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_fill(s : DbstorematrixPath, v : Double) -> DbstorematrixPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_min(s : DbstorematrixPath) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_path_max(s : DbstorematrixPath) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_path_to_string(s : DbstorematrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cluster_make(size : Int) -> DbstorematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_cluster_len(s : DbstorematrixCluster) -> Int { s.size }

pub fn db_store_matrix_cluster_get(s : DbstorematrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_cluster_set(s : DbstorematrixCluster, i : Int, v : Double) -> DbstorematrixCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_sum(s : DbstorematrixCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_cluster_mean(s : DbstorematrixCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_cluster_scale(s : DbstorematrixCluster, f : Double) -> DbstorematrixCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_add(a : DbstorematrixCluster, b : DbstorematrixCluster) -> DbstorematrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_cluster_copy(s : DbstorematrixCluster) -> DbstorematrixCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_fill(s : DbstorematrixCluster, v : Double) -> DbstorematrixCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_min(s : DbstorematrixCluster) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_cluster_max(s : DbstorematrixCluster) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_cluster_to_string(s : DbstorematrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_model_make(size : Int) -> DbstorematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_model_len(s : DbstorematrixModel) -> Int { s.size }

pub fn db_store_matrix_model_get(s : DbstorematrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_model_set(s : DbstorematrixModel, i : Int, v : Double) -> DbstorematrixModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_sum(s : DbstorematrixModel) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_model_mean(s : DbstorematrixModel) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_model_scale(s : DbstorematrixModel, f : Double) -> DbstorematrixModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_add(a : DbstorematrixModel, b : DbstorematrixModel) -> DbstorematrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_model_copy(s : DbstorematrixModel) -> DbstorematrixModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_fill(s : DbstorematrixModel, v : Double) -> DbstorematrixModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_min(s : DbstorematrixModel) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_model_max(s : DbstorematrixModel) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_model_to_string(s : DbstorematrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_layer_make(size : Int) -> DbstorematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_layer_len(s : DbstorematrixLayer) -> Int { s.size }

pub fn db_store_matrix_layer_get(s : DbstorematrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_layer_set(s : DbstorematrixLayer, i : Int, v : Double) -> DbstorematrixLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_sum(s : DbstorematrixLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_layer_mean(s : DbstorematrixLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_layer_scale(s : DbstorematrixLayer, f : Double) -> DbstorematrixLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_add(a : DbstorematrixLayer, b : DbstorematrixLayer) -> DbstorematrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_layer_copy(s : DbstorematrixLayer) -> DbstorematrixLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_fill(s : DbstorematrixLayer, v : Double) -> DbstorematrixLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_min(s : DbstorematrixLayer) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_layer_max(s : DbstorematrixLayer) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_layer_to_string(s : DbstorematrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_buffer_make(size : Int) -> DbstorematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_buffer_len(s : DbstorematrixBuffer) -> Int { s.size }

pub fn db_store_matrix_buffer_get(s : DbstorematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_buffer_set(s : DbstorematrixBuffer, i : Int, v : Double) -> DbstorematrixBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_sum(s : DbstorematrixBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_buffer_mean(s : DbstorematrixBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_buffer_scale(s : DbstorematrixBuffer, f : Double) -> DbstorematrixBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_add(a : DbstorematrixBuffer, b : DbstorematrixBuffer) -> DbstorematrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_buffer_copy(s : DbstorematrixBuffer) -> DbstorematrixBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_fill(s : DbstorematrixBuffer, v : Double) -> DbstorematrixBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_min(s : DbstorematrixBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_buffer_max(s : DbstorematrixBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_buffer_to_string(s : DbstorematrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cursor_make(size : Int) -> DbstorematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_cursor_len(s : DbstorematrixCursor) -> Int { s.size }

pub fn db_store_matrix_cursor_get(s : DbstorematrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_cursor_set(s : DbstorematrixCursor, i : Int, v : Double) -> DbstorematrixCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_sum(s : DbstorematrixCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_cursor_mean(s : DbstorematrixCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_cursor_scale(s : DbstorematrixCursor, f : Double) -> DbstorematrixCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_add(a : DbstorematrixCursor, b : DbstorematrixCursor) -> DbstorematrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_cursor_copy(s : DbstorematrixCursor) -> DbstorematrixCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_fill(s : DbstorematrixCursor, v : Double) -> DbstorematrixCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_min(s : DbstorematrixCursor) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_cursor_max(s : DbstorematrixCursor) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_cursor_to_string(s : DbstorematrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_view_make(size : Int) -> DbstorematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_view_len(s : DbstorematrixView) -> Int { s.size }

pub fn db_store_matrix_view_get(s : DbstorematrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_view_set(s : DbstorematrixView, i : Int, v : Double) -> DbstorematrixView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_sum(s : DbstorematrixView) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_view_mean(s : DbstorematrixView) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_view_scale(s : DbstorematrixView, f : Double) -> DbstorematrixView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_add(a : DbstorematrixView, b : DbstorematrixView) -> DbstorematrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_view_copy(s : DbstorematrixView) -> DbstorematrixView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_fill(s : DbstorematrixView, v : Double) -> DbstorematrixView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_min(s : DbstorematrixView) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_view_max(s : DbstorematrixView) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_view_to_string(s : DbstorematrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_range_make(size : Int) -> DbstorematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_range_len(s : DbstorematrixRange) -> Int { s.size }

pub fn db_store_matrix_range_get(s : DbstorematrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_range_set(s : DbstorematrixRange, i : Int, v : Double) -> DbstorematrixRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_sum(s : DbstorematrixRange) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_range_mean(s : DbstorematrixRange) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_range_scale(s : DbstorematrixRange, f : Double) -> DbstorematrixRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_add(a : DbstorematrixRange, b : DbstorematrixRange) -> DbstorematrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_range_copy(s : DbstorematrixRange) -> DbstorematrixRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_fill(s : DbstorematrixRange, v : Double) -> DbstorematrixRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_min(s : DbstorematrixRange) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_range_max(s : DbstorematrixRange) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_range_to_string(s : DbstorematrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_slice_make(size : Int) -> DbstorematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_slice_len(s : DbstorematrixSlice) -> Int { s.size }

pub fn db_store_matrix_slice_get(s : DbstorematrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_slice_set(s : DbstorematrixSlice, i : Int, v : Double) -> DbstorematrixSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_sum(s : DbstorematrixSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_slice_mean(s : DbstorematrixSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_slice_scale(s : DbstorematrixSlice, f : Double) -> DbstorematrixSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_add(a : DbstorematrixSlice, b : DbstorematrixSlice) -> DbstorematrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_slice_copy(s : DbstorematrixSlice) -> DbstorematrixSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_fill(s : DbstorematrixSlice, v : Double) -> DbstorematrixSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_min(s : DbstorematrixSlice) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_slice_max(s : DbstorematrixSlice) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_slice_to_string(s : DbstorematrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

