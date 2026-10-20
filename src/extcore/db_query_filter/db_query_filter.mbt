///===
/// extcore/db_query_filter

pub(all) struct DbqueryfilterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_filter_make_point(x : Double, y : Double) -> DbqueryfilterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_filter_make_point3(x : Double, y : Double, z : Double) -> DbqueryfilterPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryfilterPoint::x(self : DbqueryfilterPoint) -> Double { self.x }

pub fn DbqueryfilterPoint::y(self : DbqueryfilterPoint) -> Double { self.y }

pub fn DbqueryfilterPoint::z(self : DbqueryfilterPoint) -> Double { self.z }

pub fn DbqueryfilterPoint::label(self : DbqueryfilterPoint) -> Int { self.label }

pub fn DbqueryfilterPoint::dist(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryfilterPoint::add(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryfilterPoint::sub(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryfilterPoint::scale(self : DbqueryfilterPoint, s : Double) -> DbqueryfilterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryfilterPoint::dot(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryfilterPoint::cross(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryfilterPoint::norm(self : DbqueryfilterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryfilterPoint::normalize(self : DbqueryfilterPoint) -> DbqueryfilterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryfilterPoint::negate(self : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryfilterPoint::mid(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryfilterPoint::lerp(self : DbqueryfilterPoint, other : DbqueryfilterPoint, t : Double) -> DbqueryfilterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryfilterPoint::to_string(self : DbqueryfilterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryfilterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_filter_make_series(vals : Array[Double], name : String) -> DbqueryfilterSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryfilterSeries::len(self : DbqueryfilterSeries) -> Int { self.vals.length() }

pub fn DbqueryfilterSeries::sum(self : DbqueryfilterSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryfilterSeries::mean(self : DbqueryfilterSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryfilterSeries::min(self : DbqueryfilterSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryfilterSeries::max(self : DbqueryfilterSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryfilterSeries::range(self : DbqueryfilterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryfilterSeries::variance(self : DbqueryfilterSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryfilterSeries::std(self : DbqueryfilterSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryfilterSeries::median(self : DbqueryfilterSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryfilterSeries::scale(self : DbqueryfilterSeries, f : Double) -> DbqueryfilterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryfilterSeries::add(self : DbqueryfilterSeries, other : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryfilterSeries::sub(self : DbqueryfilterSeries, other : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryfilterSeries::normalize(self : DbqueryfilterSeries) -> DbqueryfilterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryfilterSeries::cumsum(self : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryfilterSeries::to_string(self : DbqueryfilterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryfilterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_filter_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryfilterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_filter_matrix_identity(n : Int) -> DbqueryfilterMatrix {
  let m = db_query_filter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryfilterMatrix::get(self : DbqueryfilterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryfilterMatrix::transpose(self : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  let result = db_query_filter_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryfilterMatrix::add(self : DbqueryfilterMatrix, other : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_filter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryfilterMatrix::scale(self : DbqueryfilterMatrix, s : Double) -> DbqueryfilterMatrix {
  let result = db_query_filter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryfilterMatrix::multiply(self : DbqueryfilterMatrix, other : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  if self.cols != other.rows { return db_query_filter_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_filter_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryfilterMatrix::trace(self : DbqueryfilterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryfilterMatrix::det(self : DbqueryfilterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryfilterMatrix::norm(self : DbqueryfilterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryfilterMatrix::to_string(self : DbqueryfilterMatrix) -> String {
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

pub(all) struct DbqueryfilterVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_filter_make_vector(comps : Array[Double]) -> DbqueryfilterVector {
  { comps, dim: comps.length() }
}

pub fn db_query_filter_vector_zero(dim : Int) -> DbqueryfilterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryfilterVector::add(self : DbqueryfilterVector, other : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryfilterVector::sub(self : DbqueryfilterVector, other : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryfilterVector::scale(self : DbqueryfilterVector, s : Double) -> DbqueryfilterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryfilterVector::dot(self : DbqueryfilterVector, other : DbqueryfilterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryfilterVector::norm(self : DbqueryfilterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryfilterVector::normalize(self : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryfilterVector::dist(self : DbqueryfilterVector, other : DbqueryfilterVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryfilterVector::to_string(self : DbqueryfilterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_filter_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_filter_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_filter_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_filter_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_filter_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_filter_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_filter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_filter_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_filter_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_filter_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_filter_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_filter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_filter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_filter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_filter_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_filter_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_filter_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_filter_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_filter_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_filter_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_filter_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_filter_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_filter_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_filter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_filter_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_filter_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_filter_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_filter_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_filter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryfilterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_frame_make(size : Int) -> DbqueryfilterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_frame_len(s : DbqueryfilterFrame) -> Int { s.size }

pub fn db_query_filter_frame_get(s : DbqueryfilterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_frame_set(s : DbqueryfilterFrame, i : Int, v : Double) -> DbqueryfilterFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_frame_sum(s : DbqueryfilterFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_frame_mean(s : DbqueryfilterFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_frame_scale(s : DbqueryfilterFrame, f : Double) -> DbqueryfilterFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_frame_add(a : DbqueryfilterFrame, b : DbqueryfilterFrame) -> DbqueryfilterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_frame_copy(s : DbqueryfilterFrame) -> DbqueryfilterFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_frame_fill(s : DbqueryfilterFrame, v : Double) -> DbqueryfilterFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_frame_min(s : DbqueryfilterFrame) -> Double { @_common.min(s.data) }

pub fn db_query_filter_frame_max(s : DbqueryfilterFrame) -> Double { @_common.max(s.data) }

pub fn db_query_filter_frame_to_string(s : DbqueryfilterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_table_make(size : Int) -> DbqueryfilterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_table_len(s : DbqueryfilterTable) -> Int { s.size }

pub fn db_query_filter_table_get(s : DbqueryfilterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_table_set(s : DbqueryfilterTable, i : Int, v : Double) -> DbqueryfilterTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_table_sum(s : DbqueryfilterTable) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_table_mean(s : DbqueryfilterTable) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_table_scale(s : DbqueryfilterTable, f : Double) -> DbqueryfilterTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_table_add(a : DbqueryfilterTable, b : DbqueryfilterTable) -> DbqueryfilterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_table_copy(s : DbqueryfilterTable) -> DbqueryfilterTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_table_fill(s : DbqueryfilterTable, v : Double) -> DbqueryfilterTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_table_min(s : DbqueryfilterTable) -> Double { @_common.min(s.data) }

pub fn db_query_filter_table_max(s : DbqueryfilterTable) -> Double { @_common.max(s.data) }

pub fn db_query_filter_table_to_string(s : DbqueryfilterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_graphn_make(size : Int) -> DbqueryfilterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_graphn_len(s : DbqueryfilterGraphN) -> Int { s.size }

pub fn db_query_filter_graphn_get(s : DbqueryfilterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_graphn_set(s : DbqueryfilterGraphN, i : Int, v : Double) -> DbqueryfilterGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_graphn_sum(s : DbqueryfilterGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_graphn_mean(s : DbqueryfilterGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_graphn_scale(s : DbqueryfilterGraphN, f : Double) -> DbqueryfilterGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_graphn_add(a : DbqueryfilterGraphN, b : DbqueryfilterGraphN) -> DbqueryfilterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_graphn_copy(s : DbqueryfilterGraphN) -> DbqueryfilterGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_graphn_fill(s : DbqueryfilterGraphN, v : Double) -> DbqueryfilterGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_graphn_min(s : DbqueryfilterGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_filter_graphn_max(s : DbqueryfilterGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_filter_graphn_to_string(s : DbqueryfilterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_node_make(size : Int) -> DbqueryfilterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_node_len(s : DbqueryfilterNode) -> Int { s.size }

pub fn db_query_filter_node_get(s : DbqueryfilterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_node_set(s : DbqueryfilterNode, i : Int, v : Double) -> DbqueryfilterNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_node_sum(s : DbqueryfilterNode) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_node_mean(s : DbqueryfilterNode) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_node_scale(s : DbqueryfilterNode, f : Double) -> DbqueryfilterNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_node_add(a : DbqueryfilterNode, b : DbqueryfilterNode) -> DbqueryfilterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_node_copy(s : DbqueryfilterNode) -> DbqueryfilterNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_node_fill(s : DbqueryfilterNode, v : Double) -> DbqueryfilterNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_node_min(s : DbqueryfilterNode) -> Double { @_common.min(s.data) }

pub fn db_query_filter_node_max(s : DbqueryfilterNode) -> Double { @_common.max(s.data) }

pub fn db_query_filter_node_to_string(s : DbqueryfilterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_edge_make(size : Int) -> DbqueryfilterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_edge_len(s : DbqueryfilterEdge) -> Int { s.size }

pub fn db_query_filter_edge_get(s : DbqueryfilterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_edge_set(s : DbqueryfilterEdge, i : Int, v : Double) -> DbqueryfilterEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_edge_sum(s : DbqueryfilterEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_edge_mean(s : DbqueryfilterEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_edge_scale(s : DbqueryfilterEdge, f : Double) -> DbqueryfilterEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_edge_add(a : DbqueryfilterEdge, b : DbqueryfilterEdge) -> DbqueryfilterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_edge_copy(s : DbqueryfilterEdge) -> DbqueryfilterEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_edge_fill(s : DbqueryfilterEdge, v : Double) -> DbqueryfilterEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_edge_min(s : DbqueryfilterEdge) -> Double { @_common.min(s.data) }

pub fn db_query_filter_edge_max(s : DbqueryfilterEdge) -> Double { @_common.max(s.data) }

pub fn db_query_filter_edge_to_string(s : DbqueryfilterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_path_make(size : Int) -> DbqueryfilterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_path_len(s : DbqueryfilterPath) -> Int { s.size }

pub fn db_query_filter_path_get(s : DbqueryfilterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_path_set(s : DbqueryfilterPath, i : Int, v : Double) -> DbqueryfilterPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_path_sum(s : DbqueryfilterPath) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_path_mean(s : DbqueryfilterPath) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_path_scale(s : DbqueryfilterPath, f : Double) -> DbqueryfilterPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_path_add(a : DbqueryfilterPath, b : DbqueryfilterPath) -> DbqueryfilterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_path_copy(s : DbqueryfilterPath) -> DbqueryfilterPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_path_fill(s : DbqueryfilterPath, v : Double) -> DbqueryfilterPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_path_min(s : DbqueryfilterPath) -> Double { @_common.min(s.data) }

pub fn db_query_filter_path_max(s : DbqueryfilterPath) -> Double { @_common.max(s.data) }

pub fn db_query_filter_path_to_string(s : DbqueryfilterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_cluster_make(size : Int) -> DbqueryfilterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_cluster_len(s : DbqueryfilterCluster) -> Int { s.size }

pub fn db_query_filter_cluster_get(s : DbqueryfilterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_cluster_set(s : DbqueryfilterCluster, i : Int, v : Double) -> DbqueryfilterCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_cluster_sum(s : DbqueryfilterCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_cluster_mean(s : DbqueryfilterCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_cluster_scale(s : DbqueryfilterCluster, f : Double) -> DbqueryfilterCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_cluster_add(a : DbqueryfilterCluster, b : DbqueryfilterCluster) -> DbqueryfilterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_cluster_copy(s : DbqueryfilterCluster) -> DbqueryfilterCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_cluster_fill(s : DbqueryfilterCluster, v : Double) -> DbqueryfilterCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_cluster_min(s : DbqueryfilterCluster) -> Double { @_common.min(s.data) }

pub fn db_query_filter_cluster_max(s : DbqueryfilterCluster) -> Double { @_common.max(s.data) }

pub fn db_query_filter_cluster_to_string(s : DbqueryfilterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_model_make(size : Int) -> DbqueryfilterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_model_len(s : DbqueryfilterModel) -> Int { s.size }

pub fn db_query_filter_model_get(s : DbqueryfilterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_model_set(s : DbqueryfilterModel, i : Int, v : Double) -> DbqueryfilterModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_model_sum(s : DbqueryfilterModel) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_model_mean(s : DbqueryfilterModel) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_model_scale(s : DbqueryfilterModel, f : Double) -> DbqueryfilterModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_model_add(a : DbqueryfilterModel, b : DbqueryfilterModel) -> DbqueryfilterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_model_copy(s : DbqueryfilterModel) -> DbqueryfilterModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_model_fill(s : DbqueryfilterModel, v : Double) -> DbqueryfilterModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_model_min(s : DbqueryfilterModel) -> Double { @_common.min(s.data) }

pub fn db_query_filter_model_max(s : DbqueryfilterModel) -> Double { @_common.max(s.data) }

pub fn db_query_filter_model_to_string(s : DbqueryfilterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_layer_make(size : Int) -> DbqueryfilterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_layer_len(s : DbqueryfilterLayer) -> Int { s.size }

pub fn db_query_filter_layer_get(s : DbqueryfilterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_layer_set(s : DbqueryfilterLayer, i : Int, v : Double) -> DbqueryfilterLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_layer_sum(s : DbqueryfilterLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_layer_mean(s : DbqueryfilterLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_layer_scale(s : DbqueryfilterLayer, f : Double) -> DbqueryfilterLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_layer_add(a : DbqueryfilterLayer, b : DbqueryfilterLayer) -> DbqueryfilterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_layer_copy(s : DbqueryfilterLayer) -> DbqueryfilterLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_layer_fill(s : DbqueryfilterLayer, v : Double) -> DbqueryfilterLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_layer_min(s : DbqueryfilterLayer) -> Double { @_common.min(s.data) }

pub fn db_query_filter_layer_max(s : DbqueryfilterLayer) -> Double { @_common.max(s.data) }

pub fn db_query_filter_layer_to_string(s : DbqueryfilterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_buffer_make(size : Int) -> DbqueryfilterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_buffer_len(s : DbqueryfilterBuffer) -> Int { s.size }

pub fn db_query_filter_buffer_get(s : DbqueryfilterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_buffer_set(s : DbqueryfilterBuffer, i : Int, v : Double) -> DbqueryfilterBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_buffer_sum(s : DbqueryfilterBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_buffer_mean(s : DbqueryfilterBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_buffer_scale(s : DbqueryfilterBuffer, f : Double) -> DbqueryfilterBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_buffer_add(a : DbqueryfilterBuffer, b : DbqueryfilterBuffer) -> DbqueryfilterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_buffer_copy(s : DbqueryfilterBuffer) -> DbqueryfilterBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_buffer_fill(s : DbqueryfilterBuffer, v : Double) -> DbqueryfilterBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_buffer_min(s : DbqueryfilterBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_filter_buffer_max(s : DbqueryfilterBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_filter_buffer_to_string(s : DbqueryfilterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_cursor_make(size : Int) -> DbqueryfilterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_cursor_len(s : DbqueryfilterCursor) -> Int { s.size }

pub fn db_query_filter_cursor_get(s : DbqueryfilterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_cursor_set(s : DbqueryfilterCursor, i : Int, v : Double) -> DbqueryfilterCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_cursor_sum(s : DbqueryfilterCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_cursor_mean(s : DbqueryfilterCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_cursor_scale(s : DbqueryfilterCursor, f : Double) -> DbqueryfilterCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_cursor_add(a : DbqueryfilterCursor, b : DbqueryfilterCursor) -> DbqueryfilterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_cursor_copy(s : DbqueryfilterCursor) -> DbqueryfilterCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_cursor_fill(s : DbqueryfilterCursor, v : Double) -> DbqueryfilterCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_cursor_min(s : DbqueryfilterCursor) -> Double { @_common.min(s.data) }

pub fn db_query_filter_cursor_max(s : DbqueryfilterCursor) -> Double { @_common.max(s.data) }

pub fn db_query_filter_cursor_to_string(s : DbqueryfilterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_view_make(size : Int) -> DbqueryfilterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_view_len(s : DbqueryfilterView) -> Int { s.size }

pub fn db_query_filter_view_get(s : DbqueryfilterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_view_set(s : DbqueryfilterView, i : Int, v : Double) -> DbqueryfilterView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_view_sum(s : DbqueryfilterView) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_view_mean(s : DbqueryfilterView) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_view_scale(s : DbqueryfilterView, f : Double) -> DbqueryfilterView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_view_add(a : DbqueryfilterView, b : DbqueryfilterView) -> DbqueryfilterView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_view_copy(s : DbqueryfilterView) -> DbqueryfilterView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_view_fill(s : DbqueryfilterView, v : Double) -> DbqueryfilterView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_view_min(s : DbqueryfilterView) -> Double { @_common.min(s.data) }

pub fn db_query_filter_view_max(s : DbqueryfilterView) -> Double { @_common.max(s.data) }

pub fn db_query_filter_view_to_string(s : DbqueryfilterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_range_make(size : Int) -> DbqueryfilterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_range_len(s : DbqueryfilterRange) -> Int { s.size }

pub fn db_query_filter_range_get(s : DbqueryfilterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_range_set(s : DbqueryfilterRange, i : Int, v : Double) -> DbqueryfilterRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_range_sum(s : DbqueryfilterRange) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_range_mean(s : DbqueryfilterRange) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_range_scale(s : DbqueryfilterRange, f : Double) -> DbqueryfilterRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_range_add(a : DbqueryfilterRange, b : DbqueryfilterRange) -> DbqueryfilterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_range_copy(s : DbqueryfilterRange) -> DbqueryfilterRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_range_fill(s : DbqueryfilterRange, v : Double) -> DbqueryfilterRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_range_min(s : DbqueryfilterRange) -> Double { @_common.min(s.data) }

pub fn db_query_filter_range_max(s : DbqueryfilterRange) -> Double { @_common.max(s.data) }

pub fn db_query_filter_range_to_string(s : DbqueryfilterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_slice_make(size : Int) -> DbqueryfilterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_slice_len(s : DbqueryfilterSlice) -> Int { s.size }

pub fn db_query_filter_slice_get(s : DbqueryfilterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_slice_set(s : DbqueryfilterSlice, i : Int, v : Double) -> DbqueryfilterSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_query_filter_slice_sum(s : DbqueryfilterSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_filter_slice_mean(s : DbqueryfilterSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_filter_slice_scale(s : DbqueryfilterSlice, f : Double) -> DbqueryfilterSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_filter_slice_add(a : DbqueryfilterSlice, b : DbqueryfilterSlice) -> DbqueryfilterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_filter_slice_copy(s : DbqueryfilterSlice) -> DbqueryfilterSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_filter_slice_fill(s : DbqueryfilterSlice, v : Double) -> DbqueryfilterSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_filter_slice_min(s : DbqueryfilterSlice) -> Double { @_common.min(s.data) }

pub fn db_query_filter_slice_max(s : DbqueryfilterSlice) -> Double { @_common.max(s.data) }

pub fn db_query_filter_slice_to_string(s : DbqueryfilterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

