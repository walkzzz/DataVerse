///===
/// extcore/db_index_btree

pub(all) struct DbindexbtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_btree_make_point(x : Double, y : Double) -> DbindexbtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_btree_make_point3(x : Double, y : Double, z : Double) -> DbindexbtreePoint {
  { x, y, z, label: 0 }
}

pub fn DbindexbtreePoint::x(self : DbindexbtreePoint) -> Double { self.x }

pub fn DbindexbtreePoint::y(self : DbindexbtreePoint) -> Double { self.y }

pub fn DbindexbtreePoint::z(self : DbindexbtreePoint) -> Double { self.z }

pub fn DbindexbtreePoint::label(self : DbindexbtreePoint) -> Int { self.label }

pub fn DbindexbtreePoint::dist(self : DbindexbtreePoint, other : DbindexbtreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexbtreePoint::add(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexbtreePoint::sub(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexbtreePoint::scale(self : DbindexbtreePoint, s : Double) -> DbindexbtreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexbtreePoint::dot(self : DbindexbtreePoint, other : DbindexbtreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexbtreePoint::cross(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexbtreePoint::norm(self : DbindexbtreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexbtreePoint::normalize(self : DbindexbtreePoint) -> DbindexbtreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbtreePoint::negate(self : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexbtreePoint::mid(self : DbindexbtreePoint, other : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexbtreePoint::lerp(self : DbindexbtreePoint, other : DbindexbtreePoint, t : Double) -> DbindexbtreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexbtreePoint::to_string(self : DbindexbtreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexbtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_btree_make_series(vals : Array[Double], name : String) -> DbindexbtreeSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexbtreeSeries::len(self : DbindexbtreeSeries) -> Int { self.vals.length() }

pub fn DbindexbtreeSeries::sum(self : DbindexbtreeSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexbtreeSeries::mean(self : DbindexbtreeSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexbtreeSeries::min(self : DbindexbtreeSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexbtreeSeries::max(self : DbindexbtreeSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexbtreeSeries::range(self : DbindexbtreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexbtreeSeries::variance(self : DbindexbtreeSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexbtreeSeries::std(self : DbindexbtreeSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexbtreeSeries::median(self : DbindexbtreeSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexbtreeSeries::scale(self : DbindexbtreeSeries, f : Double) -> DbindexbtreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexbtreeSeries::add(self : DbindexbtreeSeries, other : DbindexbtreeSeries) -> DbindexbtreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexbtreeSeries::sub(self : DbindexbtreeSeries, other : DbindexbtreeSeries) -> DbindexbtreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexbtreeSeries::normalize(self : DbindexbtreeSeries) -> DbindexbtreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexbtreeSeries::cumsum(self : DbindexbtreeSeries) -> DbindexbtreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexbtreeSeries::to_string(self : DbindexbtreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_btree_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_btree_matrix_identity(n : Int) -> DbindexbtreeMatrix {
  let m = db_index_btree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexbtreeMatrix::get(self : DbindexbtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexbtreeMatrix::transpose(self : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  let result = db_index_btree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexbtreeMatrix::add(self : DbindexbtreeMatrix, other : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_btree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexbtreeMatrix::scale(self : DbindexbtreeMatrix, s : Double) -> DbindexbtreeMatrix {
  let result = db_index_btree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexbtreeMatrix::multiply(self : DbindexbtreeMatrix, other : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  if self.cols != other.rows { return db_index_btree_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_btree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexbtreeMatrix::trace(self : DbindexbtreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexbtreeMatrix::det(self : DbindexbtreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexbtreeMatrix::norm(self : DbindexbtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexbtreeMatrix::to_string(self : DbindexbtreeMatrix) -> String {
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

pub(all) struct DbindexbtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_btree_make_vector(comps : Array[Double]) -> DbindexbtreeVector {
  { comps, dim: comps.length() }
}

pub fn db_index_btree_vector_zero(dim : Int) -> DbindexbtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexbtreeVector::add(self : DbindexbtreeVector, other : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbtreeVector::sub(self : DbindexbtreeVector, other : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbtreeVector::scale(self : DbindexbtreeVector, s : Double) -> DbindexbtreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexbtreeVector::dot(self : DbindexbtreeVector, other : DbindexbtreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexbtreeVector::norm(self : DbindexbtreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexbtreeVector::normalize(self : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbtreeVector::dist(self : DbindexbtreeVector, other : DbindexbtreeVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexbtreeVector::to_string(self : DbindexbtreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_btree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_btree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_btree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_btree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_btree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_btree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_btree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_btree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_btree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_btree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_btree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_btree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_btree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_btree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_btree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_btree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_btree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_btree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_btree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_btree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_btree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_btree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_btree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_btree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_btree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_btree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_btree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_btree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_btree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexbtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_frame_make(size : Int) -> DbindexbtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_frame_len(s : DbindexbtreeFrame) -> Int { s.size }

pub fn db_index_btree_frame_get(s : DbindexbtreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_frame_set(s : DbindexbtreeFrame, i : Int, v : Double) -> DbindexbtreeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_frame_sum(s : DbindexbtreeFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_frame_mean(s : DbindexbtreeFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_frame_scale(s : DbindexbtreeFrame, f : Double) -> DbindexbtreeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_frame_add(a : DbindexbtreeFrame, b : DbindexbtreeFrame) -> DbindexbtreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_frame_copy(s : DbindexbtreeFrame) -> DbindexbtreeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_frame_fill(s : DbindexbtreeFrame, v : Double) -> DbindexbtreeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_frame_min(s : DbindexbtreeFrame) -> Double { @_common.min(s.data) }

pub fn db_index_btree_frame_max(s : DbindexbtreeFrame) -> Double { @_common.max(s.data) }

pub fn db_index_btree_frame_to_string(s : DbindexbtreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_table_make(size : Int) -> DbindexbtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_table_len(s : DbindexbtreeTable) -> Int { s.size }

pub fn db_index_btree_table_get(s : DbindexbtreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_table_set(s : DbindexbtreeTable, i : Int, v : Double) -> DbindexbtreeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_table_sum(s : DbindexbtreeTable) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_table_mean(s : DbindexbtreeTable) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_table_scale(s : DbindexbtreeTable, f : Double) -> DbindexbtreeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_table_add(a : DbindexbtreeTable, b : DbindexbtreeTable) -> DbindexbtreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_table_copy(s : DbindexbtreeTable) -> DbindexbtreeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_table_fill(s : DbindexbtreeTable, v : Double) -> DbindexbtreeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_table_min(s : DbindexbtreeTable) -> Double { @_common.min(s.data) }

pub fn db_index_btree_table_max(s : DbindexbtreeTable) -> Double { @_common.max(s.data) }

pub fn db_index_btree_table_to_string(s : DbindexbtreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_graphn_make(size : Int) -> DbindexbtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_graphn_len(s : DbindexbtreeGraphN) -> Int { s.size }

pub fn db_index_btree_graphn_get(s : DbindexbtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_graphn_set(s : DbindexbtreeGraphN, i : Int, v : Double) -> DbindexbtreeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_graphn_sum(s : DbindexbtreeGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_graphn_mean(s : DbindexbtreeGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_graphn_scale(s : DbindexbtreeGraphN, f : Double) -> DbindexbtreeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_graphn_add(a : DbindexbtreeGraphN, b : DbindexbtreeGraphN) -> DbindexbtreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_graphn_copy(s : DbindexbtreeGraphN) -> DbindexbtreeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_graphn_fill(s : DbindexbtreeGraphN, v : Double) -> DbindexbtreeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_graphn_min(s : DbindexbtreeGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_btree_graphn_max(s : DbindexbtreeGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_btree_graphn_to_string(s : DbindexbtreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_node_make(size : Int) -> DbindexbtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_node_len(s : DbindexbtreeNode) -> Int { s.size }

pub fn db_index_btree_node_get(s : DbindexbtreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_node_set(s : DbindexbtreeNode, i : Int, v : Double) -> DbindexbtreeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_node_sum(s : DbindexbtreeNode) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_node_mean(s : DbindexbtreeNode) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_node_scale(s : DbindexbtreeNode, f : Double) -> DbindexbtreeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_node_add(a : DbindexbtreeNode, b : DbindexbtreeNode) -> DbindexbtreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_node_copy(s : DbindexbtreeNode) -> DbindexbtreeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_node_fill(s : DbindexbtreeNode, v : Double) -> DbindexbtreeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_node_min(s : DbindexbtreeNode) -> Double { @_common.min(s.data) }

pub fn db_index_btree_node_max(s : DbindexbtreeNode) -> Double { @_common.max(s.data) }

pub fn db_index_btree_node_to_string(s : DbindexbtreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_edge_make(size : Int) -> DbindexbtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_edge_len(s : DbindexbtreeEdge) -> Int { s.size }

pub fn db_index_btree_edge_get(s : DbindexbtreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_edge_set(s : DbindexbtreeEdge, i : Int, v : Double) -> DbindexbtreeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_edge_sum(s : DbindexbtreeEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_edge_mean(s : DbindexbtreeEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_edge_scale(s : DbindexbtreeEdge, f : Double) -> DbindexbtreeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_edge_add(a : DbindexbtreeEdge, b : DbindexbtreeEdge) -> DbindexbtreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_edge_copy(s : DbindexbtreeEdge) -> DbindexbtreeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_edge_fill(s : DbindexbtreeEdge, v : Double) -> DbindexbtreeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_edge_min(s : DbindexbtreeEdge) -> Double { @_common.min(s.data) }

pub fn db_index_btree_edge_max(s : DbindexbtreeEdge) -> Double { @_common.max(s.data) }

pub fn db_index_btree_edge_to_string(s : DbindexbtreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_path_make(size : Int) -> DbindexbtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_path_len(s : DbindexbtreePath) -> Int { s.size }

pub fn db_index_btree_path_get(s : DbindexbtreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_path_set(s : DbindexbtreePath, i : Int, v : Double) -> DbindexbtreePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_path_sum(s : DbindexbtreePath) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_path_mean(s : DbindexbtreePath) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_path_scale(s : DbindexbtreePath, f : Double) -> DbindexbtreePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_path_add(a : DbindexbtreePath, b : DbindexbtreePath) -> DbindexbtreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_path_copy(s : DbindexbtreePath) -> DbindexbtreePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_path_fill(s : DbindexbtreePath, v : Double) -> DbindexbtreePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_path_min(s : DbindexbtreePath) -> Double { @_common.min(s.data) }

pub fn db_index_btree_path_max(s : DbindexbtreePath) -> Double { @_common.max(s.data) }

pub fn db_index_btree_path_to_string(s : DbindexbtreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_cluster_make(size : Int) -> DbindexbtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_cluster_len(s : DbindexbtreeCluster) -> Int { s.size }

pub fn db_index_btree_cluster_get(s : DbindexbtreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_cluster_set(s : DbindexbtreeCluster, i : Int, v : Double) -> DbindexbtreeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_cluster_sum(s : DbindexbtreeCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_cluster_mean(s : DbindexbtreeCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_cluster_scale(s : DbindexbtreeCluster, f : Double) -> DbindexbtreeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_cluster_add(a : DbindexbtreeCluster, b : DbindexbtreeCluster) -> DbindexbtreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_cluster_copy(s : DbindexbtreeCluster) -> DbindexbtreeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_cluster_fill(s : DbindexbtreeCluster, v : Double) -> DbindexbtreeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_cluster_min(s : DbindexbtreeCluster) -> Double { @_common.min(s.data) }

pub fn db_index_btree_cluster_max(s : DbindexbtreeCluster) -> Double { @_common.max(s.data) }

pub fn db_index_btree_cluster_to_string(s : DbindexbtreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_model_make(size : Int) -> DbindexbtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_model_len(s : DbindexbtreeModel) -> Int { s.size }

pub fn db_index_btree_model_get(s : DbindexbtreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_model_set(s : DbindexbtreeModel, i : Int, v : Double) -> DbindexbtreeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_model_sum(s : DbindexbtreeModel) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_model_mean(s : DbindexbtreeModel) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_model_scale(s : DbindexbtreeModel, f : Double) -> DbindexbtreeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_model_add(a : DbindexbtreeModel, b : DbindexbtreeModel) -> DbindexbtreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_model_copy(s : DbindexbtreeModel) -> DbindexbtreeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_model_fill(s : DbindexbtreeModel, v : Double) -> DbindexbtreeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_model_min(s : DbindexbtreeModel) -> Double { @_common.min(s.data) }

pub fn db_index_btree_model_max(s : DbindexbtreeModel) -> Double { @_common.max(s.data) }

pub fn db_index_btree_model_to_string(s : DbindexbtreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_layer_make(size : Int) -> DbindexbtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_layer_len(s : DbindexbtreeLayer) -> Int { s.size }

pub fn db_index_btree_layer_get(s : DbindexbtreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_layer_set(s : DbindexbtreeLayer, i : Int, v : Double) -> DbindexbtreeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_layer_sum(s : DbindexbtreeLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_layer_mean(s : DbindexbtreeLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_layer_scale(s : DbindexbtreeLayer, f : Double) -> DbindexbtreeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_layer_add(a : DbindexbtreeLayer, b : DbindexbtreeLayer) -> DbindexbtreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_layer_copy(s : DbindexbtreeLayer) -> DbindexbtreeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_layer_fill(s : DbindexbtreeLayer, v : Double) -> DbindexbtreeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_layer_min(s : DbindexbtreeLayer) -> Double { @_common.min(s.data) }

pub fn db_index_btree_layer_max(s : DbindexbtreeLayer) -> Double { @_common.max(s.data) }

pub fn db_index_btree_layer_to_string(s : DbindexbtreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_buffer_make(size : Int) -> DbindexbtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_buffer_len(s : DbindexbtreeBuffer) -> Int { s.size }

pub fn db_index_btree_buffer_get(s : DbindexbtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_buffer_set(s : DbindexbtreeBuffer, i : Int, v : Double) -> DbindexbtreeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_buffer_sum(s : DbindexbtreeBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_buffer_mean(s : DbindexbtreeBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_buffer_scale(s : DbindexbtreeBuffer, f : Double) -> DbindexbtreeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_buffer_add(a : DbindexbtreeBuffer, b : DbindexbtreeBuffer) -> DbindexbtreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_buffer_copy(s : DbindexbtreeBuffer) -> DbindexbtreeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_buffer_fill(s : DbindexbtreeBuffer, v : Double) -> DbindexbtreeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_buffer_min(s : DbindexbtreeBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_btree_buffer_max(s : DbindexbtreeBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_btree_buffer_to_string(s : DbindexbtreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_cursor_make(size : Int) -> DbindexbtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_cursor_len(s : DbindexbtreeCursor) -> Int { s.size }

pub fn db_index_btree_cursor_get(s : DbindexbtreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_cursor_set(s : DbindexbtreeCursor, i : Int, v : Double) -> DbindexbtreeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_cursor_sum(s : DbindexbtreeCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_cursor_mean(s : DbindexbtreeCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_cursor_scale(s : DbindexbtreeCursor, f : Double) -> DbindexbtreeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_cursor_add(a : DbindexbtreeCursor, b : DbindexbtreeCursor) -> DbindexbtreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_cursor_copy(s : DbindexbtreeCursor) -> DbindexbtreeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_cursor_fill(s : DbindexbtreeCursor, v : Double) -> DbindexbtreeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_cursor_min(s : DbindexbtreeCursor) -> Double { @_common.min(s.data) }

pub fn db_index_btree_cursor_max(s : DbindexbtreeCursor) -> Double { @_common.max(s.data) }

pub fn db_index_btree_cursor_to_string(s : DbindexbtreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_view_make(size : Int) -> DbindexbtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_view_len(s : DbindexbtreeView) -> Int { s.size }

pub fn db_index_btree_view_get(s : DbindexbtreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_view_set(s : DbindexbtreeView, i : Int, v : Double) -> DbindexbtreeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_view_sum(s : DbindexbtreeView) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_view_mean(s : DbindexbtreeView) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_view_scale(s : DbindexbtreeView, f : Double) -> DbindexbtreeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_view_add(a : DbindexbtreeView, b : DbindexbtreeView) -> DbindexbtreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_view_copy(s : DbindexbtreeView) -> DbindexbtreeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_view_fill(s : DbindexbtreeView, v : Double) -> DbindexbtreeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_view_min(s : DbindexbtreeView) -> Double { @_common.min(s.data) }

pub fn db_index_btree_view_max(s : DbindexbtreeView) -> Double { @_common.max(s.data) }

pub fn db_index_btree_view_to_string(s : DbindexbtreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_range_make(size : Int) -> DbindexbtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_range_len(s : DbindexbtreeRange) -> Int { s.size }

pub fn db_index_btree_range_get(s : DbindexbtreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_range_set(s : DbindexbtreeRange, i : Int, v : Double) -> DbindexbtreeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_range_sum(s : DbindexbtreeRange) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_range_mean(s : DbindexbtreeRange) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_range_scale(s : DbindexbtreeRange, f : Double) -> DbindexbtreeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_range_add(a : DbindexbtreeRange, b : DbindexbtreeRange) -> DbindexbtreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_range_copy(s : DbindexbtreeRange) -> DbindexbtreeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_range_fill(s : DbindexbtreeRange, v : Double) -> DbindexbtreeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_range_min(s : DbindexbtreeRange) -> Double { @_common.min(s.data) }

pub fn db_index_btree_range_max(s : DbindexbtreeRange) -> Double { @_common.max(s.data) }

pub fn db_index_btree_range_to_string(s : DbindexbtreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_slice_make(size : Int) -> DbindexbtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_slice_len(s : DbindexbtreeSlice) -> Int { s.size }

pub fn db_index_btree_slice_get(s : DbindexbtreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_slice_set(s : DbindexbtreeSlice, i : Int, v : Double) -> DbindexbtreeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_btree_slice_sum(s : DbindexbtreeSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_btree_slice_mean(s : DbindexbtreeSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_btree_slice_scale(s : DbindexbtreeSlice, f : Double) -> DbindexbtreeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_btree_slice_add(a : DbindexbtreeSlice, b : DbindexbtreeSlice) -> DbindexbtreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_btree_slice_copy(s : DbindexbtreeSlice) -> DbindexbtreeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_btree_slice_fill(s : DbindexbtreeSlice, v : Double) -> DbindexbtreeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_btree_slice_min(s : DbindexbtreeSlice) -> Double { @_common.min(s.data) }

pub fn db_index_btree_slice_max(s : DbindexbtreeSlice) -> Double { @_common.max(s.data) }

pub fn db_index_btree_slice_to_string(s : DbindexbtreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

