///===
/// extcore/db_index_vector

pub(all) struct DbindexvectorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_vector_make_point(x : Double, y : Double) -> DbindexvectorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_vector_make_point3(x : Double, y : Double, z : Double) -> DbindexvectorPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexvectorPoint::x(self : DbindexvectorPoint) -> Double { self.x }

pub fn DbindexvectorPoint::y(self : DbindexvectorPoint) -> Double { self.y }

pub fn DbindexvectorPoint::z(self : DbindexvectorPoint) -> Double { self.z }

pub fn DbindexvectorPoint::label(self : DbindexvectorPoint) -> Int { self.label }

pub fn DbindexvectorPoint::dist(self : DbindexvectorPoint, other : DbindexvectorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexvectorPoint::add(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexvectorPoint::sub(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexvectorPoint::scale(self : DbindexvectorPoint, s : Double) -> DbindexvectorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexvectorPoint::dot(self : DbindexvectorPoint, other : DbindexvectorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexvectorPoint::cross(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexvectorPoint::norm(self : DbindexvectorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexvectorPoint::normalize(self : DbindexvectorPoint) -> DbindexvectorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexvectorPoint::negate(self : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexvectorPoint::mid(self : DbindexvectorPoint, other : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexvectorPoint::lerp(self : DbindexvectorPoint, other : DbindexvectorPoint, t : Double) -> DbindexvectorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexvectorPoint::to_string(self : DbindexvectorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexvectorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_vector_make_series(vals : Array[Double], name : String) -> DbindexvectorSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexvectorSeries::len(self : DbindexvectorSeries) -> Int { self.vals.length() }

pub fn DbindexvectorSeries::sum(self : DbindexvectorSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexvectorSeries::mean(self : DbindexvectorSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexvectorSeries::min(self : DbindexvectorSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexvectorSeries::max(self : DbindexvectorSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexvectorSeries::range(self : DbindexvectorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexvectorSeries::variance(self : DbindexvectorSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexvectorSeries::std(self : DbindexvectorSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexvectorSeries::median(self : DbindexvectorSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexvectorSeries::scale(self : DbindexvectorSeries, f : Double) -> DbindexvectorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexvectorSeries::add(self : DbindexvectorSeries, other : DbindexvectorSeries) -> DbindexvectorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexvectorSeries::sub(self : DbindexvectorSeries, other : DbindexvectorSeries) -> DbindexvectorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexvectorSeries::normalize(self : DbindexvectorSeries) -> DbindexvectorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexvectorSeries::cumsum(self : DbindexvectorSeries) -> DbindexvectorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexvectorSeries::to_string(self : DbindexvectorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexvectorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_vector_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexvectorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_vector_matrix_identity(n : Int) -> DbindexvectorMatrix {
  let m = db_index_vector_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexvectorMatrix::get(self : DbindexvectorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexvectorMatrix::transpose(self : DbindexvectorMatrix) -> DbindexvectorMatrix {
  let result = db_index_vector_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexvectorMatrix::add(self : DbindexvectorMatrix, other : DbindexvectorMatrix) -> DbindexvectorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_vector_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexvectorMatrix::scale(self : DbindexvectorMatrix, s : Double) -> DbindexvectorMatrix {
  let result = db_index_vector_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexvectorMatrix::multiply(self : DbindexvectorMatrix, other : DbindexvectorMatrix) -> DbindexvectorMatrix {
  if self.cols != other.rows { return db_index_vector_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_vector_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexvectorMatrix::trace(self : DbindexvectorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexvectorMatrix::det(self : DbindexvectorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexvectorMatrix::norm(self : DbindexvectorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexvectorMatrix::to_string(self : DbindexvectorMatrix) -> String {
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

pub(all) struct DbindexvectorVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_vector_make_vector(comps : Array[Double]) -> DbindexvectorVector {
  { comps, dim: comps.length() }
}

pub fn db_index_vector_vector_zero(dim : Int) -> DbindexvectorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexvectorVector::add(self : DbindexvectorVector, other : DbindexvectorVector) -> DbindexvectorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexvectorVector::sub(self : DbindexvectorVector, other : DbindexvectorVector) -> DbindexvectorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexvectorVector::scale(self : DbindexvectorVector, s : Double) -> DbindexvectorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexvectorVector::dot(self : DbindexvectorVector, other : DbindexvectorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexvectorVector::norm(self : DbindexvectorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexvectorVector::normalize(self : DbindexvectorVector) -> DbindexvectorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexvectorVector::dist(self : DbindexvectorVector, other : DbindexvectorVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexvectorVector::to_string(self : DbindexvectorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_vector_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_vector_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_vector_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_vector_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_vector_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_vector_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_vector_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_vector_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_vector_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_vector_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_vector_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_vector_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_vector_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_vector_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_vector_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_vector_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_vector_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_vector_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_vector_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_vector_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_vector_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_vector_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_vector_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_vector_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_vector_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_vector_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_vector_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_vector_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_vector_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexvectorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_frame_make(size : Int) -> DbindexvectorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_frame_len(s : DbindexvectorFrame) -> Int { s.size }

pub fn db_index_vector_frame_get(s : DbindexvectorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_frame_set(s : DbindexvectorFrame, i : Int, v : Double) -> DbindexvectorFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_frame_sum(s : DbindexvectorFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_frame_mean(s : DbindexvectorFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_frame_scale(s : DbindexvectorFrame, f : Double) -> DbindexvectorFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_frame_add(a : DbindexvectorFrame, b : DbindexvectorFrame) -> DbindexvectorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_frame_copy(s : DbindexvectorFrame) -> DbindexvectorFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_frame_fill(s : DbindexvectorFrame, v : Double) -> DbindexvectorFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_frame_min(s : DbindexvectorFrame) -> Double { @_common.min(s.data) }

pub fn db_index_vector_frame_max(s : DbindexvectorFrame) -> Double { @_common.max(s.data) }

pub fn db_index_vector_frame_to_string(s : DbindexvectorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_table_make(size : Int) -> DbindexvectorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_table_len(s : DbindexvectorTable) -> Int { s.size }

pub fn db_index_vector_table_get(s : DbindexvectorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_table_set(s : DbindexvectorTable, i : Int, v : Double) -> DbindexvectorTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_table_sum(s : DbindexvectorTable) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_table_mean(s : DbindexvectorTable) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_table_scale(s : DbindexvectorTable, f : Double) -> DbindexvectorTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_table_add(a : DbindexvectorTable, b : DbindexvectorTable) -> DbindexvectorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_table_copy(s : DbindexvectorTable) -> DbindexvectorTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_table_fill(s : DbindexvectorTable, v : Double) -> DbindexvectorTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_table_min(s : DbindexvectorTable) -> Double { @_common.min(s.data) }

pub fn db_index_vector_table_max(s : DbindexvectorTable) -> Double { @_common.max(s.data) }

pub fn db_index_vector_table_to_string(s : DbindexvectorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_graphn_make(size : Int) -> DbindexvectorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_graphn_len(s : DbindexvectorGraphN) -> Int { s.size }

pub fn db_index_vector_graphn_get(s : DbindexvectorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_graphn_set(s : DbindexvectorGraphN, i : Int, v : Double) -> DbindexvectorGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_graphn_sum(s : DbindexvectorGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_graphn_mean(s : DbindexvectorGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_graphn_scale(s : DbindexvectorGraphN, f : Double) -> DbindexvectorGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_graphn_add(a : DbindexvectorGraphN, b : DbindexvectorGraphN) -> DbindexvectorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_graphn_copy(s : DbindexvectorGraphN) -> DbindexvectorGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_graphn_fill(s : DbindexvectorGraphN, v : Double) -> DbindexvectorGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_graphn_min(s : DbindexvectorGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_vector_graphn_max(s : DbindexvectorGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_vector_graphn_to_string(s : DbindexvectorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_node_make(size : Int) -> DbindexvectorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_node_len(s : DbindexvectorNode) -> Int { s.size }

pub fn db_index_vector_node_get(s : DbindexvectorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_node_set(s : DbindexvectorNode, i : Int, v : Double) -> DbindexvectorNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_node_sum(s : DbindexvectorNode) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_node_mean(s : DbindexvectorNode) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_node_scale(s : DbindexvectorNode, f : Double) -> DbindexvectorNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_node_add(a : DbindexvectorNode, b : DbindexvectorNode) -> DbindexvectorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_node_copy(s : DbindexvectorNode) -> DbindexvectorNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_node_fill(s : DbindexvectorNode, v : Double) -> DbindexvectorNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_node_min(s : DbindexvectorNode) -> Double { @_common.min(s.data) }

pub fn db_index_vector_node_max(s : DbindexvectorNode) -> Double { @_common.max(s.data) }

pub fn db_index_vector_node_to_string(s : DbindexvectorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_edge_make(size : Int) -> DbindexvectorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_edge_len(s : DbindexvectorEdge) -> Int { s.size }

pub fn db_index_vector_edge_get(s : DbindexvectorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_edge_set(s : DbindexvectorEdge, i : Int, v : Double) -> DbindexvectorEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_edge_sum(s : DbindexvectorEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_edge_mean(s : DbindexvectorEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_edge_scale(s : DbindexvectorEdge, f : Double) -> DbindexvectorEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_edge_add(a : DbindexvectorEdge, b : DbindexvectorEdge) -> DbindexvectorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_edge_copy(s : DbindexvectorEdge) -> DbindexvectorEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_edge_fill(s : DbindexvectorEdge, v : Double) -> DbindexvectorEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_edge_min(s : DbindexvectorEdge) -> Double { @_common.min(s.data) }

pub fn db_index_vector_edge_max(s : DbindexvectorEdge) -> Double { @_common.max(s.data) }

pub fn db_index_vector_edge_to_string(s : DbindexvectorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_path_make(size : Int) -> DbindexvectorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_path_len(s : DbindexvectorPath) -> Int { s.size }

pub fn db_index_vector_path_get(s : DbindexvectorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_path_set(s : DbindexvectorPath, i : Int, v : Double) -> DbindexvectorPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_path_sum(s : DbindexvectorPath) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_path_mean(s : DbindexvectorPath) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_path_scale(s : DbindexvectorPath, f : Double) -> DbindexvectorPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_path_add(a : DbindexvectorPath, b : DbindexvectorPath) -> DbindexvectorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_path_copy(s : DbindexvectorPath) -> DbindexvectorPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_path_fill(s : DbindexvectorPath, v : Double) -> DbindexvectorPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_path_min(s : DbindexvectorPath) -> Double { @_common.min(s.data) }

pub fn db_index_vector_path_max(s : DbindexvectorPath) -> Double { @_common.max(s.data) }

pub fn db_index_vector_path_to_string(s : DbindexvectorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_cluster_make(size : Int) -> DbindexvectorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_cluster_len(s : DbindexvectorCluster) -> Int { s.size }

pub fn db_index_vector_cluster_get(s : DbindexvectorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_cluster_set(s : DbindexvectorCluster, i : Int, v : Double) -> DbindexvectorCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_cluster_sum(s : DbindexvectorCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_cluster_mean(s : DbindexvectorCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_cluster_scale(s : DbindexvectorCluster, f : Double) -> DbindexvectorCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_cluster_add(a : DbindexvectorCluster, b : DbindexvectorCluster) -> DbindexvectorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_cluster_copy(s : DbindexvectorCluster) -> DbindexvectorCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_cluster_fill(s : DbindexvectorCluster, v : Double) -> DbindexvectorCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_cluster_min(s : DbindexvectorCluster) -> Double { @_common.min(s.data) }

pub fn db_index_vector_cluster_max(s : DbindexvectorCluster) -> Double { @_common.max(s.data) }

pub fn db_index_vector_cluster_to_string(s : DbindexvectorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_model_make(size : Int) -> DbindexvectorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_model_len(s : DbindexvectorModel) -> Int { s.size }

pub fn db_index_vector_model_get(s : DbindexvectorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_model_set(s : DbindexvectorModel, i : Int, v : Double) -> DbindexvectorModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_model_sum(s : DbindexvectorModel) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_model_mean(s : DbindexvectorModel) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_model_scale(s : DbindexvectorModel, f : Double) -> DbindexvectorModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_model_add(a : DbindexvectorModel, b : DbindexvectorModel) -> DbindexvectorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_model_copy(s : DbindexvectorModel) -> DbindexvectorModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_model_fill(s : DbindexvectorModel, v : Double) -> DbindexvectorModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_model_min(s : DbindexvectorModel) -> Double { @_common.min(s.data) }

pub fn db_index_vector_model_max(s : DbindexvectorModel) -> Double { @_common.max(s.data) }

pub fn db_index_vector_model_to_string(s : DbindexvectorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_layer_make(size : Int) -> DbindexvectorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_layer_len(s : DbindexvectorLayer) -> Int { s.size }

pub fn db_index_vector_layer_get(s : DbindexvectorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_layer_set(s : DbindexvectorLayer, i : Int, v : Double) -> DbindexvectorLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_layer_sum(s : DbindexvectorLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_layer_mean(s : DbindexvectorLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_layer_scale(s : DbindexvectorLayer, f : Double) -> DbindexvectorLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_layer_add(a : DbindexvectorLayer, b : DbindexvectorLayer) -> DbindexvectorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_layer_copy(s : DbindexvectorLayer) -> DbindexvectorLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_layer_fill(s : DbindexvectorLayer, v : Double) -> DbindexvectorLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_layer_min(s : DbindexvectorLayer) -> Double { @_common.min(s.data) }

pub fn db_index_vector_layer_max(s : DbindexvectorLayer) -> Double { @_common.max(s.data) }

pub fn db_index_vector_layer_to_string(s : DbindexvectorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_buffer_make(size : Int) -> DbindexvectorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_buffer_len(s : DbindexvectorBuffer) -> Int { s.size }

pub fn db_index_vector_buffer_get(s : DbindexvectorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_buffer_set(s : DbindexvectorBuffer, i : Int, v : Double) -> DbindexvectorBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_buffer_sum(s : DbindexvectorBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_buffer_mean(s : DbindexvectorBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_buffer_scale(s : DbindexvectorBuffer, f : Double) -> DbindexvectorBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_buffer_add(a : DbindexvectorBuffer, b : DbindexvectorBuffer) -> DbindexvectorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_buffer_copy(s : DbindexvectorBuffer) -> DbindexvectorBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_buffer_fill(s : DbindexvectorBuffer, v : Double) -> DbindexvectorBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_buffer_min(s : DbindexvectorBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_vector_buffer_max(s : DbindexvectorBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_vector_buffer_to_string(s : DbindexvectorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_cursor_make(size : Int) -> DbindexvectorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_cursor_len(s : DbindexvectorCursor) -> Int { s.size }

pub fn db_index_vector_cursor_get(s : DbindexvectorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_cursor_set(s : DbindexvectorCursor, i : Int, v : Double) -> DbindexvectorCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_cursor_sum(s : DbindexvectorCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_cursor_mean(s : DbindexvectorCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_cursor_scale(s : DbindexvectorCursor, f : Double) -> DbindexvectorCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_cursor_add(a : DbindexvectorCursor, b : DbindexvectorCursor) -> DbindexvectorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_cursor_copy(s : DbindexvectorCursor) -> DbindexvectorCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_cursor_fill(s : DbindexvectorCursor, v : Double) -> DbindexvectorCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_cursor_min(s : DbindexvectorCursor) -> Double { @_common.min(s.data) }

pub fn db_index_vector_cursor_max(s : DbindexvectorCursor) -> Double { @_common.max(s.data) }

pub fn db_index_vector_cursor_to_string(s : DbindexvectorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_view_make(size : Int) -> DbindexvectorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_view_len(s : DbindexvectorView) -> Int { s.size }

pub fn db_index_vector_view_get(s : DbindexvectorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_view_set(s : DbindexvectorView, i : Int, v : Double) -> DbindexvectorView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_view_sum(s : DbindexvectorView) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_view_mean(s : DbindexvectorView) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_view_scale(s : DbindexvectorView, f : Double) -> DbindexvectorView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_view_add(a : DbindexvectorView, b : DbindexvectorView) -> DbindexvectorView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_view_copy(s : DbindexvectorView) -> DbindexvectorView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_view_fill(s : DbindexvectorView, v : Double) -> DbindexvectorView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_view_min(s : DbindexvectorView) -> Double { @_common.min(s.data) }

pub fn db_index_vector_view_max(s : DbindexvectorView) -> Double { @_common.max(s.data) }

pub fn db_index_vector_view_to_string(s : DbindexvectorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_range_make(size : Int) -> DbindexvectorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_range_len(s : DbindexvectorRange) -> Int { s.size }

pub fn db_index_vector_range_get(s : DbindexvectorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_range_set(s : DbindexvectorRange, i : Int, v : Double) -> DbindexvectorRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_range_sum(s : DbindexvectorRange) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_range_mean(s : DbindexvectorRange) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_range_scale(s : DbindexvectorRange, f : Double) -> DbindexvectorRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_range_add(a : DbindexvectorRange, b : DbindexvectorRange) -> DbindexvectorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_range_copy(s : DbindexvectorRange) -> DbindexvectorRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_range_fill(s : DbindexvectorRange, v : Double) -> DbindexvectorRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_range_min(s : DbindexvectorRange) -> Double { @_common.min(s.data) }

pub fn db_index_vector_range_max(s : DbindexvectorRange) -> Double { @_common.max(s.data) }

pub fn db_index_vector_range_to_string(s : DbindexvectorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_slice_make(size : Int) -> DbindexvectorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_slice_len(s : DbindexvectorSlice) -> Int { s.size }

pub fn db_index_vector_slice_get(s : DbindexvectorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_slice_set(s : DbindexvectorSlice, i : Int, v : Double) -> DbindexvectorSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_vector_slice_sum(s : DbindexvectorSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_vector_slice_mean(s : DbindexvectorSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_vector_slice_scale(s : DbindexvectorSlice, f : Double) -> DbindexvectorSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_vector_slice_add(a : DbindexvectorSlice, b : DbindexvectorSlice) -> DbindexvectorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_vector_slice_copy(s : DbindexvectorSlice) -> DbindexvectorSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_vector_slice_fill(s : DbindexvectorSlice, v : Double) -> DbindexvectorSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_vector_slice_min(s : DbindexvectorSlice) -> Double { @_common.min(s.data) }

pub fn db_index_vector_slice_max(s : DbindexvectorSlice) -> Double { @_common.max(s.data) }

pub fn db_index_vector_slice_to_string(s : DbindexvectorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

