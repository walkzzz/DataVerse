///===
/// extcore/db_store_row

pub(all) struct DbstorerowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_row_make_point(x : Double, y : Double) -> DbstorerowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_row_make_point3(x : Double, y : Double, z : Double) -> DbstorerowPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorerowPoint::x(self : DbstorerowPoint) -> Double { self.x }

pub fn DbstorerowPoint::y(self : DbstorerowPoint) -> Double { self.y }

pub fn DbstorerowPoint::z(self : DbstorerowPoint) -> Double { self.z }

pub fn DbstorerowPoint::label(self : DbstorerowPoint) -> Int { self.label }

pub fn DbstorerowPoint::dist(self : DbstorerowPoint, other : DbstorerowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorerowPoint::add(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorerowPoint::sub(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorerowPoint::scale(self : DbstorerowPoint, s : Double) -> DbstorerowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorerowPoint::dot(self : DbstorerowPoint, other : DbstorerowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorerowPoint::cross(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorerowPoint::norm(self : DbstorerowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorerowPoint::normalize(self : DbstorerowPoint) -> DbstorerowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorerowPoint::negate(self : DbstorerowPoint) -> DbstorerowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorerowPoint::mid(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorerowPoint::lerp(self : DbstorerowPoint, other : DbstorerowPoint, t : Double) -> DbstorerowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorerowPoint::to_string(self : DbstorerowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorerowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_row_make_series(vals : Array[Double], name : String) -> DbstorerowSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorerowSeries::len(self : DbstorerowSeries) -> Int { self.vals.length() }

pub fn DbstorerowSeries::sum(self : DbstorerowSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorerowSeries::mean(self : DbstorerowSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorerowSeries::min(self : DbstorerowSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorerowSeries::max(self : DbstorerowSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorerowSeries::range(self : DbstorerowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorerowSeries::variance(self : DbstorerowSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorerowSeries::std(self : DbstorerowSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorerowSeries::median(self : DbstorerowSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorerowSeries::scale(self : DbstorerowSeries, f : Double) -> DbstorerowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorerowSeries::add(self : DbstorerowSeries, other : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorerowSeries::sub(self : DbstorerowSeries, other : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorerowSeries::normalize(self : DbstorerowSeries) -> DbstorerowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorerowSeries::cumsum(self : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorerowSeries::to_string(self : DbstorerowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorerowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_row_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorerowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_row_matrix_identity(n : Int) -> DbstorerowMatrix {
  let m = db_store_row_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorerowMatrix::get(self : DbstorerowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorerowMatrix::transpose(self : DbstorerowMatrix) -> DbstorerowMatrix {
  let result = db_store_row_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorerowMatrix::add(self : DbstorerowMatrix, other : DbstorerowMatrix) -> DbstorerowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_row_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorerowMatrix::scale(self : DbstorerowMatrix, s : Double) -> DbstorerowMatrix {
  let result = db_store_row_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorerowMatrix::multiply(self : DbstorerowMatrix, other : DbstorerowMatrix) -> DbstorerowMatrix {
  if self.cols != other.rows { return db_store_row_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_row_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorerowMatrix::trace(self : DbstorerowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorerowMatrix::det(self : DbstorerowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorerowMatrix::norm(self : DbstorerowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorerowMatrix::to_string(self : DbstorerowMatrix) -> String {
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

pub(all) struct DbstorerowVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_row_make_vector(comps : Array[Double]) -> DbstorerowVector {
  { comps, dim: comps.length() }
}

pub fn db_store_row_vector_zero(dim : Int) -> DbstorerowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorerowVector::add(self : DbstorerowVector, other : DbstorerowVector) -> DbstorerowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorerowVector::sub(self : DbstorerowVector, other : DbstorerowVector) -> DbstorerowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorerowVector::scale(self : DbstorerowVector, s : Double) -> DbstorerowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorerowVector::dot(self : DbstorerowVector, other : DbstorerowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorerowVector::norm(self : DbstorerowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorerowVector::normalize(self : DbstorerowVector) -> DbstorerowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorerowVector::dist(self : DbstorerowVector, other : DbstorerowVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorerowVector::to_string(self : DbstorerowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_row_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_row_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_row_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_row_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_row_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_row_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_row_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_row_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_row_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_row_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_row_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_row_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_row_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_row_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_row_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_row_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_row_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_row_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_row_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_row_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_row_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_row_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_row_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_row_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_row_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_row_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_row_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_row_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_row_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorerowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_frame_make(size : Int) -> DbstorerowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_frame_len(s : DbstorerowFrame) -> Int { s.size }

pub fn db_store_row_frame_get(s : DbstorerowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_frame_set(s : DbstorerowFrame, i : Int, v : Double) -> DbstorerowFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_frame_sum(s : DbstorerowFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_row_frame_mean(s : DbstorerowFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_row_frame_scale(s : DbstorerowFrame, f : Double) -> DbstorerowFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_frame_add(a : DbstorerowFrame, b : DbstorerowFrame) -> DbstorerowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_frame_copy(s : DbstorerowFrame) -> DbstorerowFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_frame_fill(s : DbstorerowFrame, v : Double) -> DbstorerowFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_frame_min(s : DbstorerowFrame) -> Double { @_common.min(s.data) }

pub fn db_store_row_frame_max(s : DbstorerowFrame) -> Double { @_common.max(s.data) }

pub fn db_store_row_frame_to_string(s : DbstorerowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_table_make(size : Int) -> DbstorerowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_table_len(s : DbstorerowTable) -> Int { s.size }

pub fn db_store_row_table_get(s : DbstorerowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_table_set(s : DbstorerowTable, i : Int, v : Double) -> DbstorerowTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_table_sum(s : DbstorerowTable) -> Double { @_common.sum(s.data) }

pub fn db_store_row_table_mean(s : DbstorerowTable) -> Double { @_common.mean(s.data) }

pub fn db_store_row_table_scale(s : DbstorerowTable, f : Double) -> DbstorerowTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_table_add(a : DbstorerowTable, b : DbstorerowTable) -> DbstorerowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_table_copy(s : DbstorerowTable) -> DbstorerowTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_table_fill(s : DbstorerowTable, v : Double) -> DbstorerowTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_table_min(s : DbstorerowTable) -> Double { @_common.min(s.data) }

pub fn db_store_row_table_max(s : DbstorerowTable) -> Double { @_common.max(s.data) }

pub fn db_store_row_table_to_string(s : DbstorerowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_graphn_make(size : Int) -> DbstorerowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_graphn_len(s : DbstorerowGraphN) -> Int { s.size }

pub fn db_store_row_graphn_get(s : DbstorerowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_graphn_set(s : DbstorerowGraphN, i : Int, v : Double) -> DbstorerowGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_graphn_sum(s : DbstorerowGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_row_graphn_mean(s : DbstorerowGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_row_graphn_scale(s : DbstorerowGraphN, f : Double) -> DbstorerowGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_graphn_add(a : DbstorerowGraphN, b : DbstorerowGraphN) -> DbstorerowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_graphn_copy(s : DbstorerowGraphN) -> DbstorerowGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_graphn_fill(s : DbstorerowGraphN, v : Double) -> DbstorerowGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_graphn_min(s : DbstorerowGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_row_graphn_max(s : DbstorerowGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_row_graphn_to_string(s : DbstorerowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_node_make(size : Int) -> DbstorerowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_node_len(s : DbstorerowNode) -> Int { s.size }

pub fn db_store_row_node_get(s : DbstorerowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_node_set(s : DbstorerowNode, i : Int, v : Double) -> DbstorerowNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_node_sum(s : DbstorerowNode) -> Double { @_common.sum(s.data) }

pub fn db_store_row_node_mean(s : DbstorerowNode) -> Double { @_common.mean(s.data) }

pub fn db_store_row_node_scale(s : DbstorerowNode, f : Double) -> DbstorerowNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_node_add(a : DbstorerowNode, b : DbstorerowNode) -> DbstorerowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_node_copy(s : DbstorerowNode) -> DbstorerowNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_node_fill(s : DbstorerowNode, v : Double) -> DbstorerowNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_node_min(s : DbstorerowNode) -> Double { @_common.min(s.data) }

pub fn db_store_row_node_max(s : DbstorerowNode) -> Double { @_common.max(s.data) }

pub fn db_store_row_node_to_string(s : DbstorerowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_edge_make(size : Int) -> DbstorerowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_edge_len(s : DbstorerowEdge) -> Int { s.size }

pub fn db_store_row_edge_get(s : DbstorerowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_edge_set(s : DbstorerowEdge, i : Int, v : Double) -> DbstorerowEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_edge_sum(s : DbstorerowEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_row_edge_mean(s : DbstorerowEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_row_edge_scale(s : DbstorerowEdge, f : Double) -> DbstorerowEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_edge_add(a : DbstorerowEdge, b : DbstorerowEdge) -> DbstorerowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_edge_copy(s : DbstorerowEdge) -> DbstorerowEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_edge_fill(s : DbstorerowEdge, v : Double) -> DbstorerowEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_edge_min(s : DbstorerowEdge) -> Double { @_common.min(s.data) }

pub fn db_store_row_edge_max(s : DbstorerowEdge) -> Double { @_common.max(s.data) }

pub fn db_store_row_edge_to_string(s : DbstorerowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_path_make(size : Int) -> DbstorerowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_path_len(s : DbstorerowPath) -> Int { s.size }

pub fn db_store_row_path_get(s : DbstorerowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_path_set(s : DbstorerowPath, i : Int, v : Double) -> DbstorerowPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_path_sum(s : DbstorerowPath) -> Double { @_common.sum(s.data) }

pub fn db_store_row_path_mean(s : DbstorerowPath) -> Double { @_common.mean(s.data) }

pub fn db_store_row_path_scale(s : DbstorerowPath, f : Double) -> DbstorerowPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_path_add(a : DbstorerowPath, b : DbstorerowPath) -> DbstorerowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_path_copy(s : DbstorerowPath) -> DbstorerowPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_path_fill(s : DbstorerowPath, v : Double) -> DbstorerowPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_path_min(s : DbstorerowPath) -> Double { @_common.min(s.data) }

pub fn db_store_row_path_max(s : DbstorerowPath) -> Double { @_common.max(s.data) }

pub fn db_store_row_path_to_string(s : DbstorerowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_cluster_make(size : Int) -> DbstorerowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_cluster_len(s : DbstorerowCluster) -> Int { s.size }

pub fn db_store_row_cluster_get(s : DbstorerowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_cluster_set(s : DbstorerowCluster, i : Int, v : Double) -> DbstorerowCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_cluster_sum(s : DbstorerowCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_row_cluster_mean(s : DbstorerowCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_row_cluster_scale(s : DbstorerowCluster, f : Double) -> DbstorerowCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_cluster_add(a : DbstorerowCluster, b : DbstorerowCluster) -> DbstorerowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_cluster_copy(s : DbstorerowCluster) -> DbstorerowCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_cluster_fill(s : DbstorerowCluster, v : Double) -> DbstorerowCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_cluster_min(s : DbstorerowCluster) -> Double { @_common.min(s.data) }

pub fn db_store_row_cluster_max(s : DbstorerowCluster) -> Double { @_common.max(s.data) }

pub fn db_store_row_cluster_to_string(s : DbstorerowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_model_make(size : Int) -> DbstorerowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_model_len(s : DbstorerowModel) -> Int { s.size }

pub fn db_store_row_model_get(s : DbstorerowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_model_set(s : DbstorerowModel, i : Int, v : Double) -> DbstorerowModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_model_sum(s : DbstorerowModel) -> Double { @_common.sum(s.data) }

pub fn db_store_row_model_mean(s : DbstorerowModel) -> Double { @_common.mean(s.data) }

pub fn db_store_row_model_scale(s : DbstorerowModel, f : Double) -> DbstorerowModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_model_add(a : DbstorerowModel, b : DbstorerowModel) -> DbstorerowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_model_copy(s : DbstorerowModel) -> DbstorerowModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_model_fill(s : DbstorerowModel, v : Double) -> DbstorerowModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_model_min(s : DbstorerowModel) -> Double { @_common.min(s.data) }

pub fn db_store_row_model_max(s : DbstorerowModel) -> Double { @_common.max(s.data) }

pub fn db_store_row_model_to_string(s : DbstorerowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_layer_make(size : Int) -> DbstorerowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_layer_len(s : DbstorerowLayer) -> Int { s.size }

pub fn db_store_row_layer_get(s : DbstorerowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_layer_set(s : DbstorerowLayer, i : Int, v : Double) -> DbstorerowLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_layer_sum(s : DbstorerowLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_row_layer_mean(s : DbstorerowLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_row_layer_scale(s : DbstorerowLayer, f : Double) -> DbstorerowLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_layer_add(a : DbstorerowLayer, b : DbstorerowLayer) -> DbstorerowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_layer_copy(s : DbstorerowLayer) -> DbstorerowLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_layer_fill(s : DbstorerowLayer, v : Double) -> DbstorerowLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_layer_min(s : DbstorerowLayer) -> Double { @_common.min(s.data) }

pub fn db_store_row_layer_max(s : DbstorerowLayer) -> Double { @_common.max(s.data) }

pub fn db_store_row_layer_to_string(s : DbstorerowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_buffer_make(size : Int) -> DbstorerowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_buffer_len(s : DbstorerowBuffer) -> Int { s.size }

pub fn db_store_row_buffer_get(s : DbstorerowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_buffer_set(s : DbstorerowBuffer, i : Int, v : Double) -> DbstorerowBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_buffer_sum(s : DbstorerowBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_row_buffer_mean(s : DbstorerowBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_row_buffer_scale(s : DbstorerowBuffer, f : Double) -> DbstorerowBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_buffer_add(a : DbstorerowBuffer, b : DbstorerowBuffer) -> DbstorerowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_buffer_copy(s : DbstorerowBuffer) -> DbstorerowBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_buffer_fill(s : DbstorerowBuffer, v : Double) -> DbstorerowBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_buffer_min(s : DbstorerowBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_row_buffer_max(s : DbstorerowBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_row_buffer_to_string(s : DbstorerowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_cursor_make(size : Int) -> DbstorerowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_cursor_len(s : DbstorerowCursor) -> Int { s.size }

pub fn db_store_row_cursor_get(s : DbstorerowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_cursor_set(s : DbstorerowCursor, i : Int, v : Double) -> DbstorerowCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_cursor_sum(s : DbstorerowCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_row_cursor_mean(s : DbstorerowCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_row_cursor_scale(s : DbstorerowCursor, f : Double) -> DbstorerowCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_cursor_add(a : DbstorerowCursor, b : DbstorerowCursor) -> DbstorerowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_cursor_copy(s : DbstorerowCursor) -> DbstorerowCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_cursor_fill(s : DbstorerowCursor, v : Double) -> DbstorerowCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_cursor_min(s : DbstorerowCursor) -> Double { @_common.min(s.data) }

pub fn db_store_row_cursor_max(s : DbstorerowCursor) -> Double { @_common.max(s.data) }

pub fn db_store_row_cursor_to_string(s : DbstorerowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_view_make(size : Int) -> DbstorerowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_view_len(s : DbstorerowView) -> Int { s.size }

pub fn db_store_row_view_get(s : DbstorerowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_view_set(s : DbstorerowView, i : Int, v : Double) -> DbstorerowView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_view_sum(s : DbstorerowView) -> Double { @_common.sum(s.data) }

pub fn db_store_row_view_mean(s : DbstorerowView) -> Double { @_common.mean(s.data) }

pub fn db_store_row_view_scale(s : DbstorerowView, f : Double) -> DbstorerowView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_view_add(a : DbstorerowView, b : DbstorerowView) -> DbstorerowView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_view_copy(s : DbstorerowView) -> DbstorerowView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_view_fill(s : DbstorerowView, v : Double) -> DbstorerowView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_view_min(s : DbstorerowView) -> Double { @_common.min(s.data) }

pub fn db_store_row_view_max(s : DbstorerowView) -> Double { @_common.max(s.data) }

pub fn db_store_row_view_to_string(s : DbstorerowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_range_make(size : Int) -> DbstorerowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_range_len(s : DbstorerowRange) -> Int { s.size }

pub fn db_store_row_range_get(s : DbstorerowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_range_set(s : DbstorerowRange, i : Int, v : Double) -> DbstorerowRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_range_sum(s : DbstorerowRange) -> Double { @_common.sum(s.data) }

pub fn db_store_row_range_mean(s : DbstorerowRange) -> Double { @_common.mean(s.data) }

pub fn db_store_row_range_scale(s : DbstorerowRange, f : Double) -> DbstorerowRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_range_add(a : DbstorerowRange, b : DbstorerowRange) -> DbstorerowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_range_copy(s : DbstorerowRange) -> DbstorerowRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_range_fill(s : DbstorerowRange, v : Double) -> DbstorerowRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_range_min(s : DbstorerowRange) -> Double { @_common.min(s.data) }

pub fn db_store_row_range_max(s : DbstorerowRange) -> Double { @_common.max(s.data) }

pub fn db_store_row_range_to_string(s : DbstorerowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_slice_make(size : Int) -> DbstorerowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_slice_len(s : DbstorerowSlice) -> Int { s.size }

pub fn db_store_row_slice_get(s : DbstorerowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_slice_set(s : DbstorerowSlice, i : Int, v : Double) -> DbstorerowSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_row_slice_sum(s : DbstorerowSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_row_slice_mean(s : DbstorerowSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_row_slice_scale(s : DbstorerowSlice, f : Double) -> DbstorerowSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_row_slice_add(a : DbstorerowSlice, b : DbstorerowSlice) -> DbstorerowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_row_slice_copy(s : DbstorerowSlice) -> DbstorerowSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_row_slice_fill(s : DbstorerowSlice, v : Double) -> DbstorerowSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_row_slice_min(s : DbstorerowSlice) -> Double { @_common.min(s.data) }

pub fn db_store_row_slice_max(s : DbstorerowSlice) -> Double { @_common.max(s.data) }

pub fn db_store_row_slice_to_string(s : DbstorerowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

