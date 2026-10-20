///===
/// extcore/db_query_parallel

pub(all) struct DbqueryparallelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_parallel_make_point(x : Double, y : Double) -> DbqueryparallelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_parallel_make_point3(x : Double, y : Double, z : Double) -> DbqueryparallelPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryparallelPoint::x(self : DbqueryparallelPoint) -> Double { self.x }

pub fn DbqueryparallelPoint::y(self : DbqueryparallelPoint) -> Double { self.y }

pub fn DbqueryparallelPoint::z(self : DbqueryparallelPoint) -> Double { self.z }

pub fn DbqueryparallelPoint::label(self : DbqueryparallelPoint) -> Int { self.label }

pub fn DbqueryparallelPoint::dist(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryparallelPoint::add(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryparallelPoint::sub(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryparallelPoint::scale(self : DbqueryparallelPoint, s : Double) -> DbqueryparallelPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryparallelPoint::dot(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryparallelPoint::cross(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryparallelPoint::norm(self : DbqueryparallelPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryparallelPoint::normalize(self : DbqueryparallelPoint) -> DbqueryparallelPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryparallelPoint::negate(self : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryparallelPoint::mid(self : DbqueryparallelPoint, other : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryparallelPoint::lerp(self : DbqueryparallelPoint, other : DbqueryparallelPoint, t : Double) -> DbqueryparallelPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryparallelPoint::to_string(self : DbqueryparallelPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryparallelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_parallel_make_series(vals : Array[Double], name : String) -> DbqueryparallelSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryparallelSeries::len(self : DbqueryparallelSeries) -> Int { self.vals.length() }

pub fn DbqueryparallelSeries::sum(self : DbqueryparallelSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryparallelSeries::mean(self : DbqueryparallelSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryparallelSeries::min(self : DbqueryparallelSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryparallelSeries::max(self : DbqueryparallelSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryparallelSeries::range(self : DbqueryparallelSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryparallelSeries::variance(self : DbqueryparallelSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryparallelSeries::std(self : DbqueryparallelSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryparallelSeries::median(self : DbqueryparallelSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryparallelSeries::scale(self : DbqueryparallelSeries, f : Double) -> DbqueryparallelSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryparallelSeries::add(self : DbqueryparallelSeries, other : DbqueryparallelSeries) -> DbqueryparallelSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryparallelSeries::sub(self : DbqueryparallelSeries, other : DbqueryparallelSeries) -> DbqueryparallelSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryparallelSeries::normalize(self : DbqueryparallelSeries) -> DbqueryparallelSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryparallelSeries::cumsum(self : DbqueryparallelSeries) -> DbqueryparallelSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryparallelSeries::to_string(self : DbqueryparallelSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryparallelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_parallel_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryparallelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_parallel_matrix_identity(n : Int) -> DbqueryparallelMatrix {
  let m = db_query_parallel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryparallelMatrix::get(self : DbqueryparallelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryparallelMatrix::transpose(self : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  let result = db_query_parallel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryparallelMatrix::add(self : DbqueryparallelMatrix, other : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryparallelMatrix::scale(self : DbqueryparallelMatrix, s : Double) -> DbqueryparallelMatrix {
  let result = db_query_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryparallelMatrix::multiply(self : DbqueryparallelMatrix, other : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  if self.cols != other.rows { return db_query_parallel_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_parallel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryparallelMatrix::trace(self : DbqueryparallelMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryparallelMatrix::det(self : DbqueryparallelMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryparallelMatrix::norm(self : DbqueryparallelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryparallelMatrix::to_string(self : DbqueryparallelMatrix) -> String {
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

pub(all) struct DbqueryparallelVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_parallel_make_vector(comps : Array[Double]) -> DbqueryparallelVector {
  { comps, dim: comps.length() }
}

pub fn db_query_parallel_vector_zero(dim : Int) -> DbqueryparallelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryparallelVector::add(self : DbqueryparallelVector, other : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryparallelVector::sub(self : DbqueryparallelVector, other : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryparallelVector::scale(self : DbqueryparallelVector, s : Double) -> DbqueryparallelVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryparallelVector::dot(self : DbqueryparallelVector, other : DbqueryparallelVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryparallelVector::norm(self : DbqueryparallelVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryparallelVector::normalize(self : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryparallelVector::dist(self : DbqueryparallelVector, other : DbqueryparallelVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryparallelVector::to_string(self : DbqueryparallelVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_parallel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_parallel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_parallel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_parallel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_parallel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_parallel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_parallel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_parallel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_parallel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_parallel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_parallel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_parallel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_parallel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_parallel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_parallel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_parallel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_parallel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_parallel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_parallel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_parallel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_parallel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_parallel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_parallel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_parallel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_parallel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_parallel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_parallel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_parallel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_parallel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryparallelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_frame_make(size : Int) -> DbqueryparallelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_frame_len(s : DbqueryparallelFrame) -> Int { s.size }

pub fn db_query_parallel_frame_get(s : DbqueryparallelFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_frame_set(s : DbqueryparallelFrame, i : Int, v : Double) -> DbqueryparallelFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_frame_sum(s : DbqueryparallelFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_frame_mean(s : DbqueryparallelFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_frame_scale(s : DbqueryparallelFrame, f : Double) -> DbqueryparallelFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_frame_add(a : DbqueryparallelFrame, b : DbqueryparallelFrame) -> DbqueryparallelFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_frame_copy(s : DbqueryparallelFrame) -> DbqueryparallelFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_frame_fill(s : DbqueryparallelFrame, v : Double) -> DbqueryparallelFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_frame_min(s : DbqueryparallelFrame) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_frame_max(s : DbqueryparallelFrame) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_frame_to_string(s : DbqueryparallelFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_table_make(size : Int) -> DbqueryparallelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_table_len(s : DbqueryparallelTable) -> Int { s.size }

pub fn db_query_parallel_table_get(s : DbqueryparallelTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_table_set(s : DbqueryparallelTable, i : Int, v : Double) -> DbqueryparallelTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_table_sum(s : DbqueryparallelTable) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_table_mean(s : DbqueryparallelTable) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_table_scale(s : DbqueryparallelTable, f : Double) -> DbqueryparallelTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_table_add(a : DbqueryparallelTable, b : DbqueryparallelTable) -> DbqueryparallelTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_table_copy(s : DbqueryparallelTable) -> DbqueryparallelTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_table_fill(s : DbqueryparallelTable, v : Double) -> DbqueryparallelTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_table_min(s : DbqueryparallelTable) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_table_max(s : DbqueryparallelTable) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_table_to_string(s : DbqueryparallelTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_graphn_make(size : Int) -> DbqueryparallelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_graphn_len(s : DbqueryparallelGraphN) -> Int { s.size }

pub fn db_query_parallel_graphn_get(s : DbqueryparallelGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_graphn_set(s : DbqueryparallelGraphN, i : Int, v : Double) -> DbqueryparallelGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_graphn_sum(s : DbqueryparallelGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_graphn_mean(s : DbqueryparallelGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_graphn_scale(s : DbqueryparallelGraphN, f : Double) -> DbqueryparallelGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_graphn_add(a : DbqueryparallelGraphN, b : DbqueryparallelGraphN) -> DbqueryparallelGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_graphn_copy(s : DbqueryparallelGraphN) -> DbqueryparallelGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_graphn_fill(s : DbqueryparallelGraphN, v : Double) -> DbqueryparallelGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_graphn_min(s : DbqueryparallelGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_graphn_max(s : DbqueryparallelGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_graphn_to_string(s : DbqueryparallelGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_node_make(size : Int) -> DbqueryparallelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_node_len(s : DbqueryparallelNode) -> Int { s.size }

pub fn db_query_parallel_node_get(s : DbqueryparallelNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_node_set(s : DbqueryparallelNode, i : Int, v : Double) -> DbqueryparallelNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_node_sum(s : DbqueryparallelNode) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_node_mean(s : DbqueryparallelNode) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_node_scale(s : DbqueryparallelNode, f : Double) -> DbqueryparallelNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_node_add(a : DbqueryparallelNode, b : DbqueryparallelNode) -> DbqueryparallelNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_node_copy(s : DbqueryparallelNode) -> DbqueryparallelNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_node_fill(s : DbqueryparallelNode, v : Double) -> DbqueryparallelNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_node_min(s : DbqueryparallelNode) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_node_max(s : DbqueryparallelNode) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_node_to_string(s : DbqueryparallelNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_edge_make(size : Int) -> DbqueryparallelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_edge_len(s : DbqueryparallelEdge) -> Int { s.size }

pub fn db_query_parallel_edge_get(s : DbqueryparallelEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_edge_set(s : DbqueryparallelEdge, i : Int, v : Double) -> DbqueryparallelEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_edge_sum(s : DbqueryparallelEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_edge_mean(s : DbqueryparallelEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_edge_scale(s : DbqueryparallelEdge, f : Double) -> DbqueryparallelEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_edge_add(a : DbqueryparallelEdge, b : DbqueryparallelEdge) -> DbqueryparallelEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_edge_copy(s : DbqueryparallelEdge) -> DbqueryparallelEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_edge_fill(s : DbqueryparallelEdge, v : Double) -> DbqueryparallelEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_edge_min(s : DbqueryparallelEdge) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_edge_max(s : DbqueryparallelEdge) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_edge_to_string(s : DbqueryparallelEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_path_make(size : Int) -> DbqueryparallelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_path_len(s : DbqueryparallelPath) -> Int { s.size }

pub fn db_query_parallel_path_get(s : DbqueryparallelPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_path_set(s : DbqueryparallelPath, i : Int, v : Double) -> DbqueryparallelPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_path_sum(s : DbqueryparallelPath) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_path_mean(s : DbqueryparallelPath) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_path_scale(s : DbqueryparallelPath, f : Double) -> DbqueryparallelPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_path_add(a : DbqueryparallelPath, b : DbqueryparallelPath) -> DbqueryparallelPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_path_copy(s : DbqueryparallelPath) -> DbqueryparallelPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_path_fill(s : DbqueryparallelPath, v : Double) -> DbqueryparallelPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_path_min(s : DbqueryparallelPath) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_path_max(s : DbqueryparallelPath) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_path_to_string(s : DbqueryparallelPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_cluster_make(size : Int) -> DbqueryparallelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_cluster_len(s : DbqueryparallelCluster) -> Int { s.size }

pub fn db_query_parallel_cluster_get(s : DbqueryparallelCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_cluster_set(s : DbqueryparallelCluster, i : Int, v : Double) -> DbqueryparallelCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cluster_sum(s : DbqueryparallelCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_cluster_mean(s : DbqueryparallelCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_cluster_scale(s : DbqueryparallelCluster, f : Double) -> DbqueryparallelCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cluster_add(a : DbqueryparallelCluster, b : DbqueryparallelCluster) -> DbqueryparallelCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_cluster_copy(s : DbqueryparallelCluster) -> DbqueryparallelCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cluster_fill(s : DbqueryparallelCluster, v : Double) -> DbqueryparallelCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cluster_min(s : DbqueryparallelCluster) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_cluster_max(s : DbqueryparallelCluster) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_cluster_to_string(s : DbqueryparallelCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_model_make(size : Int) -> DbqueryparallelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_model_len(s : DbqueryparallelModel) -> Int { s.size }

pub fn db_query_parallel_model_get(s : DbqueryparallelModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_model_set(s : DbqueryparallelModel, i : Int, v : Double) -> DbqueryparallelModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_model_sum(s : DbqueryparallelModel) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_model_mean(s : DbqueryparallelModel) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_model_scale(s : DbqueryparallelModel, f : Double) -> DbqueryparallelModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_model_add(a : DbqueryparallelModel, b : DbqueryparallelModel) -> DbqueryparallelModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_model_copy(s : DbqueryparallelModel) -> DbqueryparallelModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_model_fill(s : DbqueryparallelModel, v : Double) -> DbqueryparallelModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_model_min(s : DbqueryparallelModel) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_model_max(s : DbqueryparallelModel) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_model_to_string(s : DbqueryparallelModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_layer_make(size : Int) -> DbqueryparallelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_layer_len(s : DbqueryparallelLayer) -> Int { s.size }

pub fn db_query_parallel_layer_get(s : DbqueryparallelLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_layer_set(s : DbqueryparallelLayer, i : Int, v : Double) -> DbqueryparallelLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_layer_sum(s : DbqueryparallelLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_layer_mean(s : DbqueryparallelLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_layer_scale(s : DbqueryparallelLayer, f : Double) -> DbqueryparallelLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_layer_add(a : DbqueryparallelLayer, b : DbqueryparallelLayer) -> DbqueryparallelLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_layer_copy(s : DbqueryparallelLayer) -> DbqueryparallelLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_layer_fill(s : DbqueryparallelLayer, v : Double) -> DbqueryparallelLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_layer_min(s : DbqueryparallelLayer) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_layer_max(s : DbqueryparallelLayer) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_layer_to_string(s : DbqueryparallelLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_buffer_make(size : Int) -> DbqueryparallelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_buffer_len(s : DbqueryparallelBuffer) -> Int { s.size }

pub fn db_query_parallel_buffer_get(s : DbqueryparallelBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_buffer_set(s : DbqueryparallelBuffer, i : Int, v : Double) -> DbqueryparallelBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_buffer_sum(s : DbqueryparallelBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_buffer_mean(s : DbqueryparallelBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_buffer_scale(s : DbqueryparallelBuffer, f : Double) -> DbqueryparallelBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_buffer_add(a : DbqueryparallelBuffer, b : DbqueryparallelBuffer) -> DbqueryparallelBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_buffer_copy(s : DbqueryparallelBuffer) -> DbqueryparallelBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_buffer_fill(s : DbqueryparallelBuffer, v : Double) -> DbqueryparallelBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_buffer_min(s : DbqueryparallelBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_buffer_max(s : DbqueryparallelBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_buffer_to_string(s : DbqueryparallelBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_cursor_make(size : Int) -> DbqueryparallelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_cursor_len(s : DbqueryparallelCursor) -> Int { s.size }

pub fn db_query_parallel_cursor_get(s : DbqueryparallelCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_cursor_set(s : DbqueryparallelCursor, i : Int, v : Double) -> DbqueryparallelCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cursor_sum(s : DbqueryparallelCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_cursor_mean(s : DbqueryparallelCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_cursor_scale(s : DbqueryparallelCursor, f : Double) -> DbqueryparallelCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cursor_add(a : DbqueryparallelCursor, b : DbqueryparallelCursor) -> DbqueryparallelCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_cursor_copy(s : DbqueryparallelCursor) -> DbqueryparallelCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cursor_fill(s : DbqueryparallelCursor, v : Double) -> DbqueryparallelCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_cursor_min(s : DbqueryparallelCursor) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_cursor_max(s : DbqueryparallelCursor) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_cursor_to_string(s : DbqueryparallelCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_view_make(size : Int) -> DbqueryparallelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_view_len(s : DbqueryparallelView) -> Int { s.size }

pub fn db_query_parallel_view_get(s : DbqueryparallelView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_view_set(s : DbqueryparallelView, i : Int, v : Double) -> DbqueryparallelView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_view_sum(s : DbqueryparallelView) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_view_mean(s : DbqueryparallelView) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_view_scale(s : DbqueryparallelView, f : Double) -> DbqueryparallelView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_view_add(a : DbqueryparallelView, b : DbqueryparallelView) -> DbqueryparallelView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_view_copy(s : DbqueryparallelView) -> DbqueryparallelView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_view_fill(s : DbqueryparallelView, v : Double) -> DbqueryparallelView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_view_min(s : DbqueryparallelView) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_view_max(s : DbqueryparallelView) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_view_to_string(s : DbqueryparallelView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_range_make(size : Int) -> DbqueryparallelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_range_len(s : DbqueryparallelRange) -> Int { s.size }

pub fn db_query_parallel_range_get(s : DbqueryparallelRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_range_set(s : DbqueryparallelRange, i : Int, v : Double) -> DbqueryparallelRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_range_sum(s : DbqueryparallelRange) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_range_mean(s : DbqueryparallelRange) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_range_scale(s : DbqueryparallelRange, f : Double) -> DbqueryparallelRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_range_add(a : DbqueryparallelRange, b : DbqueryparallelRange) -> DbqueryparallelRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_range_copy(s : DbqueryparallelRange) -> DbqueryparallelRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_range_fill(s : DbqueryparallelRange, v : Double) -> DbqueryparallelRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_range_min(s : DbqueryparallelRange) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_range_max(s : DbqueryparallelRange) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_range_to_string(s : DbqueryparallelRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_slice_make(size : Int) -> DbqueryparallelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_slice_len(s : DbqueryparallelSlice) -> Int { s.size }

pub fn db_query_parallel_slice_get(s : DbqueryparallelSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_slice_set(s : DbqueryparallelSlice, i : Int, v : Double) -> DbqueryparallelSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_parallel_slice_sum(s : DbqueryparallelSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_parallel_slice_mean(s : DbqueryparallelSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_parallel_slice_scale(s : DbqueryparallelSlice, f : Double) -> DbqueryparallelSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_slice_add(a : DbqueryparallelSlice, b : DbqueryparallelSlice) -> DbqueryparallelSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_parallel_slice_copy(s : DbqueryparallelSlice) -> DbqueryparallelSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_slice_fill(s : DbqueryparallelSlice, v : Double) -> DbqueryparallelSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_parallel_slice_min(s : DbqueryparallelSlice) -> Double { @_common.min(s.data) }

pub fn db_query_parallel_slice_max(s : DbqueryparallelSlice) -> Double { @_common.max(s.data) }

pub fn db_query_parallel_slice_to_string(s : DbqueryparallelSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

