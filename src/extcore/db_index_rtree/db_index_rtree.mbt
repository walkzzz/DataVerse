///===
/// extcore/db_index_rtree

pub(all) struct DbindexrtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_rtree_make_point(x : Double, y : Double) -> DbindexrtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_rtree_make_point3(x : Double, y : Double, z : Double) -> DbindexrtreePoint {
  { x, y, z, label: 0 }
}

pub fn DbindexrtreePoint::x(self : DbindexrtreePoint) -> Double { self.x }

pub fn DbindexrtreePoint::y(self : DbindexrtreePoint) -> Double { self.y }

pub fn DbindexrtreePoint::z(self : DbindexrtreePoint) -> Double { self.z }

pub fn DbindexrtreePoint::label(self : DbindexrtreePoint) -> Int { self.label }

pub fn DbindexrtreePoint::dist(self : DbindexrtreePoint, other : DbindexrtreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexrtreePoint::add(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexrtreePoint::sub(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexrtreePoint::scale(self : DbindexrtreePoint, s : Double) -> DbindexrtreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexrtreePoint::dot(self : DbindexrtreePoint, other : DbindexrtreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexrtreePoint::cross(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexrtreePoint::norm(self : DbindexrtreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexrtreePoint::normalize(self : DbindexrtreePoint) -> DbindexrtreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexrtreePoint::negate(self : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexrtreePoint::mid(self : DbindexrtreePoint, other : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexrtreePoint::lerp(self : DbindexrtreePoint, other : DbindexrtreePoint, t : Double) -> DbindexrtreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexrtreePoint::to_string(self : DbindexrtreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexrtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_rtree_make_series(vals : Array[Double], name : String) -> DbindexrtreeSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexrtreeSeries::len(self : DbindexrtreeSeries) -> Int { self.vals.length() }

pub fn DbindexrtreeSeries::sum(self : DbindexrtreeSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexrtreeSeries::mean(self : DbindexrtreeSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexrtreeSeries::min(self : DbindexrtreeSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexrtreeSeries::max(self : DbindexrtreeSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexrtreeSeries::range(self : DbindexrtreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexrtreeSeries::variance(self : DbindexrtreeSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexrtreeSeries::std(self : DbindexrtreeSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexrtreeSeries::median(self : DbindexrtreeSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexrtreeSeries::scale(self : DbindexrtreeSeries, f : Double) -> DbindexrtreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexrtreeSeries::add(self : DbindexrtreeSeries, other : DbindexrtreeSeries) -> DbindexrtreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexrtreeSeries::sub(self : DbindexrtreeSeries, other : DbindexrtreeSeries) -> DbindexrtreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexrtreeSeries::normalize(self : DbindexrtreeSeries) -> DbindexrtreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexrtreeSeries::cumsum(self : DbindexrtreeSeries) -> DbindexrtreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexrtreeSeries::to_string(self : DbindexrtreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexrtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_rtree_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexrtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_rtree_matrix_identity(n : Int) -> DbindexrtreeMatrix {
  let m = db_index_rtree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexrtreeMatrix::get(self : DbindexrtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexrtreeMatrix::transpose(self : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  let result = db_index_rtree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexrtreeMatrix::add(self : DbindexrtreeMatrix, other : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_rtree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexrtreeMatrix::scale(self : DbindexrtreeMatrix, s : Double) -> DbindexrtreeMatrix {
  let result = db_index_rtree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexrtreeMatrix::multiply(self : DbindexrtreeMatrix, other : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  if self.cols != other.rows { return db_index_rtree_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_rtree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexrtreeMatrix::trace(self : DbindexrtreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexrtreeMatrix::det(self : DbindexrtreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexrtreeMatrix::norm(self : DbindexrtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexrtreeMatrix::to_string(self : DbindexrtreeMatrix) -> String {
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

pub(all) struct DbindexrtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_rtree_make_vector(comps : Array[Double]) -> DbindexrtreeVector {
  { comps, dim: comps.length() }
}

pub fn db_index_rtree_vector_zero(dim : Int) -> DbindexrtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexrtreeVector::add(self : DbindexrtreeVector, other : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexrtreeVector::sub(self : DbindexrtreeVector, other : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexrtreeVector::scale(self : DbindexrtreeVector, s : Double) -> DbindexrtreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexrtreeVector::dot(self : DbindexrtreeVector, other : DbindexrtreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexrtreeVector::norm(self : DbindexrtreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexrtreeVector::normalize(self : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexrtreeVector::dist(self : DbindexrtreeVector, other : DbindexrtreeVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexrtreeVector::to_string(self : DbindexrtreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_rtree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_rtree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_rtree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_rtree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_rtree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_rtree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_rtree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_rtree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_rtree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_rtree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_rtree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_rtree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_rtree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_rtree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_rtree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_rtree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_rtree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_rtree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_rtree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_rtree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_rtree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_rtree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_rtree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_rtree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_rtree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_rtree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_rtree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_rtree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_rtree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexrtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_frame_make(size : Int) -> DbindexrtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_frame_len(s : DbindexrtreeFrame) -> Int { s.size }

pub fn db_index_rtree_frame_get(s : DbindexrtreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_frame_set(s : DbindexrtreeFrame, i : Int, v : Double) -> DbindexrtreeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_frame_sum(s : DbindexrtreeFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_frame_mean(s : DbindexrtreeFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_frame_scale(s : DbindexrtreeFrame, f : Double) -> DbindexrtreeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_frame_add(a : DbindexrtreeFrame, b : DbindexrtreeFrame) -> DbindexrtreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_frame_copy(s : DbindexrtreeFrame) -> DbindexrtreeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_frame_fill(s : DbindexrtreeFrame, v : Double) -> DbindexrtreeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_frame_min(s : DbindexrtreeFrame) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_frame_max(s : DbindexrtreeFrame) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_frame_to_string(s : DbindexrtreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_table_make(size : Int) -> DbindexrtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_table_len(s : DbindexrtreeTable) -> Int { s.size }

pub fn db_index_rtree_table_get(s : DbindexrtreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_table_set(s : DbindexrtreeTable, i : Int, v : Double) -> DbindexrtreeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_table_sum(s : DbindexrtreeTable) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_table_mean(s : DbindexrtreeTable) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_table_scale(s : DbindexrtreeTable, f : Double) -> DbindexrtreeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_table_add(a : DbindexrtreeTable, b : DbindexrtreeTable) -> DbindexrtreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_table_copy(s : DbindexrtreeTable) -> DbindexrtreeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_table_fill(s : DbindexrtreeTable, v : Double) -> DbindexrtreeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_table_min(s : DbindexrtreeTable) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_table_max(s : DbindexrtreeTable) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_table_to_string(s : DbindexrtreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_graphn_make(size : Int) -> DbindexrtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_graphn_len(s : DbindexrtreeGraphN) -> Int { s.size }

pub fn db_index_rtree_graphn_get(s : DbindexrtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_graphn_set(s : DbindexrtreeGraphN, i : Int, v : Double) -> DbindexrtreeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_graphn_sum(s : DbindexrtreeGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_graphn_mean(s : DbindexrtreeGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_graphn_scale(s : DbindexrtreeGraphN, f : Double) -> DbindexrtreeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_graphn_add(a : DbindexrtreeGraphN, b : DbindexrtreeGraphN) -> DbindexrtreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_graphn_copy(s : DbindexrtreeGraphN) -> DbindexrtreeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_graphn_fill(s : DbindexrtreeGraphN, v : Double) -> DbindexrtreeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_graphn_min(s : DbindexrtreeGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_graphn_max(s : DbindexrtreeGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_graphn_to_string(s : DbindexrtreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_node_make(size : Int) -> DbindexrtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_node_len(s : DbindexrtreeNode) -> Int { s.size }

pub fn db_index_rtree_node_get(s : DbindexrtreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_node_set(s : DbindexrtreeNode, i : Int, v : Double) -> DbindexrtreeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_node_sum(s : DbindexrtreeNode) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_node_mean(s : DbindexrtreeNode) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_node_scale(s : DbindexrtreeNode, f : Double) -> DbindexrtreeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_node_add(a : DbindexrtreeNode, b : DbindexrtreeNode) -> DbindexrtreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_node_copy(s : DbindexrtreeNode) -> DbindexrtreeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_node_fill(s : DbindexrtreeNode, v : Double) -> DbindexrtreeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_node_min(s : DbindexrtreeNode) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_node_max(s : DbindexrtreeNode) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_node_to_string(s : DbindexrtreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_edge_make(size : Int) -> DbindexrtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_edge_len(s : DbindexrtreeEdge) -> Int { s.size }

pub fn db_index_rtree_edge_get(s : DbindexrtreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_edge_set(s : DbindexrtreeEdge, i : Int, v : Double) -> DbindexrtreeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_edge_sum(s : DbindexrtreeEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_edge_mean(s : DbindexrtreeEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_edge_scale(s : DbindexrtreeEdge, f : Double) -> DbindexrtreeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_edge_add(a : DbindexrtreeEdge, b : DbindexrtreeEdge) -> DbindexrtreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_edge_copy(s : DbindexrtreeEdge) -> DbindexrtreeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_edge_fill(s : DbindexrtreeEdge, v : Double) -> DbindexrtreeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_edge_min(s : DbindexrtreeEdge) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_edge_max(s : DbindexrtreeEdge) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_edge_to_string(s : DbindexrtreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_path_make(size : Int) -> DbindexrtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_path_len(s : DbindexrtreePath) -> Int { s.size }

pub fn db_index_rtree_path_get(s : DbindexrtreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_path_set(s : DbindexrtreePath, i : Int, v : Double) -> DbindexrtreePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_path_sum(s : DbindexrtreePath) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_path_mean(s : DbindexrtreePath) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_path_scale(s : DbindexrtreePath, f : Double) -> DbindexrtreePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_path_add(a : DbindexrtreePath, b : DbindexrtreePath) -> DbindexrtreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_path_copy(s : DbindexrtreePath) -> DbindexrtreePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_path_fill(s : DbindexrtreePath, v : Double) -> DbindexrtreePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_path_min(s : DbindexrtreePath) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_path_max(s : DbindexrtreePath) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_path_to_string(s : DbindexrtreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_cluster_make(size : Int) -> DbindexrtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_cluster_len(s : DbindexrtreeCluster) -> Int { s.size }

pub fn db_index_rtree_cluster_get(s : DbindexrtreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_cluster_set(s : DbindexrtreeCluster, i : Int, v : Double) -> DbindexrtreeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cluster_sum(s : DbindexrtreeCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_cluster_mean(s : DbindexrtreeCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_cluster_scale(s : DbindexrtreeCluster, f : Double) -> DbindexrtreeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cluster_add(a : DbindexrtreeCluster, b : DbindexrtreeCluster) -> DbindexrtreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_cluster_copy(s : DbindexrtreeCluster) -> DbindexrtreeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cluster_fill(s : DbindexrtreeCluster, v : Double) -> DbindexrtreeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cluster_min(s : DbindexrtreeCluster) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_cluster_max(s : DbindexrtreeCluster) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_cluster_to_string(s : DbindexrtreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_model_make(size : Int) -> DbindexrtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_model_len(s : DbindexrtreeModel) -> Int { s.size }

pub fn db_index_rtree_model_get(s : DbindexrtreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_model_set(s : DbindexrtreeModel, i : Int, v : Double) -> DbindexrtreeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_model_sum(s : DbindexrtreeModel) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_model_mean(s : DbindexrtreeModel) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_model_scale(s : DbindexrtreeModel, f : Double) -> DbindexrtreeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_model_add(a : DbindexrtreeModel, b : DbindexrtreeModel) -> DbindexrtreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_model_copy(s : DbindexrtreeModel) -> DbindexrtreeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_model_fill(s : DbindexrtreeModel, v : Double) -> DbindexrtreeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_model_min(s : DbindexrtreeModel) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_model_max(s : DbindexrtreeModel) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_model_to_string(s : DbindexrtreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_layer_make(size : Int) -> DbindexrtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_layer_len(s : DbindexrtreeLayer) -> Int { s.size }

pub fn db_index_rtree_layer_get(s : DbindexrtreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_layer_set(s : DbindexrtreeLayer, i : Int, v : Double) -> DbindexrtreeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_layer_sum(s : DbindexrtreeLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_layer_mean(s : DbindexrtreeLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_layer_scale(s : DbindexrtreeLayer, f : Double) -> DbindexrtreeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_layer_add(a : DbindexrtreeLayer, b : DbindexrtreeLayer) -> DbindexrtreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_layer_copy(s : DbindexrtreeLayer) -> DbindexrtreeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_layer_fill(s : DbindexrtreeLayer, v : Double) -> DbindexrtreeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_layer_min(s : DbindexrtreeLayer) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_layer_max(s : DbindexrtreeLayer) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_layer_to_string(s : DbindexrtreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_buffer_make(size : Int) -> DbindexrtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_buffer_len(s : DbindexrtreeBuffer) -> Int { s.size }

pub fn db_index_rtree_buffer_get(s : DbindexrtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_buffer_set(s : DbindexrtreeBuffer, i : Int, v : Double) -> DbindexrtreeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_buffer_sum(s : DbindexrtreeBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_buffer_mean(s : DbindexrtreeBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_buffer_scale(s : DbindexrtreeBuffer, f : Double) -> DbindexrtreeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_buffer_add(a : DbindexrtreeBuffer, b : DbindexrtreeBuffer) -> DbindexrtreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_buffer_copy(s : DbindexrtreeBuffer) -> DbindexrtreeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_buffer_fill(s : DbindexrtreeBuffer, v : Double) -> DbindexrtreeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_buffer_min(s : DbindexrtreeBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_buffer_max(s : DbindexrtreeBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_buffer_to_string(s : DbindexrtreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_cursor_make(size : Int) -> DbindexrtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_cursor_len(s : DbindexrtreeCursor) -> Int { s.size }

pub fn db_index_rtree_cursor_get(s : DbindexrtreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_cursor_set(s : DbindexrtreeCursor, i : Int, v : Double) -> DbindexrtreeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cursor_sum(s : DbindexrtreeCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_cursor_mean(s : DbindexrtreeCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_cursor_scale(s : DbindexrtreeCursor, f : Double) -> DbindexrtreeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cursor_add(a : DbindexrtreeCursor, b : DbindexrtreeCursor) -> DbindexrtreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_cursor_copy(s : DbindexrtreeCursor) -> DbindexrtreeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cursor_fill(s : DbindexrtreeCursor, v : Double) -> DbindexrtreeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_cursor_min(s : DbindexrtreeCursor) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_cursor_max(s : DbindexrtreeCursor) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_cursor_to_string(s : DbindexrtreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_view_make(size : Int) -> DbindexrtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_view_len(s : DbindexrtreeView) -> Int { s.size }

pub fn db_index_rtree_view_get(s : DbindexrtreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_view_set(s : DbindexrtreeView, i : Int, v : Double) -> DbindexrtreeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_view_sum(s : DbindexrtreeView) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_view_mean(s : DbindexrtreeView) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_view_scale(s : DbindexrtreeView, f : Double) -> DbindexrtreeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_view_add(a : DbindexrtreeView, b : DbindexrtreeView) -> DbindexrtreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_view_copy(s : DbindexrtreeView) -> DbindexrtreeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_view_fill(s : DbindexrtreeView, v : Double) -> DbindexrtreeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_view_min(s : DbindexrtreeView) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_view_max(s : DbindexrtreeView) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_view_to_string(s : DbindexrtreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_range_make(size : Int) -> DbindexrtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_range_len(s : DbindexrtreeRange) -> Int { s.size }

pub fn db_index_rtree_range_get(s : DbindexrtreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_range_set(s : DbindexrtreeRange, i : Int, v : Double) -> DbindexrtreeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_range_sum(s : DbindexrtreeRange) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_range_mean(s : DbindexrtreeRange) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_range_scale(s : DbindexrtreeRange, f : Double) -> DbindexrtreeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_range_add(a : DbindexrtreeRange, b : DbindexrtreeRange) -> DbindexrtreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_range_copy(s : DbindexrtreeRange) -> DbindexrtreeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_range_fill(s : DbindexrtreeRange, v : Double) -> DbindexrtreeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_range_min(s : DbindexrtreeRange) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_range_max(s : DbindexrtreeRange) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_range_to_string(s : DbindexrtreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_slice_make(size : Int) -> DbindexrtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_slice_len(s : DbindexrtreeSlice) -> Int { s.size }

pub fn db_index_rtree_slice_get(s : DbindexrtreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_slice_set(s : DbindexrtreeSlice, i : Int, v : Double) -> DbindexrtreeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_rtree_slice_sum(s : DbindexrtreeSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_rtree_slice_mean(s : DbindexrtreeSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_rtree_slice_scale(s : DbindexrtreeSlice, f : Double) -> DbindexrtreeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_slice_add(a : DbindexrtreeSlice, b : DbindexrtreeSlice) -> DbindexrtreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_rtree_slice_copy(s : DbindexrtreeSlice) -> DbindexrtreeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_slice_fill(s : DbindexrtreeSlice, v : Double) -> DbindexrtreeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_rtree_slice_min(s : DbindexrtreeSlice) -> Double { @_common.min(s.data) }

pub fn db_index_rtree_slice_max(s : DbindexrtreeSlice) -> Double { @_common.max(s.data) }

pub fn db_index_rtree_slice_to_string(s : DbindexrtreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

