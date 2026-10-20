///===
/// extcore/db_query_aggregate

pub(all) struct DbqueryaggregatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_aggregate_make_point(x : Double, y : Double) -> DbqueryaggregatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_aggregate_make_point3(x : Double, y : Double, z : Double) -> DbqueryaggregatePoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryaggregatePoint::x(self : DbqueryaggregatePoint) -> Double { self.x }

pub fn DbqueryaggregatePoint::y(self : DbqueryaggregatePoint) -> Double { self.y }

pub fn DbqueryaggregatePoint::z(self : DbqueryaggregatePoint) -> Double { self.z }

pub fn DbqueryaggregatePoint::label(self : DbqueryaggregatePoint) -> Int { self.label }

pub fn DbqueryaggregatePoint::dist(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryaggregatePoint::add(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryaggregatePoint::sub(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryaggregatePoint::scale(self : DbqueryaggregatePoint, s : Double) -> DbqueryaggregatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryaggregatePoint::dot(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryaggregatePoint::cross(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryaggregatePoint::norm(self : DbqueryaggregatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryaggregatePoint::normalize(self : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryaggregatePoint::negate(self : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryaggregatePoint::mid(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryaggregatePoint::lerp(self : DbqueryaggregatePoint, other : DbqueryaggregatePoint, t : Double) -> DbqueryaggregatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryaggregatePoint::to_string(self : DbqueryaggregatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryaggregateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_aggregate_make_series(vals : Array[Double], name : String) -> DbqueryaggregateSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryaggregateSeries::len(self : DbqueryaggregateSeries) -> Int { self.vals.length() }

pub fn DbqueryaggregateSeries::sum(self : DbqueryaggregateSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryaggregateSeries::mean(self : DbqueryaggregateSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryaggregateSeries::min(self : DbqueryaggregateSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryaggregateSeries::max(self : DbqueryaggregateSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryaggregateSeries::range(self : DbqueryaggregateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryaggregateSeries::variance(self : DbqueryaggregateSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryaggregateSeries::std(self : DbqueryaggregateSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryaggregateSeries::median(self : DbqueryaggregateSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryaggregateSeries::scale(self : DbqueryaggregateSeries, f : Double) -> DbqueryaggregateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryaggregateSeries::add(self : DbqueryaggregateSeries, other : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryaggregateSeries::sub(self : DbqueryaggregateSeries, other : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryaggregateSeries::normalize(self : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryaggregateSeries::cumsum(self : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryaggregateSeries::to_string(self : DbqueryaggregateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryaggregateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_aggregate_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryaggregateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_aggregate_matrix_identity(n : Int) -> DbqueryaggregateMatrix {
  let m = db_query_aggregate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryaggregateMatrix::get(self : DbqueryaggregateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryaggregateMatrix::transpose(self : DbqueryaggregateMatrix) -> DbqueryaggregateMatrix {
  let result = db_query_aggregate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryaggregateMatrix::add(self : DbqueryaggregateMatrix, other : DbqueryaggregateMatrix) -> DbqueryaggregateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_aggregate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryaggregateMatrix::scale(self : DbqueryaggregateMatrix, s : Double) -> DbqueryaggregateMatrix {
  let result = db_query_aggregate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryaggregateMatrix::multiply(self : DbqueryaggregateMatrix, other : DbqueryaggregateMatrix) -> DbqueryaggregateMatrix {
  if self.cols != other.rows { return db_query_aggregate_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_aggregate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryaggregateMatrix::trace(self : DbqueryaggregateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryaggregateMatrix::det(self : DbqueryaggregateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryaggregateMatrix::norm(self : DbqueryaggregateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryaggregateMatrix::to_string(self : DbqueryaggregateMatrix) -> String {
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

pub(all) struct DbqueryaggregateVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_aggregate_make_vector(comps : Array[Double]) -> DbqueryaggregateVector {
  { comps, dim: comps.length() }
}

pub fn db_query_aggregate_vector_zero(dim : Int) -> DbqueryaggregateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryaggregateVector::add(self : DbqueryaggregateVector, other : DbqueryaggregateVector) -> DbqueryaggregateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryaggregateVector::sub(self : DbqueryaggregateVector, other : DbqueryaggregateVector) -> DbqueryaggregateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryaggregateVector::scale(self : DbqueryaggregateVector, s : Double) -> DbqueryaggregateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryaggregateVector::dot(self : DbqueryaggregateVector, other : DbqueryaggregateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryaggregateVector::norm(self : DbqueryaggregateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryaggregateVector::normalize(self : DbqueryaggregateVector) -> DbqueryaggregateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryaggregateVector::dist(self : DbqueryaggregateVector, other : DbqueryaggregateVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryaggregateVector::to_string(self : DbqueryaggregateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_aggregate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_aggregate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_aggregate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_aggregate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_aggregate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_aggregate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_aggregate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_aggregate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_aggregate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_aggregate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_aggregate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_aggregate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_aggregate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_aggregate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_aggregate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_aggregate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_aggregate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_aggregate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_aggregate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_aggregate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_aggregate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_aggregate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_aggregate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_aggregate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_aggregate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_aggregate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_aggregate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_aggregate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_aggregate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryaggregateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_frame_make(size : Int) -> DbqueryaggregateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_frame_len(s : DbqueryaggregateFrame) -> Int { s.size }

pub fn db_query_aggregate_frame_get(s : DbqueryaggregateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_frame_set(s : DbqueryaggregateFrame, i : Int, v : Double) -> DbqueryaggregateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_frame_sum(s : DbqueryaggregateFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_frame_mean(s : DbqueryaggregateFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_frame_scale(s : DbqueryaggregateFrame, f : Double) -> DbqueryaggregateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_frame_add(a : DbqueryaggregateFrame, b : DbqueryaggregateFrame) -> DbqueryaggregateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_frame_copy(s : DbqueryaggregateFrame) -> DbqueryaggregateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_frame_fill(s : DbqueryaggregateFrame, v : Double) -> DbqueryaggregateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_frame_min(s : DbqueryaggregateFrame) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_frame_max(s : DbqueryaggregateFrame) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_frame_to_string(s : DbqueryaggregateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_table_make(size : Int) -> DbqueryaggregateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_table_len(s : DbqueryaggregateTable) -> Int { s.size }

pub fn db_query_aggregate_table_get(s : DbqueryaggregateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_table_set(s : DbqueryaggregateTable, i : Int, v : Double) -> DbqueryaggregateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_table_sum(s : DbqueryaggregateTable) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_table_mean(s : DbqueryaggregateTable) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_table_scale(s : DbqueryaggregateTable, f : Double) -> DbqueryaggregateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_table_add(a : DbqueryaggregateTable, b : DbqueryaggregateTable) -> DbqueryaggregateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_table_copy(s : DbqueryaggregateTable) -> DbqueryaggregateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_table_fill(s : DbqueryaggregateTable, v : Double) -> DbqueryaggregateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_table_min(s : DbqueryaggregateTable) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_table_max(s : DbqueryaggregateTable) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_table_to_string(s : DbqueryaggregateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_graphn_make(size : Int) -> DbqueryaggregateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_graphn_len(s : DbqueryaggregateGraphN) -> Int { s.size }

pub fn db_query_aggregate_graphn_get(s : DbqueryaggregateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_graphn_set(s : DbqueryaggregateGraphN, i : Int, v : Double) -> DbqueryaggregateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_graphn_sum(s : DbqueryaggregateGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_graphn_mean(s : DbqueryaggregateGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_graphn_scale(s : DbqueryaggregateGraphN, f : Double) -> DbqueryaggregateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_graphn_add(a : DbqueryaggregateGraphN, b : DbqueryaggregateGraphN) -> DbqueryaggregateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_graphn_copy(s : DbqueryaggregateGraphN) -> DbqueryaggregateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_graphn_fill(s : DbqueryaggregateGraphN, v : Double) -> DbqueryaggregateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_graphn_min(s : DbqueryaggregateGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_graphn_max(s : DbqueryaggregateGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_graphn_to_string(s : DbqueryaggregateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_node_make(size : Int) -> DbqueryaggregateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_node_len(s : DbqueryaggregateNode) -> Int { s.size }

pub fn db_query_aggregate_node_get(s : DbqueryaggregateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_node_set(s : DbqueryaggregateNode, i : Int, v : Double) -> DbqueryaggregateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_node_sum(s : DbqueryaggregateNode) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_node_mean(s : DbqueryaggregateNode) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_node_scale(s : DbqueryaggregateNode, f : Double) -> DbqueryaggregateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_node_add(a : DbqueryaggregateNode, b : DbqueryaggregateNode) -> DbqueryaggregateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_node_copy(s : DbqueryaggregateNode) -> DbqueryaggregateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_node_fill(s : DbqueryaggregateNode, v : Double) -> DbqueryaggregateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_node_min(s : DbqueryaggregateNode) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_node_max(s : DbqueryaggregateNode) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_node_to_string(s : DbqueryaggregateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_edge_make(size : Int) -> DbqueryaggregateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_edge_len(s : DbqueryaggregateEdge) -> Int { s.size }

pub fn db_query_aggregate_edge_get(s : DbqueryaggregateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_edge_set(s : DbqueryaggregateEdge, i : Int, v : Double) -> DbqueryaggregateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_edge_sum(s : DbqueryaggregateEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_edge_mean(s : DbqueryaggregateEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_edge_scale(s : DbqueryaggregateEdge, f : Double) -> DbqueryaggregateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_edge_add(a : DbqueryaggregateEdge, b : DbqueryaggregateEdge) -> DbqueryaggregateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_edge_copy(s : DbqueryaggregateEdge) -> DbqueryaggregateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_edge_fill(s : DbqueryaggregateEdge, v : Double) -> DbqueryaggregateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_edge_min(s : DbqueryaggregateEdge) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_edge_max(s : DbqueryaggregateEdge) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_edge_to_string(s : DbqueryaggregateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_path_make(size : Int) -> DbqueryaggregatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_path_len(s : DbqueryaggregatePath) -> Int { s.size }

pub fn db_query_aggregate_path_get(s : DbqueryaggregatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_path_set(s : DbqueryaggregatePath, i : Int, v : Double) -> DbqueryaggregatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_path_sum(s : DbqueryaggregatePath) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_path_mean(s : DbqueryaggregatePath) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_path_scale(s : DbqueryaggregatePath, f : Double) -> DbqueryaggregatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_path_add(a : DbqueryaggregatePath, b : DbqueryaggregatePath) -> DbqueryaggregatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_path_copy(s : DbqueryaggregatePath) -> DbqueryaggregatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_path_fill(s : DbqueryaggregatePath, v : Double) -> DbqueryaggregatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_path_min(s : DbqueryaggregatePath) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_path_max(s : DbqueryaggregatePath) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_path_to_string(s : DbqueryaggregatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_cluster_make(size : Int) -> DbqueryaggregateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_cluster_len(s : DbqueryaggregateCluster) -> Int { s.size }

pub fn db_query_aggregate_cluster_get(s : DbqueryaggregateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_cluster_set(s : DbqueryaggregateCluster, i : Int, v : Double) -> DbqueryaggregateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cluster_sum(s : DbqueryaggregateCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_cluster_mean(s : DbqueryaggregateCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_cluster_scale(s : DbqueryaggregateCluster, f : Double) -> DbqueryaggregateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cluster_add(a : DbqueryaggregateCluster, b : DbqueryaggregateCluster) -> DbqueryaggregateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_cluster_copy(s : DbqueryaggregateCluster) -> DbqueryaggregateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cluster_fill(s : DbqueryaggregateCluster, v : Double) -> DbqueryaggregateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cluster_min(s : DbqueryaggregateCluster) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_cluster_max(s : DbqueryaggregateCluster) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_cluster_to_string(s : DbqueryaggregateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_model_make(size : Int) -> DbqueryaggregateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_model_len(s : DbqueryaggregateModel) -> Int { s.size }

pub fn db_query_aggregate_model_get(s : DbqueryaggregateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_model_set(s : DbqueryaggregateModel, i : Int, v : Double) -> DbqueryaggregateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_model_sum(s : DbqueryaggregateModel) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_model_mean(s : DbqueryaggregateModel) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_model_scale(s : DbqueryaggregateModel, f : Double) -> DbqueryaggregateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_model_add(a : DbqueryaggregateModel, b : DbqueryaggregateModel) -> DbqueryaggregateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_model_copy(s : DbqueryaggregateModel) -> DbqueryaggregateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_model_fill(s : DbqueryaggregateModel, v : Double) -> DbqueryaggregateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_model_min(s : DbqueryaggregateModel) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_model_max(s : DbqueryaggregateModel) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_model_to_string(s : DbqueryaggregateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_layer_make(size : Int) -> DbqueryaggregateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_layer_len(s : DbqueryaggregateLayer) -> Int { s.size }

pub fn db_query_aggregate_layer_get(s : DbqueryaggregateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_layer_set(s : DbqueryaggregateLayer, i : Int, v : Double) -> DbqueryaggregateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_layer_sum(s : DbqueryaggregateLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_layer_mean(s : DbqueryaggregateLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_layer_scale(s : DbqueryaggregateLayer, f : Double) -> DbqueryaggregateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_layer_add(a : DbqueryaggregateLayer, b : DbqueryaggregateLayer) -> DbqueryaggregateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_layer_copy(s : DbqueryaggregateLayer) -> DbqueryaggregateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_layer_fill(s : DbqueryaggregateLayer, v : Double) -> DbqueryaggregateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_layer_min(s : DbqueryaggregateLayer) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_layer_max(s : DbqueryaggregateLayer) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_layer_to_string(s : DbqueryaggregateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_buffer_make(size : Int) -> DbqueryaggregateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_buffer_len(s : DbqueryaggregateBuffer) -> Int { s.size }

pub fn db_query_aggregate_buffer_get(s : DbqueryaggregateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_buffer_set(s : DbqueryaggregateBuffer, i : Int, v : Double) -> DbqueryaggregateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_buffer_sum(s : DbqueryaggregateBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_buffer_mean(s : DbqueryaggregateBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_buffer_scale(s : DbqueryaggregateBuffer, f : Double) -> DbqueryaggregateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_buffer_add(a : DbqueryaggregateBuffer, b : DbqueryaggregateBuffer) -> DbqueryaggregateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_buffer_copy(s : DbqueryaggregateBuffer) -> DbqueryaggregateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_buffer_fill(s : DbqueryaggregateBuffer, v : Double) -> DbqueryaggregateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_buffer_min(s : DbqueryaggregateBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_buffer_max(s : DbqueryaggregateBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_buffer_to_string(s : DbqueryaggregateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_cursor_make(size : Int) -> DbqueryaggregateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_cursor_len(s : DbqueryaggregateCursor) -> Int { s.size }

pub fn db_query_aggregate_cursor_get(s : DbqueryaggregateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_cursor_set(s : DbqueryaggregateCursor, i : Int, v : Double) -> DbqueryaggregateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cursor_sum(s : DbqueryaggregateCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_cursor_mean(s : DbqueryaggregateCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_cursor_scale(s : DbqueryaggregateCursor, f : Double) -> DbqueryaggregateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cursor_add(a : DbqueryaggregateCursor, b : DbqueryaggregateCursor) -> DbqueryaggregateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_cursor_copy(s : DbqueryaggregateCursor) -> DbqueryaggregateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cursor_fill(s : DbqueryaggregateCursor, v : Double) -> DbqueryaggregateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_cursor_min(s : DbqueryaggregateCursor) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_cursor_max(s : DbqueryaggregateCursor) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_cursor_to_string(s : DbqueryaggregateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_view_make(size : Int) -> DbqueryaggregateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_view_len(s : DbqueryaggregateView) -> Int { s.size }

pub fn db_query_aggregate_view_get(s : DbqueryaggregateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_view_set(s : DbqueryaggregateView, i : Int, v : Double) -> DbqueryaggregateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_view_sum(s : DbqueryaggregateView) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_view_mean(s : DbqueryaggregateView) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_view_scale(s : DbqueryaggregateView, f : Double) -> DbqueryaggregateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_view_add(a : DbqueryaggregateView, b : DbqueryaggregateView) -> DbqueryaggregateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_view_copy(s : DbqueryaggregateView) -> DbqueryaggregateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_view_fill(s : DbqueryaggregateView, v : Double) -> DbqueryaggregateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_view_min(s : DbqueryaggregateView) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_view_max(s : DbqueryaggregateView) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_view_to_string(s : DbqueryaggregateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_range_make(size : Int) -> DbqueryaggregateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_range_len(s : DbqueryaggregateRange) -> Int { s.size }

pub fn db_query_aggregate_range_get(s : DbqueryaggregateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_range_set(s : DbqueryaggregateRange, i : Int, v : Double) -> DbqueryaggregateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_range_sum(s : DbqueryaggregateRange) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_range_mean(s : DbqueryaggregateRange) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_range_scale(s : DbqueryaggregateRange, f : Double) -> DbqueryaggregateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_range_add(a : DbqueryaggregateRange, b : DbqueryaggregateRange) -> DbqueryaggregateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_range_copy(s : DbqueryaggregateRange) -> DbqueryaggregateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_range_fill(s : DbqueryaggregateRange, v : Double) -> DbqueryaggregateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_range_min(s : DbqueryaggregateRange) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_range_max(s : DbqueryaggregateRange) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_range_to_string(s : DbqueryaggregateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_slice_make(size : Int) -> DbqueryaggregateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_slice_len(s : DbqueryaggregateSlice) -> Int { s.size }

pub fn db_query_aggregate_slice_get(s : DbqueryaggregateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_slice_set(s : DbqueryaggregateSlice, i : Int, v : Double) -> DbqueryaggregateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_slice_sum(s : DbqueryaggregateSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_aggregate_slice_mean(s : DbqueryaggregateSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_aggregate_slice_scale(s : DbqueryaggregateSlice, f : Double) -> DbqueryaggregateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_slice_add(a : DbqueryaggregateSlice, b : DbqueryaggregateSlice) -> DbqueryaggregateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_aggregate_slice_copy(s : DbqueryaggregateSlice) -> DbqueryaggregateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_slice_fill(s : DbqueryaggregateSlice, v : Double) -> DbqueryaggregateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_aggregate_slice_min(s : DbqueryaggregateSlice) -> Double { @_common.min(s.data) }

pub fn db_query_aggregate_slice_max(s : DbqueryaggregateSlice) -> Double { @_common.max(s.data) }

pub fn db_query_aggregate_slice_to_string(s : DbqueryaggregateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

