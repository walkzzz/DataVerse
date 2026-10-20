///===
/// extcore/db_store_col

pub(all) struct DbstorecolPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_col_make_point(x : Double, y : Double) -> DbstorecolPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_col_make_point3(x : Double, y : Double, z : Double) -> DbstorecolPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorecolPoint::x(self : DbstorecolPoint) -> Double { self.x }

pub fn DbstorecolPoint::y(self : DbstorecolPoint) -> Double { self.y }

pub fn DbstorecolPoint::z(self : DbstorecolPoint) -> Double { self.z }

pub fn DbstorecolPoint::label(self : DbstorecolPoint) -> Int { self.label }

pub fn DbstorecolPoint::dist(self : DbstorecolPoint, other : DbstorecolPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorecolPoint::add(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorecolPoint::sub(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorecolPoint::scale(self : DbstorecolPoint, s : Double) -> DbstorecolPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorecolPoint::dot(self : DbstorecolPoint, other : DbstorecolPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorecolPoint::cross(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorecolPoint::norm(self : DbstorecolPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorecolPoint::normalize(self : DbstorecolPoint) -> DbstorecolPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorecolPoint::negate(self : DbstorecolPoint) -> DbstorecolPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorecolPoint::mid(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorecolPoint::lerp(self : DbstorecolPoint, other : DbstorecolPoint, t : Double) -> DbstorecolPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorecolPoint::to_string(self : DbstorecolPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorecolSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_col_make_series(vals : Array[Double], name : String) -> DbstorecolSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorecolSeries::len(self : DbstorecolSeries) -> Int { self.vals.length() }

pub fn DbstorecolSeries::sum(self : DbstorecolSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorecolSeries::mean(self : DbstorecolSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorecolSeries::min(self : DbstorecolSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorecolSeries::max(self : DbstorecolSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorecolSeries::range(self : DbstorecolSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorecolSeries::variance(self : DbstorecolSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorecolSeries::std(self : DbstorecolSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorecolSeries::median(self : DbstorecolSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorecolSeries::scale(self : DbstorecolSeries, f : Double) -> DbstorecolSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorecolSeries::add(self : DbstorecolSeries, other : DbstorecolSeries) -> DbstorecolSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorecolSeries::sub(self : DbstorecolSeries, other : DbstorecolSeries) -> DbstorecolSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorecolSeries::normalize(self : DbstorecolSeries) -> DbstorecolSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorecolSeries::cumsum(self : DbstorecolSeries) -> DbstorecolSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorecolSeries::to_string(self : DbstorecolSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorecolMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_col_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorecolMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_col_matrix_identity(n : Int) -> DbstorecolMatrix {
  let m = db_store_col_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorecolMatrix::get(self : DbstorecolMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorecolMatrix::transpose(self : DbstorecolMatrix) -> DbstorecolMatrix {
  let result = db_store_col_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorecolMatrix::add(self : DbstorecolMatrix, other : DbstorecolMatrix) -> DbstorecolMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_col_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorecolMatrix::scale(self : DbstorecolMatrix, s : Double) -> DbstorecolMatrix {
  let result = db_store_col_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorecolMatrix::multiply(self : DbstorecolMatrix, other : DbstorecolMatrix) -> DbstorecolMatrix {
  if self.cols != other.rows { return db_store_col_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_col_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorecolMatrix::trace(self : DbstorecolMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorecolMatrix::det(self : DbstorecolMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorecolMatrix::norm(self : DbstorecolMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorecolMatrix::to_string(self : DbstorecolMatrix) -> String {
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

pub(all) struct DbstorecolVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_col_make_vector(comps : Array[Double]) -> DbstorecolVector {
  { comps, dim: comps.length() }
}

pub fn db_store_col_vector_zero(dim : Int) -> DbstorecolVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorecolVector::add(self : DbstorecolVector, other : DbstorecolVector) -> DbstorecolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorecolVector::sub(self : DbstorecolVector, other : DbstorecolVector) -> DbstorecolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorecolVector::scale(self : DbstorecolVector, s : Double) -> DbstorecolVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorecolVector::dot(self : DbstorecolVector, other : DbstorecolVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorecolVector::norm(self : DbstorecolVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorecolVector::normalize(self : DbstorecolVector) -> DbstorecolVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorecolVector::dist(self : DbstorecolVector, other : DbstorecolVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorecolVector::to_string(self : DbstorecolVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_col_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_col_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_col_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_col_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_col_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_col_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_col_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_col_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_col_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_col_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_col_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_col_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_col_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_col_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_col_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_col_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_col_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_col_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_col_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_col_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_col_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_col_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_col_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_col_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_col_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_col_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_col_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_col_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_col_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorecolFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_frame_make(size : Int) -> DbstorecolFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_frame_len(s : DbstorecolFrame) -> Int { s.size }

pub fn db_store_col_frame_get(s : DbstorecolFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_frame_set(s : DbstorecolFrame, i : Int, v : Double) -> DbstorecolFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_frame_sum(s : DbstorecolFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_col_frame_mean(s : DbstorecolFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_col_frame_scale(s : DbstorecolFrame, f : Double) -> DbstorecolFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_frame_add(a : DbstorecolFrame, b : DbstorecolFrame) -> DbstorecolFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_frame_copy(s : DbstorecolFrame) -> DbstorecolFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_frame_fill(s : DbstorecolFrame, v : Double) -> DbstorecolFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_frame_min(s : DbstorecolFrame) -> Double { @_common.min(s.data) }

pub fn db_store_col_frame_max(s : DbstorecolFrame) -> Double { @_common.max(s.data) }

pub fn db_store_col_frame_to_string(s : DbstorecolFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_table_make(size : Int) -> DbstorecolTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_table_len(s : DbstorecolTable) -> Int { s.size }

pub fn db_store_col_table_get(s : DbstorecolTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_table_set(s : DbstorecolTable, i : Int, v : Double) -> DbstorecolTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_table_sum(s : DbstorecolTable) -> Double { @_common.sum(s.data) }

pub fn db_store_col_table_mean(s : DbstorecolTable) -> Double { @_common.mean(s.data) }

pub fn db_store_col_table_scale(s : DbstorecolTable, f : Double) -> DbstorecolTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_table_add(a : DbstorecolTable, b : DbstorecolTable) -> DbstorecolTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_table_copy(s : DbstorecolTable) -> DbstorecolTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_table_fill(s : DbstorecolTable, v : Double) -> DbstorecolTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_table_min(s : DbstorecolTable) -> Double { @_common.min(s.data) }

pub fn db_store_col_table_max(s : DbstorecolTable) -> Double { @_common.max(s.data) }

pub fn db_store_col_table_to_string(s : DbstorecolTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_graphn_make(size : Int) -> DbstorecolGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_graphn_len(s : DbstorecolGraphN) -> Int { s.size }

pub fn db_store_col_graphn_get(s : DbstorecolGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_graphn_set(s : DbstorecolGraphN, i : Int, v : Double) -> DbstorecolGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_graphn_sum(s : DbstorecolGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_col_graphn_mean(s : DbstorecolGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_col_graphn_scale(s : DbstorecolGraphN, f : Double) -> DbstorecolGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_graphn_add(a : DbstorecolGraphN, b : DbstorecolGraphN) -> DbstorecolGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_graphn_copy(s : DbstorecolGraphN) -> DbstorecolGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_graphn_fill(s : DbstorecolGraphN, v : Double) -> DbstorecolGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_graphn_min(s : DbstorecolGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_col_graphn_max(s : DbstorecolGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_col_graphn_to_string(s : DbstorecolGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_node_make(size : Int) -> DbstorecolNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_node_len(s : DbstorecolNode) -> Int { s.size }

pub fn db_store_col_node_get(s : DbstorecolNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_node_set(s : DbstorecolNode, i : Int, v : Double) -> DbstorecolNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_node_sum(s : DbstorecolNode) -> Double { @_common.sum(s.data) }

pub fn db_store_col_node_mean(s : DbstorecolNode) -> Double { @_common.mean(s.data) }

pub fn db_store_col_node_scale(s : DbstorecolNode, f : Double) -> DbstorecolNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_node_add(a : DbstorecolNode, b : DbstorecolNode) -> DbstorecolNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_node_copy(s : DbstorecolNode) -> DbstorecolNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_node_fill(s : DbstorecolNode, v : Double) -> DbstorecolNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_node_min(s : DbstorecolNode) -> Double { @_common.min(s.data) }

pub fn db_store_col_node_max(s : DbstorecolNode) -> Double { @_common.max(s.data) }

pub fn db_store_col_node_to_string(s : DbstorecolNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_edge_make(size : Int) -> DbstorecolEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_edge_len(s : DbstorecolEdge) -> Int { s.size }

pub fn db_store_col_edge_get(s : DbstorecolEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_edge_set(s : DbstorecolEdge, i : Int, v : Double) -> DbstorecolEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_edge_sum(s : DbstorecolEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_col_edge_mean(s : DbstorecolEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_col_edge_scale(s : DbstorecolEdge, f : Double) -> DbstorecolEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_edge_add(a : DbstorecolEdge, b : DbstorecolEdge) -> DbstorecolEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_edge_copy(s : DbstorecolEdge) -> DbstorecolEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_edge_fill(s : DbstorecolEdge, v : Double) -> DbstorecolEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_edge_min(s : DbstorecolEdge) -> Double { @_common.min(s.data) }

pub fn db_store_col_edge_max(s : DbstorecolEdge) -> Double { @_common.max(s.data) }

pub fn db_store_col_edge_to_string(s : DbstorecolEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_path_make(size : Int) -> DbstorecolPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_path_len(s : DbstorecolPath) -> Int { s.size }

pub fn db_store_col_path_get(s : DbstorecolPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_path_set(s : DbstorecolPath, i : Int, v : Double) -> DbstorecolPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_path_sum(s : DbstorecolPath) -> Double { @_common.sum(s.data) }

pub fn db_store_col_path_mean(s : DbstorecolPath) -> Double { @_common.mean(s.data) }

pub fn db_store_col_path_scale(s : DbstorecolPath, f : Double) -> DbstorecolPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_path_add(a : DbstorecolPath, b : DbstorecolPath) -> DbstorecolPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_path_copy(s : DbstorecolPath) -> DbstorecolPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_path_fill(s : DbstorecolPath, v : Double) -> DbstorecolPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_path_min(s : DbstorecolPath) -> Double { @_common.min(s.data) }

pub fn db_store_col_path_max(s : DbstorecolPath) -> Double { @_common.max(s.data) }

pub fn db_store_col_path_to_string(s : DbstorecolPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_cluster_make(size : Int) -> DbstorecolCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_cluster_len(s : DbstorecolCluster) -> Int { s.size }

pub fn db_store_col_cluster_get(s : DbstorecolCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_cluster_set(s : DbstorecolCluster, i : Int, v : Double) -> DbstorecolCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_cluster_sum(s : DbstorecolCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_col_cluster_mean(s : DbstorecolCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_col_cluster_scale(s : DbstorecolCluster, f : Double) -> DbstorecolCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_cluster_add(a : DbstorecolCluster, b : DbstorecolCluster) -> DbstorecolCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_cluster_copy(s : DbstorecolCluster) -> DbstorecolCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_cluster_fill(s : DbstorecolCluster, v : Double) -> DbstorecolCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_cluster_min(s : DbstorecolCluster) -> Double { @_common.min(s.data) }

pub fn db_store_col_cluster_max(s : DbstorecolCluster) -> Double { @_common.max(s.data) }

pub fn db_store_col_cluster_to_string(s : DbstorecolCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_model_make(size : Int) -> DbstorecolModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_model_len(s : DbstorecolModel) -> Int { s.size }

pub fn db_store_col_model_get(s : DbstorecolModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_model_set(s : DbstorecolModel, i : Int, v : Double) -> DbstorecolModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_model_sum(s : DbstorecolModel) -> Double { @_common.sum(s.data) }

pub fn db_store_col_model_mean(s : DbstorecolModel) -> Double { @_common.mean(s.data) }

pub fn db_store_col_model_scale(s : DbstorecolModel, f : Double) -> DbstorecolModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_model_add(a : DbstorecolModel, b : DbstorecolModel) -> DbstorecolModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_model_copy(s : DbstorecolModel) -> DbstorecolModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_model_fill(s : DbstorecolModel, v : Double) -> DbstorecolModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_model_min(s : DbstorecolModel) -> Double { @_common.min(s.data) }

pub fn db_store_col_model_max(s : DbstorecolModel) -> Double { @_common.max(s.data) }

pub fn db_store_col_model_to_string(s : DbstorecolModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_layer_make(size : Int) -> DbstorecolLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_layer_len(s : DbstorecolLayer) -> Int { s.size }

pub fn db_store_col_layer_get(s : DbstorecolLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_layer_set(s : DbstorecolLayer, i : Int, v : Double) -> DbstorecolLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_layer_sum(s : DbstorecolLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_col_layer_mean(s : DbstorecolLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_col_layer_scale(s : DbstorecolLayer, f : Double) -> DbstorecolLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_layer_add(a : DbstorecolLayer, b : DbstorecolLayer) -> DbstorecolLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_layer_copy(s : DbstorecolLayer) -> DbstorecolLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_layer_fill(s : DbstorecolLayer, v : Double) -> DbstorecolLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_layer_min(s : DbstorecolLayer) -> Double { @_common.min(s.data) }

pub fn db_store_col_layer_max(s : DbstorecolLayer) -> Double { @_common.max(s.data) }

pub fn db_store_col_layer_to_string(s : DbstorecolLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_buffer_make(size : Int) -> DbstorecolBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_buffer_len(s : DbstorecolBuffer) -> Int { s.size }

pub fn db_store_col_buffer_get(s : DbstorecolBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_buffer_set(s : DbstorecolBuffer, i : Int, v : Double) -> DbstorecolBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_buffer_sum(s : DbstorecolBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_col_buffer_mean(s : DbstorecolBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_col_buffer_scale(s : DbstorecolBuffer, f : Double) -> DbstorecolBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_buffer_add(a : DbstorecolBuffer, b : DbstorecolBuffer) -> DbstorecolBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_buffer_copy(s : DbstorecolBuffer) -> DbstorecolBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_buffer_fill(s : DbstorecolBuffer, v : Double) -> DbstorecolBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_buffer_min(s : DbstorecolBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_col_buffer_max(s : DbstorecolBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_col_buffer_to_string(s : DbstorecolBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_cursor_make(size : Int) -> DbstorecolCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_cursor_len(s : DbstorecolCursor) -> Int { s.size }

pub fn db_store_col_cursor_get(s : DbstorecolCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_cursor_set(s : DbstorecolCursor, i : Int, v : Double) -> DbstorecolCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_cursor_sum(s : DbstorecolCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_col_cursor_mean(s : DbstorecolCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_col_cursor_scale(s : DbstorecolCursor, f : Double) -> DbstorecolCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_cursor_add(a : DbstorecolCursor, b : DbstorecolCursor) -> DbstorecolCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_cursor_copy(s : DbstorecolCursor) -> DbstorecolCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_cursor_fill(s : DbstorecolCursor, v : Double) -> DbstorecolCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_cursor_min(s : DbstorecolCursor) -> Double { @_common.min(s.data) }

pub fn db_store_col_cursor_max(s : DbstorecolCursor) -> Double { @_common.max(s.data) }

pub fn db_store_col_cursor_to_string(s : DbstorecolCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_view_make(size : Int) -> DbstorecolView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_view_len(s : DbstorecolView) -> Int { s.size }

pub fn db_store_col_view_get(s : DbstorecolView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_view_set(s : DbstorecolView, i : Int, v : Double) -> DbstorecolView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_view_sum(s : DbstorecolView) -> Double { @_common.sum(s.data) }

pub fn db_store_col_view_mean(s : DbstorecolView) -> Double { @_common.mean(s.data) }

pub fn db_store_col_view_scale(s : DbstorecolView, f : Double) -> DbstorecolView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_view_add(a : DbstorecolView, b : DbstorecolView) -> DbstorecolView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_view_copy(s : DbstorecolView) -> DbstorecolView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_view_fill(s : DbstorecolView, v : Double) -> DbstorecolView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_view_min(s : DbstorecolView) -> Double { @_common.min(s.data) }

pub fn db_store_col_view_max(s : DbstorecolView) -> Double { @_common.max(s.data) }

pub fn db_store_col_view_to_string(s : DbstorecolView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_range_make(size : Int) -> DbstorecolRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_range_len(s : DbstorecolRange) -> Int { s.size }

pub fn db_store_col_range_get(s : DbstorecolRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_range_set(s : DbstorecolRange, i : Int, v : Double) -> DbstorecolRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_range_sum(s : DbstorecolRange) -> Double { @_common.sum(s.data) }

pub fn db_store_col_range_mean(s : DbstorecolRange) -> Double { @_common.mean(s.data) }

pub fn db_store_col_range_scale(s : DbstorecolRange, f : Double) -> DbstorecolRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_range_add(a : DbstorecolRange, b : DbstorecolRange) -> DbstorecolRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_range_copy(s : DbstorecolRange) -> DbstorecolRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_range_fill(s : DbstorecolRange, v : Double) -> DbstorecolRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_range_min(s : DbstorecolRange) -> Double { @_common.min(s.data) }

pub fn db_store_col_range_max(s : DbstorecolRange) -> Double { @_common.max(s.data) }

pub fn db_store_col_range_to_string(s : DbstorecolRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_slice_make(size : Int) -> DbstorecolSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_slice_len(s : DbstorecolSlice) -> Int { s.size }

pub fn db_store_col_slice_get(s : DbstorecolSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_slice_set(s : DbstorecolSlice, i : Int, v : Double) -> DbstorecolSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_col_slice_sum(s : DbstorecolSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_col_slice_mean(s : DbstorecolSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_col_slice_scale(s : DbstorecolSlice, f : Double) -> DbstorecolSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_col_slice_add(a : DbstorecolSlice, b : DbstorecolSlice) -> DbstorecolSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_col_slice_copy(s : DbstorecolSlice) -> DbstorecolSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_col_slice_fill(s : DbstorecolSlice, v : Double) -> DbstorecolSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_col_slice_min(s : DbstorecolSlice) -> Double { @_common.min(s.data) }

pub fn db_store_col_slice_max(s : DbstorecolSlice) -> Double { @_common.max(s.data) }

pub fn db_store_col_slice_to_string(s : DbstorecolSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

