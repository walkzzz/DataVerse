///===
/// extcore/db_query_select

pub(all) struct DbqueryselectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_select_make_point(x : Double, y : Double) -> DbqueryselectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_select_make_point3(x : Double, y : Double, z : Double) -> DbqueryselectPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryselectPoint::x(self : DbqueryselectPoint) -> Double { self.x }

pub fn DbqueryselectPoint::y(self : DbqueryselectPoint) -> Double { self.y }

pub fn DbqueryselectPoint::z(self : DbqueryselectPoint) -> Double { self.z }

pub fn DbqueryselectPoint::label(self : DbqueryselectPoint) -> Int { self.label }

pub fn DbqueryselectPoint::dist(self : DbqueryselectPoint, other : DbqueryselectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryselectPoint::add(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryselectPoint::sub(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryselectPoint::scale(self : DbqueryselectPoint, s : Double) -> DbqueryselectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryselectPoint::dot(self : DbqueryselectPoint, other : DbqueryselectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryselectPoint::cross(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryselectPoint::norm(self : DbqueryselectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryselectPoint::normalize(self : DbqueryselectPoint) -> DbqueryselectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryselectPoint::negate(self : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryselectPoint::mid(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryselectPoint::lerp(self : DbqueryselectPoint, other : DbqueryselectPoint, t : Double) -> DbqueryselectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryselectPoint::to_string(self : DbqueryselectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryselectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_select_make_series(vals : Array[Double], name : String) -> DbqueryselectSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryselectSeries::len(self : DbqueryselectSeries) -> Int { self.vals.length() }

pub fn DbqueryselectSeries::sum(self : DbqueryselectSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryselectSeries::mean(self : DbqueryselectSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryselectSeries::min(self : DbqueryselectSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryselectSeries::max(self : DbqueryselectSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryselectSeries::range(self : DbqueryselectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryselectSeries::variance(self : DbqueryselectSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryselectSeries::std(self : DbqueryselectSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryselectSeries::median(self : DbqueryselectSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryselectSeries::scale(self : DbqueryselectSeries, f : Double) -> DbqueryselectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryselectSeries::add(self : DbqueryselectSeries, other : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryselectSeries::sub(self : DbqueryselectSeries, other : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryselectSeries::normalize(self : DbqueryselectSeries) -> DbqueryselectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryselectSeries::cumsum(self : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryselectSeries::to_string(self : DbqueryselectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryselectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_select_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryselectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_select_matrix_identity(n : Int) -> DbqueryselectMatrix {
  let m = db_query_select_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryselectMatrix::get(self : DbqueryselectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryselectMatrix::transpose(self : DbqueryselectMatrix) -> DbqueryselectMatrix {
  let result = db_query_select_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryselectMatrix::add(self : DbqueryselectMatrix, other : DbqueryselectMatrix) -> DbqueryselectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_select_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryselectMatrix::scale(self : DbqueryselectMatrix, s : Double) -> DbqueryselectMatrix {
  let result = db_query_select_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryselectMatrix::multiply(self : DbqueryselectMatrix, other : DbqueryselectMatrix) -> DbqueryselectMatrix {
  if self.cols != other.rows { return db_query_select_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_select_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryselectMatrix::trace(self : DbqueryselectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryselectMatrix::det(self : DbqueryselectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryselectMatrix::norm(self : DbqueryselectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryselectMatrix::to_string(self : DbqueryselectMatrix) -> String {
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

pub(all) struct DbqueryselectVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_select_make_vector(comps : Array[Double]) -> DbqueryselectVector {
  { comps, dim: comps.length() }
}

pub fn db_query_select_vector_zero(dim : Int) -> DbqueryselectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryselectVector::add(self : DbqueryselectVector, other : DbqueryselectVector) -> DbqueryselectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryselectVector::sub(self : DbqueryselectVector, other : DbqueryselectVector) -> DbqueryselectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryselectVector::scale(self : DbqueryselectVector, s : Double) -> DbqueryselectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryselectVector::dot(self : DbqueryselectVector, other : DbqueryselectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryselectVector::norm(self : DbqueryselectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryselectVector::normalize(self : DbqueryselectVector) -> DbqueryselectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryselectVector::dist(self : DbqueryselectVector, other : DbqueryselectVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryselectVector::to_string(self : DbqueryselectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_select_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_select_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_select_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_select_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_select_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_select_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_select_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_select_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_select_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_select_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_select_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_select_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_select_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_select_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_select_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_select_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_select_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_select_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_select_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_select_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_select_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_select_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_select_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_select_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_select_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_select_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_select_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_select_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_select_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryselectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_frame_make(size : Int) -> DbqueryselectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_frame_len(s : DbqueryselectFrame) -> Int { s.size }

pub fn db_query_select_frame_get(s : DbqueryselectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_frame_set(s : DbqueryselectFrame, i : Int, v : Double) -> DbqueryselectFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_frame_sum(s : DbqueryselectFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_select_frame_mean(s : DbqueryselectFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_select_frame_scale(s : DbqueryselectFrame, f : Double) -> DbqueryselectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_frame_add(a : DbqueryselectFrame, b : DbqueryselectFrame) -> DbqueryselectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_frame_copy(s : DbqueryselectFrame) -> DbqueryselectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_frame_fill(s : DbqueryselectFrame, v : Double) -> DbqueryselectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_frame_min(s : DbqueryselectFrame) -> Double { @_common.min(s.data) }

pub fn db_query_select_frame_max(s : DbqueryselectFrame) -> Double { @_common.max(s.data) }

pub fn db_query_select_frame_to_string(s : DbqueryselectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_table_make(size : Int) -> DbqueryselectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_table_len(s : DbqueryselectTable) -> Int { s.size }

pub fn db_query_select_table_get(s : DbqueryselectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_table_set(s : DbqueryselectTable, i : Int, v : Double) -> DbqueryselectTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_table_sum(s : DbqueryselectTable) -> Double { @_common.sum(s.data) }

pub fn db_query_select_table_mean(s : DbqueryselectTable) -> Double { @_common.mean(s.data) }

pub fn db_query_select_table_scale(s : DbqueryselectTable, f : Double) -> DbqueryselectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_table_add(a : DbqueryselectTable, b : DbqueryselectTable) -> DbqueryselectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_table_copy(s : DbqueryselectTable) -> DbqueryselectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_table_fill(s : DbqueryselectTable, v : Double) -> DbqueryselectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_table_min(s : DbqueryselectTable) -> Double { @_common.min(s.data) }

pub fn db_query_select_table_max(s : DbqueryselectTable) -> Double { @_common.max(s.data) }

pub fn db_query_select_table_to_string(s : DbqueryselectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_graphn_make(size : Int) -> DbqueryselectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_graphn_len(s : DbqueryselectGraphN) -> Int { s.size }

pub fn db_query_select_graphn_get(s : DbqueryselectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_graphn_set(s : DbqueryselectGraphN, i : Int, v : Double) -> DbqueryselectGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_graphn_sum(s : DbqueryselectGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_select_graphn_mean(s : DbqueryselectGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_select_graphn_scale(s : DbqueryselectGraphN, f : Double) -> DbqueryselectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_graphn_add(a : DbqueryselectGraphN, b : DbqueryselectGraphN) -> DbqueryselectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_graphn_copy(s : DbqueryselectGraphN) -> DbqueryselectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_graphn_fill(s : DbqueryselectGraphN, v : Double) -> DbqueryselectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_graphn_min(s : DbqueryselectGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_select_graphn_max(s : DbqueryselectGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_select_graphn_to_string(s : DbqueryselectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_node_make(size : Int) -> DbqueryselectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_node_len(s : DbqueryselectNode) -> Int { s.size }

pub fn db_query_select_node_get(s : DbqueryselectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_node_set(s : DbqueryselectNode, i : Int, v : Double) -> DbqueryselectNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_node_sum(s : DbqueryselectNode) -> Double { @_common.sum(s.data) }

pub fn db_query_select_node_mean(s : DbqueryselectNode) -> Double { @_common.mean(s.data) }

pub fn db_query_select_node_scale(s : DbqueryselectNode, f : Double) -> DbqueryselectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_node_add(a : DbqueryselectNode, b : DbqueryselectNode) -> DbqueryselectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_node_copy(s : DbqueryselectNode) -> DbqueryselectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_node_fill(s : DbqueryselectNode, v : Double) -> DbqueryselectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_node_min(s : DbqueryselectNode) -> Double { @_common.min(s.data) }

pub fn db_query_select_node_max(s : DbqueryselectNode) -> Double { @_common.max(s.data) }

pub fn db_query_select_node_to_string(s : DbqueryselectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_edge_make(size : Int) -> DbqueryselectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_edge_len(s : DbqueryselectEdge) -> Int { s.size }

pub fn db_query_select_edge_get(s : DbqueryselectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_edge_set(s : DbqueryselectEdge, i : Int, v : Double) -> DbqueryselectEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_edge_sum(s : DbqueryselectEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_select_edge_mean(s : DbqueryselectEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_select_edge_scale(s : DbqueryselectEdge, f : Double) -> DbqueryselectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_edge_add(a : DbqueryselectEdge, b : DbqueryselectEdge) -> DbqueryselectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_edge_copy(s : DbqueryselectEdge) -> DbqueryselectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_edge_fill(s : DbqueryselectEdge, v : Double) -> DbqueryselectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_edge_min(s : DbqueryselectEdge) -> Double { @_common.min(s.data) }

pub fn db_query_select_edge_max(s : DbqueryselectEdge) -> Double { @_common.max(s.data) }

pub fn db_query_select_edge_to_string(s : DbqueryselectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_path_make(size : Int) -> DbqueryselectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_path_len(s : DbqueryselectPath) -> Int { s.size }

pub fn db_query_select_path_get(s : DbqueryselectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_path_set(s : DbqueryselectPath, i : Int, v : Double) -> DbqueryselectPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_path_sum(s : DbqueryselectPath) -> Double { @_common.sum(s.data) }

pub fn db_query_select_path_mean(s : DbqueryselectPath) -> Double { @_common.mean(s.data) }

pub fn db_query_select_path_scale(s : DbqueryselectPath, f : Double) -> DbqueryselectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_path_add(a : DbqueryselectPath, b : DbqueryselectPath) -> DbqueryselectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_path_copy(s : DbqueryselectPath) -> DbqueryselectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_path_fill(s : DbqueryselectPath, v : Double) -> DbqueryselectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_path_min(s : DbqueryselectPath) -> Double { @_common.min(s.data) }

pub fn db_query_select_path_max(s : DbqueryselectPath) -> Double { @_common.max(s.data) }

pub fn db_query_select_path_to_string(s : DbqueryselectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_cluster_make(size : Int) -> DbqueryselectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_cluster_len(s : DbqueryselectCluster) -> Int { s.size }

pub fn db_query_select_cluster_get(s : DbqueryselectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_cluster_set(s : DbqueryselectCluster, i : Int, v : Double) -> DbqueryselectCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_cluster_sum(s : DbqueryselectCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_select_cluster_mean(s : DbqueryselectCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_select_cluster_scale(s : DbqueryselectCluster, f : Double) -> DbqueryselectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_cluster_add(a : DbqueryselectCluster, b : DbqueryselectCluster) -> DbqueryselectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_cluster_copy(s : DbqueryselectCluster) -> DbqueryselectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_cluster_fill(s : DbqueryselectCluster, v : Double) -> DbqueryselectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_cluster_min(s : DbqueryselectCluster) -> Double { @_common.min(s.data) }

pub fn db_query_select_cluster_max(s : DbqueryselectCluster) -> Double { @_common.max(s.data) }

pub fn db_query_select_cluster_to_string(s : DbqueryselectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_model_make(size : Int) -> DbqueryselectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_model_len(s : DbqueryselectModel) -> Int { s.size }

pub fn db_query_select_model_get(s : DbqueryselectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_model_set(s : DbqueryselectModel, i : Int, v : Double) -> DbqueryselectModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_model_sum(s : DbqueryselectModel) -> Double { @_common.sum(s.data) }

pub fn db_query_select_model_mean(s : DbqueryselectModel) -> Double { @_common.mean(s.data) }

pub fn db_query_select_model_scale(s : DbqueryselectModel, f : Double) -> DbqueryselectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_model_add(a : DbqueryselectModel, b : DbqueryselectModel) -> DbqueryselectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_model_copy(s : DbqueryselectModel) -> DbqueryselectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_model_fill(s : DbqueryselectModel, v : Double) -> DbqueryselectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_model_min(s : DbqueryselectModel) -> Double { @_common.min(s.data) }

pub fn db_query_select_model_max(s : DbqueryselectModel) -> Double { @_common.max(s.data) }

pub fn db_query_select_model_to_string(s : DbqueryselectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_layer_make(size : Int) -> DbqueryselectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_layer_len(s : DbqueryselectLayer) -> Int { s.size }

pub fn db_query_select_layer_get(s : DbqueryselectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_layer_set(s : DbqueryselectLayer, i : Int, v : Double) -> DbqueryselectLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_layer_sum(s : DbqueryselectLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_select_layer_mean(s : DbqueryselectLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_select_layer_scale(s : DbqueryselectLayer, f : Double) -> DbqueryselectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_layer_add(a : DbqueryselectLayer, b : DbqueryselectLayer) -> DbqueryselectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_layer_copy(s : DbqueryselectLayer) -> DbqueryselectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_layer_fill(s : DbqueryselectLayer, v : Double) -> DbqueryselectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_layer_min(s : DbqueryselectLayer) -> Double { @_common.min(s.data) }

pub fn db_query_select_layer_max(s : DbqueryselectLayer) -> Double { @_common.max(s.data) }

pub fn db_query_select_layer_to_string(s : DbqueryselectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_buffer_make(size : Int) -> DbqueryselectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_buffer_len(s : DbqueryselectBuffer) -> Int { s.size }

pub fn db_query_select_buffer_get(s : DbqueryselectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_buffer_set(s : DbqueryselectBuffer, i : Int, v : Double) -> DbqueryselectBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_buffer_sum(s : DbqueryselectBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_select_buffer_mean(s : DbqueryselectBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_select_buffer_scale(s : DbqueryselectBuffer, f : Double) -> DbqueryselectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_buffer_add(a : DbqueryselectBuffer, b : DbqueryselectBuffer) -> DbqueryselectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_buffer_copy(s : DbqueryselectBuffer) -> DbqueryselectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_buffer_fill(s : DbqueryselectBuffer, v : Double) -> DbqueryselectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_buffer_min(s : DbqueryselectBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_select_buffer_max(s : DbqueryselectBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_select_buffer_to_string(s : DbqueryselectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_cursor_make(size : Int) -> DbqueryselectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_cursor_len(s : DbqueryselectCursor) -> Int { s.size }

pub fn db_query_select_cursor_get(s : DbqueryselectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_cursor_set(s : DbqueryselectCursor, i : Int, v : Double) -> DbqueryselectCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_cursor_sum(s : DbqueryselectCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_select_cursor_mean(s : DbqueryselectCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_select_cursor_scale(s : DbqueryselectCursor, f : Double) -> DbqueryselectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_cursor_add(a : DbqueryselectCursor, b : DbqueryselectCursor) -> DbqueryselectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_cursor_copy(s : DbqueryselectCursor) -> DbqueryselectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_cursor_fill(s : DbqueryselectCursor, v : Double) -> DbqueryselectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_cursor_min(s : DbqueryselectCursor) -> Double { @_common.min(s.data) }

pub fn db_query_select_cursor_max(s : DbqueryselectCursor) -> Double { @_common.max(s.data) }

pub fn db_query_select_cursor_to_string(s : DbqueryselectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_view_make(size : Int) -> DbqueryselectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_view_len(s : DbqueryselectView) -> Int { s.size }

pub fn db_query_select_view_get(s : DbqueryselectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_view_set(s : DbqueryselectView, i : Int, v : Double) -> DbqueryselectView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_view_sum(s : DbqueryselectView) -> Double { @_common.sum(s.data) }

pub fn db_query_select_view_mean(s : DbqueryselectView) -> Double { @_common.mean(s.data) }

pub fn db_query_select_view_scale(s : DbqueryselectView, f : Double) -> DbqueryselectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_view_add(a : DbqueryselectView, b : DbqueryselectView) -> DbqueryselectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_view_copy(s : DbqueryselectView) -> DbqueryselectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_view_fill(s : DbqueryselectView, v : Double) -> DbqueryselectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_view_min(s : DbqueryselectView) -> Double { @_common.min(s.data) }

pub fn db_query_select_view_max(s : DbqueryselectView) -> Double { @_common.max(s.data) }

pub fn db_query_select_view_to_string(s : DbqueryselectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_range_make(size : Int) -> DbqueryselectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_range_len(s : DbqueryselectRange) -> Int { s.size }

pub fn db_query_select_range_get(s : DbqueryselectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_range_set(s : DbqueryselectRange, i : Int, v : Double) -> DbqueryselectRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_range_sum(s : DbqueryselectRange) -> Double { @_common.sum(s.data) }

pub fn db_query_select_range_mean(s : DbqueryselectRange) -> Double { @_common.mean(s.data) }

pub fn db_query_select_range_scale(s : DbqueryselectRange, f : Double) -> DbqueryselectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_range_add(a : DbqueryselectRange, b : DbqueryselectRange) -> DbqueryselectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_range_copy(s : DbqueryselectRange) -> DbqueryselectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_range_fill(s : DbqueryselectRange, v : Double) -> DbqueryselectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_range_min(s : DbqueryselectRange) -> Double { @_common.min(s.data) }

pub fn db_query_select_range_max(s : DbqueryselectRange) -> Double { @_common.max(s.data) }

pub fn db_query_select_range_to_string(s : DbqueryselectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_slice_make(size : Int) -> DbqueryselectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_slice_len(s : DbqueryselectSlice) -> Int { s.size }

pub fn db_query_select_slice_get(s : DbqueryselectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_slice_set(s : DbqueryselectSlice, i : Int, v : Double) -> DbqueryselectSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_select_slice_sum(s : DbqueryselectSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_select_slice_mean(s : DbqueryselectSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_select_slice_scale(s : DbqueryselectSlice, f : Double) -> DbqueryselectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_select_slice_add(a : DbqueryselectSlice, b : DbqueryselectSlice) -> DbqueryselectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_select_slice_copy(s : DbqueryselectSlice) -> DbqueryselectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_select_slice_fill(s : DbqueryselectSlice, v : Double) -> DbqueryselectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_select_slice_min(s : DbqueryselectSlice) -> Double { @_common.min(s.data) }

pub fn db_query_select_slice_max(s : DbqueryselectSlice) -> Double { @_common.max(s.data) }

pub fn db_query_select_slice_to_string(s : DbqueryselectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

