///===
/// extcore/db_query_window

pub(all) struct DbquerywindowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_window_make_point(x : Double, y : Double) -> DbquerywindowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_window_make_point3(x : Double, y : Double, z : Double) -> DbquerywindowPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerywindowPoint::x(self : DbquerywindowPoint) -> Double { self.x }

pub fn DbquerywindowPoint::y(self : DbquerywindowPoint) -> Double { self.y }

pub fn DbquerywindowPoint::z(self : DbquerywindowPoint) -> Double { self.z }

pub fn DbquerywindowPoint::label(self : DbquerywindowPoint) -> Int { self.label }

pub fn DbquerywindowPoint::dist(self : DbquerywindowPoint, other : DbquerywindowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerywindowPoint::add(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerywindowPoint::sub(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerywindowPoint::scale(self : DbquerywindowPoint, s : Double) -> DbquerywindowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerywindowPoint::dot(self : DbquerywindowPoint, other : DbquerywindowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerywindowPoint::cross(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerywindowPoint::norm(self : DbquerywindowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerywindowPoint::normalize(self : DbquerywindowPoint) -> DbquerywindowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerywindowPoint::negate(self : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerywindowPoint::mid(self : DbquerywindowPoint, other : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerywindowPoint::lerp(self : DbquerywindowPoint, other : DbquerywindowPoint, t : Double) -> DbquerywindowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerywindowPoint::to_string(self : DbquerywindowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerywindowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_window_make_series(vals : Array[Double], name : String) -> DbquerywindowSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerywindowSeries::len(self : DbquerywindowSeries) -> Int { self.vals.length() }

pub fn DbquerywindowSeries::sum(self : DbquerywindowSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerywindowSeries::mean(self : DbquerywindowSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerywindowSeries::min(self : DbquerywindowSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerywindowSeries::max(self : DbquerywindowSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerywindowSeries::range(self : DbquerywindowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerywindowSeries::variance(self : DbquerywindowSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerywindowSeries::std(self : DbquerywindowSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerywindowSeries::median(self : DbquerywindowSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerywindowSeries::scale(self : DbquerywindowSeries, f : Double) -> DbquerywindowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerywindowSeries::add(self : DbquerywindowSeries, other : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerywindowSeries::sub(self : DbquerywindowSeries, other : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerywindowSeries::normalize(self : DbquerywindowSeries) -> DbquerywindowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerywindowSeries::cumsum(self : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerywindowSeries::to_string(self : DbquerywindowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerywindowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_window_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerywindowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_window_matrix_identity(n : Int) -> DbquerywindowMatrix {
  let m = db_query_window_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerywindowMatrix::get(self : DbquerywindowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerywindowMatrix::transpose(self : DbquerywindowMatrix) -> DbquerywindowMatrix {
  let result = db_query_window_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerywindowMatrix::add(self : DbquerywindowMatrix, other : DbquerywindowMatrix) -> DbquerywindowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_window_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerywindowMatrix::scale(self : DbquerywindowMatrix, s : Double) -> DbquerywindowMatrix {
  let result = db_query_window_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerywindowMatrix::multiply(self : DbquerywindowMatrix, other : DbquerywindowMatrix) -> DbquerywindowMatrix {
  if self.cols != other.rows { return db_query_window_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_window_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbquerywindowMatrix::trace(self : DbquerywindowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerywindowMatrix::det(self : DbquerywindowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerywindowMatrix::norm(self : DbquerywindowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerywindowMatrix::to_string(self : DbquerywindowMatrix) -> String {
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

pub(all) struct DbquerywindowVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_window_make_vector(comps : Array[Double]) -> DbquerywindowVector {
  { comps, dim: comps.length() }
}

pub fn db_query_window_vector_zero(dim : Int) -> DbquerywindowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerywindowVector::add(self : DbquerywindowVector, other : DbquerywindowVector) -> DbquerywindowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerywindowVector::sub(self : DbquerywindowVector, other : DbquerywindowVector) -> DbquerywindowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerywindowVector::scale(self : DbquerywindowVector, s : Double) -> DbquerywindowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerywindowVector::dot(self : DbquerywindowVector, other : DbquerywindowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerywindowVector::norm(self : DbquerywindowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerywindowVector::normalize(self : DbquerywindowVector) -> DbquerywindowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerywindowVector::dist(self : DbquerywindowVector, other : DbquerywindowVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerywindowVector::to_string(self : DbquerywindowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_window_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_window_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_window_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_window_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_window_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_window_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_window_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_window_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_window_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_window_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_window_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_window_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_window_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_window_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_window_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_window_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_window_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_window_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_window_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_window_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_window_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_window_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_window_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_window_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_window_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_window_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_window_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_window_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_window_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerywindowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_frame_make(size : Int) -> DbquerywindowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_frame_len(s : DbquerywindowFrame) -> Int { s.size }

pub fn db_query_window_frame_get(s : DbquerywindowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_frame_set(s : DbquerywindowFrame, i : Int, v : Double) -> DbquerywindowFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_sum(s : DbquerywindowFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_window_frame_mean(s : DbquerywindowFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_window_frame_scale(s : DbquerywindowFrame, f : Double) -> DbquerywindowFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_add(a : DbquerywindowFrame, b : DbquerywindowFrame) -> DbquerywindowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_frame_copy(s : DbquerywindowFrame) -> DbquerywindowFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_fill(s : DbquerywindowFrame, v : Double) -> DbquerywindowFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_min(s : DbquerywindowFrame) -> Double { @_common.min(s.data) }

pub fn db_query_window_frame_max(s : DbquerywindowFrame) -> Double { @_common.max(s.data) }

pub fn db_query_window_frame_to_string(s : DbquerywindowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_table_make(size : Int) -> DbquerywindowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_table_len(s : DbquerywindowTable) -> Int { s.size }

pub fn db_query_window_table_get(s : DbquerywindowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_table_set(s : DbquerywindowTable, i : Int, v : Double) -> DbquerywindowTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_table_sum(s : DbquerywindowTable) -> Double { @_common.sum(s.data) }

pub fn db_query_window_table_mean(s : DbquerywindowTable) -> Double { @_common.mean(s.data) }

pub fn db_query_window_table_scale(s : DbquerywindowTable, f : Double) -> DbquerywindowTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_table_add(a : DbquerywindowTable, b : DbquerywindowTable) -> DbquerywindowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_table_copy(s : DbquerywindowTable) -> DbquerywindowTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_table_fill(s : DbquerywindowTable, v : Double) -> DbquerywindowTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_table_min(s : DbquerywindowTable) -> Double { @_common.min(s.data) }

pub fn db_query_window_table_max(s : DbquerywindowTable) -> Double { @_common.max(s.data) }

pub fn db_query_window_table_to_string(s : DbquerywindowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_graphn_make(size : Int) -> DbquerywindowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_graphn_len(s : DbquerywindowGraphN) -> Int { s.size }

pub fn db_query_window_graphn_get(s : DbquerywindowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_graphn_set(s : DbquerywindowGraphN, i : Int, v : Double) -> DbquerywindowGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_sum(s : DbquerywindowGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_window_graphn_mean(s : DbquerywindowGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_window_graphn_scale(s : DbquerywindowGraphN, f : Double) -> DbquerywindowGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_add(a : DbquerywindowGraphN, b : DbquerywindowGraphN) -> DbquerywindowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_graphn_copy(s : DbquerywindowGraphN) -> DbquerywindowGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_fill(s : DbquerywindowGraphN, v : Double) -> DbquerywindowGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_min(s : DbquerywindowGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_window_graphn_max(s : DbquerywindowGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_window_graphn_to_string(s : DbquerywindowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_node_make(size : Int) -> DbquerywindowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_node_len(s : DbquerywindowNode) -> Int { s.size }

pub fn db_query_window_node_get(s : DbquerywindowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_node_set(s : DbquerywindowNode, i : Int, v : Double) -> DbquerywindowNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_node_sum(s : DbquerywindowNode) -> Double { @_common.sum(s.data) }

pub fn db_query_window_node_mean(s : DbquerywindowNode) -> Double { @_common.mean(s.data) }

pub fn db_query_window_node_scale(s : DbquerywindowNode, f : Double) -> DbquerywindowNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_node_add(a : DbquerywindowNode, b : DbquerywindowNode) -> DbquerywindowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_node_copy(s : DbquerywindowNode) -> DbquerywindowNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_node_fill(s : DbquerywindowNode, v : Double) -> DbquerywindowNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_node_min(s : DbquerywindowNode) -> Double { @_common.min(s.data) }

pub fn db_query_window_node_max(s : DbquerywindowNode) -> Double { @_common.max(s.data) }

pub fn db_query_window_node_to_string(s : DbquerywindowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_edge_make(size : Int) -> DbquerywindowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_edge_len(s : DbquerywindowEdge) -> Int { s.size }

pub fn db_query_window_edge_get(s : DbquerywindowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_edge_set(s : DbquerywindowEdge, i : Int, v : Double) -> DbquerywindowEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_sum(s : DbquerywindowEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_window_edge_mean(s : DbquerywindowEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_window_edge_scale(s : DbquerywindowEdge, f : Double) -> DbquerywindowEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_add(a : DbquerywindowEdge, b : DbquerywindowEdge) -> DbquerywindowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_edge_copy(s : DbquerywindowEdge) -> DbquerywindowEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_fill(s : DbquerywindowEdge, v : Double) -> DbquerywindowEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_min(s : DbquerywindowEdge) -> Double { @_common.min(s.data) }

pub fn db_query_window_edge_max(s : DbquerywindowEdge) -> Double { @_common.max(s.data) }

pub fn db_query_window_edge_to_string(s : DbquerywindowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_path_make(size : Int) -> DbquerywindowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_path_len(s : DbquerywindowPath) -> Int { s.size }

pub fn db_query_window_path_get(s : DbquerywindowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_path_set(s : DbquerywindowPath, i : Int, v : Double) -> DbquerywindowPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_path_sum(s : DbquerywindowPath) -> Double { @_common.sum(s.data) }

pub fn db_query_window_path_mean(s : DbquerywindowPath) -> Double { @_common.mean(s.data) }

pub fn db_query_window_path_scale(s : DbquerywindowPath, f : Double) -> DbquerywindowPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_path_add(a : DbquerywindowPath, b : DbquerywindowPath) -> DbquerywindowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_path_copy(s : DbquerywindowPath) -> DbquerywindowPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_path_fill(s : DbquerywindowPath, v : Double) -> DbquerywindowPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_path_min(s : DbquerywindowPath) -> Double { @_common.min(s.data) }

pub fn db_query_window_path_max(s : DbquerywindowPath) -> Double { @_common.max(s.data) }

pub fn db_query_window_path_to_string(s : DbquerywindowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_cluster_make(size : Int) -> DbquerywindowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_cluster_len(s : DbquerywindowCluster) -> Int { s.size }

pub fn db_query_window_cluster_get(s : DbquerywindowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_cluster_set(s : DbquerywindowCluster, i : Int, v : Double) -> DbquerywindowCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_sum(s : DbquerywindowCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_window_cluster_mean(s : DbquerywindowCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_window_cluster_scale(s : DbquerywindowCluster, f : Double) -> DbquerywindowCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_add(a : DbquerywindowCluster, b : DbquerywindowCluster) -> DbquerywindowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_cluster_copy(s : DbquerywindowCluster) -> DbquerywindowCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_fill(s : DbquerywindowCluster, v : Double) -> DbquerywindowCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_min(s : DbquerywindowCluster) -> Double { @_common.min(s.data) }

pub fn db_query_window_cluster_max(s : DbquerywindowCluster) -> Double { @_common.max(s.data) }

pub fn db_query_window_cluster_to_string(s : DbquerywindowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_model_make(size : Int) -> DbquerywindowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_model_len(s : DbquerywindowModel) -> Int { s.size }

pub fn db_query_window_model_get(s : DbquerywindowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_model_set(s : DbquerywindowModel, i : Int, v : Double) -> DbquerywindowModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_model_sum(s : DbquerywindowModel) -> Double { @_common.sum(s.data) }

pub fn db_query_window_model_mean(s : DbquerywindowModel) -> Double { @_common.mean(s.data) }

pub fn db_query_window_model_scale(s : DbquerywindowModel, f : Double) -> DbquerywindowModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_model_add(a : DbquerywindowModel, b : DbquerywindowModel) -> DbquerywindowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_model_copy(s : DbquerywindowModel) -> DbquerywindowModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_model_fill(s : DbquerywindowModel, v : Double) -> DbquerywindowModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_model_min(s : DbquerywindowModel) -> Double { @_common.min(s.data) }

pub fn db_query_window_model_max(s : DbquerywindowModel) -> Double { @_common.max(s.data) }

pub fn db_query_window_model_to_string(s : DbquerywindowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_layer_make(size : Int) -> DbquerywindowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_layer_len(s : DbquerywindowLayer) -> Int { s.size }

pub fn db_query_window_layer_get(s : DbquerywindowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_layer_set(s : DbquerywindowLayer, i : Int, v : Double) -> DbquerywindowLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_sum(s : DbquerywindowLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_window_layer_mean(s : DbquerywindowLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_window_layer_scale(s : DbquerywindowLayer, f : Double) -> DbquerywindowLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_add(a : DbquerywindowLayer, b : DbquerywindowLayer) -> DbquerywindowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_layer_copy(s : DbquerywindowLayer) -> DbquerywindowLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_fill(s : DbquerywindowLayer, v : Double) -> DbquerywindowLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_min(s : DbquerywindowLayer) -> Double { @_common.min(s.data) }

pub fn db_query_window_layer_max(s : DbquerywindowLayer) -> Double { @_common.max(s.data) }

pub fn db_query_window_layer_to_string(s : DbquerywindowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_buffer_make(size : Int) -> DbquerywindowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_buffer_len(s : DbquerywindowBuffer) -> Int { s.size }

pub fn db_query_window_buffer_get(s : DbquerywindowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_buffer_set(s : DbquerywindowBuffer, i : Int, v : Double) -> DbquerywindowBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_sum(s : DbquerywindowBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_window_buffer_mean(s : DbquerywindowBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_window_buffer_scale(s : DbquerywindowBuffer, f : Double) -> DbquerywindowBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_add(a : DbquerywindowBuffer, b : DbquerywindowBuffer) -> DbquerywindowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_buffer_copy(s : DbquerywindowBuffer) -> DbquerywindowBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_fill(s : DbquerywindowBuffer, v : Double) -> DbquerywindowBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_min(s : DbquerywindowBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_window_buffer_max(s : DbquerywindowBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_window_buffer_to_string(s : DbquerywindowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_cursor_make(size : Int) -> DbquerywindowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_cursor_len(s : DbquerywindowCursor) -> Int { s.size }

pub fn db_query_window_cursor_get(s : DbquerywindowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_cursor_set(s : DbquerywindowCursor, i : Int, v : Double) -> DbquerywindowCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_sum(s : DbquerywindowCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_window_cursor_mean(s : DbquerywindowCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_window_cursor_scale(s : DbquerywindowCursor, f : Double) -> DbquerywindowCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_add(a : DbquerywindowCursor, b : DbquerywindowCursor) -> DbquerywindowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_cursor_copy(s : DbquerywindowCursor) -> DbquerywindowCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_fill(s : DbquerywindowCursor, v : Double) -> DbquerywindowCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_min(s : DbquerywindowCursor) -> Double { @_common.min(s.data) }

pub fn db_query_window_cursor_max(s : DbquerywindowCursor) -> Double { @_common.max(s.data) }

pub fn db_query_window_cursor_to_string(s : DbquerywindowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_view_make(size : Int) -> DbquerywindowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_view_len(s : DbquerywindowView) -> Int { s.size }

pub fn db_query_window_view_get(s : DbquerywindowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_view_set(s : DbquerywindowView, i : Int, v : Double) -> DbquerywindowView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_view_sum(s : DbquerywindowView) -> Double { @_common.sum(s.data) }

pub fn db_query_window_view_mean(s : DbquerywindowView) -> Double { @_common.mean(s.data) }

pub fn db_query_window_view_scale(s : DbquerywindowView, f : Double) -> DbquerywindowView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_view_add(a : DbquerywindowView, b : DbquerywindowView) -> DbquerywindowView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_view_copy(s : DbquerywindowView) -> DbquerywindowView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_view_fill(s : DbquerywindowView, v : Double) -> DbquerywindowView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_view_min(s : DbquerywindowView) -> Double { @_common.min(s.data) }

pub fn db_query_window_view_max(s : DbquerywindowView) -> Double { @_common.max(s.data) }

pub fn db_query_window_view_to_string(s : DbquerywindowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_range_make(size : Int) -> DbquerywindowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_range_len(s : DbquerywindowRange) -> Int { s.size }

pub fn db_query_window_range_get(s : DbquerywindowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_range_set(s : DbquerywindowRange, i : Int, v : Double) -> DbquerywindowRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_range_sum(s : DbquerywindowRange) -> Double { @_common.sum(s.data) }

pub fn db_query_window_range_mean(s : DbquerywindowRange) -> Double { @_common.mean(s.data) }

pub fn db_query_window_range_scale(s : DbquerywindowRange, f : Double) -> DbquerywindowRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_range_add(a : DbquerywindowRange, b : DbquerywindowRange) -> DbquerywindowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_range_copy(s : DbquerywindowRange) -> DbquerywindowRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_range_fill(s : DbquerywindowRange, v : Double) -> DbquerywindowRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_range_min(s : DbquerywindowRange) -> Double { @_common.min(s.data) }

pub fn db_query_window_range_max(s : DbquerywindowRange) -> Double { @_common.max(s.data) }

pub fn db_query_window_range_to_string(s : DbquerywindowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_slice_make(size : Int) -> DbquerywindowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_slice_len(s : DbquerywindowSlice) -> Int { s.size }

pub fn db_query_window_slice_get(s : DbquerywindowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_slice_set(s : DbquerywindowSlice, i : Int, v : Double) -> DbquerywindowSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_sum(s : DbquerywindowSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_window_slice_mean(s : DbquerywindowSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_window_slice_scale(s : DbquerywindowSlice, f : Double) -> DbquerywindowSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_add(a : DbquerywindowSlice, b : DbquerywindowSlice) -> DbquerywindowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_slice_copy(s : DbquerywindowSlice) -> DbquerywindowSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_fill(s : DbquerywindowSlice, v : Double) -> DbquerywindowSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_min(s : DbquerywindowSlice) -> Double { @_common.min(s.data) }

pub fn db_query_window_slice_max(s : DbquerywindowSlice) -> Double { @_common.max(s.data) }

pub fn db_query_window_slice_to_string(s : DbquerywindowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

