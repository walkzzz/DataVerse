///===
/// extcore/db_query_join

pub(all) struct DbqueryjoinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_join_make_point(x : Double, y : Double) -> DbqueryjoinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_join_make_point3(x : Double, y : Double, z : Double) -> DbqueryjoinPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryjoinPoint::x(self : DbqueryjoinPoint) -> Double { self.x }

pub fn DbqueryjoinPoint::y(self : DbqueryjoinPoint) -> Double { self.y }

pub fn DbqueryjoinPoint::z(self : DbqueryjoinPoint) -> Double { self.z }

pub fn DbqueryjoinPoint::label(self : DbqueryjoinPoint) -> Int { self.label }

pub fn DbqueryjoinPoint::dist(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryjoinPoint::add(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryjoinPoint::sub(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryjoinPoint::scale(self : DbqueryjoinPoint, s : Double) -> DbqueryjoinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryjoinPoint::dot(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryjoinPoint::cross(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryjoinPoint::norm(self : DbqueryjoinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryjoinPoint::normalize(self : DbqueryjoinPoint) -> DbqueryjoinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryjoinPoint::negate(self : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryjoinPoint::mid(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryjoinPoint::lerp(self : DbqueryjoinPoint, other : DbqueryjoinPoint, t : Double) -> DbqueryjoinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryjoinPoint::to_string(self : DbqueryjoinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryjoinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_join_make_series(vals : Array[Double], name : String) -> DbqueryjoinSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryjoinSeries::len(self : DbqueryjoinSeries) -> Int { self.vals.length() }

pub fn DbqueryjoinSeries::sum(self : DbqueryjoinSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryjoinSeries::mean(self : DbqueryjoinSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryjoinSeries::min(self : DbqueryjoinSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryjoinSeries::max(self : DbqueryjoinSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryjoinSeries::range(self : DbqueryjoinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryjoinSeries::variance(self : DbqueryjoinSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryjoinSeries::std(self : DbqueryjoinSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryjoinSeries::median(self : DbqueryjoinSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryjoinSeries::scale(self : DbqueryjoinSeries, f : Double) -> DbqueryjoinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryjoinSeries::add(self : DbqueryjoinSeries, other : DbqueryjoinSeries) -> DbqueryjoinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryjoinSeries::sub(self : DbqueryjoinSeries, other : DbqueryjoinSeries) -> DbqueryjoinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryjoinSeries::normalize(self : DbqueryjoinSeries) -> DbqueryjoinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryjoinSeries::cumsum(self : DbqueryjoinSeries) -> DbqueryjoinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryjoinSeries::to_string(self : DbqueryjoinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryjoinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_join_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryjoinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_join_matrix_identity(n : Int) -> DbqueryjoinMatrix {
  let m = db_query_join_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryjoinMatrix::get(self : DbqueryjoinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryjoinMatrix::transpose(self : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  let result = db_query_join_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryjoinMatrix::add(self : DbqueryjoinMatrix, other : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_join_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryjoinMatrix::scale(self : DbqueryjoinMatrix, s : Double) -> DbqueryjoinMatrix {
  let result = db_query_join_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryjoinMatrix::multiply(self : DbqueryjoinMatrix, other : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  if self.cols != other.rows { return db_query_join_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_join_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryjoinMatrix::trace(self : DbqueryjoinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryjoinMatrix::det(self : DbqueryjoinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryjoinMatrix::norm(self : DbqueryjoinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryjoinMatrix::to_string(self : DbqueryjoinMatrix) -> String {
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

pub(all) struct DbqueryjoinVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_join_make_vector(comps : Array[Double]) -> DbqueryjoinVector {
  { comps, dim: comps.length() }
}

pub fn db_query_join_vector_zero(dim : Int) -> DbqueryjoinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryjoinVector::add(self : DbqueryjoinVector, other : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryjoinVector::sub(self : DbqueryjoinVector, other : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryjoinVector::scale(self : DbqueryjoinVector, s : Double) -> DbqueryjoinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryjoinVector::dot(self : DbqueryjoinVector, other : DbqueryjoinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryjoinVector::norm(self : DbqueryjoinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryjoinVector::normalize(self : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryjoinVector::dist(self : DbqueryjoinVector, other : DbqueryjoinVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryjoinVector::to_string(self : DbqueryjoinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_join_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_join_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_join_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_join_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_join_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_join_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_join_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_join_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_join_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_join_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_join_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_join_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_join_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_join_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_join_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_join_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_join_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_join_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_join_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_join_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_join_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_join_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_join_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_join_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_join_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_join_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_join_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_join_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_join_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryjoinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_frame_make(size : Int) -> DbqueryjoinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_frame_len(s : DbqueryjoinFrame) -> Int { s.size }

pub fn db_query_join_frame_get(s : DbqueryjoinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_frame_set(s : DbqueryjoinFrame, i : Int, v : Double) -> DbqueryjoinFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_frame_sum(s : DbqueryjoinFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_join_frame_mean(s : DbqueryjoinFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_join_frame_scale(s : DbqueryjoinFrame, f : Double) -> DbqueryjoinFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_frame_add(a : DbqueryjoinFrame, b : DbqueryjoinFrame) -> DbqueryjoinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_frame_copy(s : DbqueryjoinFrame) -> DbqueryjoinFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_frame_fill(s : DbqueryjoinFrame, v : Double) -> DbqueryjoinFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_frame_min(s : DbqueryjoinFrame) -> Double { @_common.min(s.data) }

pub fn db_query_join_frame_max(s : DbqueryjoinFrame) -> Double { @_common.max(s.data) }

pub fn db_query_join_frame_to_string(s : DbqueryjoinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_table_make(size : Int) -> DbqueryjoinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_table_len(s : DbqueryjoinTable) -> Int { s.size }

pub fn db_query_join_table_get(s : DbqueryjoinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_table_set(s : DbqueryjoinTable, i : Int, v : Double) -> DbqueryjoinTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_table_sum(s : DbqueryjoinTable) -> Double { @_common.sum(s.data) }

pub fn db_query_join_table_mean(s : DbqueryjoinTable) -> Double { @_common.mean(s.data) }

pub fn db_query_join_table_scale(s : DbqueryjoinTable, f : Double) -> DbqueryjoinTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_table_add(a : DbqueryjoinTable, b : DbqueryjoinTable) -> DbqueryjoinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_table_copy(s : DbqueryjoinTable) -> DbqueryjoinTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_table_fill(s : DbqueryjoinTable, v : Double) -> DbqueryjoinTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_table_min(s : DbqueryjoinTable) -> Double { @_common.min(s.data) }

pub fn db_query_join_table_max(s : DbqueryjoinTable) -> Double { @_common.max(s.data) }

pub fn db_query_join_table_to_string(s : DbqueryjoinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_graphn_make(size : Int) -> DbqueryjoinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_graphn_len(s : DbqueryjoinGraphN) -> Int { s.size }

pub fn db_query_join_graphn_get(s : DbqueryjoinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_graphn_set(s : DbqueryjoinGraphN, i : Int, v : Double) -> DbqueryjoinGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_graphn_sum(s : DbqueryjoinGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_join_graphn_mean(s : DbqueryjoinGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_join_graphn_scale(s : DbqueryjoinGraphN, f : Double) -> DbqueryjoinGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_graphn_add(a : DbqueryjoinGraphN, b : DbqueryjoinGraphN) -> DbqueryjoinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_graphn_copy(s : DbqueryjoinGraphN) -> DbqueryjoinGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_graphn_fill(s : DbqueryjoinGraphN, v : Double) -> DbqueryjoinGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_graphn_min(s : DbqueryjoinGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_join_graphn_max(s : DbqueryjoinGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_join_graphn_to_string(s : DbqueryjoinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_node_make(size : Int) -> DbqueryjoinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_node_len(s : DbqueryjoinNode) -> Int { s.size }

pub fn db_query_join_node_get(s : DbqueryjoinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_node_set(s : DbqueryjoinNode, i : Int, v : Double) -> DbqueryjoinNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_node_sum(s : DbqueryjoinNode) -> Double { @_common.sum(s.data) }

pub fn db_query_join_node_mean(s : DbqueryjoinNode) -> Double { @_common.mean(s.data) }

pub fn db_query_join_node_scale(s : DbqueryjoinNode, f : Double) -> DbqueryjoinNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_node_add(a : DbqueryjoinNode, b : DbqueryjoinNode) -> DbqueryjoinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_node_copy(s : DbqueryjoinNode) -> DbqueryjoinNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_node_fill(s : DbqueryjoinNode, v : Double) -> DbqueryjoinNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_node_min(s : DbqueryjoinNode) -> Double { @_common.min(s.data) }

pub fn db_query_join_node_max(s : DbqueryjoinNode) -> Double { @_common.max(s.data) }

pub fn db_query_join_node_to_string(s : DbqueryjoinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_edge_make(size : Int) -> DbqueryjoinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_edge_len(s : DbqueryjoinEdge) -> Int { s.size }

pub fn db_query_join_edge_get(s : DbqueryjoinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_edge_set(s : DbqueryjoinEdge, i : Int, v : Double) -> DbqueryjoinEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_edge_sum(s : DbqueryjoinEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_join_edge_mean(s : DbqueryjoinEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_join_edge_scale(s : DbqueryjoinEdge, f : Double) -> DbqueryjoinEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_edge_add(a : DbqueryjoinEdge, b : DbqueryjoinEdge) -> DbqueryjoinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_edge_copy(s : DbqueryjoinEdge) -> DbqueryjoinEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_edge_fill(s : DbqueryjoinEdge, v : Double) -> DbqueryjoinEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_edge_min(s : DbqueryjoinEdge) -> Double { @_common.min(s.data) }

pub fn db_query_join_edge_max(s : DbqueryjoinEdge) -> Double { @_common.max(s.data) }

pub fn db_query_join_edge_to_string(s : DbqueryjoinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_path_make(size : Int) -> DbqueryjoinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_path_len(s : DbqueryjoinPath) -> Int { s.size }

pub fn db_query_join_path_get(s : DbqueryjoinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_path_set(s : DbqueryjoinPath, i : Int, v : Double) -> DbqueryjoinPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_path_sum(s : DbqueryjoinPath) -> Double { @_common.sum(s.data) }

pub fn db_query_join_path_mean(s : DbqueryjoinPath) -> Double { @_common.mean(s.data) }

pub fn db_query_join_path_scale(s : DbqueryjoinPath, f : Double) -> DbqueryjoinPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_path_add(a : DbqueryjoinPath, b : DbqueryjoinPath) -> DbqueryjoinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_path_copy(s : DbqueryjoinPath) -> DbqueryjoinPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_path_fill(s : DbqueryjoinPath, v : Double) -> DbqueryjoinPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_path_min(s : DbqueryjoinPath) -> Double { @_common.min(s.data) }

pub fn db_query_join_path_max(s : DbqueryjoinPath) -> Double { @_common.max(s.data) }

pub fn db_query_join_path_to_string(s : DbqueryjoinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_cluster_make(size : Int) -> DbqueryjoinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_cluster_len(s : DbqueryjoinCluster) -> Int { s.size }

pub fn db_query_join_cluster_get(s : DbqueryjoinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_cluster_set(s : DbqueryjoinCluster, i : Int, v : Double) -> DbqueryjoinCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_cluster_sum(s : DbqueryjoinCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_join_cluster_mean(s : DbqueryjoinCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_join_cluster_scale(s : DbqueryjoinCluster, f : Double) -> DbqueryjoinCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_cluster_add(a : DbqueryjoinCluster, b : DbqueryjoinCluster) -> DbqueryjoinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_cluster_copy(s : DbqueryjoinCluster) -> DbqueryjoinCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_cluster_fill(s : DbqueryjoinCluster, v : Double) -> DbqueryjoinCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_cluster_min(s : DbqueryjoinCluster) -> Double { @_common.min(s.data) }

pub fn db_query_join_cluster_max(s : DbqueryjoinCluster) -> Double { @_common.max(s.data) }

pub fn db_query_join_cluster_to_string(s : DbqueryjoinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_model_make(size : Int) -> DbqueryjoinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_model_len(s : DbqueryjoinModel) -> Int { s.size }

pub fn db_query_join_model_get(s : DbqueryjoinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_model_set(s : DbqueryjoinModel, i : Int, v : Double) -> DbqueryjoinModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_model_sum(s : DbqueryjoinModel) -> Double { @_common.sum(s.data) }

pub fn db_query_join_model_mean(s : DbqueryjoinModel) -> Double { @_common.mean(s.data) }

pub fn db_query_join_model_scale(s : DbqueryjoinModel, f : Double) -> DbqueryjoinModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_model_add(a : DbqueryjoinModel, b : DbqueryjoinModel) -> DbqueryjoinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_model_copy(s : DbqueryjoinModel) -> DbqueryjoinModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_model_fill(s : DbqueryjoinModel, v : Double) -> DbqueryjoinModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_model_min(s : DbqueryjoinModel) -> Double { @_common.min(s.data) }

pub fn db_query_join_model_max(s : DbqueryjoinModel) -> Double { @_common.max(s.data) }

pub fn db_query_join_model_to_string(s : DbqueryjoinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_layer_make(size : Int) -> DbqueryjoinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_layer_len(s : DbqueryjoinLayer) -> Int { s.size }

pub fn db_query_join_layer_get(s : DbqueryjoinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_layer_set(s : DbqueryjoinLayer, i : Int, v : Double) -> DbqueryjoinLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_layer_sum(s : DbqueryjoinLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_join_layer_mean(s : DbqueryjoinLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_join_layer_scale(s : DbqueryjoinLayer, f : Double) -> DbqueryjoinLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_layer_add(a : DbqueryjoinLayer, b : DbqueryjoinLayer) -> DbqueryjoinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_layer_copy(s : DbqueryjoinLayer) -> DbqueryjoinLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_layer_fill(s : DbqueryjoinLayer, v : Double) -> DbqueryjoinLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_layer_min(s : DbqueryjoinLayer) -> Double { @_common.min(s.data) }

pub fn db_query_join_layer_max(s : DbqueryjoinLayer) -> Double { @_common.max(s.data) }

pub fn db_query_join_layer_to_string(s : DbqueryjoinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_buffer_make(size : Int) -> DbqueryjoinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_buffer_len(s : DbqueryjoinBuffer) -> Int { s.size }

pub fn db_query_join_buffer_get(s : DbqueryjoinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_buffer_set(s : DbqueryjoinBuffer, i : Int, v : Double) -> DbqueryjoinBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_buffer_sum(s : DbqueryjoinBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_join_buffer_mean(s : DbqueryjoinBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_join_buffer_scale(s : DbqueryjoinBuffer, f : Double) -> DbqueryjoinBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_buffer_add(a : DbqueryjoinBuffer, b : DbqueryjoinBuffer) -> DbqueryjoinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_buffer_copy(s : DbqueryjoinBuffer) -> DbqueryjoinBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_buffer_fill(s : DbqueryjoinBuffer, v : Double) -> DbqueryjoinBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_buffer_min(s : DbqueryjoinBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_join_buffer_max(s : DbqueryjoinBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_join_buffer_to_string(s : DbqueryjoinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_cursor_make(size : Int) -> DbqueryjoinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_cursor_len(s : DbqueryjoinCursor) -> Int { s.size }

pub fn db_query_join_cursor_get(s : DbqueryjoinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_cursor_set(s : DbqueryjoinCursor, i : Int, v : Double) -> DbqueryjoinCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_cursor_sum(s : DbqueryjoinCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_join_cursor_mean(s : DbqueryjoinCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_join_cursor_scale(s : DbqueryjoinCursor, f : Double) -> DbqueryjoinCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_cursor_add(a : DbqueryjoinCursor, b : DbqueryjoinCursor) -> DbqueryjoinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_cursor_copy(s : DbqueryjoinCursor) -> DbqueryjoinCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_cursor_fill(s : DbqueryjoinCursor, v : Double) -> DbqueryjoinCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_cursor_min(s : DbqueryjoinCursor) -> Double { @_common.min(s.data) }

pub fn db_query_join_cursor_max(s : DbqueryjoinCursor) -> Double { @_common.max(s.data) }

pub fn db_query_join_cursor_to_string(s : DbqueryjoinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_view_make(size : Int) -> DbqueryjoinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_view_len(s : DbqueryjoinView) -> Int { s.size }

pub fn db_query_join_view_get(s : DbqueryjoinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_view_set(s : DbqueryjoinView, i : Int, v : Double) -> DbqueryjoinView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_view_sum(s : DbqueryjoinView) -> Double { @_common.sum(s.data) }

pub fn db_query_join_view_mean(s : DbqueryjoinView) -> Double { @_common.mean(s.data) }

pub fn db_query_join_view_scale(s : DbqueryjoinView, f : Double) -> DbqueryjoinView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_view_add(a : DbqueryjoinView, b : DbqueryjoinView) -> DbqueryjoinView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_view_copy(s : DbqueryjoinView) -> DbqueryjoinView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_view_fill(s : DbqueryjoinView, v : Double) -> DbqueryjoinView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_view_min(s : DbqueryjoinView) -> Double { @_common.min(s.data) }

pub fn db_query_join_view_max(s : DbqueryjoinView) -> Double { @_common.max(s.data) }

pub fn db_query_join_view_to_string(s : DbqueryjoinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_range_make(size : Int) -> DbqueryjoinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_range_len(s : DbqueryjoinRange) -> Int { s.size }

pub fn db_query_join_range_get(s : DbqueryjoinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_range_set(s : DbqueryjoinRange, i : Int, v : Double) -> DbqueryjoinRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_range_sum(s : DbqueryjoinRange) -> Double { @_common.sum(s.data) }

pub fn db_query_join_range_mean(s : DbqueryjoinRange) -> Double { @_common.mean(s.data) }

pub fn db_query_join_range_scale(s : DbqueryjoinRange, f : Double) -> DbqueryjoinRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_range_add(a : DbqueryjoinRange, b : DbqueryjoinRange) -> DbqueryjoinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_range_copy(s : DbqueryjoinRange) -> DbqueryjoinRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_range_fill(s : DbqueryjoinRange, v : Double) -> DbqueryjoinRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_range_min(s : DbqueryjoinRange) -> Double { @_common.min(s.data) }

pub fn db_query_join_range_max(s : DbqueryjoinRange) -> Double { @_common.max(s.data) }

pub fn db_query_join_range_to_string(s : DbqueryjoinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_slice_make(size : Int) -> DbqueryjoinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_slice_len(s : DbqueryjoinSlice) -> Int { s.size }

pub fn db_query_join_slice_get(s : DbqueryjoinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_slice_set(s : DbqueryjoinSlice, i : Int, v : Double) -> DbqueryjoinSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_join_slice_sum(s : DbqueryjoinSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_join_slice_mean(s : DbqueryjoinSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_join_slice_scale(s : DbqueryjoinSlice, f : Double) -> DbqueryjoinSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_join_slice_add(a : DbqueryjoinSlice, b : DbqueryjoinSlice) -> DbqueryjoinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_join_slice_copy(s : DbqueryjoinSlice) -> DbqueryjoinSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_join_slice_fill(s : DbqueryjoinSlice, v : Double) -> DbqueryjoinSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_join_slice_min(s : DbqueryjoinSlice) -> Double { @_common.min(s.data) }

pub fn db_query_join_slice_max(s : DbqueryjoinSlice) -> Double { @_common.max(s.data) }

pub fn db_query_join_slice_to_string(s : DbqueryjoinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

