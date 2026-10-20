///===
/// extcore/db_query_sort

pub(all) struct DbquerysortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_sort_make_point(x : Double, y : Double) -> DbquerysortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_sort_make_point3(x : Double, y : Double, z : Double) -> DbquerysortPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerysortPoint::x(self : DbquerysortPoint) -> Double { self.x }

pub fn DbquerysortPoint::y(self : DbquerysortPoint) -> Double { self.y }

pub fn DbquerysortPoint::z(self : DbquerysortPoint) -> Double { self.z }

pub fn DbquerysortPoint::label(self : DbquerysortPoint) -> Int { self.label }

pub fn DbquerysortPoint::dist(self : DbquerysortPoint, other : DbquerysortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerysortPoint::add(self : DbquerysortPoint, other : DbquerysortPoint) -> DbquerysortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerysortPoint::sub(self : DbquerysortPoint, other : DbquerysortPoint) -> DbquerysortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerysortPoint::scale(self : DbquerysortPoint, s : Double) -> DbquerysortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerysortPoint::dot(self : DbquerysortPoint, other : DbquerysortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerysortPoint::cross(self : DbquerysortPoint, other : DbquerysortPoint) -> DbquerysortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerysortPoint::norm(self : DbquerysortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerysortPoint::normalize(self : DbquerysortPoint) -> DbquerysortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerysortPoint::negate(self : DbquerysortPoint) -> DbquerysortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerysortPoint::mid(self : DbquerysortPoint, other : DbquerysortPoint) -> DbquerysortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerysortPoint::lerp(self : DbquerysortPoint, other : DbquerysortPoint, t : Double) -> DbquerysortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerysortPoint::to_string(self : DbquerysortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerysortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_sort_make_series(vals : Array[Double], name : String) -> DbquerysortSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerysortSeries::len(self : DbquerysortSeries) -> Int { self.vals.length() }

pub fn DbquerysortSeries::sum(self : DbquerysortSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerysortSeries::mean(self : DbquerysortSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerysortSeries::min(self : DbquerysortSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerysortSeries::max(self : DbquerysortSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerysortSeries::range(self : DbquerysortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerysortSeries::variance(self : DbquerysortSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerysortSeries::std(self : DbquerysortSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerysortSeries::median(self : DbquerysortSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerysortSeries::scale(self : DbquerysortSeries, f : Double) -> DbquerysortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerysortSeries::add(self : DbquerysortSeries, other : DbquerysortSeries) -> DbquerysortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerysortSeries::sub(self : DbquerysortSeries, other : DbquerysortSeries) -> DbquerysortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerysortSeries::normalize(self : DbquerysortSeries) -> DbquerysortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerysortSeries::cumsum(self : DbquerysortSeries) -> DbquerysortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerysortSeries::to_string(self : DbquerysortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerysortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_sort_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerysortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_sort_matrix_identity(n : Int) -> DbquerysortMatrix {
  let m = db_query_sort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerysortMatrix::get(self : DbquerysortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerysortMatrix::transpose(self : DbquerysortMatrix) -> DbquerysortMatrix {
  let result = db_query_sort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerysortMatrix::add(self : DbquerysortMatrix, other : DbquerysortMatrix) -> DbquerysortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_sort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerysortMatrix::scale(self : DbquerysortMatrix, s : Double) -> DbquerysortMatrix {
  let result = db_query_sort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerysortMatrix::multiply(self : DbquerysortMatrix, other : DbquerysortMatrix) -> DbquerysortMatrix {
  if self.cols != other.rows { return db_query_sort_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_sort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbquerysortMatrix::trace(self : DbquerysortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerysortMatrix::det(self : DbquerysortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerysortMatrix::norm(self : DbquerysortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerysortMatrix::to_string(self : DbquerysortMatrix) -> String {
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

pub(all) struct DbquerysortVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_sort_make_vector(comps : Array[Double]) -> DbquerysortVector {
  { comps, dim: comps.length() }
}

pub fn db_query_sort_vector_zero(dim : Int) -> DbquerysortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerysortVector::add(self : DbquerysortVector, other : DbquerysortVector) -> DbquerysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerysortVector::sub(self : DbquerysortVector, other : DbquerysortVector) -> DbquerysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerysortVector::scale(self : DbquerysortVector, s : Double) -> DbquerysortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerysortVector::dot(self : DbquerysortVector, other : DbquerysortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerysortVector::norm(self : DbquerysortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerysortVector::normalize(self : DbquerysortVector) -> DbquerysortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerysortVector::dist(self : DbquerysortVector, other : DbquerysortVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerysortVector::to_string(self : DbquerysortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_sort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_sort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_sort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_sort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_sort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_sort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_sort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_sort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_sort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_sort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_sort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_sort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_sort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_sort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_sort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_sort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_sort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_sort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_sort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_sort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_sort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_sort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_sort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_sort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_sort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_sort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_sort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_sort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_sort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerysortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_frame_make(size : Int) -> DbquerysortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_frame_len(s : DbquerysortFrame) -> Int { s.size }

pub fn db_query_sort_frame_get(s : DbquerysortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_frame_set(s : DbquerysortFrame, i : Int, v : Double) -> DbquerysortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_frame_sum(s : DbquerysortFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_frame_mean(s : DbquerysortFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_frame_scale(s : DbquerysortFrame, f : Double) -> DbquerysortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_frame_add(a : DbquerysortFrame, b : DbquerysortFrame) -> DbquerysortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_frame_copy(s : DbquerysortFrame) -> DbquerysortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_frame_fill(s : DbquerysortFrame, v : Double) -> DbquerysortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_frame_min(s : DbquerysortFrame) -> Double { @_common.min(s.data) }

pub fn db_query_sort_frame_max(s : DbquerysortFrame) -> Double { @_common.max(s.data) }

pub fn db_query_sort_frame_to_string(s : DbquerysortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_table_make(size : Int) -> DbquerysortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_table_len(s : DbquerysortTable) -> Int { s.size }

pub fn db_query_sort_table_get(s : DbquerysortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_table_set(s : DbquerysortTable, i : Int, v : Double) -> DbquerysortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_table_sum(s : DbquerysortTable) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_table_mean(s : DbquerysortTable) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_table_scale(s : DbquerysortTable, f : Double) -> DbquerysortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_table_add(a : DbquerysortTable, b : DbquerysortTable) -> DbquerysortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_table_copy(s : DbquerysortTable) -> DbquerysortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_table_fill(s : DbquerysortTable, v : Double) -> DbquerysortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_table_min(s : DbquerysortTable) -> Double { @_common.min(s.data) }

pub fn db_query_sort_table_max(s : DbquerysortTable) -> Double { @_common.max(s.data) }

pub fn db_query_sort_table_to_string(s : DbquerysortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_graphn_make(size : Int) -> DbquerysortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_graphn_len(s : DbquerysortGraphN) -> Int { s.size }

pub fn db_query_sort_graphn_get(s : DbquerysortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_graphn_set(s : DbquerysortGraphN, i : Int, v : Double) -> DbquerysortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_graphn_sum(s : DbquerysortGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_graphn_mean(s : DbquerysortGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_graphn_scale(s : DbquerysortGraphN, f : Double) -> DbquerysortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_graphn_add(a : DbquerysortGraphN, b : DbquerysortGraphN) -> DbquerysortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_graphn_copy(s : DbquerysortGraphN) -> DbquerysortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_graphn_fill(s : DbquerysortGraphN, v : Double) -> DbquerysortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_graphn_min(s : DbquerysortGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_sort_graphn_max(s : DbquerysortGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_sort_graphn_to_string(s : DbquerysortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_node_make(size : Int) -> DbquerysortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_node_len(s : DbquerysortNode) -> Int { s.size }

pub fn db_query_sort_node_get(s : DbquerysortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_node_set(s : DbquerysortNode, i : Int, v : Double) -> DbquerysortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_node_sum(s : DbquerysortNode) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_node_mean(s : DbquerysortNode) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_node_scale(s : DbquerysortNode, f : Double) -> DbquerysortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_node_add(a : DbquerysortNode, b : DbquerysortNode) -> DbquerysortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_node_copy(s : DbquerysortNode) -> DbquerysortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_node_fill(s : DbquerysortNode, v : Double) -> DbquerysortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_node_min(s : DbquerysortNode) -> Double { @_common.min(s.data) }

pub fn db_query_sort_node_max(s : DbquerysortNode) -> Double { @_common.max(s.data) }

pub fn db_query_sort_node_to_string(s : DbquerysortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_edge_make(size : Int) -> DbquerysortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_edge_len(s : DbquerysortEdge) -> Int { s.size }

pub fn db_query_sort_edge_get(s : DbquerysortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_edge_set(s : DbquerysortEdge, i : Int, v : Double) -> DbquerysortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_edge_sum(s : DbquerysortEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_edge_mean(s : DbquerysortEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_edge_scale(s : DbquerysortEdge, f : Double) -> DbquerysortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_edge_add(a : DbquerysortEdge, b : DbquerysortEdge) -> DbquerysortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_edge_copy(s : DbquerysortEdge) -> DbquerysortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_edge_fill(s : DbquerysortEdge, v : Double) -> DbquerysortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_edge_min(s : DbquerysortEdge) -> Double { @_common.min(s.data) }

pub fn db_query_sort_edge_max(s : DbquerysortEdge) -> Double { @_common.max(s.data) }

pub fn db_query_sort_edge_to_string(s : DbquerysortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_path_make(size : Int) -> DbquerysortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_path_len(s : DbquerysortPath) -> Int { s.size }

pub fn db_query_sort_path_get(s : DbquerysortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_path_set(s : DbquerysortPath, i : Int, v : Double) -> DbquerysortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_path_sum(s : DbquerysortPath) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_path_mean(s : DbquerysortPath) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_path_scale(s : DbquerysortPath, f : Double) -> DbquerysortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_path_add(a : DbquerysortPath, b : DbquerysortPath) -> DbquerysortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_path_copy(s : DbquerysortPath) -> DbquerysortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_path_fill(s : DbquerysortPath, v : Double) -> DbquerysortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_path_min(s : DbquerysortPath) -> Double { @_common.min(s.data) }

pub fn db_query_sort_path_max(s : DbquerysortPath) -> Double { @_common.max(s.data) }

pub fn db_query_sort_path_to_string(s : DbquerysortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_cluster_make(size : Int) -> DbquerysortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_cluster_len(s : DbquerysortCluster) -> Int { s.size }

pub fn db_query_sort_cluster_get(s : DbquerysortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_cluster_set(s : DbquerysortCluster, i : Int, v : Double) -> DbquerysortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_cluster_sum(s : DbquerysortCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_cluster_mean(s : DbquerysortCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_cluster_scale(s : DbquerysortCluster, f : Double) -> DbquerysortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_cluster_add(a : DbquerysortCluster, b : DbquerysortCluster) -> DbquerysortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_cluster_copy(s : DbquerysortCluster) -> DbquerysortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_cluster_fill(s : DbquerysortCluster, v : Double) -> DbquerysortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_cluster_min(s : DbquerysortCluster) -> Double { @_common.min(s.data) }

pub fn db_query_sort_cluster_max(s : DbquerysortCluster) -> Double { @_common.max(s.data) }

pub fn db_query_sort_cluster_to_string(s : DbquerysortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_model_make(size : Int) -> DbquerysortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_model_len(s : DbquerysortModel) -> Int { s.size }

pub fn db_query_sort_model_get(s : DbquerysortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_model_set(s : DbquerysortModel, i : Int, v : Double) -> DbquerysortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_model_sum(s : DbquerysortModel) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_model_mean(s : DbquerysortModel) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_model_scale(s : DbquerysortModel, f : Double) -> DbquerysortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_model_add(a : DbquerysortModel, b : DbquerysortModel) -> DbquerysortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_model_copy(s : DbquerysortModel) -> DbquerysortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_model_fill(s : DbquerysortModel, v : Double) -> DbquerysortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_model_min(s : DbquerysortModel) -> Double { @_common.min(s.data) }

pub fn db_query_sort_model_max(s : DbquerysortModel) -> Double { @_common.max(s.data) }

pub fn db_query_sort_model_to_string(s : DbquerysortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_layer_make(size : Int) -> DbquerysortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_layer_len(s : DbquerysortLayer) -> Int { s.size }

pub fn db_query_sort_layer_get(s : DbquerysortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_layer_set(s : DbquerysortLayer, i : Int, v : Double) -> DbquerysortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_layer_sum(s : DbquerysortLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_layer_mean(s : DbquerysortLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_layer_scale(s : DbquerysortLayer, f : Double) -> DbquerysortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_layer_add(a : DbquerysortLayer, b : DbquerysortLayer) -> DbquerysortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_layer_copy(s : DbquerysortLayer) -> DbquerysortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_layer_fill(s : DbquerysortLayer, v : Double) -> DbquerysortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_layer_min(s : DbquerysortLayer) -> Double { @_common.min(s.data) }

pub fn db_query_sort_layer_max(s : DbquerysortLayer) -> Double { @_common.max(s.data) }

pub fn db_query_sort_layer_to_string(s : DbquerysortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_buffer_make(size : Int) -> DbquerysortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_buffer_len(s : DbquerysortBuffer) -> Int { s.size }

pub fn db_query_sort_buffer_get(s : DbquerysortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_buffer_set(s : DbquerysortBuffer, i : Int, v : Double) -> DbquerysortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_buffer_sum(s : DbquerysortBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_buffer_mean(s : DbquerysortBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_buffer_scale(s : DbquerysortBuffer, f : Double) -> DbquerysortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_buffer_add(a : DbquerysortBuffer, b : DbquerysortBuffer) -> DbquerysortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_buffer_copy(s : DbquerysortBuffer) -> DbquerysortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_buffer_fill(s : DbquerysortBuffer, v : Double) -> DbquerysortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_buffer_min(s : DbquerysortBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_sort_buffer_max(s : DbquerysortBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_sort_buffer_to_string(s : DbquerysortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_cursor_make(size : Int) -> DbquerysortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_cursor_len(s : DbquerysortCursor) -> Int { s.size }

pub fn db_query_sort_cursor_get(s : DbquerysortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_cursor_set(s : DbquerysortCursor, i : Int, v : Double) -> DbquerysortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_cursor_sum(s : DbquerysortCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_cursor_mean(s : DbquerysortCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_cursor_scale(s : DbquerysortCursor, f : Double) -> DbquerysortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_cursor_add(a : DbquerysortCursor, b : DbquerysortCursor) -> DbquerysortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_cursor_copy(s : DbquerysortCursor) -> DbquerysortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_cursor_fill(s : DbquerysortCursor, v : Double) -> DbquerysortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_cursor_min(s : DbquerysortCursor) -> Double { @_common.min(s.data) }

pub fn db_query_sort_cursor_max(s : DbquerysortCursor) -> Double { @_common.max(s.data) }

pub fn db_query_sort_cursor_to_string(s : DbquerysortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_view_make(size : Int) -> DbquerysortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_view_len(s : DbquerysortView) -> Int { s.size }

pub fn db_query_sort_view_get(s : DbquerysortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_view_set(s : DbquerysortView, i : Int, v : Double) -> DbquerysortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_view_sum(s : DbquerysortView) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_view_mean(s : DbquerysortView) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_view_scale(s : DbquerysortView, f : Double) -> DbquerysortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_view_add(a : DbquerysortView, b : DbquerysortView) -> DbquerysortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_view_copy(s : DbquerysortView) -> DbquerysortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_view_fill(s : DbquerysortView, v : Double) -> DbquerysortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_view_min(s : DbquerysortView) -> Double { @_common.min(s.data) }

pub fn db_query_sort_view_max(s : DbquerysortView) -> Double { @_common.max(s.data) }

pub fn db_query_sort_view_to_string(s : DbquerysortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_range_make(size : Int) -> DbquerysortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_range_len(s : DbquerysortRange) -> Int { s.size }

pub fn db_query_sort_range_get(s : DbquerysortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_range_set(s : DbquerysortRange, i : Int, v : Double) -> DbquerysortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_range_sum(s : DbquerysortRange) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_range_mean(s : DbquerysortRange) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_range_scale(s : DbquerysortRange, f : Double) -> DbquerysortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_range_add(a : DbquerysortRange, b : DbquerysortRange) -> DbquerysortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_range_copy(s : DbquerysortRange) -> DbquerysortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_range_fill(s : DbquerysortRange, v : Double) -> DbquerysortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_range_min(s : DbquerysortRange) -> Double { @_common.min(s.data) }

pub fn db_query_sort_range_max(s : DbquerysortRange) -> Double { @_common.max(s.data) }

pub fn db_query_sort_range_to_string(s : DbquerysortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_slice_make(size : Int) -> DbquerysortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_slice_len(s : DbquerysortSlice) -> Int { s.size }

pub fn db_query_sort_slice_get(s : DbquerysortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_slice_set(s : DbquerysortSlice, i : Int, v : Double) -> DbquerysortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_sort_slice_sum(s : DbquerysortSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_sort_slice_mean(s : DbquerysortSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_sort_slice_scale(s : DbquerysortSlice, f : Double) -> DbquerysortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_sort_slice_add(a : DbquerysortSlice, b : DbquerysortSlice) -> DbquerysortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_sort_slice_copy(s : DbquerysortSlice) -> DbquerysortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_sort_slice_fill(s : DbquerysortSlice, v : Double) -> DbquerysortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_sort_slice_min(s : DbquerysortSlice) -> Double { @_common.min(s.data) }

pub fn db_query_sort_slice_max(s : DbquerysortSlice) -> Double { @_common.max(s.data) }

pub fn db_query_sort_slice_to_string(s : DbquerysortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

