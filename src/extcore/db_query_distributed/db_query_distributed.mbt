///===
/// extcore/db_query_distributed

pub(all) struct DbquerydistributedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_distributed_make_point(x : Double, y : Double) -> DbquerydistributedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_distributed_make_point3(x : Double, y : Double, z : Double) -> DbquerydistributedPoint {
  { x, y, z, label: 0 }
}

pub fn DbquerydistributedPoint::x(self : DbquerydistributedPoint) -> Double { self.x }

pub fn DbquerydistributedPoint::y(self : DbquerydistributedPoint) -> Double { self.y }

pub fn DbquerydistributedPoint::z(self : DbquerydistributedPoint) -> Double { self.z }

pub fn DbquerydistributedPoint::label(self : DbquerydistributedPoint) -> Int { self.label }

pub fn DbquerydistributedPoint::dist(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbquerydistributedPoint::add(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbquerydistributedPoint::sub(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbquerydistributedPoint::scale(self : DbquerydistributedPoint, s : Double) -> DbquerydistributedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbquerydistributedPoint::dot(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbquerydistributedPoint::cross(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbquerydistributedPoint::norm(self : DbquerydistributedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbquerydistributedPoint::normalize(self : DbquerydistributedPoint) -> DbquerydistributedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerydistributedPoint::negate(self : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbquerydistributedPoint::mid(self : DbquerydistributedPoint, other : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbquerydistributedPoint::lerp(self : DbquerydistributedPoint, other : DbquerydistributedPoint, t : Double) -> DbquerydistributedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbquerydistributedPoint::to_string(self : DbquerydistributedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbquerydistributedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_distributed_make_series(vals : Array[Double], name : String) -> DbquerydistributedSeries {
  { vals, name, meta: 0 }
}

pub fn DbquerydistributedSeries::len(self : DbquerydistributedSeries) -> Int { self.vals.length() }

pub fn DbquerydistributedSeries::sum(self : DbquerydistributedSeries) -> Double { @_common.sum(self.vals) }

pub fn DbquerydistributedSeries::mean(self : DbquerydistributedSeries) -> Double { @_common.mean(self.vals) }

pub fn DbquerydistributedSeries::min(self : DbquerydistributedSeries) -> Double { @_common.min(self.vals) }

pub fn DbquerydistributedSeries::max(self : DbquerydistributedSeries) -> Double { @_common.max(self.vals) }

pub fn DbquerydistributedSeries::range(self : DbquerydistributedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbquerydistributedSeries::variance(self : DbquerydistributedSeries) -> Double { @_common.variance(self.vals) }

pub fn DbquerydistributedSeries::std(self : DbquerydistributedSeries) -> Double { @_common.std(self.vals) }

pub fn DbquerydistributedSeries::median(self : DbquerydistributedSeries) -> Double { @_common.median(self.vals) }

pub fn DbquerydistributedSeries::scale(self : DbquerydistributedSeries, f : Double) -> DbquerydistributedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbquerydistributedSeries::add(self : DbquerydistributedSeries, other : DbquerydistributedSeries) -> DbquerydistributedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbquerydistributedSeries::sub(self : DbquerydistributedSeries, other : DbquerydistributedSeries) -> DbquerydistributedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbquerydistributedSeries::normalize(self : DbquerydistributedSeries) -> DbquerydistributedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbquerydistributedSeries::cumsum(self : DbquerydistributedSeries) -> DbquerydistributedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbquerydistributedSeries::to_string(self : DbquerydistributedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerydistributedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_distributed_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerydistributedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_distributed_matrix_identity(n : Int) -> DbquerydistributedMatrix {
  let m = db_query_distributed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbquerydistributedMatrix::get(self : DbquerydistributedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbquerydistributedMatrix::transpose(self : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  let result = db_query_distributed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbquerydistributedMatrix::add(self : DbquerydistributedMatrix, other : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_distributed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbquerydistributedMatrix::scale(self : DbquerydistributedMatrix, s : Double) -> DbquerydistributedMatrix {
  let result = db_query_distributed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbquerydistributedMatrix::multiply(self : DbquerydistributedMatrix, other : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  if self.cols != other.rows { return db_query_distributed_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_distributed_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbquerydistributedMatrix::trace(self : DbquerydistributedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbquerydistributedMatrix::det(self : DbquerydistributedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbquerydistributedMatrix::norm(self : DbquerydistributedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbquerydistributedMatrix::to_string(self : DbquerydistributedMatrix) -> String {
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

pub(all) struct DbquerydistributedVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_distributed_make_vector(comps : Array[Double]) -> DbquerydistributedVector {
  { comps, dim: comps.length() }
}

pub fn db_query_distributed_vector_zero(dim : Int) -> DbquerydistributedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbquerydistributedVector::add(self : DbquerydistributedVector, other : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerydistributedVector::sub(self : DbquerydistributedVector, other : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbquerydistributedVector::scale(self : DbquerydistributedVector, s : Double) -> DbquerydistributedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbquerydistributedVector::dot(self : DbquerydistributedVector, other : DbquerydistributedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbquerydistributedVector::norm(self : DbquerydistributedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbquerydistributedVector::normalize(self : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbquerydistributedVector::dist(self : DbquerydistributedVector, other : DbquerydistributedVector) -> Double {
  self.sub(other).norm()
}

pub fn DbquerydistributedVector::to_string(self : DbquerydistributedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_distributed_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_distributed_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_distributed_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_distributed_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_distributed_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_distributed_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_distributed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_distributed_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_distributed_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_distributed_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_distributed_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_distributed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_distributed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_distributed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_distributed_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_distributed_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_distributed_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_distributed_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_distributed_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_distributed_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_distributed_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_distributed_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_distributed_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_distributed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_distributed_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_distributed_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_distributed_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_distributed_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_distributed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerydistributedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_frame_make(size : Int) -> DbquerydistributedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_frame_len(s : DbquerydistributedFrame) -> Int { s.size }

pub fn db_query_distributed_frame_get(s : DbquerydistributedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_frame_set(s : DbquerydistributedFrame, i : Int, v : Double) -> DbquerydistributedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_frame_sum(s : DbquerydistributedFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_frame_mean(s : DbquerydistributedFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_frame_scale(s : DbquerydistributedFrame, f : Double) -> DbquerydistributedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_frame_add(a : DbquerydistributedFrame, b : DbquerydistributedFrame) -> DbquerydistributedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_frame_copy(s : DbquerydistributedFrame) -> DbquerydistributedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_frame_fill(s : DbquerydistributedFrame, v : Double) -> DbquerydistributedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_frame_min(s : DbquerydistributedFrame) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_frame_max(s : DbquerydistributedFrame) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_frame_to_string(s : DbquerydistributedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_table_make(size : Int) -> DbquerydistributedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_table_len(s : DbquerydistributedTable) -> Int { s.size }

pub fn db_query_distributed_table_get(s : DbquerydistributedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_table_set(s : DbquerydistributedTable, i : Int, v : Double) -> DbquerydistributedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_table_sum(s : DbquerydistributedTable) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_table_mean(s : DbquerydistributedTable) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_table_scale(s : DbquerydistributedTable, f : Double) -> DbquerydistributedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_table_add(a : DbquerydistributedTable, b : DbquerydistributedTable) -> DbquerydistributedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_table_copy(s : DbquerydistributedTable) -> DbquerydistributedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_table_fill(s : DbquerydistributedTable, v : Double) -> DbquerydistributedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_table_min(s : DbquerydistributedTable) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_table_max(s : DbquerydistributedTable) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_table_to_string(s : DbquerydistributedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_graphn_make(size : Int) -> DbquerydistributedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_graphn_len(s : DbquerydistributedGraphN) -> Int { s.size }

pub fn db_query_distributed_graphn_get(s : DbquerydistributedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_graphn_set(s : DbquerydistributedGraphN, i : Int, v : Double) -> DbquerydistributedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_graphn_sum(s : DbquerydistributedGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_graphn_mean(s : DbquerydistributedGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_graphn_scale(s : DbquerydistributedGraphN, f : Double) -> DbquerydistributedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_graphn_add(a : DbquerydistributedGraphN, b : DbquerydistributedGraphN) -> DbquerydistributedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_graphn_copy(s : DbquerydistributedGraphN) -> DbquerydistributedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_graphn_fill(s : DbquerydistributedGraphN, v : Double) -> DbquerydistributedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_graphn_min(s : DbquerydistributedGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_graphn_max(s : DbquerydistributedGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_graphn_to_string(s : DbquerydistributedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_node_make(size : Int) -> DbquerydistributedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_node_len(s : DbquerydistributedNode) -> Int { s.size }

pub fn db_query_distributed_node_get(s : DbquerydistributedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_node_set(s : DbquerydistributedNode, i : Int, v : Double) -> DbquerydistributedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_node_sum(s : DbquerydistributedNode) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_node_mean(s : DbquerydistributedNode) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_node_scale(s : DbquerydistributedNode, f : Double) -> DbquerydistributedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_node_add(a : DbquerydistributedNode, b : DbquerydistributedNode) -> DbquerydistributedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_node_copy(s : DbquerydistributedNode) -> DbquerydistributedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_node_fill(s : DbquerydistributedNode, v : Double) -> DbquerydistributedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_node_min(s : DbquerydistributedNode) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_node_max(s : DbquerydistributedNode) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_node_to_string(s : DbquerydistributedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_edge_make(size : Int) -> DbquerydistributedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_edge_len(s : DbquerydistributedEdge) -> Int { s.size }

pub fn db_query_distributed_edge_get(s : DbquerydistributedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_edge_set(s : DbquerydistributedEdge, i : Int, v : Double) -> DbquerydistributedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_edge_sum(s : DbquerydistributedEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_edge_mean(s : DbquerydistributedEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_edge_scale(s : DbquerydistributedEdge, f : Double) -> DbquerydistributedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_edge_add(a : DbquerydistributedEdge, b : DbquerydistributedEdge) -> DbquerydistributedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_edge_copy(s : DbquerydistributedEdge) -> DbquerydistributedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_edge_fill(s : DbquerydistributedEdge, v : Double) -> DbquerydistributedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_edge_min(s : DbquerydistributedEdge) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_edge_max(s : DbquerydistributedEdge) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_edge_to_string(s : DbquerydistributedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_path_make(size : Int) -> DbquerydistributedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_path_len(s : DbquerydistributedPath) -> Int { s.size }

pub fn db_query_distributed_path_get(s : DbquerydistributedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_path_set(s : DbquerydistributedPath, i : Int, v : Double) -> DbquerydistributedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_path_sum(s : DbquerydistributedPath) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_path_mean(s : DbquerydistributedPath) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_path_scale(s : DbquerydistributedPath, f : Double) -> DbquerydistributedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_path_add(a : DbquerydistributedPath, b : DbquerydistributedPath) -> DbquerydistributedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_path_copy(s : DbquerydistributedPath) -> DbquerydistributedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_path_fill(s : DbquerydistributedPath, v : Double) -> DbquerydistributedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_path_min(s : DbquerydistributedPath) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_path_max(s : DbquerydistributedPath) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_path_to_string(s : DbquerydistributedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_cluster_make(size : Int) -> DbquerydistributedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_cluster_len(s : DbquerydistributedCluster) -> Int { s.size }

pub fn db_query_distributed_cluster_get(s : DbquerydistributedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_cluster_set(s : DbquerydistributedCluster, i : Int, v : Double) -> DbquerydistributedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cluster_sum(s : DbquerydistributedCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_cluster_mean(s : DbquerydistributedCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_cluster_scale(s : DbquerydistributedCluster, f : Double) -> DbquerydistributedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cluster_add(a : DbquerydistributedCluster, b : DbquerydistributedCluster) -> DbquerydistributedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_cluster_copy(s : DbquerydistributedCluster) -> DbquerydistributedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cluster_fill(s : DbquerydistributedCluster, v : Double) -> DbquerydistributedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cluster_min(s : DbquerydistributedCluster) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_cluster_max(s : DbquerydistributedCluster) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_cluster_to_string(s : DbquerydistributedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_model_make(size : Int) -> DbquerydistributedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_model_len(s : DbquerydistributedModel) -> Int { s.size }

pub fn db_query_distributed_model_get(s : DbquerydistributedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_model_set(s : DbquerydistributedModel, i : Int, v : Double) -> DbquerydistributedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_model_sum(s : DbquerydistributedModel) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_model_mean(s : DbquerydistributedModel) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_model_scale(s : DbquerydistributedModel, f : Double) -> DbquerydistributedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_model_add(a : DbquerydistributedModel, b : DbquerydistributedModel) -> DbquerydistributedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_model_copy(s : DbquerydistributedModel) -> DbquerydistributedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_model_fill(s : DbquerydistributedModel, v : Double) -> DbquerydistributedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_model_min(s : DbquerydistributedModel) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_model_max(s : DbquerydistributedModel) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_model_to_string(s : DbquerydistributedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_layer_make(size : Int) -> DbquerydistributedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_layer_len(s : DbquerydistributedLayer) -> Int { s.size }

pub fn db_query_distributed_layer_get(s : DbquerydistributedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_layer_set(s : DbquerydistributedLayer, i : Int, v : Double) -> DbquerydistributedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_layer_sum(s : DbquerydistributedLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_layer_mean(s : DbquerydistributedLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_layer_scale(s : DbquerydistributedLayer, f : Double) -> DbquerydistributedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_layer_add(a : DbquerydistributedLayer, b : DbquerydistributedLayer) -> DbquerydistributedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_layer_copy(s : DbquerydistributedLayer) -> DbquerydistributedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_layer_fill(s : DbquerydistributedLayer, v : Double) -> DbquerydistributedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_layer_min(s : DbquerydistributedLayer) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_layer_max(s : DbquerydistributedLayer) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_layer_to_string(s : DbquerydistributedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_buffer_make(size : Int) -> DbquerydistributedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_buffer_len(s : DbquerydistributedBuffer) -> Int { s.size }

pub fn db_query_distributed_buffer_get(s : DbquerydistributedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_buffer_set(s : DbquerydistributedBuffer, i : Int, v : Double) -> DbquerydistributedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_buffer_sum(s : DbquerydistributedBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_buffer_mean(s : DbquerydistributedBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_buffer_scale(s : DbquerydistributedBuffer, f : Double) -> DbquerydistributedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_buffer_add(a : DbquerydistributedBuffer, b : DbquerydistributedBuffer) -> DbquerydistributedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_buffer_copy(s : DbquerydistributedBuffer) -> DbquerydistributedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_buffer_fill(s : DbquerydistributedBuffer, v : Double) -> DbquerydistributedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_buffer_min(s : DbquerydistributedBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_buffer_max(s : DbquerydistributedBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_buffer_to_string(s : DbquerydistributedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_cursor_make(size : Int) -> DbquerydistributedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_cursor_len(s : DbquerydistributedCursor) -> Int { s.size }

pub fn db_query_distributed_cursor_get(s : DbquerydistributedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_cursor_set(s : DbquerydistributedCursor, i : Int, v : Double) -> DbquerydistributedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cursor_sum(s : DbquerydistributedCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_cursor_mean(s : DbquerydistributedCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_cursor_scale(s : DbquerydistributedCursor, f : Double) -> DbquerydistributedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cursor_add(a : DbquerydistributedCursor, b : DbquerydistributedCursor) -> DbquerydistributedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_cursor_copy(s : DbquerydistributedCursor) -> DbquerydistributedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cursor_fill(s : DbquerydistributedCursor, v : Double) -> DbquerydistributedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_cursor_min(s : DbquerydistributedCursor) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_cursor_max(s : DbquerydistributedCursor) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_cursor_to_string(s : DbquerydistributedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_view_make(size : Int) -> DbquerydistributedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_view_len(s : DbquerydistributedView) -> Int { s.size }

pub fn db_query_distributed_view_get(s : DbquerydistributedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_view_set(s : DbquerydistributedView, i : Int, v : Double) -> DbquerydistributedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_view_sum(s : DbquerydistributedView) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_view_mean(s : DbquerydistributedView) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_view_scale(s : DbquerydistributedView, f : Double) -> DbquerydistributedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_view_add(a : DbquerydistributedView, b : DbquerydistributedView) -> DbquerydistributedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_view_copy(s : DbquerydistributedView) -> DbquerydistributedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_view_fill(s : DbquerydistributedView, v : Double) -> DbquerydistributedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_view_min(s : DbquerydistributedView) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_view_max(s : DbquerydistributedView) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_view_to_string(s : DbquerydistributedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_range_make(size : Int) -> DbquerydistributedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_range_len(s : DbquerydistributedRange) -> Int { s.size }

pub fn db_query_distributed_range_get(s : DbquerydistributedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_range_set(s : DbquerydistributedRange, i : Int, v : Double) -> DbquerydistributedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_range_sum(s : DbquerydistributedRange) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_range_mean(s : DbquerydistributedRange) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_range_scale(s : DbquerydistributedRange, f : Double) -> DbquerydistributedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_range_add(a : DbquerydistributedRange, b : DbquerydistributedRange) -> DbquerydistributedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_range_copy(s : DbquerydistributedRange) -> DbquerydistributedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_range_fill(s : DbquerydistributedRange, v : Double) -> DbquerydistributedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_range_min(s : DbquerydistributedRange) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_range_max(s : DbquerydistributedRange) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_range_to_string(s : DbquerydistributedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_slice_make(size : Int) -> DbquerydistributedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_slice_len(s : DbquerydistributedSlice) -> Int { s.size }

pub fn db_query_distributed_slice_get(s : DbquerydistributedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_slice_set(s : DbquerydistributedSlice, i : Int, v : Double) -> DbquerydistributedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_distributed_slice_sum(s : DbquerydistributedSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_distributed_slice_mean(s : DbquerydistributedSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_distributed_slice_scale(s : DbquerydistributedSlice, f : Double) -> DbquerydistributedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_slice_add(a : DbquerydistributedSlice, b : DbquerydistributedSlice) -> DbquerydistributedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_distributed_slice_copy(s : DbquerydistributedSlice) -> DbquerydistributedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_slice_fill(s : DbquerydistributedSlice, v : Double) -> DbquerydistributedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_distributed_slice_min(s : DbquerydistributedSlice) -> Double { @_common.min(s.data) }

pub fn db_query_distributed_slice_max(s : DbquerydistributedSlice) -> Double { @_common.max(s.data) }

pub fn db_query_distributed_slice_to_string(s : DbquerydistributedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

