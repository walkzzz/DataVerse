///===
/// extcore/db_query_recursive

pub(all) struct DbqueryrecursivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_recursive_make_point(x : Double, y : Double) -> DbqueryrecursivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_recursive_make_point3(x : Double, y : Double, z : Double) -> DbqueryrecursivePoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryrecursivePoint::x(self : DbqueryrecursivePoint) -> Double { self.x }

pub fn DbqueryrecursivePoint::y(self : DbqueryrecursivePoint) -> Double { self.y }

pub fn DbqueryrecursivePoint::z(self : DbqueryrecursivePoint) -> Double { self.z }

pub fn DbqueryrecursivePoint::label(self : DbqueryrecursivePoint) -> Int { self.label }

pub fn DbqueryrecursivePoint::dist(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryrecursivePoint::add(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryrecursivePoint::sub(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryrecursivePoint::scale(self : DbqueryrecursivePoint, s : Double) -> DbqueryrecursivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryrecursivePoint::dot(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryrecursivePoint::cross(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryrecursivePoint::norm(self : DbqueryrecursivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryrecursivePoint::normalize(self : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryrecursivePoint::negate(self : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryrecursivePoint::mid(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryrecursivePoint::lerp(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint, t : Double) -> DbqueryrecursivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryrecursivePoint::to_string(self : DbqueryrecursivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryrecursiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_recursive_make_series(vals : Array[Double], name : String) -> DbqueryrecursiveSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryrecursiveSeries::len(self : DbqueryrecursiveSeries) -> Int { self.vals.length() }

pub fn DbqueryrecursiveSeries::sum(self : DbqueryrecursiveSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryrecursiveSeries::mean(self : DbqueryrecursiveSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryrecursiveSeries::min(self : DbqueryrecursiveSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryrecursiveSeries::max(self : DbqueryrecursiveSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryrecursiveSeries::range(self : DbqueryrecursiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryrecursiveSeries::variance(self : DbqueryrecursiveSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryrecursiveSeries::std(self : DbqueryrecursiveSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryrecursiveSeries::median(self : DbqueryrecursiveSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryrecursiveSeries::scale(self : DbqueryrecursiveSeries, f : Double) -> DbqueryrecursiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryrecursiveSeries::add(self : DbqueryrecursiveSeries, other : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryrecursiveSeries::sub(self : DbqueryrecursiveSeries, other : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryrecursiveSeries::normalize(self : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryrecursiveSeries::cumsum(self : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryrecursiveSeries::to_string(self : DbqueryrecursiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryrecursiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_recursive_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryrecursiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_recursive_matrix_identity(n : Int) -> DbqueryrecursiveMatrix {
  let m = db_query_recursive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryrecursiveMatrix::get(self : DbqueryrecursiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryrecursiveMatrix::transpose(self : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  let result = db_query_recursive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryrecursiveMatrix::add(self : DbqueryrecursiveMatrix, other : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_recursive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryrecursiveMatrix::scale(self : DbqueryrecursiveMatrix, s : Double) -> DbqueryrecursiveMatrix {
  let result = db_query_recursive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryrecursiveMatrix::multiply(self : DbqueryrecursiveMatrix, other : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  if self.cols != other.rows { return db_query_recursive_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_recursive_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryrecursiveMatrix::trace(self : DbqueryrecursiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryrecursiveMatrix::det(self : DbqueryrecursiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryrecursiveMatrix::norm(self : DbqueryrecursiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryrecursiveMatrix::to_string(self : DbqueryrecursiveMatrix) -> String {
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

pub(all) struct DbqueryrecursiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_recursive_make_vector(comps : Array[Double]) -> DbqueryrecursiveVector {
  { comps, dim: comps.length() }
}

pub fn db_query_recursive_vector_zero(dim : Int) -> DbqueryrecursiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryrecursiveVector::add(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryrecursiveVector::sub(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryrecursiveVector::scale(self : DbqueryrecursiveVector, s : Double) -> DbqueryrecursiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryrecursiveVector::dot(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryrecursiveVector::norm(self : DbqueryrecursiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryrecursiveVector::normalize(self : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryrecursiveVector::dist(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryrecursiveVector::to_string(self : DbqueryrecursiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_recursive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_recursive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_recursive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_recursive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_recursive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_recursive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_recursive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_recursive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_recursive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_recursive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_recursive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_recursive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_recursive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_recursive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_recursive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_recursive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_recursive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_recursive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_recursive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_recursive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_recursive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_recursive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_recursive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_recursive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_recursive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_recursive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_recursive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_recursive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_recursive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryrecursiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_frame_make(size : Int) -> DbqueryrecursiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_frame_len(s : DbqueryrecursiveFrame) -> Int { s.size }

pub fn db_query_recursive_frame_get(s : DbqueryrecursiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_frame_set(s : DbqueryrecursiveFrame, i : Int, v : Double) -> DbqueryrecursiveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_frame_sum(s : DbqueryrecursiveFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_frame_mean(s : DbqueryrecursiveFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_frame_scale(s : DbqueryrecursiveFrame, f : Double) -> DbqueryrecursiveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_frame_add(a : DbqueryrecursiveFrame, b : DbqueryrecursiveFrame) -> DbqueryrecursiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_frame_copy(s : DbqueryrecursiveFrame) -> DbqueryrecursiveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_frame_fill(s : DbqueryrecursiveFrame, v : Double) -> DbqueryrecursiveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_frame_min(s : DbqueryrecursiveFrame) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_frame_max(s : DbqueryrecursiveFrame) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_frame_to_string(s : DbqueryrecursiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_table_make(size : Int) -> DbqueryrecursiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_table_len(s : DbqueryrecursiveTable) -> Int { s.size }

pub fn db_query_recursive_table_get(s : DbqueryrecursiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_table_set(s : DbqueryrecursiveTable, i : Int, v : Double) -> DbqueryrecursiveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_table_sum(s : DbqueryrecursiveTable) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_table_mean(s : DbqueryrecursiveTable) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_table_scale(s : DbqueryrecursiveTable, f : Double) -> DbqueryrecursiveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_table_add(a : DbqueryrecursiveTable, b : DbqueryrecursiveTable) -> DbqueryrecursiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_table_copy(s : DbqueryrecursiveTable) -> DbqueryrecursiveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_table_fill(s : DbqueryrecursiveTable, v : Double) -> DbqueryrecursiveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_table_min(s : DbqueryrecursiveTable) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_table_max(s : DbqueryrecursiveTable) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_table_to_string(s : DbqueryrecursiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_graphn_make(size : Int) -> DbqueryrecursiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_graphn_len(s : DbqueryrecursiveGraphN) -> Int { s.size }

pub fn db_query_recursive_graphn_get(s : DbqueryrecursiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_graphn_set(s : DbqueryrecursiveGraphN, i : Int, v : Double) -> DbqueryrecursiveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_graphn_sum(s : DbqueryrecursiveGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_graphn_mean(s : DbqueryrecursiveGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_graphn_scale(s : DbqueryrecursiveGraphN, f : Double) -> DbqueryrecursiveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_graphn_add(a : DbqueryrecursiveGraphN, b : DbqueryrecursiveGraphN) -> DbqueryrecursiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_graphn_copy(s : DbqueryrecursiveGraphN) -> DbqueryrecursiveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_graphn_fill(s : DbqueryrecursiveGraphN, v : Double) -> DbqueryrecursiveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_graphn_min(s : DbqueryrecursiveGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_graphn_max(s : DbqueryrecursiveGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_graphn_to_string(s : DbqueryrecursiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_node_make(size : Int) -> DbqueryrecursiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_node_len(s : DbqueryrecursiveNode) -> Int { s.size }

pub fn db_query_recursive_node_get(s : DbqueryrecursiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_node_set(s : DbqueryrecursiveNode, i : Int, v : Double) -> DbqueryrecursiveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_node_sum(s : DbqueryrecursiveNode) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_node_mean(s : DbqueryrecursiveNode) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_node_scale(s : DbqueryrecursiveNode, f : Double) -> DbqueryrecursiveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_node_add(a : DbqueryrecursiveNode, b : DbqueryrecursiveNode) -> DbqueryrecursiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_node_copy(s : DbqueryrecursiveNode) -> DbqueryrecursiveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_node_fill(s : DbqueryrecursiveNode, v : Double) -> DbqueryrecursiveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_node_min(s : DbqueryrecursiveNode) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_node_max(s : DbqueryrecursiveNode) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_node_to_string(s : DbqueryrecursiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_edge_make(size : Int) -> DbqueryrecursiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_edge_len(s : DbqueryrecursiveEdge) -> Int { s.size }

pub fn db_query_recursive_edge_get(s : DbqueryrecursiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_edge_set(s : DbqueryrecursiveEdge, i : Int, v : Double) -> DbqueryrecursiveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_edge_sum(s : DbqueryrecursiveEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_edge_mean(s : DbqueryrecursiveEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_edge_scale(s : DbqueryrecursiveEdge, f : Double) -> DbqueryrecursiveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_edge_add(a : DbqueryrecursiveEdge, b : DbqueryrecursiveEdge) -> DbqueryrecursiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_edge_copy(s : DbqueryrecursiveEdge) -> DbqueryrecursiveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_edge_fill(s : DbqueryrecursiveEdge, v : Double) -> DbqueryrecursiveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_edge_min(s : DbqueryrecursiveEdge) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_edge_max(s : DbqueryrecursiveEdge) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_edge_to_string(s : DbqueryrecursiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_path_make(size : Int) -> DbqueryrecursivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_path_len(s : DbqueryrecursivePath) -> Int { s.size }

pub fn db_query_recursive_path_get(s : DbqueryrecursivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_path_set(s : DbqueryrecursivePath, i : Int, v : Double) -> DbqueryrecursivePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_path_sum(s : DbqueryrecursivePath) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_path_mean(s : DbqueryrecursivePath) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_path_scale(s : DbqueryrecursivePath, f : Double) -> DbqueryrecursivePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_path_add(a : DbqueryrecursivePath, b : DbqueryrecursivePath) -> DbqueryrecursivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_path_copy(s : DbqueryrecursivePath) -> DbqueryrecursivePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_path_fill(s : DbqueryrecursivePath, v : Double) -> DbqueryrecursivePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_path_min(s : DbqueryrecursivePath) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_path_max(s : DbqueryrecursivePath) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_path_to_string(s : DbqueryrecursivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_cluster_make(size : Int) -> DbqueryrecursiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_cluster_len(s : DbqueryrecursiveCluster) -> Int { s.size }

pub fn db_query_recursive_cluster_get(s : DbqueryrecursiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_cluster_set(s : DbqueryrecursiveCluster, i : Int, v : Double) -> DbqueryrecursiveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cluster_sum(s : DbqueryrecursiveCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_cluster_mean(s : DbqueryrecursiveCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_cluster_scale(s : DbqueryrecursiveCluster, f : Double) -> DbqueryrecursiveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cluster_add(a : DbqueryrecursiveCluster, b : DbqueryrecursiveCluster) -> DbqueryrecursiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_cluster_copy(s : DbqueryrecursiveCluster) -> DbqueryrecursiveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cluster_fill(s : DbqueryrecursiveCluster, v : Double) -> DbqueryrecursiveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cluster_min(s : DbqueryrecursiveCluster) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_cluster_max(s : DbqueryrecursiveCluster) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_cluster_to_string(s : DbqueryrecursiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_model_make(size : Int) -> DbqueryrecursiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_model_len(s : DbqueryrecursiveModel) -> Int { s.size }

pub fn db_query_recursive_model_get(s : DbqueryrecursiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_model_set(s : DbqueryrecursiveModel, i : Int, v : Double) -> DbqueryrecursiveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_model_sum(s : DbqueryrecursiveModel) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_model_mean(s : DbqueryrecursiveModel) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_model_scale(s : DbqueryrecursiveModel, f : Double) -> DbqueryrecursiveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_model_add(a : DbqueryrecursiveModel, b : DbqueryrecursiveModel) -> DbqueryrecursiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_model_copy(s : DbqueryrecursiveModel) -> DbqueryrecursiveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_model_fill(s : DbqueryrecursiveModel, v : Double) -> DbqueryrecursiveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_model_min(s : DbqueryrecursiveModel) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_model_max(s : DbqueryrecursiveModel) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_model_to_string(s : DbqueryrecursiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_layer_make(size : Int) -> DbqueryrecursiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_layer_len(s : DbqueryrecursiveLayer) -> Int { s.size }

pub fn db_query_recursive_layer_get(s : DbqueryrecursiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_layer_set(s : DbqueryrecursiveLayer, i : Int, v : Double) -> DbqueryrecursiveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_layer_sum(s : DbqueryrecursiveLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_layer_mean(s : DbqueryrecursiveLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_layer_scale(s : DbqueryrecursiveLayer, f : Double) -> DbqueryrecursiveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_layer_add(a : DbqueryrecursiveLayer, b : DbqueryrecursiveLayer) -> DbqueryrecursiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_layer_copy(s : DbqueryrecursiveLayer) -> DbqueryrecursiveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_layer_fill(s : DbqueryrecursiveLayer, v : Double) -> DbqueryrecursiveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_layer_min(s : DbqueryrecursiveLayer) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_layer_max(s : DbqueryrecursiveLayer) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_layer_to_string(s : DbqueryrecursiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_buffer_make(size : Int) -> DbqueryrecursiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_buffer_len(s : DbqueryrecursiveBuffer) -> Int { s.size }

pub fn db_query_recursive_buffer_get(s : DbqueryrecursiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_buffer_set(s : DbqueryrecursiveBuffer, i : Int, v : Double) -> DbqueryrecursiveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_buffer_sum(s : DbqueryrecursiveBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_buffer_mean(s : DbqueryrecursiveBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_buffer_scale(s : DbqueryrecursiveBuffer, f : Double) -> DbqueryrecursiveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_buffer_add(a : DbqueryrecursiveBuffer, b : DbqueryrecursiveBuffer) -> DbqueryrecursiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_buffer_copy(s : DbqueryrecursiveBuffer) -> DbqueryrecursiveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_buffer_fill(s : DbqueryrecursiveBuffer, v : Double) -> DbqueryrecursiveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_buffer_min(s : DbqueryrecursiveBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_buffer_max(s : DbqueryrecursiveBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_buffer_to_string(s : DbqueryrecursiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_cursor_make(size : Int) -> DbqueryrecursiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_cursor_len(s : DbqueryrecursiveCursor) -> Int { s.size }

pub fn db_query_recursive_cursor_get(s : DbqueryrecursiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_cursor_set(s : DbqueryrecursiveCursor, i : Int, v : Double) -> DbqueryrecursiveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cursor_sum(s : DbqueryrecursiveCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_cursor_mean(s : DbqueryrecursiveCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_cursor_scale(s : DbqueryrecursiveCursor, f : Double) -> DbqueryrecursiveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cursor_add(a : DbqueryrecursiveCursor, b : DbqueryrecursiveCursor) -> DbqueryrecursiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_cursor_copy(s : DbqueryrecursiveCursor) -> DbqueryrecursiveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cursor_fill(s : DbqueryrecursiveCursor, v : Double) -> DbqueryrecursiveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_cursor_min(s : DbqueryrecursiveCursor) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_cursor_max(s : DbqueryrecursiveCursor) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_cursor_to_string(s : DbqueryrecursiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_view_make(size : Int) -> DbqueryrecursiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_view_len(s : DbqueryrecursiveView) -> Int { s.size }

pub fn db_query_recursive_view_get(s : DbqueryrecursiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_view_set(s : DbqueryrecursiveView, i : Int, v : Double) -> DbqueryrecursiveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_view_sum(s : DbqueryrecursiveView) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_view_mean(s : DbqueryrecursiveView) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_view_scale(s : DbqueryrecursiveView, f : Double) -> DbqueryrecursiveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_view_add(a : DbqueryrecursiveView, b : DbqueryrecursiveView) -> DbqueryrecursiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_view_copy(s : DbqueryrecursiveView) -> DbqueryrecursiveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_view_fill(s : DbqueryrecursiveView, v : Double) -> DbqueryrecursiveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_view_min(s : DbqueryrecursiveView) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_view_max(s : DbqueryrecursiveView) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_view_to_string(s : DbqueryrecursiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_range_make(size : Int) -> DbqueryrecursiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_range_len(s : DbqueryrecursiveRange) -> Int { s.size }

pub fn db_query_recursive_range_get(s : DbqueryrecursiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_range_set(s : DbqueryrecursiveRange, i : Int, v : Double) -> DbqueryrecursiveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_range_sum(s : DbqueryrecursiveRange) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_range_mean(s : DbqueryrecursiveRange) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_range_scale(s : DbqueryrecursiveRange, f : Double) -> DbqueryrecursiveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_range_add(a : DbqueryrecursiveRange, b : DbqueryrecursiveRange) -> DbqueryrecursiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_range_copy(s : DbqueryrecursiveRange) -> DbqueryrecursiveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_range_fill(s : DbqueryrecursiveRange, v : Double) -> DbqueryrecursiveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_range_min(s : DbqueryrecursiveRange) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_range_max(s : DbqueryrecursiveRange) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_range_to_string(s : DbqueryrecursiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_slice_make(size : Int) -> DbqueryrecursiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_slice_len(s : DbqueryrecursiveSlice) -> Int { s.size }

pub fn db_query_recursive_slice_get(s : DbqueryrecursiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_slice_set(s : DbqueryrecursiveSlice, i : Int, v : Double) -> DbqueryrecursiveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_recursive_slice_sum(s : DbqueryrecursiveSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_recursive_slice_mean(s : DbqueryrecursiveSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_recursive_slice_scale(s : DbqueryrecursiveSlice, f : Double) -> DbqueryrecursiveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_slice_add(a : DbqueryrecursiveSlice, b : DbqueryrecursiveSlice) -> DbqueryrecursiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_recursive_slice_copy(s : DbqueryrecursiveSlice) -> DbqueryrecursiveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_slice_fill(s : DbqueryrecursiveSlice, v : Double) -> DbqueryrecursiveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_recursive_slice_min(s : DbqueryrecursiveSlice) -> Double { @_common.min(s.data) }

pub fn db_query_recursive_slice_max(s : DbqueryrecursiveSlice) -> Double { @_common.max(s.data) }

pub fn db_query_recursive_slice_to_string(s : DbqueryrecursiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

