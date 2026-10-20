///===
/// extcore/db_query_group

pub(all) struct DbquerygroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_group_make_point(x : Double, y : Double) -> DbquerygroupPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_group_make_point3(x : Double, y : Double, z : Double) -> DbquerygroupPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerygroupPoint::x(self : DbquerygroupPoint) -> Double { self.x }

pub fn DbquerygroupPoint::y(self : DbquerygroupPoint) -> Double { self.y }

pub fn DbquerygroupPoint::z(self : DbquerygroupPoint) -> Double { self.z }

pub fn DbquerygroupPoint::label(self : DbquerygroupPoint) -> Int { self.label }

pub fn DbquerygroupPoint::dist(self : DbquerygroupPoint, other : DbquerygroupPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerygroupPoint::add(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerygroupPoint::sub(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerygroupPoint::scale(self : DbquerygroupPoint, s : Double) -> DbquerygroupPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerygroupPoint::dot(self : DbquerygroupPoint, other : DbquerygroupPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerygroupPoint::cross(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerygroupPoint::norm(self : DbquerygroupPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerygroupPoint::normalize(self : DbquerygroupPoint) -> DbquerygroupPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerygroupPoint::negate(self : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerygroupPoint::mid(self : DbquerygroupPoint, other : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerygroupPoint::lerp(self : DbquerygroupPoint, other : DbquerygroupPoint, t : Double) -> DbquerygroupPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerygroupPoint::to_string(self : DbquerygroupPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerygroupSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_group_make_series(vals : Array[Double], name : String) -> DbquerygroupSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerygroupSeries::len(self : DbquerygroupSeries) -> Int { self.vals.length() }

pub fn DbquerygroupSeries::sum(self : DbquerygroupSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerygroupSeries::mean(self : DbquerygroupSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerygroupSeries::min(self : DbquerygroupSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerygroupSeries::max(self : DbquerygroupSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerygroupSeries::range(self : DbquerygroupSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerygroupSeries::variance(self : DbquerygroupSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerygroupSeries::std(self : DbquerygroupSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerygroupSeries::median(self : DbquerygroupSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerygroupSeries::scale(self : DbquerygroupSeries, f : Double) -> DbquerygroupSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerygroupSeries::add(self : DbquerygroupSeries, other : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerygroupSeries::sub(self : DbquerygroupSeries, other : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerygroupSeries::normalize(self : DbquerygroupSeries) -> DbquerygroupSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerygroupSeries::cumsum(self : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerygroupSeries::to_string(self : DbquerygroupSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerygroupMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_group_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerygroupMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_group_matrix_identity(n : Int) -> DbquerygroupMatrix {
  let m = db_query_group_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerygroupMatrix::get(self : DbquerygroupMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerygroupMatrix::transpose(self : DbquerygroupMatrix) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerygroupMatrix::add(self : DbquerygroupMatrix, other : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerygroupMatrix::scale(self : DbquerygroupMatrix, s : Double) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerygroupMatrix::multiply(self : DbquerygroupMatrix, other : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if self.cols != other.rows { return db_query_group_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_group_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbquerygroupMatrix::trace(self : DbquerygroupMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerygroupMatrix::det(self : DbquerygroupMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerygroupMatrix::norm(self : DbquerygroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerygroupMatrix::to_string(self : DbquerygroupMatrix) -> String {
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

pub(all) struct DbquerygroupVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_group_make_vector(comps : Array[Double]) -> DbquerygroupVector {
  { comps, dim: comps.length() }
}

pub fn db_query_group_vector_zero(dim : Int) -> DbquerygroupVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerygroupVector::add(self : DbquerygroupVector, other : DbquerygroupVector) -> DbquerygroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerygroupVector::sub(self : DbquerygroupVector, other : DbquerygroupVector) -> DbquerygroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerygroupVector::scale(self : DbquerygroupVector, s : Double) -> DbquerygroupVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerygroupVector::dot(self : DbquerygroupVector, other : DbquerygroupVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerygroupVector::norm(self : DbquerygroupVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerygroupVector::normalize(self : DbquerygroupVector) -> DbquerygroupVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerygroupVector::dist(self : DbquerygroupVector, other : DbquerygroupVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerygroupVector::to_string(self : DbquerygroupVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_group_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_group_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_group_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_group_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_group_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_group_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_group_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_group_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_group_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_group_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_group_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_group_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_group_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_group_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_group_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_group_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_group_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_group_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_group_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_group_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_group_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_group_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_group_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_group_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_group_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_group_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_group_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_group_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_group_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerygroupFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_frame_make(size : Int) -> DbquerygroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_frame_len(s : DbquerygroupFrame) -> Int { s.size }

pub fn db_query_group_frame_get(s : DbquerygroupFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_frame_set(s : DbquerygroupFrame, i : Int, v : Double) -> DbquerygroupFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_frame_sum(s : DbquerygroupFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_group_frame_mean(s : DbquerygroupFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_group_frame_scale(s : DbquerygroupFrame, f : Double) -> DbquerygroupFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_frame_add(a : DbquerygroupFrame, b : DbquerygroupFrame) -> DbquerygroupFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_frame_copy(s : DbquerygroupFrame) -> DbquerygroupFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_frame_fill(s : DbquerygroupFrame, v : Double) -> DbquerygroupFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_frame_min(s : DbquerygroupFrame) -> Double { @_common.min(s.data) }

pub fn db_query_group_frame_max(s : DbquerygroupFrame) -> Double { @_common.max(s.data) }

pub fn db_query_group_frame_to_string(s : DbquerygroupFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_table_make(size : Int) -> DbquerygroupTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_table_len(s : DbquerygroupTable) -> Int { s.size }

pub fn db_query_group_table_get(s : DbquerygroupTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_table_set(s : DbquerygroupTable, i : Int, v : Double) -> DbquerygroupTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_table_sum(s : DbquerygroupTable) -> Double { @_common.sum(s.data) }

pub fn db_query_group_table_mean(s : DbquerygroupTable) -> Double { @_common.mean(s.data) }

pub fn db_query_group_table_scale(s : DbquerygroupTable, f : Double) -> DbquerygroupTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_table_add(a : DbquerygroupTable, b : DbquerygroupTable) -> DbquerygroupTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_table_copy(s : DbquerygroupTable) -> DbquerygroupTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_table_fill(s : DbquerygroupTable, v : Double) -> DbquerygroupTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_table_min(s : DbquerygroupTable) -> Double { @_common.min(s.data) }

pub fn db_query_group_table_max(s : DbquerygroupTable) -> Double { @_common.max(s.data) }

pub fn db_query_group_table_to_string(s : DbquerygroupTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_graphn_make(size : Int) -> DbquerygroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_graphn_len(s : DbquerygroupGraphN) -> Int { s.size }

pub fn db_query_group_graphn_get(s : DbquerygroupGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_graphn_set(s : DbquerygroupGraphN, i : Int, v : Double) -> DbquerygroupGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_graphn_sum(s : DbquerygroupGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_group_graphn_mean(s : DbquerygroupGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_group_graphn_scale(s : DbquerygroupGraphN, f : Double) -> DbquerygroupGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_graphn_add(a : DbquerygroupGraphN, b : DbquerygroupGraphN) -> DbquerygroupGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_graphn_copy(s : DbquerygroupGraphN) -> DbquerygroupGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_graphn_fill(s : DbquerygroupGraphN, v : Double) -> DbquerygroupGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_graphn_min(s : DbquerygroupGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_group_graphn_max(s : DbquerygroupGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_group_graphn_to_string(s : DbquerygroupGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_node_make(size : Int) -> DbquerygroupNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_node_len(s : DbquerygroupNode) -> Int { s.size }

pub fn db_query_group_node_get(s : DbquerygroupNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_node_set(s : DbquerygroupNode, i : Int, v : Double) -> DbquerygroupNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_node_sum(s : DbquerygroupNode) -> Double { @_common.sum(s.data) }

pub fn db_query_group_node_mean(s : DbquerygroupNode) -> Double { @_common.mean(s.data) }

pub fn db_query_group_node_scale(s : DbquerygroupNode, f : Double) -> DbquerygroupNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_node_add(a : DbquerygroupNode, b : DbquerygroupNode) -> DbquerygroupNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_node_copy(s : DbquerygroupNode) -> DbquerygroupNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_node_fill(s : DbquerygroupNode, v : Double) -> DbquerygroupNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_node_min(s : DbquerygroupNode) -> Double { @_common.min(s.data) }

pub fn db_query_group_node_max(s : DbquerygroupNode) -> Double { @_common.max(s.data) }

pub fn db_query_group_node_to_string(s : DbquerygroupNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_edge_make(size : Int) -> DbquerygroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_edge_len(s : DbquerygroupEdge) -> Int { s.size }

pub fn db_query_group_edge_get(s : DbquerygroupEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_edge_set(s : DbquerygroupEdge, i : Int, v : Double) -> DbquerygroupEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_edge_sum(s : DbquerygroupEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_group_edge_mean(s : DbquerygroupEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_group_edge_scale(s : DbquerygroupEdge, f : Double) -> DbquerygroupEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_edge_add(a : DbquerygroupEdge, b : DbquerygroupEdge) -> DbquerygroupEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_edge_copy(s : DbquerygroupEdge) -> DbquerygroupEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_edge_fill(s : DbquerygroupEdge, v : Double) -> DbquerygroupEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_edge_min(s : DbquerygroupEdge) -> Double { @_common.min(s.data) }

pub fn db_query_group_edge_max(s : DbquerygroupEdge) -> Double { @_common.max(s.data) }

pub fn db_query_group_edge_to_string(s : DbquerygroupEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_path_make(size : Int) -> DbquerygroupPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_path_len(s : DbquerygroupPath) -> Int { s.size }

pub fn db_query_group_path_get(s : DbquerygroupPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_path_set(s : DbquerygroupPath, i : Int, v : Double) -> DbquerygroupPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_path_sum(s : DbquerygroupPath) -> Double { @_common.sum(s.data) }

pub fn db_query_group_path_mean(s : DbquerygroupPath) -> Double { @_common.mean(s.data) }

pub fn db_query_group_path_scale(s : DbquerygroupPath, f : Double) -> DbquerygroupPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_path_add(a : DbquerygroupPath, b : DbquerygroupPath) -> DbquerygroupPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_path_copy(s : DbquerygroupPath) -> DbquerygroupPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_path_fill(s : DbquerygroupPath, v : Double) -> DbquerygroupPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_path_min(s : DbquerygroupPath) -> Double { @_common.min(s.data) }

pub fn db_query_group_path_max(s : DbquerygroupPath) -> Double { @_common.max(s.data) }

pub fn db_query_group_path_to_string(s : DbquerygroupPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cluster_make(size : Int) -> DbquerygroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_cluster_len(s : DbquerygroupCluster) -> Int { s.size }

pub fn db_query_group_cluster_get(s : DbquerygroupCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_cluster_set(s : DbquerygroupCluster, i : Int, v : Double) -> DbquerygroupCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_cluster_sum(s : DbquerygroupCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_group_cluster_mean(s : DbquerygroupCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_group_cluster_scale(s : DbquerygroupCluster, f : Double) -> DbquerygroupCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_cluster_add(a : DbquerygroupCluster, b : DbquerygroupCluster) -> DbquerygroupCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_cluster_copy(s : DbquerygroupCluster) -> DbquerygroupCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_cluster_fill(s : DbquerygroupCluster, v : Double) -> DbquerygroupCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_cluster_min(s : DbquerygroupCluster) -> Double { @_common.min(s.data) }

pub fn db_query_group_cluster_max(s : DbquerygroupCluster) -> Double { @_common.max(s.data) }

pub fn db_query_group_cluster_to_string(s : DbquerygroupCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_model_make(size : Int) -> DbquerygroupModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_model_len(s : DbquerygroupModel) -> Int { s.size }

pub fn db_query_group_model_get(s : DbquerygroupModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_model_set(s : DbquerygroupModel, i : Int, v : Double) -> DbquerygroupModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_model_sum(s : DbquerygroupModel) -> Double { @_common.sum(s.data) }

pub fn db_query_group_model_mean(s : DbquerygroupModel) -> Double { @_common.mean(s.data) }

pub fn db_query_group_model_scale(s : DbquerygroupModel, f : Double) -> DbquerygroupModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_model_add(a : DbquerygroupModel, b : DbquerygroupModel) -> DbquerygroupModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_model_copy(s : DbquerygroupModel) -> DbquerygroupModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_model_fill(s : DbquerygroupModel, v : Double) -> DbquerygroupModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_model_min(s : DbquerygroupModel) -> Double { @_common.min(s.data) }

pub fn db_query_group_model_max(s : DbquerygroupModel) -> Double { @_common.max(s.data) }

pub fn db_query_group_model_to_string(s : DbquerygroupModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_layer_make(size : Int) -> DbquerygroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_layer_len(s : DbquerygroupLayer) -> Int { s.size }

pub fn db_query_group_layer_get(s : DbquerygroupLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_layer_set(s : DbquerygroupLayer, i : Int, v : Double) -> DbquerygroupLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_layer_sum(s : DbquerygroupLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_group_layer_mean(s : DbquerygroupLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_group_layer_scale(s : DbquerygroupLayer, f : Double) -> DbquerygroupLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_layer_add(a : DbquerygroupLayer, b : DbquerygroupLayer) -> DbquerygroupLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_layer_copy(s : DbquerygroupLayer) -> DbquerygroupLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_layer_fill(s : DbquerygroupLayer, v : Double) -> DbquerygroupLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_layer_min(s : DbquerygroupLayer) -> Double { @_common.min(s.data) }

pub fn db_query_group_layer_max(s : DbquerygroupLayer) -> Double { @_common.max(s.data) }

pub fn db_query_group_layer_to_string(s : DbquerygroupLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_buffer_make(size : Int) -> DbquerygroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_buffer_len(s : DbquerygroupBuffer) -> Int { s.size }

pub fn db_query_group_buffer_get(s : DbquerygroupBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_buffer_set(s : DbquerygroupBuffer, i : Int, v : Double) -> DbquerygroupBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_buffer_sum(s : DbquerygroupBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_group_buffer_mean(s : DbquerygroupBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_group_buffer_scale(s : DbquerygroupBuffer, f : Double) -> DbquerygroupBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_buffer_add(a : DbquerygroupBuffer, b : DbquerygroupBuffer) -> DbquerygroupBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_buffer_copy(s : DbquerygroupBuffer) -> DbquerygroupBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_buffer_fill(s : DbquerygroupBuffer, v : Double) -> DbquerygroupBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_buffer_min(s : DbquerygroupBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_group_buffer_max(s : DbquerygroupBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_group_buffer_to_string(s : DbquerygroupBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cursor_make(size : Int) -> DbquerygroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_cursor_len(s : DbquerygroupCursor) -> Int { s.size }

pub fn db_query_group_cursor_get(s : DbquerygroupCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_cursor_set(s : DbquerygroupCursor, i : Int, v : Double) -> DbquerygroupCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_cursor_sum(s : DbquerygroupCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_group_cursor_mean(s : DbquerygroupCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_group_cursor_scale(s : DbquerygroupCursor, f : Double) -> DbquerygroupCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_cursor_add(a : DbquerygroupCursor, b : DbquerygroupCursor) -> DbquerygroupCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_cursor_copy(s : DbquerygroupCursor) -> DbquerygroupCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_cursor_fill(s : DbquerygroupCursor, v : Double) -> DbquerygroupCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_cursor_min(s : DbquerygroupCursor) -> Double { @_common.min(s.data) }

pub fn db_query_group_cursor_max(s : DbquerygroupCursor) -> Double { @_common.max(s.data) }

pub fn db_query_group_cursor_to_string(s : DbquerygroupCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_view_make(size : Int) -> DbquerygroupView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_view_len(s : DbquerygroupView) -> Int { s.size }

pub fn db_query_group_view_get(s : DbquerygroupView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_view_set(s : DbquerygroupView, i : Int, v : Double) -> DbquerygroupView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_view_sum(s : DbquerygroupView) -> Double { @_common.sum(s.data) }

pub fn db_query_group_view_mean(s : DbquerygroupView) -> Double { @_common.mean(s.data) }

pub fn db_query_group_view_scale(s : DbquerygroupView, f : Double) -> DbquerygroupView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_view_add(a : DbquerygroupView, b : DbquerygroupView) -> DbquerygroupView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_view_copy(s : DbquerygroupView) -> DbquerygroupView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_view_fill(s : DbquerygroupView, v : Double) -> DbquerygroupView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_view_min(s : DbquerygroupView) -> Double { @_common.min(s.data) }

pub fn db_query_group_view_max(s : DbquerygroupView) -> Double { @_common.max(s.data) }

pub fn db_query_group_view_to_string(s : DbquerygroupView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_range_make(size : Int) -> DbquerygroupRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_range_len(s : DbquerygroupRange) -> Int { s.size }

pub fn db_query_group_range_get(s : DbquerygroupRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_range_set(s : DbquerygroupRange, i : Int, v : Double) -> DbquerygroupRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_range_sum(s : DbquerygroupRange) -> Double { @_common.sum(s.data) }

pub fn db_query_group_range_mean(s : DbquerygroupRange) -> Double { @_common.mean(s.data) }

pub fn db_query_group_range_scale(s : DbquerygroupRange, f : Double) -> DbquerygroupRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_range_add(a : DbquerygroupRange, b : DbquerygroupRange) -> DbquerygroupRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_range_copy(s : DbquerygroupRange) -> DbquerygroupRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_range_fill(s : DbquerygroupRange, v : Double) -> DbquerygroupRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_range_min(s : DbquerygroupRange) -> Double { @_common.min(s.data) }

pub fn db_query_group_range_max(s : DbquerygroupRange) -> Double { @_common.max(s.data) }

pub fn db_query_group_range_to_string(s : DbquerygroupRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_slice_make(size : Int) -> DbquerygroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_slice_len(s : DbquerygroupSlice) -> Int { s.size }

pub fn db_query_group_slice_get(s : DbquerygroupSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_slice_set(s : DbquerygroupSlice, i : Int, v : Double) -> DbquerygroupSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_group_slice_sum(s : DbquerygroupSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_group_slice_mean(s : DbquerygroupSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_group_slice_scale(s : DbquerygroupSlice, f : Double) -> DbquerygroupSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_group_slice_add(a : DbquerygroupSlice, b : DbquerygroupSlice) -> DbquerygroupSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_group_slice_copy(s : DbquerygroupSlice) -> DbquerygroupSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_group_slice_fill(s : DbquerygroupSlice, v : Double) -> DbquerygroupSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_group_slice_min(s : DbquerygroupSlice) -> Double { @_common.min(s.data) }

pub fn db_query_group_slice_max(s : DbquerygroupSlice) -> Double { @_common.max(s.data) }

pub fn db_query_group_slice_to_string(s : DbquerygroupSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

