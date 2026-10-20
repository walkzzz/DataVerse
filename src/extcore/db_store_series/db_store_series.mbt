///===
/// extcore/db_store_series

pub(all) struct DbstoreseriesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_series_make_point(x : Double, y : Double) -> DbstoreseriesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_series_make_point3(x : Double, y : Double, z : Double) -> DbstoreseriesPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoreseriesPoint::x(self : DbstoreseriesPoint) -> Double { self.x }

pub fn DbstoreseriesPoint::y(self : DbstoreseriesPoint) -> Double { self.y }

pub fn DbstoreseriesPoint::z(self : DbstoreseriesPoint) -> Double { self.z }

pub fn DbstoreseriesPoint::label(self : DbstoreseriesPoint) -> Int { self.label }

pub fn DbstoreseriesPoint::dist(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoreseriesPoint::add(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoreseriesPoint::sub(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoreseriesPoint::scale(self : DbstoreseriesPoint, s : Double) -> DbstoreseriesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoreseriesPoint::dot(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoreseriesPoint::cross(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoreseriesPoint::norm(self : DbstoreseriesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoreseriesPoint::normalize(self : DbstoreseriesPoint) -> DbstoreseriesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoreseriesPoint::negate(self : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoreseriesPoint::mid(self : DbstoreseriesPoint, other : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoreseriesPoint::lerp(self : DbstoreseriesPoint, other : DbstoreseriesPoint, t : Double) -> DbstoreseriesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoreseriesPoint::to_string(self : DbstoreseriesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoreseriesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_series_make_series(vals : Array[Double], name : String) -> DbstoreseriesSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoreseriesSeries::len(self : DbstoreseriesSeries) -> Int { self.vals.length() }

pub fn DbstoreseriesSeries::sum(self : DbstoreseriesSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoreseriesSeries::mean(self : DbstoreseriesSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoreseriesSeries::min(self : DbstoreseriesSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoreseriesSeries::max(self : DbstoreseriesSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoreseriesSeries::range(self : DbstoreseriesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoreseriesSeries::variance(self : DbstoreseriesSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoreseriesSeries::std(self : DbstoreseriesSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoreseriesSeries::median(self : DbstoreseriesSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoreseriesSeries::scale(self : DbstoreseriesSeries, f : Double) -> DbstoreseriesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoreseriesSeries::add(self : DbstoreseriesSeries, other : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoreseriesSeries::sub(self : DbstoreseriesSeries, other : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoreseriesSeries::normalize(self : DbstoreseriesSeries) -> DbstoreseriesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoreseriesSeries::cumsum(self : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoreseriesSeries::to_string(self : DbstoreseriesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoreseriesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_series_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoreseriesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_series_matrix_identity(n : Int) -> DbstoreseriesMatrix {
  let m = db_store_series_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoreseriesMatrix::get(self : DbstoreseriesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoreseriesMatrix::transpose(self : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  let result = db_store_series_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoreseriesMatrix::add(self : DbstoreseriesMatrix, other : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_series_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoreseriesMatrix::scale(self : DbstoreseriesMatrix, s : Double) -> DbstoreseriesMatrix {
  let result = db_store_series_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoreseriesMatrix::multiply(self : DbstoreseriesMatrix, other : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  if self.cols != other.rows { return db_store_series_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_series_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoreseriesMatrix::trace(self : DbstoreseriesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoreseriesMatrix::det(self : DbstoreseriesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoreseriesMatrix::norm(self : DbstoreseriesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoreseriesMatrix::to_string(self : DbstoreseriesMatrix) -> String {
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

pub(all) struct DbstoreseriesVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_series_make_vector(comps : Array[Double]) -> DbstoreseriesVector {
  { comps, dim: comps.length() }
}

pub fn db_store_series_vector_zero(dim : Int) -> DbstoreseriesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoreseriesVector::add(self : DbstoreseriesVector, other : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoreseriesVector::sub(self : DbstoreseriesVector, other : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoreseriesVector::scale(self : DbstoreseriesVector, s : Double) -> DbstoreseriesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoreseriesVector::dot(self : DbstoreseriesVector, other : DbstoreseriesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoreseriesVector::norm(self : DbstoreseriesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoreseriesVector::normalize(self : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoreseriesVector::dist(self : DbstoreseriesVector, other : DbstoreseriesVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoreseriesVector::to_string(self : DbstoreseriesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_series_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_series_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_series_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_series_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_series_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_series_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_series_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_series_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_series_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_series_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_series_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_series_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_series_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_series_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_series_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_series_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_series_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_series_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_series_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_series_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_series_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_series_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_series_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_series_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_series_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_series_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_series_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_series_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_series_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoreseriesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_frame_make(size : Int) -> DbstoreseriesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_frame_len(s : DbstoreseriesFrame) -> Int { s.size }

pub fn db_store_series_frame_get(s : DbstoreseriesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_frame_set(s : DbstoreseriesFrame, i : Int, v : Double) -> DbstoreseriesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_sum(s : DbstoreseriesFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_series_frame_mean(s : DbstoreseriesFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_series_frame_scale(s : DbstoreseriesFrame, f : Double) -> DbstoreseriesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_add(a : DbstoreseriesFrame, b : DbstoreseriesFrame) -> DbstoreseriesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_frame_copy(s : DbstoreseriesFrame) -> DbstoreseriesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_fill(s : DbstoreseriesFrame, v : Double) -> DbstoreseriesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_min(s : DbstoreseriesFrame) -> Double { @_common.min(s.data) }

pub fn db_store_series_frame_max(s : DbstoreseriesFrame) -> Double { @_common.max(s.data) }

pub fn db_store_series_frame_to_string(s : DbstoreseriesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_table_make(size : Int) -> DbstoreseriesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_table_len(s : DbstoreseriesTable) -> Int { s.size }

pub fn db_store_series_table_get(s : DbstoreseriesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_table_set(s : DbstoreseriesTable, i : Int, v : Double) -> DbstoreseriesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_table_sum(s : DbstoreseriesTable) -> Double { @_common.sum(s.data) }

pub fn db_store_series_table_mean(s : DbstoreseriesTable) -> Double { @_common.mean(s.data) }

pub fn db_store_series_table_scale(s : DbstoreseriesTable, f : Double) -> DbstoreseriesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_table_add(a : DbstoreseriesTable, b : DbstoreseriesTable) -> DbstoreseriesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_table_copy(s : DbstoreseriesTable) -> DbstoreseriesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_table_fill(s : DbstoreseriesTable, v : Double) -> DbstoreseriesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_table_min(s : DbstoreseriesTable) -> Double { @_common.min(s.data) }

pub fn db_store_series_table_max(s : DbstoreseriesTable) -> Double { @_common.max(s.data) }

pub fn db_store_series_table_to_string(s : DbstoreseriesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_graphn_make(size : Int) -> DbstoreseriesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_graphn_len(s : DbstoreseriesGraphN) -> Int { s.size }

pub fn db_store_series_graphn_get(s : DbstoreseriesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_graphn_set(s : DbstoreseriesGraphN, i : Int, v : Double) -> DbstoreseriesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_sum(s : DbstoreseriesGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_series_graphn_mean(s : DbstoreseriesGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_series_graphn_scale(s : DbstoreseriesGraphN, f : Double) -> DbstoreseriesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_add(a : DbstoreseriesGraphN, b : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_graphn_copy(s : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_fill(s : DbstoreseriesGraphN, v : Double) -> DbstoreseriesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_min(s : DbstoreseriesGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_series_graphn_max(s : DbstoreseriesGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_series_graphn_to_string(s : DbstoreseriesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_node_make(size : Int) -> DbstoreseriesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_node_len(s : DbstoreseriesNode) -> Int { s.size }

pub fn db_store_series_node_get(s : DbstoreseriesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_node_set(s : DbstoreseriesNode, i : Int, v : Double) -> DbstoreseriesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_node_sum(s : DbstoreseriesNode) -> Double { @_common.sum(s.data) }

pub fn db_store_series_node_mean(s : DbstoreseriesNode) -> Double { @_common.mean(s.data) }

pub fn db_store_series_node_scale(s : DbstoreseriesNode, f : Double) -> DbstoreseriesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_node_add(a : DbstoreseriesNode, b : DbstoreseriesNode) -> DbstoreseriesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_node_copy(s : DbstoreseriesNode) -> DbstoreseriesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_node_fill(s : DbstoreseriesNode, v : Double) -> DbstoreseriesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_node_min(s : DbstoreseriesNode) -> Double { @_common.min(s.data) }

pub fn db_store_series_node_max(s : DbstoreseriesNode) -> Double { @_common.max(s.data) }

pub fn db_store_series_node_to_string(s : DbstoreseriesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_edge_make(size : Int) -> DbstoreseriesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_edge_len(s : DbstoreseriesEdge) -> Int { s.size }

pub fn db_store_series_edge_get(s : DbstoreseriesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_edge_set(s : DbstoreseriesEdge, i : Int, v : Double) -> DbstoreseriesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_sum(s : DbstoreseriesEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_series_edge_mean(s : DbstoreseriesEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_series_edge_scale(s : DbstoreseriesEdge, f : Double) -> DbstoreseriesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_add(a : DbstoreseriesEdge, b : DbstoreseriesEdge) -> DbstoreseriesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_edge_copy(s : DbstoreseriesEdge) -> DbstoreseriesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_fill(s : DbstoreseriesEdge, v : Double) -> DbstoreseriesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_min(s : DbstoreseriesEdge) -> Double { @_common.min(s.data) }

pub fn db_store_series_edge_max(s : DbstoreseriesEdge) -> Double { @_common.max(s.data) }

pub fn db_store_series_edge_to_string(s : DbstoreseriesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_path_make(size : Int) -> DbstoreseriesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_path_len(s : DbstoreseriesPath) -> Int { s.size }

pub fn db_store_series_path_get(s : DbstoreseriesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_path_set(s : DbstoreseriesPath, i : Int, v : Double) -> DbstoreseriesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_path_sum(s : DbstoreseriesPath) -> Double { @_common.sum(s.data) }

pub fn db_store_series_path_mean(s : DbstoreseriesPath) -> Double { @_common.mean(s.data) }

pub fn db_store_series_path_scale(s : DbstoreseriesPath, f : Double) -> DbstoreseriesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_path_add(a : DbstoreseriesPath, b : DbstoreseriesPath) -> DbstoreseriesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_path_copy(s : DbstoreseriesPath) -> DbstoreseriesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_path_fill(s : DbstoreseriesPath, v : Double) -> DbstoreseriesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_path_min(s : DbstoreseriesPath) -> Double { @_common.min(s.data) }

pub fn db_store_series_path_max(s : DbstoreseriesPath) -> Double { @_common.max(s.data) }

pub fn db_store_series_path_to_string(s : DbstoreseriesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_cluster_make(size : Int) -> DbstoreseriesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_cluster_len(s : DbstoreseriesCluster) -> Int { s.size }

pub fn db_store_series_cluster_get(s : DbstoreseriesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_cluster_set(s : DbstoreseriesCluster, i : Int, v : Double) -> DbstoreseriesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_sum(s : DbstoreseriesCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_series_cluster_mean(s : DbstoreseriesCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_series_cluster_scale(s : DbstoreseriesCluster, f : Double) -> DbstoreseriesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_add(a : DbstoreseriesCluster, b : DbstoreseriesCluster) -> DbstoreseriesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_cluster_copy(s : DbstoreseriesCluster) -> DbstoreseriesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_fill(s : DbstoreseriesCluster, v : Double) -> DbstoreseriesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_min(s : DbstoreseriesCluster) -> Double { @_common.min(s.data) }

pub fn db_store_series_cluster_max(s : DbstoreseriesCluster) -> Double { @_common.max(s.data) }

pub fn db_store_series_cluster_to_string(s : DbstoreseriesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_model_make(size : Int) -> DbstoreseriesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_model_len(s : DbstoreseriesModel) -> Int { s.size }

pub fn db_store_series_model_get(s : DbstoreseriesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_model_set(s : DbstoreseriesModel, i : Int, v : Double) -> DbstoreseriesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_model_sum(s : DbstoreseriesModel) -> Double { @_common.sum(s.data) }

pub fn db_store_series_model_mean(s : DbstoreseriesModel) -> Double { @_common.mean(s.data) }

pub fn db_store_series_model_scale(s : DbstoreseriesModel, f : Double) -> DbstoreseriesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_model_add(a : DbstoreseriesModel, b : DbstoreseriesModel) -> DbstoreseriesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_model_copy(s : DbstoreseriesModel) -> DbstoreseriesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_model_fill(s : DbstoreseriesModel, v : Double) -> DbstoreseriesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_model_min(s : DbstoreseriesModel) -> Double { @_common.min(s.data) }

pub fn db_store_series_model_max(s : DbstoreseriesModel) -> Double { @_common.max(s.data) }

pub fn db_store_series_model_to_string(s : DbstoreseriesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_layer_make(size : Int) -> DbstoreseriesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_layer_len(s : DbstoreseriesLayer) -> Int { s.size }

pub fn db_store_series_layer_get(s : DbstoreseriesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_layer_set(s : DbstoreseriesLayer, i : Int, v : Double) -> DbstoreseriesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_sum(s : DbstoreseriesLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_series_layer_mean(s : DbstoreseriesLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_series_layer_scale(s : DbstoreseriesLayer, f : Double) -> DbstoreseriesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_add(a : DbstoreseriesLayer, b : DbstoreseriesLayer) -> DbstoreseriesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_layer_copy(s : DbstoreseriesLayer) -> DbstoreseriesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_fill(s : DbstoreseriesLayer, v : Double) -> DbstoreseriesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_min(s : DbstoreseriesLayer) -> Double { @_common.min(s.data) }

pub fn db_store_series_layer_max(s : DbstoreseriesLayer) -> Double { @_common.max(s.data) }

pub fn db_store_series_layer_to_string(s : DbstoreseriesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_buffer_make(size : Int) -> DbstoreseriesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_buffer_len(s : DbstoreseriesBuffer) -> Int { s.size }

pub fn db_store_series_buffer_get(s : DbstoreseriesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_buffer_set(s : DbstoreseriesBuffer, i : Int, v : Double) -> DbstoreseriesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_sum(s : DbstoreseriesBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_series_buffer_mean(s : DbstoreseriesBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_series_buffer_scale(s : DbstoreseriesBuffer, f : Double) -> DbstoreseriesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_add(a : DbstoreseriesBuffer, b : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_buffer_copy(s : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_fill(s : DbstoreseriesBuffer, v : Double) -> DbstoreseriesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_min(s : DbstoreseriesBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_series_buffer_max(s : DbstoreseriesBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_series_buffer_to_string(s : DbstoreseriesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_cursor_make(size : Int) -> DbstoreseriesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_cursor_len(s : DbstoreseriesCursor) -> Int { s.size }

pub fn db_store_series_cursor_get(s : DbstoreseriesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_cursor_set(s : DbstoreseriesCursor, i : Int, v : Double) -> DbstoreseriesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_sum(s : DbstoreseriesCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_series_cursor_mean(s : DbstoreseriesCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_series_cursor_scale(s : DbstoreseriesCursor, f : Double) -> DbstoreseriesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_add(a : DbstoreseriesCursor, b : DbstoreseriesCursor) -> DbstoreseriesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_cursor_copy(s : DbstoreseriesCursor) -> DbstoreseriesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_fill(s : DbstoreseriesCursor, v : Double) -> DbstoreseriesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_min(s : DbstoreseriesCursor) -> Double { @_common.min(s.data) }

pub fn db_store_series_cursor_max(s : DbstoreseriesCursor) -> Double { @_common.max(s.data) }

pub fn db_store_series_cursor_to_string(s : DbstoreseriesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_view_make(size : Int) -> DbstoreseriesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_view_len(s : DbstoreseriesView) -> Int { s.size }

pub fn db_store_series_view_get(s : DbstoreseriesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_view_set(s : DbstoreseriesView, i : Int, v : Double) -> DbstoreseriesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_view_sum(s : DbstoreseriesView) -> Double { @_common.sum(s.data) }

pub fn db_store_series_view_mean(s : DbstoreseriesView) -> Double { @_common.mean(s.data) }

pub fn db_store_series_view_scale(s : DbstoreseriesView, f : Double) -> DbstoreseriesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_view_add(a : DbstoreseriesView, b : DbstoreseriesView) -> DbstoreseriesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_view_copy(s : DbstoreseriesView) -> DbstoreseriesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_view_fill(s : DbstoreseriesView, v : Double) -> DbstoreseriesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_view_min(s : DbstoreseriesView) -> Double { @_common.min(s.data) }

pub fn db_store_series_view_max(s : DbstoreseriesView) -> Double { @_common.max(s.data) }

pub fn db_store_series_view_to_string(s : DbstoreseriesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_range_make(size : Int) -> DbstoreseriesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_range_len(s : DbstoreseriesRange) -> Int { s.size }

pub fn db_store_series_range_get(s : DbstoreseriesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_range_set(s : DbstoreseriesRange, i : Int, v : Double) -> DbstoreseriesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_range_sum(s : DbstoreseriesRange) -> Double { @_common.sum(s.data) }

pub fn db_store_series_range_mean(s : DbstoreseriesRange) -> Double { @_common.mean(s.data) }

pub fn db_store_series_range_scale(s : DbstoreseriesRange, f : Double) -> DbstoreseriesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_range_add(a : DbstoreseriesRange, b : DbstoreseriesRange) -> DbstoreseriesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_range_copy(s : DbstoreseriesRange) -> DbstoreseriesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_range_fill(s : DbstoreseriesRange, v : Double) -> DbstoreseriesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_range_min(s : DbstoreseriesRange) -> Double { @_common.min(s.data) }

pub fn db_store_series_range_max(s : DbstoreseriesRange) -> Double { @_common.max(s.data) }

pub fn db_store_series_range_to_string(s : DbstoreseriesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_slice_make(size : Int) -> DbstoreseriesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_slice_len(s : DbstoreseriesSlice) -> Int { s.size }

pub fn db_store_series_slice_get(s : DbstoreseriesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_slice_set(s : DbstoreseriesSlice, i : Int, v : Double) -> DbstoreseriesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_sum(s : DbstoreseriesSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_series_slice_mean(s : DbstoreseriesSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_series_slice_scale(s : DbstoreseriesSlice, f : Double) -> DbstoreseriesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_add(a : DbstoreseriesSlice, b : DbstoreseriesSlice) -> DbstoreseriesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_slice_copy(s : DbstoreseriesSlice) -> DbstoreseriesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_fill(s : DbstoreseriesSlice, v : Double) -> DbstoreseriesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_min(s : DbstoreseriesSlice) -> Double { @_common.min(s.data) }

pub fn db_store_series_slice_max(s : DbstoreseriesSlice) -> Double { @_common.max(s.data) }

pub fn db_store_series_slice_to_string(s : DbstoreseriesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

